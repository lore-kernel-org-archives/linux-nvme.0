From: lkp@intel.com (kbuild test robot)
Date: Sat, 22 Jul 2017 11:45:55 +0800
Subject: [PATCH v3 1/3] string.h: add memcpy_and_pad()
In-Reply-To: <20170720163402.17793-2-mwilck@suse.com>
Message-ID: <201707221134.lYiTU9Zo%fengguang.wu@intel.com>

Hi Martin,

[auto build test WARNING on linus/master]
[also build test WARNING on v4.13-rc1 next-20170721]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Martin-Wilck/Improve-readbility-of-NVME-wwid-attribute/20170722-110309
config: x86_64-randconfig-x005-201729 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

   In file included from include/uapi/linux/stddef.h:1:0,
                    from include/linux/stddef.h:4,
                    from include/uapi/linux/posix_types.h:4,
                    from include/uapi/linux/types.h:13,
                    from include/linux/types.h:5,
                    from include/linux/mod_devicetable.h:11,
                    from scripts/mod/devicetable-offsets.c:2:
>> include/linux/compiler.h:162:4: warning: '______f' is static but declared in inline function 'memcpy_and_pad' which is not static
       ______f = {     \
       ^
   include/linux/compiler.h:154:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/linux/string.h:421:2: note: in expansion of macro 'if'
     if (dest_len > count) {
     ^~
>> include/linux/compiler.h:162:4: warning: '______f' is static but declared in inline function 'memcpy_and_pad' which is not static
       ______f = {     \
       ^
   include/linux/compiler.h:154:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/linux/string.h:419:2: note: in expansion of macro 'if'
     if (dest_size < dest_len)
     ^~
>> include/linux/compiler.h:162:4: warning: '______f' is static but declared in inline function 'memcpy_and_pad' which is not static
       ______f = {     \
       ^
   include/linux/compiler.h:154:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/linux/string.h:416:8: note: in expansion of macro 'if'
      else if (src_size < dest_len && src_size < count)
           ^~
>> include/linux/compiler.h:162:4: warning: '______f' is static but declared in inline function 'memcpy_and_pad' which is not static
       ______f = {     \
       ^
   include/linux/compiler.h:154:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/linux/string.h:414:3: note: in expansion of macro 'if'
      if (dest_size < dest_len && dest_size < count)
      ^~
>> include/linux/compiler.h:162:4: warning: '______f' is static but declared in inline function 'memcpy_and_pad' which is not static
       ______f = {     \
       ^
   include/linux/compiler.h:154:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/linux/string.h:413:2: note: in expansion of macro 'if'
     if (__builtin_constant_p(dest_len) && __builtin_constant_p(count)) {
     ^~
   include/linux/compiler.h:162:4: warning: '______f' is static but declared in inline function 'strcpy' which is not static
       ______f = {     \
       ^
   include/linux/compiler.h:154:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/linux/string.h:391:2: note: in expansion of macro 'if'
     if (p_size == (size_t)-1 && q_size == (size_t)-1)
     ^~
   include/linux/compiler.h:162:4: warning: '______f' is static but declared in inline function 'kmemdup' which is not static
       ______f = {     \
       ^
   include/linux/compiler.h:154:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/linux/string.h:381:2: note: in expansion of macro 'if'
     if (p_size < size)
     ^~
   include/linux/compiler.h:162:4: warning: '______f' is static but declared in inline function 'kmemdup' which is not static
       ______f = {     \
       ^
   include/linux/compiler.h:154:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/linux/string.h:379:2: note: in expansion of macro 'if'
     if (__builtin_constant_p(size) && p_size < size)
     ^~
   include/linux/compiler.h:162:4: warning: '______f' is static but declared in inline function 'memchr_inv' which is not static
       ______f = {     \
       ^
   include/linux/compiler.h:154:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/linux/string.h:370:2: note: in expansion of macro 'if'
     if (p_size < size)
     ^~
   include/linux/compiler.h:162:4: warning: '______f' is static but declared in inline function 'memchr_inv' which is not static
       ______f = {     \
       ^
   include/linux/compiler.h:154:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/linux/string.h:368:2: note: in expansion of macro 'if'
     if (__builtin_constant_p(size) && p_size < size)
     ^~
   include/linux/compiler.h:162:4: warning: '______f' is static but declared in inline function 'memchr' which is not static
       ______f = {     \
       ^
   include/linux/compiler.h:154:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/linux/string.h:359:2: note: in expansion of macro 'if'
     if (p_size < size)
     ^~
   include/linux/compiler.h:162:4: warning: '______f' is static but declared in inline function 'memchr' which is not static
       ______f = {     \
       ^
   include/linux/compiler.h:154:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/linux/string.h:357:2: note: in expansion of macro 'if'
     if (__builtin_constant_p(size) && p_size < size)
     ^~
   include/linux/compiler.h:162:4: warning: '______f' is static but declared in inline function 'memcmp' which is not static
       ______f = {     \
       ^
   include/linux/compiler.h:154:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/linux/string.h:349:2: note: in expansion of macro 'if'
     if (p_size < size || q_size < size)
     ^~
   include/linux/compiler.h:162:4: warning: '______f' is static but declared in inline function 'memcmp' which is not static
       ______f = {     \
       ^
   include/linux/compiler.h:154:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/linux/string.h:346:3: note: in expansion of macro 'if'
      if (q_size < size)
      ^~
   include/linux/compiler.h:162:4: warning: '______f' is static but declared in inline function 'memcmp' which is not static
       ______f = {     \
       ^
   include/linux/compiler.h:154:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/linux/string.h:344:3: note: in expansion of macro 'if'
      if (p_size < size)
      ^~
   include/linux/compiler.h:162:4: warning: '______f' is static but declared in inline function 'memcmp' which is not static
       ______f = {     \

vim +162 include/linux/compiler.h

2bcd521a Steven Rostedt 2008-11-21  148  
2bcd521a Steven Rostedt 2008-11-21  149  #ifdef CONFIG_PROFILE_ALL_BRANCHES
2bcd521a Steven Rostedt 2008-11-21  150  /*
2bcd521a Steven Rostedt 2008-11-21  151   * "Define 'is'", Bill Clinton
2bcd521a Steven Rostedt 2008-11-21  152   * "Define 'if'", Steven Rostedt
2bcd521a Steven Rostedt 2008-11-21  153   */
ab3c9c68 Linus Torvalds 2009-04-07  154  #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
ab3c9c68 Linus Torvalds 2009-04-07  155  #define __trace_if(cond) \
b33c8ff4 Arnd Bergmann  2016-02-12  156  	if (__builtin_constant_p(!!(cond)) ? !!(cond) :			\
2bcd521a Steven Rostedt 2008-11-21  157  	({								\
2bcd521a Steven Rostedt 2008-11-21  158  		int ______r;						\
2bcd521a Steven Rostedt 2008-11-21  159  		static struct ftrace_branch_data			\
2bcd521a Steven Rostedt 2008-11-21  160  			__attribute__((__aligned__(4)))			\
2bcd521a Steven Rostedt 2008-11-21  161  			__attribute__((section("_ftrace_branch")))	\
2bcd521a Steven Rostedt 2008-11-21 @162  			______f = {					\
2bcd521a Steven Rostedt 2008-11-21  163  				.func = __func__,			\
2bcd521a Steven Rostedt 2008-11-21  164  				.file = __FILE__,			\
2bcd521a Steven Rostedt 2008-11-21  165  				.line = __LINE__,			\
2bcd521a Steven Rostedt 2008-11-21  166  			};						\
2bcd521a Steven Rostedt 2008-11-21  167  		______r = !!(cond);					\
97e7e4f3 Witold Baryluk 2009-03-17  168  		______f.miss_hit[______r]++;					\
2bcd521a Steven Rostedt 2008-11-21  169  		______r;						\
2bcd521a Steven Rostedt 2008-11-21  170  	}))
2bcd521a Steven Rostedt 2008-11-21  171  #endif /* CONFIG_PROFILE_ALL_BRANCHES */
2bcd521a Steven Rostedt 2008-11-21  172  

:::::: The code at line 162 was first introduced by commit
:::::: 2bcd521a684cc94befbe2ce7d5b613c841b0d304 trace: profile all if conditionals

:::::: TO: Steven Rostedt <srostedt at redhat.com>
:::::: CC: Ingo Molnar <mingo at elte.hu>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 26326 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20170722/7326d48c/attachment-0001.gz>
