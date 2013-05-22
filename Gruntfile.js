module.exports = function(grunt) {
    "use strict";

    grunt.initConfig({
        package: grunt.file.readJSON("package.json"),

        // compress
        uglify: {
            konashijs: {
                options: {
                    banner: '/*! <%= package.name %>.js <%= grunt.template.today("yyyy-mm-dd") %> */\n'
                },
                files: {
                    "build/<%= package.name %>-<%= package.version %>.min.js": ["assets/<%= package.name %>.js"],
                }
            }
        },

        shell: {
            copyjs: {
                command: 'cp assets/<%= package.name %>.js build/<%= package.name %>-<%= package.version %>.js;' +
                         'cp assets/<%= package.name %>.js build/<%= package.name %>.js;' +
                         'cp build/<%= package.name %>-<%= package.version %>.min.js build/<%= package.name %>.min.js;'
            }
        }
    });

    grunt.loadNpmTasks("grunt-contrib-uglify");
    grunt.loadNpmTasks("grunt-shell");

    grunt.registerTask("default", [ "uglify", "shell:copyjs" ]);
};
