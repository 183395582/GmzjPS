package com.gmzj.service.impl;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.stereotype.Service;

import com.gmzj.entity.Role;
import com.gmzj.dao.RoleDao;
import com.gmzj.service.ResourceService;
import com.gmzj.service.RoleService;

@Service
public class RoleServiceImpl implements RoleService {

    @Autowired
    private RoleDao roleDao;
    
    @Autowired
    private ResourceService resourceService;

    public Role createRole(Role role) {
        return roleDao.createRole(role);
    }

    @CacheEvict(value="permissions", allEntries=true)
    public Role updateRole(Role role) {
        return roleDao.updateRole(role);
    }

    @CacheEvict(value="permissions", allEntries=true)
    public void deleteRole(Long roleId) {
        roleDao.deleteRole(roleId);
    }

    @Override
    public Role findOne(Long roleId) {
        return roleDao.findOne(roleId);
    }

    @Override
    public List<Role> findAll() {
        return roleDao.findAll();
    }

    @Override
    public Set<String> findRoles(Long... roleIds) {
        Set<String> roles = new HashSet<String>();
        for(Long roleId : roleIds) {
            Role role = findOne(roleId);
            if(role != null) {
                roles.add(role.getRole());
            }
        }
        return roles;
    }

    @Override
    public Set<String> findPermissions(Long[] roleIds) {
        Set<Long> resourceIds = new HashSet<Long>();
        for(Long roleId : roleIds) {
            Role role = findOne(roleId);
            if(role != null) {
                resourceIds.addAll(role.getResourceIds());
            }
        }
        return resourceService.findPermissions(resourceIds);
    }
}
