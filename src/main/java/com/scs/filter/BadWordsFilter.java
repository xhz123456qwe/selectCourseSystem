package com.scs.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebInitParam;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@jakarta.servlet.annotation.WebFilter(value = "/*", filterName = "WebFilter", initParams = {@WebInitParam(name = "badWord", value = "傻逼")})
public class BadWordsFilter implements Filter
{
    private List<String> badWords = new ArrayList<>();

    @Override
    public void init(FilterConfig filterConfig) throws ServletException
    {
        String badWord = filterConfig.getInitParameter("badWord");
        badWords.add(badWord);
        badWords.add("狗屎");
        badWords.add("放屁");
        badWords.add("智障");
        badWords.add("垃圾");
        badWords.add("低能");
        badWords.add("废物");
        badWords.add("混蛋");
        //想屏蔽什么可以自己加^_^
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException
    {
        if (servletRequest.getParameter("description") != null)
        {
            String description = servletRequest.getParameter("description");
            for (int i = 0; i < badWords.size(); i++)
            {
                if (description.contains(badWords.get(i)))
                {
                    description = description.replace(badWords.get(i), "**");
                }
            }

            servletRequest.setAttribute("changedDescription", description);
        }
        filterChain.doFilter(servletRequest, servletResponse);

    }

    @Override
    public void destroy()
    {
        Filter.super.destroy();
    }
}
