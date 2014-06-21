module.exports = function(grunt) {
    "use strict";

    grunt.initConfig({
        package: grunt.file.readJSON("package.json"),

        // compress
        uglify: {
            konashijs: {
                options: {
                     banner: '/*! <%= package.name %>.js v<%= package.version %> <%= grunt.template.today("yyyy-mm-dd") %> http://konashi.ux-xu.com/kjs */\n'
                },
                files: {
                    "build/<%= package.name %>-<%= package.version %>.min.js": ["js/<%= package.name %>.js"],
                    "build/konashi-ext-acdrive.min.js": ["js/konashi-ext-acdrive.js"],
                    "build/konashi-ext-adc.min.js": ["js/konashi-ext-adc.js"],
                    "build/konashi-ext-grove.min.js": ["js/konashi-ext-grove.js"],
                }
            }
        },

        shell: {
            copyjs: {
                command: 'cp js/<%= package.name %>.js build/<%= package.name %>-<%= package.version %>.js;' +
                         'cp js/<%= package.name %>.js build/<%= package.name %>.js;' +
                         'cp build/<%= package.name %>-<%= package.version %>.min.js build/<%= package.name %>.min.js;' +
                         'for d in `find ./samples/ -mindepth 1 -maxdepth 1 -type d`; do cp js/<%= package.name %>.js ${d}/assets/; done;'
            },
            copyextjs: {
                command: 'cp js/konashi-ext-acdrive.js build/;' +
                         'cp js/konashi-ext-adc.js build/;' +
                         'cp js/konashi-ext-grove.js build/;'
            }
        }
    });

    grunt.loadNpmTasks("grunt-contrib-uglify");
    grunt.loadNpmTasks("grunt-shell");

    grunt.registerTask("default", [ "uglify", "shell:copyjs", "shell:copyextjs" ]);
};
