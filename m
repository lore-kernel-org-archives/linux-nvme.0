From: lkp@intel.com (kbuild test robot)
Date: Mon, 24 Jul 2017 02:18:08 +0800
Subject: [PATCH v3 1/3] string.h: add memcpy_and_pad()
In-Reply-To: <20170720163402.17793-2-mwilck@suse.com>
Message-ID: <201707240247.2vcuFp67%fengguang.wu@intel.com>

Hi Martin,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.13-rc1 next-20170721]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Martin-Wilck/Improve-readbility-of-NVME-wwid-attribute/20170722-110309
config: x86_64-randconfig-v0-07240033 (attached as .config)
compiler: gcc-4.4 (Debian 4.4.7-8) 4.4.7
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   cc1: warnings being treated as errors
   In file included from include/linux/bitmap.h:8,
                    from include/linux/cpumask.h:11,
                    from arch/x86/include/asm/cpumask.h:4,
                    from arch/x86/include/asm/msr.h:10,
                    from arch/x86/include/asm/processor.h:20,
                    from arch/x86/include/asm/cpufeature.h:4,
                    from arch/x86/include/asm/thread_info.h:52,
                    from include/linux/thread_info.h:37,
                    from arch/x86/include/asm/preempt.h:6,
                    from include/linux/preempt.h:80,
                    from include/linux/spinlock.h:50,
                    from include/linux/mmzone.h:7,
                    from include/linux/gfp.h:5,
                    from include/linux/slab.h:14,
                    from include/linux/resource_ext.h:19,
                    from include/linux/acpi.h:26,
                    from drivers/gpu//drm/i915/i915_drv.c:30:
   include/linux/string.h: In function 'memcpy_and_pad':
>> include/linux/string.h:413: error: '______f' is static but declared in inline function 'memcpy_and_pad' which is not static
   include/linux/string.h:414: error: '______f' is static but declared in inline function 'memcpy_and_pad' which is not static
   include/linux/string.h:416: error: '______f' is static but declared in inline function 'memcpy_and_pad' which is not static
   include/linux/string.h:419: error: '______f' is static but declared in inline function 'memcpy_and_pad' which is not static
   include/linux/string.h:421: error: '______f' is static but declared in inline function 'memcpy_and_pad' which is not static

vim +413 include/linux/string.h

   398	
   399	/**
   400	 * memcpy_and_pad - Copy one buffer to another with padding
   401	 * @dest: Where to copy to
   402	 * @dest_len: The destination buffer size
   403	 * @src: Where to copy from
   404	 * @count: The number of bytes to copy
   405	 * @pad: Character to use for padding if space is left in destination.
   406	 */
   407	__FORTIFY_INLINE void memcpy_and_pad(void *dest, size_t dest_len,
   408					     const void *src, size_t count, int pad)
   409	{
   410		size_t dest_size = __builtin_object_size(dest, 0);
   411		size_t src_size = __builtin_object_size(src, 0);
   412	
 > 413		if (__builtin_constant_p(dest_len) && __builtin_constant_p(count)) {
   414			if (dest_size < dest_len && dest_size < count)
   415				__write_overflow();
   416			else if (src_size < dest_len && src_size < count)
   417				__read_overflow3();
   418		}
   419		if (dest_size < dest_len)
   420			fortify_panic(__func__);
   421		if (dest_len > count) {
   422			memcpy(dest, src, count);
   423			memset(dest + count, pad,  dest_len - count);
   424		} else
   425			memcpy(dest, src, dest_len);
   426	}
   427	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 29271 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20170724/b929cb26/attachment-0001.gz>
