Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6122CC636D6
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Feb 2023 21:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a7EVORFRMg5/wyeEhsw3mx5edBKi6IjoCdD4kzMxk1w=; b=zluf+395pwT9srcy1MaP3GDqSv
	NFmOJwLCK5MKCZcPYVgOcA8fK9Zc9RR46Z6W0fIfk8PHZa3ey8jL3WzZgFXeMwKUTY7ZjIXBkFV19
	PRfIfDdVeYfPISmBxsZbnkBoQIRcnDCcxku8qMj9vzg1oiHFRwU8ev3t9HvP/LSRDnN2ZDUZfb06p
	INNDnYd9ohzdOfEneAi7u9BAse1UlOaqMr2FF6V8attiYbapn7RuUndLBepznJIXwfdj3f9/Kit8+
	EoZ9eeW8Au8yhk9w+v1snPMZsRaf+IasC1wLLWNbro7680iV9jzwcRGqs0FITz2r1vjg8YdExlDa5
	6PBd8jVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pUEAI-005iYv-BB; Mon, 20 Feb 2023 21:57:42 +0000
Received: from mga02.intel.com ([134.134.136.20])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pUEAE-005iYH-AR
	for linux-nvme@lists.infradead.org; Mon, 20 Feb 2023 21:57:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676930258; x=1708466258;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lFNJ4xZ2jtjUGX9TOVIKdIbazyFjXPKRgiWY4LvKm+s=;
  b=h005BTni2JzgcrHCsXNBaX8RY8zkDZ/YbZZ4ZryP6drsE+N8roGe8ue0
   I3LOkQSH37MUBIP+GNUnpxQ3ogPok15lDqH4frDN1e6UbYKeFmhCmLYcn
   QsdUVDeSeZz4MBGAeq4i717JbfwOTBeLCPsGksSMFvYvPTS0bd5abW843
   hg2G1WJ5hNV7uUuoR+8SsHR/V7rYAdPtDey6M6mCziR+U5KONPJTdRA+J
   CiV/Cn3UGNIqlL+ZPhtsKjs3HMT4T/BLeHlp9OR3ezUtq1BZ5ofMDBZL0
   rc4mltx4cyVyRT0v3OR9PXYWIPmRfb9JUYArkjLOzcFsNdb5E+Hg1w59u
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="320621931"
X-IronPort-AV: E=Sophos;i="5.97,313,1669104000"; 
   d="scan'208";a="320621931"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2023 13:57:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="845438006"
X-IronPort-AV: E=Sophos;i="5.97,313,1669104000"; 
   d="scan'208";a="845438006"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 20 Feb 2023 13:57:31 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1pUEA6-000ECb-1f;
	Mon, 20 Feb 2023 21:57:30 +0000
Date: Tue, 21 Feb 2023 05:56:58 +0800
From: kernel test robot <lkp@intel.com>
To: Nitesh Shetty <nj.shetty@samsung.com>, Jens Axboe <axboe@kernel.dk>,
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	dm-devel@redhat.com, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: oe-kbuild-all@lists.linux.dev, bvanassche@acm.org, hare@suse.de,
	ming.lei@redhat.com, damien.lemoal@opensource.wdc.com,
	anuj20.g@samsung.com, joshi.k@samsung.com, nitheshshetty@gmail.com,
	gost.dev@samsung.com, Nitesh Shetty <nj.shetty@samsung.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v7 4/8] fs, block: copy_file_range for def_blk_ops for
 direct block device.
Message-ID: <202302210520.EIfbuJLy-lkp@intel.com>
References: <20230220105336.3810-5-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230220105336.3810-5-nj.shetty@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230220_135738_445166_480AFBD8 
X-CRM114-Status: GOOD (  14.62  )
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

Hi Nitesh,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on device-mapper-dm/for-next]
[also build test ERROR on linus/master v6.2 next-20230220]
[cannot apply to axboe-block/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nitesh-Shetty/block-Add-copy-offload-support-infrastructure/20230220-205057
base:   https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git for-next
patch link:    https://lore.kernel.org/r/20230220105336.3810-5-nj.shetty%40samsung.com
patch subject: [PATCH v7 4/8] fs, block: copy_file_range for def_blk_ops for direct block device.
config: riscv-randconfig-r042-20230219 (https://download.01.org/0day-ci/archive/20230221/202302210520.EIfbuJLy-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/0f95ad2cb727ac6ac8406a01ff216d9237b403b7
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Nitesh-Shetty/block-Add-copy-offload-support-infrastructure/20230220-205057
        git checkout 0f95ad2cb727ac6ac8406a01ff216d9237b403b7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302210520.EIfbuJLy-lkp@intel.com/

All errors (new ones prefixed by >>):

   riscv64-linux-ld: fs/read_write.o: in function `__do_compat_sys_preadv2':
>> fs/read_write.c:1134: undefined reference to `I_BDEV'


vim +1134 fs/read_write.c

3ebfd81f7fb3e8 H.J. Lu           2016-07-14  1128  
f17d8b35452cab Milosz Tanski     2016-03-03  1129  COMPAT_SYSCALL_DEFINE6(preadv2, compat_ulong_t, fd,
3523a9d4547898 Christoph Hellwig 2020-09-25  1130  		const struct iovec __user *, vec,
f17d8b35452cab Milosz Tanski     2016-03-03  1131  		compat_ulong_t, vlen, u32, pos_low, u32, pos_high,
ddef7ed2b5cbaf Christoph Hellwig 2017-07-06  1132  		rwf_t, flags)
f17d8b35452cab Milosz Tanski     2016-03-03  1133  {
f17d8b35452cab Milosz Tanski     2016-03-03 @1134  	loff_t pos = ((loff_t)pos_high << 32) | pos_low;
f17d8b35452cab Milosz Tanski     2016-03-03  1135  
f17d8b35452cab Milosz Tanski     2016-03-03  1136  	if (pos == -1)
3523a9d4547898 Christoph Hellwig 2020-09-25  1137  		return do_readv(fd, vec, vlen, flags);
3523a9d4547898 Christoph Hellwig 2020-09-25  1138  	return do_preadv(fd, vec, vlen, pos, flags);
72ec35163f9f72 Al Viro           2013-03-20  1139  }
72ec35163f9f72 Al Viro           2013-03-20  1140  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

