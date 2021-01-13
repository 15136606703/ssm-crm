package com.zh.crm.workbench.service.impl;

import com.zh.crm.vo.PaginationVo;
import com.zh.crm.workbench.dao.ClueDao;
import com.zh.crm.workbench.dao.ClueRemarkDao;
import com.zh.crm.workbench.domain.Activity;
import com.zh.crm.workbench.domain.Clue;
import com.zh.crm.workbench.service.ClueService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

/**
 * @Classname ClueServiceImpl
 * @Date 2021-1-12 17:12
 * @Created by 张浩
 */
@Service
public class ClueServiceImpl implements ClueService {

    @Resource
    private ClueDao clueDao;
    @Resource
    private ClueRemarkDao clueRemarkDao;
    @Override
    public boolean save(Clue clue) {
        boolean flag = false;
        int count = clueDao.save(clue);
        if (count != 0){
            flag = true;
        }

        return flag;
    }

    @Override
    public PaginationVo<Clue> pageList(Map<String, Object> map) {
        //获取total
        int total = clueDao.getTotalByCondition(map);
        List<Clue> cList = clueDao.getClueListByCondition(map);
        PaginationVo<Clue> vo = new PaginationVo<>();
        vo.setTotal(total);
        vo.setDataList(cList);
        return vo;
    }

    @Override
    public boolean delete(String[] ids) {

        boolean flag = true;
        //查询出需要删除备注的数量
        int count1 = clueRemarkDao.getCountByCids(ids);
        //删除备注，返回受到影响的条数（实际删除的数量）
        int count2 = clueRemarkDao.deleteByCids(ids);
        //删除市场活动
        if (count1!= count2) {
            flag = false;
        }
        //查询要删除的关联市场数

        int count3 = clueDao.delete(ids);
        if (count3!=ids.length){
            flag = false;
        }
        return flag;

    }

    @Override
    public boolean update(Clue clue) {
        return false;
    }

    @Override
    public Clue getById(String id) {
        return null;
    }
}
