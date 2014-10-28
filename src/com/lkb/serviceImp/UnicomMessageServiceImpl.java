package com.lkb.serviceImp;


import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.lkb.bean.UnicomMessage;
import com.lkb.constant.Constant;
import com.lkb.dao.IUnicomMessageDao;
import com.lkb.service.IUnicomMessageService;

@Service
@Transactional
public class UnicomMessageServiceImpl implements IUnicomMessageService {

	@Resource
	private IUnicomMessageDao dao;

	@Override
	public UnicomMessage findById(String id) {
		return dao.findById(id);
	}

	@Override
	public void save(UnicomMessage obj) {
		dao.save(obj);
	}

	@Override
	public void delete(String id) {
		dao.delete(id);
	}

	@Override
	public void update(UnicomMessage obj) {
		dao.update(obj);
	}

	@Override
	public List<Map> getByPhone(Map map) {
		return dao.getByPhone(map);
	}
	@Override
	public List<Map> getListByPhone(String phone) {
		return dao.getListByPhone(phone);
	}

	@Override
	public List<Map> getUnicomMessageForReport(Map map) {
		return dao.getUnicomMessageForReport(map);
	}

	@Override
	public List<Map> getUnicomMessageForReport2(Map map) {
		return dao.getUnicomMessageForReport2(map);
	}

	@Override
	public UnicomMessage getMaxSentTime(String phone) {
		return dao.getMaxSentTime(phone);
	}

	@Override
	public List<Map> getList(String phone) {
		return dao.getList(phone);
	}
	
	
	@Override
	public void insertbatch(List<UnicomMessage> vctList){
		int batchAmount = Constant.batchAmount;
		int vsize =  vctList.size();
		if(vctList!=null&&vsize>0){
			int amount = vsize/batchAmount;
			if(amount>=1){
				for(int j=0;j<amount+1;j++){
					int size = (j+1)*batchAmount;
					if(size>vsize){
						size = vsize;
					}
					List list = vctList.subList(j*batchAmount, size);
					if(list!=null && list.size()>0){
						dao.insertbatch(list);
					}	
				}				
			}else{
				dao.insertbatch(vctList);
			}	
		}
		
	}
	
}