<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
    <script src="<%=request.getContextPath()%>/js/jquery.min.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/js/jquery.Jcrop.js" type="text/javascript"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/jquery.Jcrop.css" type="text/css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/demos.css" type="text/css" />

	<link type="text/css" href="<%=request.getContextPath()%>/css/jquery.autocomplete.css" rel="stylesheet" />
	<script src="<%=request.getContextPath()%>/js/jquery.autocomplete.js"></script>
        
    <link type="text/css" href="<%=request.getContextPath()%>/css/jquery.tagsinput.css" rel="stylesheet" />
	<script src="<%=request.getContextPath()%>/js/jquery.tagsinput.js"></script>
	<script type="text/javascript">
		var divCount='<c:out value="${listSize}" />';
		if(divCount==undefined){
			divCount=0;
		}
	</script>
	<script src="<%=request.getContextPath()%>/js/TagPhotos.js"></script>


<portlet:renderURL var="callFaceURL">
	<portlet:param name="tags" value="true" />
</portlet:renderURL>
	
<portlet:defineObjects />

<div id="MainDiv">
	<img src="<%=request.getContextPath()%>/img/DSC01895.JPG" id="target" usemap="#imageMap" onmousemove="hideAllArea()" width="1000px" height="400px"/>

	<c:set var="count" value="0" scope="page" />

	<map id="imageMap" name="imageMap">
   		 <c:forEach items="${listFace}" var="tagItr" >
   		 	<c:set var="count" value="${count + 1}" scope="page"/>
   		 	<area alt="${tagItr.tagName}" title="${tagItr.tagName}" coords="${tagItr.x1},${tagItr.y1},${tagItr.x2},${tagItr.y2}" id="area${count}" href="#" shape="rect" onmousemove="displayArea(${count})">	
   		 </c:forEach>
    </map>
	
	<form id="coords" class="coords" action="<%=callFaceURL.toString()%>" method="POST">
      <div>
	      <label>X1 <input type="text" size="4" id="x1" name="x1" /></label>
	      <label>Y1 <input type="text" size="4" id="y1" name="y1" /></label>
	      <label>X2 <input type="text" size="4" id="x2" name="x2" /></label>
	      <label>Y2 <input type="text" size="4" id="y2" name="y2" /></label>
	      <label>W <input type="text" size="4" id="w" name="w" /></label>
	      <label>H <input type="text" size="4" id="h" name="h" /></label>
      </div>
      <div class="buttons">
    	  <input type="button" name= "EditTagImage" value="Edit Tags" onclick="editTagImage()"/>
    	  <input type="submit" name= "DoneTagging" value="Done Tagging" onclick="editTag();hideBox();"/>
      </div>
      <c:set var="count" value="0" scope="page" />
       <c:forEach items="${listFace}" var="tagItr" >
   		 	<c:set var="count" value="${count + 1}" scope="page"/>
   		 	<input type="hidden" id="inputEl${count}" name="tagValues" value="${tagItr.x1},${tagItr.y1},${tagItr.x2},${tagItr.y2},${tagItr.width},${tagItr.height},${tagItr.tagName},${tagItr.topHeight}" />
   		 </c:forEach>
    </form>
	
	<div id="moveMe" style="display:none;">
		<input type="text" name="searchTerm" maxlength="30" size="50" style="font-weight:bold;width:200px;" width="100%" id="queryfill" />
    </div>
    <c:set var="count" value="0" scope="page" />
    <c:forEach items="${listFace}" var="tagItr" >
   		<c:set var="count" value="${count + 1}" scope="page"/>
   		<div id="rect${count}" class="blackrectangle" style="position:absolute;top:${tagItr.topHeight}px;left:${tagItr.x1}px;width:${tagItr.width}px;height:${tagItr.height}px;display:block;" onclick="hitTaggedUser(${count})">
	   	 	<div class='innerTag' id='tagNameOnDiv${count}'> ${tagItr.tagName}</div>
	   	 	<a href= '#' class='photoTag-delete' onclick='removeTagById(${count});return false;'></a>
   		</div>
   	</c:forEach>
</div>
<c:set var="count" value="0" scope="page" />
<div class ="mainTagNames" id="tagNames">
	<c:forEach items="${listFace}" var="tagItr" >
   	 	<c:set var="count" value="${count + 1}" scope="page"/>
   	 	<div class='innerTag innerTagAddMargin' id='tagDiv${count}'>
   	 		<span onclick='hitTaggedUser(${count})' onmouseout='hideArea(${count})' onmousemove='displayArea(${count})'>${tagItr.tagName}</span>
	   	 	<a href= '#' class='photoTag-delete-anthr' onmousemove='displayArea(${count})' onmouseout='hideArea(${count})' onclick='removeTagById(${count});return false;'></a>
   	 	</div>
   	 </c:forEach>
</div>