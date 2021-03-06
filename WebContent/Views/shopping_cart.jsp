<%@page import="dylanandapril.database.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="url">${pageContext.request.requestURL}</c:set>
<base
	href="${fn:substring(url, 0, fn:length(url) - fn:length(pageContext.request.requestURI))}${pageContext.request.contextPath}/" />
<link rel="stylesheet" href="scripts/ThirdParty/bootstrap.min.css" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Shopping Cart</title>
</head>
<body style="padding-top: 80px; padding-bottom:100px">

<%
User u = (User) request.getSession(true).getAttribute("user"); 
if(u == null || !u.getRole().equals("customer")) {
	response.sendRedirect(request.getContextPath()+"/login");
	return;
}
%>

	<jsp:include page="/Views/Partials/navbar.jsp"></jsp:include>

	<div class="container" ng-app="shopping" ng-controller="ShoppingCtrl">
		<div class="page-header">
		  <h1>Shopping Cart</h1>
		</div>
		<div class="col-md-8 col-md-offset-1">
			<table class="table table-striped">
				<thead>
					<tr>
						<th>Product</th>
						<th>Price</th>
						<th>Quantity</th>
					</tr>
				</thead>
				<tbody>
					<tr ng-repeat="item in shoppingcart">
						<td>{{item.product.name}}</td>
						<td>{{item.product.price | currency}}</td>
						<td>
							<select ng-model="item.quantity" ng-change="saveItem(item)" 
								ng-options="num for num in quantities" class="form-control"></select>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="col-md-3">
			<div class="thumbnail" style="position:fixed; min-width: 250px">
				<div class="caption">
					<h1 style="text-align:center">Total</h1>
					<h2 style="text-align:center">{{total() | currency}}</h2>
					<form style="margin-top: 30px;" role="form" action="customer/confirmation" method="POST" novalidate>
						<div class="form-group">
							<label>Credit Card</label>
							<input name="cc" ng-model="creditCard" class="form-control" placeholder="Enter credit card number">
						</div>
						<div style="text-align:center" >
							<button type="submit" ng-disabled="!creditCard" class="btn btn-success">Purchase</a>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="/Views/Partials/footer.html"></jsp:include>
	<jsp:include page="/Views/Partials/javascript.jsp"></jsp:include>
	<script type="text/javascript" src="scripts/shopping_cart.js"></script>
</body>
</html>