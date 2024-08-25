import ballerina/http;
import ballerina/io;

type ItuneSearchItem record {
    string collectionName;
    string collectionViewUrl;
};

type ItuneSearchResult record {
    ItuneSearchItem[] results;
};

service /pickagift on new http:Listener(8081) {
    resource function get albums(string artist) returns string|error {
        http:Client iTunes = check new ("http://www.apple.com");
        ItuneSearchResult search = check iTunes->get(serchUrl(artist));
        io:println(search.results[0].collectionName);
        return search.results[0].collectionName;
    }
}

function serchUrl(string artist) returns string {
    return "/search?term=" + artist + "&entity=album&attribute=artistTerm";
}
