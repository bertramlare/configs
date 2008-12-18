<?
class phpCode
{
	private $code;

	public function __construct($code)
	{
		$this->code = $code;
	}

	public function extractMethod($method_name)
	{
		$assignments = array();
		$usages = array();

		foreach ($this->extractVars() as $list)
		{
			list($var, $context) = $list;

			if ($context == 'usage')
			{
				$usages[$var] = 1;
			}
			else 
			{
				$assignments[$var] = 1;
			}
		}

		if (sizeof($assignments) == 1)
		{
			$var = key($assignments);
			$return = "return {$var};";
		}
		else
		{
			$return = "return array(" . join(', ', array_keys($assignments)) . ");";
		}

		$function_header = $this->createFunctionHeader($method_name, array_keys($usages));
		$function_pieces = array
		(
			"private function " . $function_header,
			"{",
			$this->code,
			'',
			"\t" . $return,
			"}",
		);

		$line_ending = $this->getLineEnding();
		$function_usage = '$this->' . $function_header . ';';
		$function_code = join($line_ending, $function_pieces);

		return array($function_usage, $function_code);
	}

	private function createFunctionHeader($method_name, $vars)
	{
		return "$method_name(" . join(', ', $vars) . ")";
	}

	private function extractVars()
	{
		$matches = array();
		preg_match_all('/(\$\w+\b)\s*(..)?/', $this->code, $matches);

		$vars = $matches[1];
		$trailing_chars = $matches[2];
		$result = array();

		foreach ($vars as $i => $var)
		{
			$trailing_char = trim($trailing_chars[$i]);

			if ($var != '$this')
			{
				$context = ($trailing_char == '=') ? 'assignment' : 'usage';
				$result[] = array($var, $context);
			}
		}

		return $result;
	}

	private function getLineEnding()
	{
		$is_windows = (bool)preg_match('/\r/', $this->code);

		return ($is_windows) ? "\r\n" : "\n";
	}
}
?>
