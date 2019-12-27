This is available on https://sumit.murari.me and will be used to host blog only.


# Please to keep the thoughts 

[Personal website](sumit.murari.me), powered by [Jekyll](http://jekyllrb.com/) and 
freely hosted in [Github pages](https://pages.github.com/).

* For local work, use the site variable `local: true` in config.yml, it'll use static bootstrap and jquery libs.


To check change locally:

* `docker-compose up` or `make serve`


To create a new draft:

    * `octopress new draft "your posts drafts name"`
    
    * `make create name='my drafts name'`
    
To publish it as post

    * `octopress publish _drafts/your_draft_file`
    
    * `make publish path='_drafts/your_draft_file'`

To push the post

    * `git commit`
    
    * `git push`


## Copyright & License

Copyright (C) 2017 - Released under the MIT License.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
