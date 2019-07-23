# README.md

A `README.md` file is a very useful component of any project
repository; it is the first file that unfamiliar users will open to
learn about your project. If this course uses GitHub, you will also
notice that the README.md is automatically rendered on GitHub as a
simple "homepage" for your project. Instructions for creating your own
GitHub repository from these files may be given during the course. The
same instructions are also summarized in [CONTRIBUTING.md].

## Data

If this project does not contain a data folder, the way to access data
for the worksheets depends on whether you are using RStudio Server and
Jupyter hosted by SESYNC or your own compute resources.

To access the data from a SESYNC hosted environment, open RStudio and
enter the following command at the `>` prompt.

```
file.symlink('/nfs/public-data/training', 'data')
```

Otherwise, download the "data.zip" folder from the course syllabus (if
not currently there, it will be posted after the course), and unzip it
to this "handouts" folder. The result should be a subdirectory called
"data" within this project.

[CONTRIBUTING.md]: CONTRIBUTING.md
