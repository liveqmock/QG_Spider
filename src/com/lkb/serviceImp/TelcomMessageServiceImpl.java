package com.lkb.serviceImp;


import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.lkb.bean.TelcomMessage;
import com.lkb.constant.Constant;
import com.lkb.daoImp.TelcomMessageDaoImp;
import com.lkb.service.ITelcomMessageService;
import com.lkb.util.InfoUtil;

@Service
@Transactional
public class TelcomMessageServiceImpl implements ITelcomMessageService {

	@Resource
	private TelcomMessageDaoImp dao;

	@Override
	public TelcomMessage findById(String id) {
		return dao.findById(id);
	}

	@Override
	public void save(TelcomMessage obj) {
		dao.save(obj);
	}

	@Override
	public void delete(String id) {
		dao.delete(id);
	}

	@Override
	public void update(TelcomMessage obj) {
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
	public List<Map> getTelcomMessageForReport(Map map) {
		return dao.getTelcomMessageForReport(map);
	}

	@Override
	public List<Map> getTelcomMessageForReport2(Map map) {
		return dao.getTelcomMessageForReport2(map);
	}

	@Override
	public TelcomMessage getMaxSentTime(String phone) {
		return dao.getMaxSentTime(phone);
	}

	@Override
	public List<Map> getList(String phone) {
		return dao.getList(phone);
	}
	
	@Override
	public void insertbatch(List<TelcomMessage> vctList){
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
