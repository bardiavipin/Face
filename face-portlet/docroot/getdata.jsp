
<%@page import="com.liferay.portal.kernel.json.JSONFactoryUtil"%>
<%@page import="com.liferay.portal.kernel.json.JSONObject"%>
<%@page import="com.liferay.portal.kernel.json.JSONArray"%>
<%@page import="java.util.LinkedList"%>
<%@page import="com.liferay.portal.model.User"%>
<%@page import="com.liferay.portal.service.UserLocalServiceUtil"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="com.liferay.portal.kernel.util.PortalClassLoaderUtil"%>
<%@page import="com.liferay.portal.kernel.dao.orm.DynamicQueryFactoryUtil"%>
<%@page import="com.liferay.portal.kernel.dao.orm.DynamicQuery"%>
<%@page import="com.liferay.portal.kernel.dao.orm.PropertyFactoryUtil"%>
<%@page import="com.liferay.portal.kernel.dao.orm.OrderFactoryUtil"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.liferay.portal.kernel.util.Validator"%>

<%
List<User> AuthorList=null;
   		try{
    		        
    	ClassLoader classLoader = PortalClassLoaderUtil.getClassLoader();
    	DynamicQuery dynamicQuery =null;
    	
    		String serachPattern = request.getParameter("q");
 			serachPattern = serachPattern.replace('*', '%');
 			
		dynamicQuery = DynamicQueryFactoryUtil.forClass(User.class, classLoader)
		.add(PropertyFactoryUtil.forName("emailAddress").like(serachPattern+"%" ))
      	.addOrder(OrderFactoryUtil.asc("firstName"));
    
		AuthorList  = (List)UserLocalServiceUtil.dynamicQuery(dynamicQuery);
        JSONArray results = JSONFactoryUtil.createJSONArray();
        
    	String emailid=null;
        for (int i = 0; i < AuthorList.size(); i++ ) {   
            if(AuthorList.get(i).isActive()) { 
        		emailid=AuthorList.get(i).getScreenName();
             	out.println(emailid);
        	}
        }
    }
    catch(Exception e){
    	System.out.println("\n\n-------Exception in getting users in getData.jsp in Manage Contribution Credit---------\n\n");
    }
%>