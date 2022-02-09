Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45FBBC433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Feb 2022 06:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G2YUg3XvB9bsHB5DYFq/tTIL0nXODL++zKBcBWIKTwg=; b=ReukCKJ6totKAjf9+vPtErEVVU
	ynfLjRW4sIDT79i1uVuH+r623dBNwYyPFaILRZ+4MbvcyfY/t5/GInUmi2P6J1+z+s6Tcj+LMLq18
	zO9LcH2BC8exylYshSP9ZU7DI6Il4qYTEk1kOX0ICe/K1amPmQfdgatfjpVDPOa/HokuZh6s1kB7r
	aeauplrisqZrbC1MOOsHQ4zHx6LRtvusx5hex0ktxyMQgnol2NjtM2VChwv4V5pCFN7aiczxdkOIq
	Sz0DJlvpIdePbHfHjN34IxMiYu72USqvl4MSXJ+82aY+bH3dpTtXTvi26FS0ezj7xPwSXBFBWEAvQ
	Z26K17jA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nHgDp-00GJxs-Pa; Wed, 09 Feb 2022 06:12:57 +0000
Received: from mga11.intel.com ([192.55.52.93])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nHdpK-00G9ke-LO
 for linux-nvme@lists.infradead.org; Wed, 09 Feb 2022 03:39:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644377970; x=1675913970;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=UUr2oeyzfQDDRtI6hlTLxPqoP/+EpMIGE8+TwWUBk0o=;
 b=ez4stKHhDDVl6yT1xk5D8g+3iUmg6vrCg8TAcWNDTtW/xjyZoVHkRtZ5
 AkML9UxVY1ZAhD/aTHvD0/3HXMB2dpsSCRydZH82ctlxsBCTB2U96Xgky
 6CE1Ffq0Udon1BOWvX0OHPNOF3GER6T7MJTggDfsPXGg+ZBoP1ivFgiWr
 9Lnn0vGK9LR2fXDionZhp+FoMQGhojvuhSQgfNXqQzgFyAM2aPkT8ECtb
 6PukQzvp23a5vkpBXcCI7xCABAid6MlSUqkj0wlwHZfUEVnV2FJnnBTCw
 xpNL6Zk1jhro343tWtHiX6vAKur/bWm7Bstd/yrOxlOjFHfvU46ZNM2g1 w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="246696649"
X-IronPort-AV: E=Sophos;i="5.88,354,1635231600"; d="scan'208";a="246696649"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Feb 2022 19:39:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,354,1635231600"; d="scan'208";a="771204809"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
 by fmsmga006.fm.intel.com with ESMTP; 08 Feb 2022 19:39:23 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1nHdpD-0001Al-6Z; Wed, 09 Feb 2022 03:39:23 +0000
Date: Wed, 9 Feb 2022 11:39:03 +0800
From: kernel test robot <lkp@intel.com>
To: Nitesh Shetty <nj.shetty@samsung.com>, mpatocka@redhat.com
Cc: kbuild-all@lists.01.org, javier@javigon.com, chaitanyak@nvidia.com,
 linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 dm-devel@redhat.com, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, axboe@kernel.dk, msnitzer@redhat.com,
 bvanassche@acm.org, martin.petersen@oracle.com,
 roland@purestorage.com, hare@suse.de, kbusch@kernel.org, hch@lst.de,
 Frederick.Knight@netapp.com, zach.brown@ni.com, osandov@fb.com,
 lsf-pc@lists.linux-foundation.org, djwong@kernel.org,
 josef@toxicpanda.com, clm@fb.com, dsterba@suse.com, tytso@mit.edu,
 jack@suse.com, joshi.k@samsung.com, arnav.dawn@samsung.com,
 nj.shetty@samsung.com
Subject: Re: [PATCH v2 04/10] block: Introduce a new ioctl for copy
Message-ID: <202202091048.qDQvi6ab-lkp@intel.com>
References: <20220207141348.4235-5-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207141348.4235-5-nj.shetty@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220208_193930_750640_BC604505 
X-CRM114-Status: GOOD (  12.03  )
X-Mailman-Approved-At: Tue, 08 Feb 2022 22:12:56 -0800
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

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on axboe-block/for-next]
[also build test WARNING on next-20220208]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Nitesh-Shetty/block-make-bio_map_kern-non-static/20220207-231407
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
config: i386-randconfig-c001 (https://download.01.org/0day-ci/archive/20220209/202202091048.qDQvi6ab-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cocci warnings: (new ones prefixed by >>)
>> block/ioctl.c:145:10-17: WARNING opportunity for memdup_user

vim +145 block/ioctl.c

   126	
   127	static int blk_ioctl_copy(struct block_device *bdev, fmode_t mode,
   128			unsigned long arg)
   129	{
   130		struct copy_range crange, *ranges;
   131		size_t payload_size = 0;
   132		int ret;
   133	
   134		if (!(mode & FMODE_WRITE))
   135			return -EBADF;
   136	
   137		if (copy_from_user(&crange, (void __user *)arg, sizeof(crange)))
   138			return -EFAULT;
   139	
   140		if (unlikely(!crange.nr_range || crange.reserved || crange.nr_range >= MAX_COPY_NR_RANGE))
   141			return -EINVAL;
   142	
   143		payload_size = (crange.nr_range * sizeof(struct range_entry)) + sizeof(crange);
   144	
 > 145		ranges = kmalloc(payload_size, GFP_KERNEL);
   146		if (!ranges)
   147			return -ENOMEM;
   148	
   149		if (copy_from_user(ranges, (void __user *)arg, payload_size)) {
   150			ret = -EFAULT;
   151			goto out;
   152		}
   153	
   154		ret = blkdev_issue_copy(bdev, ranges->nr_range, ranges->range_list, bdev, GFP_KERNEL, 0);
   155		if (copy_to_user((void __user *)arg, ranges, payload_size))
   156			ret = -EFAULT;
   157	out:
   158		kfree(ranges);
   159		return ret;
   160	}
   161	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

