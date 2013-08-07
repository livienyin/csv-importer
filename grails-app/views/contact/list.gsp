
<%@ page import="csv.app.Contact" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
        <link rel="stylesheet" href="${resource(dir: 'css', file: 'modal.css')}" type="text/css">
		<g:set var="entityName" value="${message(code: 'contact.label', default: 'Contact')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
        <g:javascript library="jquery" />
	</head>
	<body>
		<a href="#list-contact" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
                <li><a id="ajax-create" href="#">Ajax Create</a></li>
			</ul>
		</div>

        <g:uploadForm action="csvUpload" enctype="multipart/form-data">
            <input type="file" name="file">
            <input type="submit">
        </g:uploadForm>

		<div id="list-contact" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>

            <table>
				<thead>
					<tr>
					
						<g:sortableColumn property="email" title="${message(code: 'contact.email.label', default: 'Email')}" />
					
						<g:sortableColumn property="firstName" title="${message(code: 'contact.firstName.label', default: 'First Name')}" />
					
						<g:sortableColumn property="lastName" title="${message(code: 'contact.lastName.label', default: 'Last Name')}" />
					
						<g:sortableColumn property="prefix" title="${message(code: 'contact.prefix.label', default: 'Prefix')}" />
					
						<g:sortableColumn property="phone" title="${message(code: 'contact.phone.label', default: 'Phone')}" />
					
						<g:sortableColumn property="fax" title="${message(code: 'contact.fax.label', default: 'Fax')}" />

                        <g:sortableColumn property="company" title="${message(code: 'contact.company.label', default: 'Company')}" />

                        <g:sortableColumn property="title" title="${message(code: 'contact.title.label', default: 'Title')}" />

                        <g:sortableColumn property="delete" title="Delete" />

                        <g:sortableColumn property="edit" title="Edit" />

					</tr>
				</thead>
				<tbody>
				<g:each in="${contactInstanceList}" status="i" var="contactInstance">
					<tr id="contact-${contactInstance.id}" class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${contactInstance.id}">${fieldValue(bean: contactInstance, field: "email")}</g:link></td>
					
						<td>${fieldValue(bean: contactInstance, field: "firstName")}</td>
					
						<td>${fieldValue(bean: contactInstance, field: "lastName")}</td>
					
						<td>${fieldValue(bean: contactInstance, field: "prefix")}</td>
					
						<td>${fieldValue(bean: contactInstance, field: "phone")}</td>
					
						<td>${fieldValue(bean: contactInstance, field: "fax")}</td>

                        <td>${fieldValue(bean: contactInstance, field: "company")}</td>

                        <td>${fieldValue(bean: contactInstance, field: "title")}</td>

                        <td><g:remoteLink action="ajaxDelete" params="${[id:contactInstance.id]}" update="main-content">delete</g:remoteLink></td>

                        <td><g:link elementId="ajax-edit" action="editModal" id="${contactInstance.id}">edit</g:link></td>

					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${contactInstanceTotal}" />
			</div>
		</div>
    </body>
</html>
<g:javascript>
    var modal = (function(){

        var method = {},
            $modal,
            $overlay,
            $content,
            $close;

        $overlay = $('<div id="overlay"></div>');
        $modal = $('<div id="modal"></div>');
        $content = $('<div id="content"></div>');
        $close = $('<a id="close" href="#">close</a>');

        method.center = function(){
            var top, left;
            top = Math.max($(window).height() - $modal.height(), 0) / 2;
            left = Math.max($(window).width() - $modal.width(), 0) / 2;
            $modal.css({
                top:top + $(window).scrollTop(),
                left:left + $(window).scrollLeft()
            });
        }
        method.open = function(settings){
            $.ajax({
                url: settings.url,
                success: function(data) {
                    $content.empty().append(data);
                    $modal.append($content);
                    method.center();
                    $modal.append($close);
                }
            });

            $modal.css({
                width: settings.width || 'auto',
                height: settings.height || 'auto'
            });

            $(window).bind('resize.modal', method.center);

            $overlay.show();
            $modal.show();

        }
        method.close = function(){
            $modal.hide();
            $overlay.hide();
            $content.empty();
            $(window).unbind('resize.modal');
        }

        $close.click(function(event){
            event.preventDefault();
            method.close();
        })

        $modal.hide();
        $overlay.hide();

        $(document).ready(function(){
            $('body').append($overlay, $modal);
        })
        return method;
    }());

    $(document).ready(function(){
        $('a#ajax-create').click(function(event){
            event.preventDefault();
            modal.open({url: '/csv-app/contact/createModal'});
        })

        $('a#ajax-edit').click(function(event){
            var link = $(this).attr('href');
            event.preventDefault();
            modal.open({url: link});
        })
    })
</g:javascript>