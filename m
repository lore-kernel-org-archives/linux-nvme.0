Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0FE9E668B1
	for <linux-nvme@archiver.kernel.org>; Sat, 20 Dec 2025 15:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zMl/TGA0u1xBmBaMRlepUrMqntUGhGfVo9a9FRBDMXc=; b=z2lM+ikhggRemSGhNCNtLZ64Pe
	zNKhwTGi1+vn0lzaArY6p49WNz0px5evfMusL9DaUt4jlBDPFysw6NBotx43FAINEMVzviu6/bLuL
	q9wYAmc3onp91MOKiCoM+e2a7Utkk21mD84nhRP8KygyJduHRMF/X2xHTXhaZpkoavSHYc0H6rD3Y
	PUlKUQuDwfwLj4zmQ1tjI0TyzgSktCzucmCQ+kkeub3JXH5/0HvLkaxp3fDYpiVDeDYh/VyVPk1/S
	aX+I3MS4iLYtmxMoDdj1uB4iDHSEPdu2OGVuau1zv9z2wib3wAFrlr6HMjn+FLd4Y7pLVhOCRlTWd
	peFrlgtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWz88-0000000BhXo-2QKX;
	Sat, 20 Dec 2025 15:44:28 +0000
Received: from mgamail.intel.com ([198.175.65.13])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWz86-0000000BhXQ-0W9y
	for linux-nvme@lists.infradead.org;
	Sat, 20 Dec 2025 15:44:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766245466; x=1797781466;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i30qgdidF5swEfrY8bISvHkNXQBtVxmPrBDz6HH/8cE=;
  b=DgE9uSz2uujEtzXsmSFCAkN56OLqO/GGGZTnQgfjchBVJUfQtTentCeX
   Zy1muB47AisuFQrnfwBoyA8eoCmUB7xEr/NXsYAz1BtO80jyiZ80kaS9O
   xjx/AFPTlbRqcSnuFbfzeGtbO5Qxpui75jRPU64gExfflBBDQ7TM94mK4
   xwuDi6FBgCDy2N7qbx96EXlTVuWK5EeUfvd9+XwPbOiibibi58slPCt05
   NRXTIhFnqao4iO6PZkolfmqXm558gNavl80ImUF0Foi9ckdogOikYskcK
   SVXLioUVqMKnBKcUl7JdEJI6ep6qaFNCXUjbad0pnOKsqueWElm0Tielu
   Q==;
X-CSE-ConnectionGUID: pKzDGmmwQU6/8it8jw1EYg==
X-CSE-MsgGUID: kttHyUu7S7Wz/pNe/XdDVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11648"; a="79297149"
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="79297149"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2025 07:44:24 -0800
X-CSE-ConnectionGUID: 7rxyLLmsSwu8Qk61HDxw4w==
X-CSE-MsgGUID: odg2+K3HSBq45ro0hb4fag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="236535410"
Received: from lkp-server01.sh.intel.com (HELO 0d09efa1b85f) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 20 Dec 2025 07:44:18 -0800
Received: from kbuild by 0d09efa1b85f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vWz7v-000000004m1-2LBa;
	Sat, 20 Dec 2025 15:44:15 +0000
Date: Sat, 20 Dec 2025 23:43:44 +0800
From: kernel test robot <lkp@intel.com>
To: Hou Tao <houtao@huaweicloud.com>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-mm@kvack.org, linux-nvme@lists.infradead.org,
	Bjorn Helgaas <helgaas@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>,
	Alistair Popple <apopple@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	houtao1@huawei.com
Subject: Re: [PATCH 03/13] kernfs: add support for get_unmapped_area callback
Message-ID: <202512202307.ewUcqBQV-lkp@intel.com>
References: <20251220040446.274991-4-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251220040446.274991-4-houtao@huaweicloud.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251220_074426_207984_D0FF8470 
X-CRM114-Status: GOOD (  13.30  )
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

Hi Hou,

kernel test robot noticed the following build errors:

[auto build test ERROR on driver-core/driver-core-testing]
[also build test ERROR on driver-core/driver-core-next driver-core/driver-core-linus akpm-mm/mm-everything linus/master v6.19-rc1 next-20251219]
[cannot apply to pci/next pci/for-linus]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hou-Tao/PCI-P2PDMA-Release-the-per-cpu-ref-of-pgmap-when-vm_insert_page-fails/20251220-121804
base:   driver-core/driver-core-testing
patch link:    https://lore.kernel.org/r/20251220040446.274991-4-houtao%40huaweicloud.com
patch subject: [PATCH 03/13] kernfs: add support for get_unmapped_area callback
config: sh-allnoconfig (https://download.01.org/0day-ci/archive/20251220/202512202307.ewUcqBQV-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251220/202512202307.ewUcqBQV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512202307.ewUcqBQV-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/kernfs/file.c: In function 'kernfs_get_unmapped_area':
>> fs/kernfs/file.c:480:16: error: implicit declaration of function 'mm_get_unmapped_area'; did you mean 'get_unmapped_area'? [-Wimplicit-function-declaration]
     480 |         addr = mm_get_unmapped_area(file, uaddr, len, pgoff, flags);
         |                ^~~~~~~~~~~~~~~~~~~~
         |                get_unmapped_area


vim +480 fs/kernfs/file.c

   456	
   457	static unsigned long kernfs_get_unmapped_area(struct file *file, unsigned long uaddr,
   458						      unsigned long len, unsigned long pgoff,
   459						      unsigned long flags)
   460	{
   461		struct kernfs_open_file *of = kernfs_of(file);
   462		const struct kernfs_ops *ops;
   463		long addr;
   464	
   465		if (!(of->kn->flags & KERNFS_HAS_MMAP))
   466			return -ENODEV;
   467	
   468		mutex_lock(&of->mutex);
   469	
   470		addr = -ENODEV;
   471		if (!kernfs_get_active_of(of))
   472			goto out_unlock;
   473	
   474		ops = kernfs_ops(of->kn);
   475		if (ops->get_unmapped_area) {
   476			addr = ops->get_unmapped_area(of, uaddr, len, pgoff, flags);
   477			if (!IS_ERR_VALUE(addr) || addr != -EOPNOTSUPP)
   478				goto out_put;
   479		}
 > 480		addr = mm_get_unmapped_area(file, uaddr, len, pgoff, flags);
   481	
   482	out_put:
   483		kernfs_put_active_of(of);
   484	out_unlock:
   485		mutex_unlock(&of->mutex);
   486	
   487		return addr;
   488	}
   489	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

