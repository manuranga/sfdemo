import ballerina/file;
import ballerina/log;

listener file:Listener inbox = new ({path: "/tmp", recursive: false});

function init() {
    log:printInfo("sfSales", values = sfSalesValues(), baseUrl = sfSales.baseUrl);
}

service on inbox {
    remote function onCreate(file:FileEvent event) {
        log:printInfo("file", name = event.name, values = sfSalesValues());
    }
}
