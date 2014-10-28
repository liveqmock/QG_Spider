package com.lkb.dao;

import java.util.List;
import java.util.Map;

import com.lkb.bean.University;



public interface IUniversityDao {
	/**返回所有**/
	List<University> getAll();
	/**返回当前**/
	University get(Integer id);
	/***
	 * @param type=true 查询所有285院校
	 * @return all;
	 */
	List<University> getObjByType(Boolean type);
	
	void save(University university);
	
//	void delete(Integer id);
	/*
	 * 根据名字获得学校数量
	 * */
	int getObjByName(Map map);
}
