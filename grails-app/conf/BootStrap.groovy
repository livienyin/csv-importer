import csv.app.Contact
import grails.converters.JSON

class BootStrap {

    def init = { servletContext ->

        JSON.registerObjectMarshaller(Contact) {
            def output = [:]
            output['id'] = it.id
            output['email'] = it.email
            output['firstName'] = it.firstName
            output['lastName'] = it.lastName
            output['prefix'] = it.prefix
            output['phone'] = it.phone
            output['fax'] = it.fax
            output['title'] = it.title
            output['company'] = ["id": it.company.id, "name": it.company.getName()]

            return output;
        }
    }
    def destroy = {
    }
}
