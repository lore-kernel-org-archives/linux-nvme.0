Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51BBEC00140
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Aug 2022 21:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J/VtjHaJk9PykAUaAFishNK4NuoYCF2NdQqgdnElEHA=; b=nojKmyJzlKRl8IefRJHZyH/8Pp
	zacxYGMBiZtZPeuiOaWMSV0U2ziuio6hK6iM2VSE6V3pvU2gcSigo3Cy7JkehZI+1L0OxSJM0l8DM
	StWMDkpTYnnH7EaP5tUrh7NTD2WSJUxm3OsyqaCWgz7I64iBaL+SgTQC/b1zwWQRPIE0tWS70vs32
	D7YRKRLlSey5h4Vc6fyz8ioV/jTWnsNgvJFiUYk7Nhpa/MggcHvliZko0i2S8VQRCnA8P7b/9mycR
	OSCan27Z7BW/CGkrGpoqitIvifmLnUkT1U9mMPlQDF6eatUufgLRGhjuABIoZQir3H3D1UECxo9qn
	9EoH616Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oK4nG-000nSs-N8; Fri, 05 Aug 2022 21:23:42 +0000
Received: from mga04.intel.com ([192.55.52.120])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oK4nC-000nPo-MZ
	for linux-nvme@lists.infradead.org; Fri, 05 Aug 2022 21:23:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659734618; x=1691270618;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R+cx4naRn4EL5oWfO7JYH/qaE90sSoLCRakX+2FvYew=;
  b=EYODpXLhI0Id7aBze5FIrVGvO6ZARhyhbB7K2TyhxeBrhsmSeVDMJNAA
   xPxtw6AoNTEFBN/memdhbJf20ZYVZ9ri9o/1rusb3j+e9/+miSrVAcj61
   /GZXMRLdiLSy7ib8LFfetN/QW1JbDM+ZYUBW8uCYj2K3NBHaInqwSVaZ0
   tj8hckTzlX52bcb1wcme6RfNEmN3J/CdkCPEDoTAjMxNB4nAIct18HLt9
   /lav6VHLv4oL2vRTMUwEZ0JO1hqkFSqvsL8zmThZ9Wnee3PRqi8keDTwx
   opc9YHLnN0m+1CYGHh3Bn0QDN1wSQap9vACPwtyrYTZGp2NhbD37cx8kv
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="289053277"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="289053277"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 14:23:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="603728097"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 05 Aug 2022 14:23:33 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1oK4n6-000JkF-2P;
	Fri, 05 Aug 2022 21:23:32 +0000
Date: Sat, 6 Aug 2022 05:22:47 +0800
From: kernel test robot <lkp@intel.com>
To: Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk, hch@lst.de
Cc: kbuild-all@lists.01.org, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	ming.lei@redhat.com, joshiiitr@gmail.com, gost.dev@samsung.com,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH 4/4] nvme: wire up async polling for io passthrough
 commands
Message-ID: <202208060547.zSVYtFTN-lkp@intel.com>
References: <20220805154226.155008-5-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805154226.155008-5-joshi.k@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220805_142338_786748_05F6696A 
X-CRM114-Status: GOOD (  13.89  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Kanchan,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on axboe-block/for-next]
[also build test ERROR on linus/master]
[cannot apply to hch-configfs/for-next v5.19]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kanchan-Joshi/fs-add-file_operations-uring_cmd_iopoll/20220806-004320
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220806/202208060547.zSVYtFTN-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/0964795577fbf09d8b315269504b5e87b5ac492b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Kanchan-Joshi/fs-add-file_operations-uring_cmd_iopoll/20220806-004320
        git checkout 0964795577fbf09d8b315269504b5e87b5ac492b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   drivers/nvme/host/ioctl.c: In function 'nvme_ns_head_chr_uring_cmd_iopoll':
>> drivers/nvme/host/ioctl.c:737:39: error: 'struct io_uring_cmd' has no member named 'private'
     737 |                 bio = READ_ONCE(ioucmd->private);
         |                                       ^~
   include/linux/compiler_types.h:334:23: note: in definition of macro '__compiletime_assert'
     334 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:354:9: note: in expansion of macro '_compiletime_assert'
     354 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/nvme/host/ioctl.c:737:23: note: in expansion of macro 'READ_ONCE'
     737 |                 bio = READ_ONCE(ioucmd->private);
         |                       ^~~~~~~~~
>> drivers/nvme/host/ioctl.c:737:39: error: 'struct io_uring_cmd' has no member named 'private'
     737 |                 bio = READ_ONCE(ioucmd->private);
         |                                       ^~
   include/linux/compiler_types.h:334:23: note: in definition of macro '__compiletime_assert'
     334 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:354:9: note: in expansion of macro '_compiletime_assert'
     354 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/nvme/host/ioctl.c:737:23: note: in expansion of macro 'READ_ONCE'
     737 |                 bio = READ_ONCE(ioucmd->private);
         |                       ^~~~~~~~~
>> drivers/nvme/host/ioctl.c:737:39: error: 'struct io_uring_cmd' has no member named 'private'
     737 |                 bio = READ_ONCE(ioucmd->private);
         |                                       ^~
   include/linux/compiler_types.h:334:23: note: in definition of macro '__compiletime_assert'
     334 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:354:9: note: in expansion of macro '_compiletime_assert'
     354 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/nvme/host/ioctl.c:737:23: note: in expansion of macro 'READ_ONCE'
     737 |                 bio = READ_ONCE(ioucmd->private);
         |                       ^~~~~~~~~
>> drivers/nvme/host/ioctl.c:737:39: error: 'struct io_uring_cmd' has no member named 'private'
     737 |                 bio = READ_ONCE(ioucmd->private);
         |                                       ^~
   include/linux/compiler_types.h:334:23: note: in definition of macro '__compiletime_assert'
     334 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:354:9: note: in expansion of macro '_compiletime_assert'
     354 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/nvme/host/ioctl.c:737:23: note: in expansion of macro 'READ_ONCE'
     737 |                 bio = READ_ONCE(ioucmd->private);
         |                       ^~~~~~~~~
>> drivers/nvme/host/ioctl.c:737:39: error: 'struct io_uring_cmd' has no member named 'private'
     737 |                 bio = READ_ONCE(ioucmd->private);
         |                                       ^~
   include/linux/compiler_types.h:334:23: note: in definition of macro '__compiletime_assert'
     334 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:354:9: note: in expansion of macro '_compiletime_assert'
     354 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/nvme/host/ioctl.c:737:23: note: in expansion of macro 'READ_ONCE'
     737 |                 bio = READ_ONCE(ioucmd->private);
         |                       ^~~~~~~~~
>> drivers/nvme/host/ioctl.c:737:39: error: 'struct io_uring_cmd' has no member named 'private'
     737 |                 bio = READ_ONCE(ioucmd->private);
         |                                       ^~
   include/linux/compiler_types.h:310:27: note: in definition of macro '__unqual_scalar_typeof'
     310 |                 _Generic((x),                                           \
         |                           ^
   include/asm-generic/rwonce.h:50:9: note: in expansion of macro '__READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |         ^~~~~~~~~~~
   drivers/nvme/host/ioctl.c:737:23: note: in expansion of macro 'READ_ONCE'
     737 |                 bio = READ_ONCE(ioucmd->private);
         |                       ^~~~~~~~~
   In file included from ./arch/x86/include/generated/asm/rwonce.h:1,
                    from include/linux/compiler.h:248,
                    from include/linux/ptrace.h:5,
                    from drivers/nvme/host/ioctl.c:6:
>> drivers/nvme/host/ioctl.c:737:39: error: 'struct io_uring_cmd' has no member named 'private'
     737 |                 bio = READ_ONCE(ioucmd->private);
         |                                       ^~
   include/asm-generic/rwonce.h:44:73: note: in definition of macro '__READ_ONCE'
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                                                                         ^
   drivers/nvme/host/ioctl.c:737:23: note: in expansion of macro 'READ_ONCE'
     737 |                 bio = READ_ONCE(ioucmd->private);
         |                       ^~~~~~~~~


vim +737 drivers/nvme/host/ioctl.c

   724	
   725	int nvme_ns_head_chr_uring_cmd_iopoll(struct io_uring_cmd *ioucmd)
   726	{
   727		struct cdev *cdev = file_inode(ioucmd->file)->i_cdev;
   728		struct nvme_ns_head *head = container_of(cdev, struct nvme_ns_head, cdev);
   729		int srcu_idx = srcu_read_lock(&head->srcu);
   730		struct nvme_ns *ns = nvme_find_path(head);
   731		struct bio *bio;
   732		int ret = 0;
   733		struct request_queue *q;
   734	
   735		if (ns) {
   736			rcu_read_lock();
 > 737			bio = READ_ONCE(ioucmd->private);
   738			q = ns->queue;
   739			if (test_bit(QUEUE_FLAG_POLL, &q->queue_flags) && bio
   740					&& bio->bi_bdev)
   741				ret = bio_poll(bio, 0, 0);
   742			rcu_read_unlock();
   743		}
   744		srcu_read_unlock(&head->srcu, srcu_idx);
   745		return ret;
   746	}
   747	#endif /* CONFIG_NVME_MULTIPATH */
   748	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

