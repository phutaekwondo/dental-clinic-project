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

export function GetAllAPIsPathFixed ( dir = apidir ) {
    const result = GetAllAPIsPath(dir);
    // remove "./pages/" from the beginning of each path
    const prefix_removed = result.map(path => path.replace('./pages', ''));

    // remove extension ".js", ".ts" from the end of each path
    const extension_removed = prefix_removed.map(path => path.replace(/\.[^/.]+$/, ""));

    return extension_removed;
};

// console.log(GetAllAPIsPathFixed());
