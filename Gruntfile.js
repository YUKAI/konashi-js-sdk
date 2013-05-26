module.exports = function(grunt) {
    "use strict";

    grunt.initConfig({
        package: grunt.file.readJSON("package.json"),

        // compress
        uglify: {
            konashijs: {
                options: {
                     banner: '/*! <%= package.name %>.js <%= grunt.template.today("yyyy-mm-dd") %> http://konashi.ux-xu.com/kjs */\n'
                },
                files: {
                    "build/<%= package.name %>-<%= package.version %>.min.js": ["js/<%= package.name %>.js"],
                }
            }
        },

        shell: {
            copyjs: {
                command: 'cp js/<%= package.name %>.js build/<%= package.name %>-<%= package.version %>.js;' +
                         'cp js/<%= package.name %>.js build/<%= package.name %>.js;' +
                         'cp build/<%= package.name %>-<%= package.version %>.min.js build/<%= package.name %>.min.js;' +
                         'for d in "./samples/*"; do cp js/<%= package.name %>.js ${d}/assets/; done;'
            }
        }
    });

    grunt.loadNpmTasks("grunt-contrib-uglify");
    grunt.loadNpmTasks("grunt-shell");

    grunt.registerTask("default", [ "uglify", "shell:copyjs" ]);
};
