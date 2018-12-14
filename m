From: lkp@intel.com (kbuild test robot)
Date: Fri, 14 Dec 2018 22:13:29 +0800
Subject: [PATCH] scatterlist: Update size type to support greater then
 4GB size.
In-Reply-To: <1544595853-18492-1-git-send-email-amhetre@nvidia.com>
References: <1544595853-18492-1-git-send-email-amhetre@nvidia.com>
Message-ID: <201812142241.Z0ZTNRxX%fengguang.wu@intel.com>

Hi Krishna,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.20-rc6 next-20181214]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Ashish-Mhetre/scatterlist-Update-size-type-to-support-greater-then-4GB-size/20181214-214801
config: x86_64-randconfig-x000-201849 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/init.h:5:0,
                    from drivers/nvme//host/fabrics.c:15:
   drivers/nvme//host/fabrics.c: In function 'nvmf_exit':
>> include/linux/compiler.h:372:38: error: call to '__compiletime_assert_1149' declared with attribute error: BUILD_BUG_ON failed: sizeof(struct nvmf_connect_command) != 64
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
                                         ^
   include/linux/compiler.h:353:4: note: in definition of macro '__compiletime_assert'
       prefix ## suffix();    \
       ^~~~~~
   include/linux/compiler.h:372:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:45:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:69:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
     ^~~~~~~~~~~~~~~~
>> drivers/nvme//host/fabrics.c:1149:2: note: in expansion of macro 'BUILD_BUG_ON'
     BUILD_BUG_ON(sizeof(struct nvmf_connect_command) != 64);
     ^~~~~~~~~~~~
--
   In file included from include/linux/init.h:5:0,
                    from drivers/nvme/host/fabrics.c:15:
   drivers/nvme/host/fabrics.c: In function 'nvmf_exit':
>> include/linux/compiler.h:372:38: error: call to '__compiletime_assert_1149' declared with attribute error: BUILD_BUG_ON failed: sizeof(struct nvmf_connect_command) != 64
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
                                         ^
   include/linux/compiler.h:353:4: note: in definition of macro '__compiletime_assert'
       prefix ## suffix();    \
       ^~~~~~
   include/linux/compiler.h:372:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:45:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:69:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
     ^~~~~~~~~~~~~~~~
   drivers/nvme/host/fabrics.c:1149:2: note: in expansion of macro 'BUILD_BUG_ON'
     BUILD_BUG_ON(sizeof(struct nvmf_connect_command) != 64);
     ^~~~~~~~~~~~

vim +/__compiletime_assert_1149 +372 include/linux/compiler.h

9a8ab1c3 Daniel Santos 2013-02-21  358  
9a8ab1c3 Daniel Santos 2013-02-21  359  #define _compiletime_assert(condition, msg, prefix, suffix) \
9a8ab1c3 Daniel Santos 2013-02-21  360  	__compiletime_assert(condition, msg, prefix, suffix)
9a8ab1c3 Daniel Santos 2013-02-21  361  
9a8ab1c3 Daniel Santos 2013-02-21  362  /**
9a8ab1c3 Daniel Santos 2013-02-21  363   * compiletime_assert - break build and emit msg if condition is false
9a8ab1c3 Daniel Santos 2013-02-21  364   * @condition: a compile-time constant condition to check
9a8ab1c3 Daniel Santos 2013-02-21  365   * @msg:       a message to emit if condition is false
9a8ab1c3 Daniel Santos 2013-02-21  366   *
9a8ab1c3 Daniel Santos 2013-02-21  367   * In tradition of POSIX assert, this macro will break the build if the
9a8ab1c3 Daniel Santos 2013-02-21  368   * supplied condition is *false*, emitting the supplied error message if the
9a8ab1c3 Daniel Santos 2013-02-21  369   * compiler has support to do so.
9a8ab1c3 Daniel Santos 2013-02-21  370   */
9a8ab1c3 Daniel Santos 2013-02-21  371  #define compiletime_assert(condition, msg) \
9a8ab1c3 Daniel Santos 2013-02-21 @372  	_compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
9a8ab1c3 Daniel Santos 2013-02-21  373  

:::::: The code at line 372 was first introduced by commit
:::::: 9a8ab1c39970a4938a72d94e6fd13be88a797590 bug.h, compiler.h: introduce compiletime_assert & BUILD_BUG_ON_MSG

:::::: TO: Daniel Santos <daniel.santos at pobox.com>
:::::: CC: Linus Torvalds <torvalds at linux-foundation.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 30629 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20181214/43937f77/attachment-0001.gz>
