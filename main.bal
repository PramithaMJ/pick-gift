import ballerina/http;
import ballerina/io;

type ItuneSearchItem record {
    string collectionName;
    string collectionViewUrl;
};

type ItuneSearchResult record {
    ItuneSearchItem[] results;
};

type Album record {|
    string name;
    string url;
|};

service /pickagift on new http:Listener(8081) {
    resource function get albums(string artist) returns Album[]|error {
        http:Client iTunes = check new ("http://itunes.apple.com");
        ItuneSearchResult search = check iTunes->get(serchUrl(artist));
        io:println(search.results[0].collectionName);
        return from ItuneSearchItem i in search.results
            select {name: i.collectionName, url: i.collectionViewUrl};
    }
}

function serchUrl(string artist) returns string {
    return "/search?term=" + artist + "&entity=album&attribute=artistTerm";
}
