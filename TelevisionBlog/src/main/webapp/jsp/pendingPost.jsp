<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Pending Posts</title>
        <!-- Bootstrap core CSS -->
        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">

        <!-- Custom styles for this template -->
        <link href="${pageContext.request.contextPath}/css/starter-template.css" rel="stylesheet">

        <!-- SWC Icon -->
        <link rel="shortcut icon" href="${pageContext.request.contextPath}/img/icon.png">


        <style>
            th {
                text-align: center;
            };
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Dashboard</h1>
            <hr/>
            <div class="row">
                <div class="col-md-4"></div>
                <div class="col-md-8">
                    <div style="float: right">
                        <button class="btn btn-default"><a href="${pageContext.request.contextPath}/blog/writeBlog">Create Blog</a></button>
                    </div>
                </div>
            </div>
            <br />
            <div class="row">
                <jsp:include page="adminMenu.jsp"/>

                <div class="col-md-8">
                    <table class="table table-bordered" style="text-align: center;" id="pending-post-table">                       

                        <tr>
                            <th colspan="7">Blog Posts Needing Approval</th>
                        </tr>

                        <tr>
                            <th>Title</th>
                            <th>Post Date</th>
                            <th>Expiration Date</th>
                            <th>Author</th>
                            <th>Edit</th>
                            <th>Approve</th>
                            <th>Delete</th>
                        </tr>





                        <c:forEach items="${active}" var="post">
                            <tr id="post-row-${post.id}">

                                <c:choose>                                    
                                    <c:when test="${not post.isDraft}">
                                        <td>${post.title}</td>
                                    </c:when>
                                    <c:otherwise>
                                        <td>${post.title} (DRAFT)</td>  
                                    </c:otherwise>
                                </c:choose>
                                <td>${post.postDate}</td>
                                <c:choose>
                                    <c:when test="${empty post.expirationDate}">
                                        <td><a href="" data-post-id="${post.id}" data-toggle="modal" data-target="#edit-date-modal" class="glyphicon glyphicon-calendar"> No Date</a></td>
                                    </c:when>
                                    <c:otherwise>
                                        <td><a href="" data-post-id="${post.id}" data-toggle="modal" data-target="#edit-date-modal" class="glyphicon glyphicon-calendar"> ${post.expirationDate}</a></td>
                                    </c:otherwise>
                                </c:choose>
                                <td>${post.user.username}</td>
                                <td><a href="${pageContext.request.contextPath}/blog/edit/${post.id}" class="glyphicon glyphicon-edit" style="color: green;"></a></td>


                                <c:choose>                                    
                                    <c:when test="${not post.isDraft}">
                                        <td><a href="" data-post-id="${post.id}" class="approve-post-link glyphicon glyphicon-transfer" style="color:dodgerblue"></a></td>
                                        </c:when>
                                        <c:otherwise>
                                        <td><i class="approve-post-link glyphicon glyphicon-transfer" style="color:grey"/></td>
                                    </c:otherwise>
                                </c:choose>


                                <td><a href="" data-post-id="${post.id}" class="delete-post-link glyphicon glyphicon-remove" style="color:red"></a></td>
                            </tr>
                        </c:forEach>







                        <c:forEach items="${expired}" var="exp">
                            <tr id="post-row-${exp.id}">
                                <td><a href="${pageContext.request.contextPath}/blog/${exp.title}">${exp.title}</a></td>
                                <td>${exp.postDate}</td>
                                <c:choose>
                                    <c:when test="${empty exp.expirationDate}">
                                        <td><a href="" data-post-id="${exp.id}" data-toggle="modal" data-target="#edit-date-modal" class="glyphicon glyphicon-calendar"> No Date</a></td>
                                    </c:when>
                                    <c:otherwise>
                                        <td><a href="" data-post-id="${exp.id}" data-toggle="modal" data-target="#edit-date-modal" class="glyphicon glyphicon-calendar"> ${exp.expirationDate}</a></td>
                                    </c:otherwise>
                                </c:choose>
                                <td>${exp.user.username}</td>
                                <td><a href="${pageContext.request.contextPath}/blog/edit/${exp.id}" class="glyphicon glyphicon-edit" style="color: green;"></a></td>
                                <td><a href="" data-post-id="${exp.id}" class="approve-post-link glyphicon glyphicon-transfer" style="color:graytext"></a></td>
                                <td><a href="" data-post-id="${exp.id}" class="delete-post-link glyphicon glyphicon-remove" style="color:red"></a></td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>
            </div>
        </div>

        <div id="edit-date-modal" class="modal fade" tabindex="-1" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">Set Expiration Date</h4>
                    </div>
                    <div class="modal-body">

                        <input type="hidden" id="edit-post-id" />
                        <input type="hidden" id="edit-post-title" />
                        <input type="hidden" id="edit-post-category" />
                        <input type="hidden" id="edit-post-content" />
                        <input type="hidden" id="edit-post-date" />
                        <input type="hidden" id="edit-post-user-id" />
                        <input type="hidden" id="edit-post-active" />
                        <input type="hidden" id="edit-post-approved" />
                        <input type="hidden" id="edit-post-url" />

                        <div class="form-group">
                            <label class="col-md-4 control-label">Expiration Date:</label>
                            <div class="col-md-8">
                                <input type="text" class="form-control" id="edit-post-expiration-date" />
                            </div>
                            <br/>
                        </div>


                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="button" id="edit-date-button" class="btn btn-primary">Save changes</button>
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal-dialog -->
        </div><!-- /.modal -->


        <script>
            var contextRoot = "${pageContext.request.contextPath}";
        </script>
        <!-- Placed at the end of the document so the pages load faster -->
        <script src="${pageContext.request.contextPath}/js/jquery-1.11.1.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/adminApp.js"></script>

    </body>
</html>
