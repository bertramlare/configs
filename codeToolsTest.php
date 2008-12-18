<?php
require_once('./phpCode.php');

class codeToolsTest extends PHPUnit_Framework_Testcase
{
	public function testExtractMethod()
	{
		$input = '	$rot_info = $this->db->getAll
	("
		SELECT
			p.p_id, p.lastname, p.firstname, p.student_number, i.roleType_id, g.name, r.name, r.full_name, i.start_date, i.end_date, i.meta_id 
		FROM
			people p, groups g, rotations r, people_in_rotation i
		WHERE
			g.roleType_id IN ($roles_str) AND clinicElement_id<=0 AND start_date>=$from_date
			AND start_date<=$to_date AND g.group_id IN ($group_str)
			AND p.p_id=i.p_id AND i.rotation_id=r.rotation_id AND r.owner_group_id=g.group_id
		ORDER BY
			g.name, p.lastname, p.firstname
	");';

		$expected = 'private function getRotationInfo($roles_str, $from_date, $to_date, $group_str)
{
	$rot_info = $this->db->getAll
	("
		SELECT
			p.p_id, p.lastname, p.firstname, p.student_number, i.roleType_id, g.name, r.name, r.full_name, i.start_date, i.end_date, i.meta_id 
		FROM
			people p, groups g, rotations r, people_in_rotation i
		WHERE
			g.roleType_id IN ($roles_str) AND clinicElement_id<=0 AND start_date>=$from_date
			AND start_date<=$to_date AND g.group_id IN ($group_str)
			AND p.p_id=i.p_id AND i.rotation_id=r.rotation_id AND r.owner_group_id=g.group_id
		ORDER BY
			g.name, p.lastname, p.firstname
	");

	return $rot_info;
}';

		$code = new phpCode($input);
		list($method_usage, $method_code) = $code->extractMethod('getRotationInfo');
		$this->assertEquals($expected, $method_code);
		$this->assertEquals('$this->getRotationInfo($roles_str, $from_date, $to_date, $group_str);', $method_usage);
	}
}
?>
