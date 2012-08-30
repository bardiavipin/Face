package com.learn.face.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.portlet.PortletException;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;

import com.learn.face.model.FaceModel;
import com.liferay.util.bridges.mvc.MVCPortlet;

public class FaceController extends MVCPortlet{

	public void doView(
			RenderRequest renderRequest, RenderResponse renderResponse)
		throws IOException, PortletException {
		System.out.println("Done...:))");
		
		String tags=renderRequest.getParameter("tags");
		
		if(tags!=null && tags.equalsIgnoreCase("true")){
			String tagValuesList[]=renderRequest.getParameterValues("tagValues");
			List<FaceModel> listFaceModel=new ArrayList<FaceModel>();
			for(String tag:tagValuesList){
				System.out.println("tag coords and tag name : " + tag);
				String tagValue[]=tag.split(",");
				FaceModel faceModel=new FaceModel();
				faceModel.setX1(Double.parseDouble(tagValue[0]));
				faceModel.setY1(Double.parseDouble(tagValue[1]));
				faceModel.setX2(Double.parseDouble(tagValue[2]));
				faceModel.setY2(Double.parseDouble(tagValue[3]));
				faceModel.setWidth(Integer.parseInt(tagValue[4]));
				faceModel.setHeight(Integer.parseInt(tagValue[5]));
				faceModel.setTagName(tagValue[6]);
				faceModel.setTopHeight(Double.parseDouble(tagValue[7]));
				listFaceModel.add(faceModel);
			}
			renderRequest.setAttribute("listFace", listFaceModel);
			renderRequest.setAttribute("listSize", listFaceModel.size());
		}
		include(viewTemplate, renderRequest, renderResponse);
	}
}
