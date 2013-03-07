<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="core" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>${data.test1}</title>
        <link rel="stylesheet" type="text/css" href="../css/demo.css" />
        <link rel="stylesheet" type="text/css" href="../css/style.css" />
		<link rel="stylesheet" href="../themes/base/jquery.ui.all.css">

	<script src="../js/jquery-1.8.2.js"></script>
	<script src="../ui/jquery.ui.core.js"></script>
	<script src="../ui/jquery.ui.widget.js"></script>
	<script src="../ui/jquery.ui.datepicker.js"></script>
    <script src="../ui/jquery.ui.mouse.js"></script>
	<script src="../ui/jquery.ui.resizable.js"></script>
	<script src="../ui/jquery.ui.accordion.js"></script>
		<link rel="stylesheet" href="../css/jqdemos.css">
	<script type="text/javascript">
	$(function() {
		$( "#datepicker" ).datepicker();
	});
		$(function() {
		$( "#accordion" ).accordion({
			fillSpace: true
		});
		$( "#accordion2" ).accordion({
			fillSpace: true
		});
		$( "#accordion2" ).accordion( "option", "icons", false );
		
	});
	$(function() {
		$( "#accordionResizer" ).resizable({
			minHeight: 140,
			resize: function() {
				$( "#accordion" ).accordion( "resize" );
				$( "#accordion2" ).accordion( "resize" );
			}
		
		});
	});
  
    
	$(document).ready(function(){
		$("#myButton").click(function(){
	           
            //get the form data and then serialize that
            dataString = $("#myAjaxRequestForm").serialize();
            
            //get the form data using another method
            var uid = $("input#uid").val();
            var groupID = $("input#groupID").val();
            
            alert("go"+ uid + groupID);
            dataString = "uid=" + uid +"&groupID=" + groupID;
            
            //make the AJAX request, dataType is set to json
            //meaning we are expecting JSON data in response from the server
    	
    	
    	///////////////
        // setup some local variables
        var $form = $(this);
        // let's select and cache all the fields
        var $inputs = $form.find("input, select, button, textarea");
        // serialize the data in the form
        var serializedData = $form.serialize();

        // let's disable the inputs for the duration of the ajax request
        $inputs.prop("disabled", true);
    	/////////
   	
            $.ajax({
                type: "POST",
                url: "/LimenLibrary/web/testing",
                data: dataString,
                //data: serializedData,
               // data:  "uid="+uid.val()+"&groupID="+groupID.val(),
                
                //if received a response from the server
                success: function( data, textStatus, jqXHR) {
                	console.log(data.image);
                	console.log(data.html);
                    //our country code was correct so we have some information to display
                    /* 
                    if(data.success){
                         $("#groupmessage").html("");
                         $("#groupmessage").append("<b>ok</b>");
                        // $("#ajaxResponse").append("<b>Country Code:</b> " + data.countryInfo.code + "<br/>");
                        // $("#ajaxResponse").append("<b>Country Name:</b> " + data.countryInfo.name + "<br/>");
                        // $("#ajaxResponse").append("<b>Continent:</b> " + data.countryInfo.continent + "<br/>");
                        // $("#ajaxResponse").append("<b>Region:</b> " + data.countryInfo.region + "<br/>");
                        // $("#ajaxResponse").append("<b>Life Expectancy:</b> " + data.countryInfo.lifeExpectancy + "<br/>");
                        // $("#ajaxResponse").append("<b>GNP:</b> " + data.countryInfo.gnp + "<br/>");
                     }
                     //display error message
                     else {
                    	 $("#groupmessage").html("");
                    	 $("#groupmessage").append("<b>oererek</b>");
                    	 $("#groupmessage").append("111 ${data.test} ${data.test1}");

                     }
                    */
                },
                
                //If there was no resonse from the server
                error: function(jqXHR, textStatus, errorThrown){
                     console.log("Something really bad happened " + textStatus);
                      $("#ajaxResponse").html(jqXHR.responseText);
                },
                
                //capture the request before it was sent to server
                beforeSend: function(jqXHR, settings){
                    //adding some Dummy data to the request
                    settings.data += "&dummyData=whatever";
                    //disable the button until we get the response
                    $('#myButton').attr("disabled", true);
                },
                
                //this is called after the response or error functions are finsihed
                //so that we can take some action
                complete: function(jqXHR, textStatus){
                    //enable the button
                    $('#myButton').attr("disabled", false);
                }
      
            });    

		});
	});

    

	</script> 


</head>

<body>
<h3>Welcome <core:out value="${loginForm.userName}" /></h3>
<table>
	<tr>
		<td><a href="loginform.html">Back</a></td>
		
	</tr>
</table>

//////////////

<br><br><br>

<table id="Table_" width="171" height="720" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td><img src="../images/homepage/web-left-bar_01.jpg" width="169" height="190" alt=""></td>
    <td rowspan="4"><table id="Table_2" width="663" height="720" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td colspan="9" width="663" height="180"><img src="../images/homepage/web-central-bar_01.jpg" width="663" height="180" alt=""></td>
      </tr>
      <tr>
        <td colspan="9" width="663" height="440">
        <div id="accordion2">
            <h3>group2</h3>
                <div id='groupmessage'>
        

<table width="620" border="0" cellpadding="0" cellspacing="0" >
 <c:forEach var="a" items="${list2.groupmessage}">
 
	  <tr  align="center" >
	    <td >
		    <table id="Table_" width="620" height="102" border="0" cellpadding="0" cellspacing="0" >
		      <tr>
		        <td rowspan="4"  width="16" height="102"><img src="../images/homepage/web-central_01.jpg" width="16" height="102" alt=""></td>
		        <td colspan="2" width="588" height="8"><img src="../images/homepage/web-central_02.jpg" width="588" height="8" alt=""></td>
		        <td rowspan="4" width="16" height="102" ><img src="../images/homepage/web-central_03.jpg" width="16" height="102" alt=""></td>
		      </tr>
		      <tr>
		        <td width="48" height="48"><img src="../images/homepage/web-central_04.jpg" width="48" height="48" alt=""></td>
		        <td  width="540" height="48" bgcolor="#F1F1F3">
		        <c:out value="${a.fromUserName}" />
		        </td>
		      </tr>
		      <tr>
		        <td width="588" height="38" colspan="2" bgcolor="#F1F1F3">
		        <c:out value="${a.message}" />
		        </td>
		      </tr>
		      <tr>
		        <td colspan="2" width="588" height="8"><img src="../images/homepage/web-central_07.jpg" width="588" height="8" alt=""></td>
		      </tr>
		    </table>
	    </td>
	  </tr>
	  
	  <tr>
	    <td>&nbsp;</td>
  </tr>
 </c:forEach>
</table>

                </div>	
          </div>
        
        </td>
      </tr>
      <tr>
        <td><img src="../images/homepage/web-central-bar_03.jpg" width="67" height="100" alt=""></td>
        <td><img src="../images/homepage/web-central-bar_04.jpg" width="67" height="100" alt=""></td>
        <td><img src="../images/homepage/web-central-bar_05.jpg" width="42" height="100" alt=""></td>
        <td><img src="../images/homepage/web-central-bar_06.jpg" width="73" height="100" alt=""></td>
        <td><img src="../images/homepage/web-central-bar_07.jpg" width="35" height="100" alt=""></td>
        <td><img src="../images/homepage/web-central-bar_08.jpg" width="73" height="100" alt=""></td>
        <td><img src="../images/homepage/web-central-bar_09.jpg" width="35" height="100" alt=""></td>
        <td><img src="../images/homepage/web-central-bar_10.jpg" width="74" height="100" alt=""></td>
        <td><img src="../images/homepage/web-central-bar_11.jpg" width="197" height="100" alt=""></td>
      </tr>
    </table></td>
    <td rowspan="4" valign="top"><img src="../images/homepage/web-homepage-bar_03.jpg" width="13" height="720" alt=""></td>
    <td rowspan="4" valign="top" background="../images/homepage/web-right-bg.jpg">
<div id="accordion">
	<h3><img src="../images/homepage/web-group.jpg" width="177" height="49"></h3>
	<div id='group'>
	 <c:forEach var="b" items="${list2.group}">

		  <div><p><c:out value="${b.groupName}" /></p></div>
		  <!-- 
			<core:out value="${list2.group[i].groupDetail}" />
			<core:out value="${list2.group[i].numMessage}" />
			<core:out value="${list2.group[i].groupID}" />
			<core:out value="${list2.group[i].groupName}" />
			<br><br>
			 -->
		  </c:forEach>
    </div>
    
	<h3><img src="../images/homepage/web-messgae.jpg" width="177" height="50"></h3>
		<div id='message'>
		<c:forEach var="c" items="${list2.groupmessage}">

  <div><p><c:out value="${c.fromUserName}" /></p></div>
 <!-- 
	<core:out value="${list2.groupmessage[i].fromUserName}" />
	<core:out value="${list2.groupmessage[i].message}" />
	<core:out value="${list2.groupmessage[i].createTime}" />
	<core:out value="${list2.groupmessage[i].groupID}" />
	<core:out value="${list2.groupmessage[i].mid}" />
	<core:out value="${list2.groupmessage[i].fromUserID}" />
	<br><br>
	 -->
  </c:forEach>

        </div>	
    <h3><img src="../images/homepage/web-calendar.jpg" width="177" height="50"></h3>
		<div id="datepicker"></div>
</div>

    </td>
  </tr>
  <tr>
    <td><img src="../images/homepage/web-left-bar_02.jpg" width="169" height="75" alt=""></td>
  </tr>
  <tr>
    <td><img src="../images/homepage/web-left-bar_03.jpg" width="169" height="265" alt=""></td>
  </tr>
  <tr>
    <td><img src="../images/homepage/web-left-bar_04.jpg" width="169" height="190" alt=""></td>
  </tr>
</table>

    <form id="groupmessageForm">
        <fieldset>
            <legend>jQuery Ajax Form data Submit Request</legend>
 
                <p>
                    uid:<input id="uid" type="text" name="uid" />
                </p>
                
                 <p>
                    groupID:<input id="groupID" type="text" name="groupID" />
                </p>
                <p>
                    <input id="myButton" type="button" value="Submit" />
                </p>
        </fieldset>
    </form>
    <div id="anotherSection">
        <fieldset>
            <legend>Response from jQuery Ajax Request</legend>
                 <div id="ajaxResponse"></div>
        </fieldset>
    </div>  
 
</body>
</html>