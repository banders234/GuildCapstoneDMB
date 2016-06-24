/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.televisionblog.controller;

import com.mycompany.televisionblog.dao.BlogPostDao;
import com.mycompany.televisionblog.dao.PageDao;
import com.mycompany.televisionblog.dto.BlogPost;
import com.mycompany.televisionblog.dto.Page;
import java.util.Date;
import java.util.List;
import java.util.Map;
import javax.inject.Inject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 *
 * @author apprentice
 */
@Controller
@RequestMapping(value="/admin")
public class AdminController {
    
    BlogPostDao postDao;
    PageDao pageDao;
    
    @Inject
    public AdminController(BlogPostDao postDao, PageDao pageDao) {
        this.postDao = postDao;
        this.pageDao = pageDao;
    }
    
    @RequestMapping(value="/", method=RequestMethod.GET) 
    public String home(Map model) {
        
        List<BlogPost> pendingPosts = postDao.listUnapproved();
        model.put("pendingPosts", pendingPosts);
        return "adminHome";
    } 
    
    @RequestMapping(value="/post", method=RequestMethod.GET) 
    public String blogPosts(Map model) {
        
        List<BlogPost> posts = postDao.list();
        model.put("posts", posts);
        return "post";
    } 
    
    @RequestMapping(value="/page", method=RequestMethod.GET) 
    public String staticPages(Map model) {
        
        List<Page> pages = pageDao.list();
        model.put("pages", pages);
        return "page";
    } 
    
    
    
    @RequestMapping(value="/approval/{val}/{id}", method=RequestMethod.POST)
    @ResponseBody
    public void approvePost(@PathVariable("id") Integer id, @PathVariable("val") Integer val) {
        
        BlogPost post = postDao.get(id);
        
        if(val == 1) {
            post.setApproved(true);
        } else if(val == 2) {
            post.setApproved(false);
        }
        
        postDao.update(post);
        
    }
    
}