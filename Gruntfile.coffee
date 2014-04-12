module.exports = (grunt) ->
  # Constants
  THEME = '../pelican-svbhack'

  grunt.initConfig
    pelican:
      dev:
        contentDir: 'src'
        configFile: 'local_settings_dev.py'
        outputDir: 'output'
      dist:
        contentDir: 'src'
        configFile: 'local_settings.py'
        outputDir: '.'

    watch:
      src:
        files: ['src/**/*.md', 'src/static/**']
        tasks: 'pelican:dev'
      theme:
        files: [
          "#{THEME}/templates/**"
          "#{THEME}/static/css/*.css"
        ]
        tasks: 'pelican:dev'
      options:
        livereload: yes

    connect:
      server:
        options:
          port: 8080
          base: 'output'

  grunt.loadNpmTasks 'grunt-pelican'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-connect'

  grunt.registerTask 'dev', [
    'pelican:dev'
  ]

  grunt.registerTask 'default', [
    'connect'
    'watch'
  ]
