<%@ page import="csv.app.Contact" %>



<div class="fieldcontain ${hasErrors(bean: contactInstance, field: 'email', 'error')} ">
	<label for="email">
		<g:message code="contact.email.label" default="Email" />
		
	</label>
	<g:field type="email" name="email" value="${contactInstance?.email}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: contactInstance, field: 'firstName', 'error')} required">
	<label for="firstName">
		<g:message code="contact.firstName.label" default="First Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="firstName" maxlength="50" required="" value="${contactInstance?.firstName}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: contactInstance, field: 'lastName', 'error')} required">
	<label for="lastName">
		<g:message code="contact.lastName.label" default="Last Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="lastName" maxlength="50" required="" value="${contactInstance?.lastName}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: contactInstance, field: 'prefix', 'error')} ">
	<label for="prefix">
		<g:message code="contact.prefix.label" default="Prefix" />
		
	</label>
	<g:textField name="prefix" value="${contactInstance?.prefix}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: contactInstance, field: 'phone', 'error')} ">
	<label for="phone">
		<g:message code="contact.phone.label" default="Phone" />
		
	</label>
	<g:textField name="phone" value="${contactInstance?.phone}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: contactInstance, field: 'fax', 'error')} ">
	<label for="fax">
		<g:message code="contact.fax.label" default="Fax" />
		
	</label>
	<g:textField name="fax" value="${contactInstance?.fax}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: contactInstance, field: 'title', 'error')} ">
	<label for="title">
		<g:message code="contact.title.label" default="Title" />
		
	</label>
	<g:textField name="title" value="${contactInstance?.title}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: contactInstance, field: 'company', 'error')} required">
	<label for="company">
		<g:message code="contact.company.label" default="Company" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="company" name="company.id" from="${csv.app.Company.list()}" optionKey="id" required="" value="${contactInstance?.company?.id}" class="many-to-one"/>
</div>

