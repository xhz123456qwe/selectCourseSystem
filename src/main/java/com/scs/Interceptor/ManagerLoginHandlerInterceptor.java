package com.scs.Interceptor;

import com.scs.bean.Manager;
import com.scs.bean.Student;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author 徐豪智
 * @description   阻止未经过登录直接进入管理员界面
 */
public class ManagerLoginHandlerInterceptor implements HandlerInterceptor
{
    @Override
    public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object handler) throws Exception
    {
        String requestURI = httpServletRequest.getRequestURI();
        Manager manager = (Manager) httpServletRequest.getSession().getAttribute("manager");
        if (manager != null)
        {
            System.out.println("manager");
            return true;
        } else
        {
            System.out.println("no");
            httpServletResponse.sendRedirect(httpServletRequest.getContextPath() + "/");
        }
        return false;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception
    {
        HandlerInterceptor.super.postHandle(request, response, handler, modelAndView);
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception
    {
        HandlerInterceptor.super.afterCompletion(request, response, handler, ex);
    }
}
