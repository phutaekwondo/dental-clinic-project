import { readdirSync, statSync } from 'fs';

const apidir = './pages/api'; 

export function GetAllAPIsPath ( dir = apidir ) {

    var results = [];

    readdirSync(dir).forEach(function(file) {

        file = dir+'/'+file;
        var stat = statSync(file);

        if (stat && stat.isDirectory()) {
            results = results.concat(GetAllAPIsPath(file))
        } else results.push(file);

    });

    return results;
};

console.log(GetAllAPIsPath());
