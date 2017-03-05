# DDSCaseStudy1

To start contributing you can use git from command line or use [GitHub Desktop](https://desktop.github.com)

###Instructions for contributing with git from command line:

* Clone the repo (only once):<br>
```sh
git clone https://github.com/post2web/DDSCaseStudy1.git
```
* Sync with the repo:<br>
```sh
git pull
```
* Make changes - edit/create/delete files and folders.
* Send your changes to github.<br/>
```sh
# contribute all the changes your made
git add -A
# commit the changes to your local git
git commit -m "description of changes"
# send the changes to github
git push
```

### Todo list: (write your name on the task before you start it)
- [x] Create file structure of the project - Ivelin
- [ ] Write download data code in source/download.R
- [x-LVB ] Add methods in the Makefile: download_data and delete_data . --LVB: These are really 1 united task. I have created a Makefile to download the data and clean. I am starting with EDS. GDP is in good shape at the onset.  We can have a separate Makefile to download the data. I am writing one to clean it.  We need another for creating a Makefile to Merge.  Then a Master Makefile to pull the separate Makefiles together.
- [x -LVB ] Write clean data code in source/clean.R
- [x-LVB ] Add methods in the Makefile: clean_data
- [ ] Write a draft code in Analysis.Rmd
- [ ] Merge Makefile with code to Merge.
- [ ] Master Makefile to pull Download/Clean Makefile & Merge Makefile together.
