import ballerina/http;
import ballerina/io;

type GithubSearchItem record {
    string collectionName;
    string collectionViewUrl;
};

type GithubSearchResult record {
    GithubSearchItem[] results;
};

service /pickagift on new http:Listener(8080) {
    resource function get albums(string artist) returns error? {
         http:Client github =check new("");
    GithubSearchResult search = check github->get("");
    io:println(search.results[0].collectionName);
    return search.results[0].collectionName;
    }
}

function 