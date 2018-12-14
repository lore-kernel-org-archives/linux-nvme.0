From: lkp@intel.com (kbuild test robot)
Date: Fri, 14 Dec 2018 22:13:30 +0800
Subject: [PATCH] scatterlist: Update size type to support greater then
 4GB size.
In-Reply-To: <1544595853-18492-1-git-send-email-amhetre@nvidia.com>
References: <1544595853-18492-1-git-send-email-amhetre@nvidia.com>
Message-ID: <201812142219.cpqahfNN%fengguang.wu@intel.com>

Hi Krishna,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.20-rc6 next-20181214]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Ashish-Mhetre/scatterlist-Update-size-type-to-support-greater-then-4GB-size/20181214-214801
config: x86_64-randconfig-x012-201849 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/kernel.h:10:0,
                    from include/linux/list.h:9,
                    from include/linux/async.h:16,
                    from drivers/nvme/host/pci.c:16:
   In function '_nvme_check_size',
       inlined from 'nvme_exit' at drivers/nvme/host/pci.c:2748:2:
>> include/linux/compiler.h:372:38: error: call to '__compiletime_assert_206' declared with attribute error: BUILD_BUG_ON failed: sizeof(struct nvme_rw_command) != 64
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
>> drivers/nvme/host/pci.c:206:2: note: in expansion of macro 'BUILD_BUG_ON'
     BUILD_BUG_ON(sizeof(struct nvme_rw_command) != 64);
     ^~~~~~~~~~~~
>> include/linux/compiler.h:372:38: error: call to '__compiletime_assert_210' declared with attribute error: BUILD_BUG_ON failed: sizeof(struct nvme_features) != 64
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
   drivers/nvme/host/pci.c:210:2: note: in expansion of macro 'BUILD_BUG_ON'
     BUILD_BUG_ON(sizeof(struct nvme_features) != 64);
     ^~~~~~~~~~~~
>> include/linux/compiler.h:372:38: error: call to '__compiletime_assert_213' declared with attribute error: BUILD_BUG_ON failed: sizeof(struct nvme_command) != 64
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
   drivers/nvme/host/pci.c:213:2: note: in expansion of macro 'BUILD_BUG_ON'
     BUILD_BUG_ON(sizeof(struct nvme_command) != 64);
     ^~~~~~~~~~~~
--
   In file included from include/linux/kernel.h:10:0,
                    from include/linux/list.h:9,
                    from include/linux/async.h:16,
                    from drivers/nvme//host/pci.c:16:
   In function '_nvme_check_size',
       inlined from 'nvme_exit' at drivers/nvme//host/pci.c:2748:2:
>> include/linux/compiler.h:372:38: error: call to '__compiletime_assert_206' declared with attribute error: BUILD_BUG_ON failed: sizeof(struct nvme_rw_command) != 64
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
   drivers/nvme//host/pci.c:206:2: note: in expansion of macro 'BUILD_BUG_ON'
     BUILD_BUG_ON(sizeof(struct nvme_rw_command) != 64);
     ^~~~~~~~~~~~
>> include/linux/compiler.h:372:38: error: call to '__compiletime_assert_210' declared with attribute error: BUILD_BUG_ON failed: sizeof(struct nvme_features) != 64
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
   drivers/nvme//host/pci.c:210:2: note: in expansion of macro 'BUILD_BUG_ON'
     BUILD_BUG_ON(sizeof(struct nvme_features) != 64);
     ^~~~~~~~~~~~
>> include/linux/compiler.h:372:38: error: call to '__compiletime_assert_213' declared with attribute error: BUILD_BUG_ON failed: sizeof(struct nvme_command) != 64
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
   drivers/nvme//host/pci.c:213:2: note: in expansion of macro 'BUILD_BUG_ON'
     BUILD_BUG_ON(sizeof(struct nvme_command) != 64);
     ^~~~~~~~~~~~

vim +/BUILD_BUG_ON +206 drivers/nvme/host/pci.c

b60503ba drivers/block/nvme.c      Matthew Wilcox     2011-01-20  200  
b60503ba drivers/block/nvme.c      Matthew Wilcox     2011-01-20  201  /*
b60503ba drivers/block/nvme.c      Matthew Wilcox     2011-01-20  202   * Check we didin't inadvertently grow the command struct
b60503ba drivers/block/nvme.c      Matthew Wilcox     2011-01-20  203   */
b60503ba drivers/block/nvme.c      Matthew Wilcox     2011-01-20  204  static inline void _nvme_check_size(void)
b60503ba drivers/block/nvme.c      Matthew Wilcox     2011-01-20  205  {
b60503ba drivers/block/nvme.c      Matthew Wilcox     2011-01-20 @206  	BUILD_BUG_ON(sizeof(struct nvme_rw_command) != 64);
b60503ba drivers/block/nvme.c      Matthew Wilcox     2011-01-20  207  	BUILD_BUG_ON(sizeof(struct nvme_create_cq) != 64);
b60503ba drivers/block/nvme.c      Matthew Wilcox     2011-01-20  208  	BUILD_BUG_ON(sizeof(struct nvme_create_sq) != 64);
b60503ba drivers/block/nvme.c      Matthew Wilcox     2011-01-20  209  	BUILD_BUG_ON(sizeof(struct nvme_delete_queue) != 64);
b60503ba drivers/block/nvme.c      Matthew Wilcox     2011-01-20  210  	BUILD_BUG_ON(sizeof(struct nvme_features) != 64);
f8ebf840 drivers/block/nvme-core.c Vishal Verma       2013-03-27  211  	BUILD_BUG_ON(sizeof(struct nvme_format_cmd) != 64);
c30341dc drivers/block/nvme-core.c Keith Busch        2013-12-10  212  	BUILD_BUG_ON(sizeof(struct nvme_abort_cmd) != 64);
b60503ba drivers/block/nvme.c      Matthew Wilcox     2011-01-20  213  	BUILD_BUG_ON(sizeof(struct nvme_command) != 64);
0add5e8e drivers/nvme/host/pci.c   Johannes Thumshirn 2017-06-07  214  	BUILD_BUG_ON(sizeof(struct nvme_id_ctrl) != NVME_IDENTIFY_DATA_SIZE);
0add5e8e drivers/nvme/host/pci.c   Johannes Thumshirn 2017-06-07  215  	BUILD_BUG_ON(sizeof(struct nvme_id_ns) != NVME_IDENTIFY_DATA_SIZE);
b60503ba drivers/block/nvme.c      Matthew Wilcox     2011-01-20  216  	BUILD_BUG_ON(sizeof(struct nvme_lba_range_type) != 64);
6ecec745 drivers/block/nvme.c      Keith Busch        2012-09-26  217  	BUILD_BUG_ON(sizeof(struct nvme_smart_log) != 512);
f9f38e33 drivers/nvme/host/pci.c   Helen Koike        2017-04-10  218  	BUILD_BUG_ON(sizeof(struct nvme_dbbuf) != 64);
f9f38e33 drivers/nvme/host/pci.c   Helen Koike        2017-04-10  219  }
f9f38e33 drivers/nvme/host/pci.c   Helen Koike        2017-04-10  220  

:::::: The code at line 206 was first introduced by commit
:::::: b60503ba432b16fc84442a84e29a7aad2c0c363d NVMe: New driver

:::::: TO: Matthew Wilcox <matthew.r.wilcox at intel.com>
:::::: CC: Matthew Wilcox <matthew.r.wilcox at intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 29920 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20181214/5325f831/attachment-0001.gz>
