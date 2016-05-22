xampp_linux_7_0 Cookbook
========================
xampp_linux_7_0

Requirements
------------


Attributes
----------


Usage
-----
#### xampp_linux_7_0::default
Just include `xampp_linux_7_0` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[xampp_linux_7_0]"
  ],
  "xampp_linux_7_0": {
    "x64_str": "x64",
    "build_number": "5",
    "release_number": "0",
    "file_sha256sum": "8b93005ab1dda77e112fa24ef18542e83cbe05c32a5b17f1172818633d351ff0"
  }
}
```

Contributing
------------


Source repository
------------
This cookbook in the [source repository](https://github.com/aska-ltd-jp/xampp_linux_7_0/)


License and Authors
-------------------
**Author:**  developers.oss@aska-ltd.jp

**Copyright:** 2016, Aska Co., Ltd. http://www.aska-ltd.jp/

```
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
