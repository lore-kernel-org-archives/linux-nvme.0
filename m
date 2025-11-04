Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A66E4CCF9F8
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Nov 2025 00:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j72kH5A4NosGnsKtmgZWqectlM8qu9qu5lI/LSZR6iI=; b=rcqzG6cM3tM7caO7yF3ti9lP3E
	+UWfkm9JtS0Lsl8CH3ZlUvnQdX8JsbySxLao+R2o34bZjR4Wn4tKmAFS4L/gcXE96d922q7tbM+5y
	LDjyhF2uIL5MBSmJnt8qt3bQR1Ai6mEafJcubmFTzBmfeNPKLutnkBEpDPV73D+WJLSF56ObJ5bTO
	cvK23oJPD3e9DG4ltvAr7Ximw1DIIIrbdM3z+CqQFt3kI/P8plbUYZOJXxypEgjPGbLQ9zF9jW7Jf
	8mhU9lxwvz3r4xaYQdEIcfYw7nDmjTLNIwXEXBINBEpysjywkFBzG4VB8UZ5YPjzDuRBhY7g7pMOG
	mdSmCogw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vG54v-0000000ArDx-2cTV;
	Tue, 04 Nov 2025 00:39:17 +0000
Received: from mgamail.intel.com ([192.198.163.10])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vG54s-0000000ArDT-2gym
	for linux-nvme@lists.infradead.org;
	Tue, 04 Nov 2025 00:39:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762216755; x=1793752755;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mPNm/C4lAMOMRgM7UB0KMAJ0ifsULw0KEfI5BGUhPDQ=;
  b=TieugbQBxQ4ekKvBlLu1InLhhtb4EkgsbWTmySCbTh0B9wRhPyuUQauQ
   j3dV+ZqV+O/bzX48GKvxeA2tqtVO+Tp/TMgjsF+oxRhPKU5SCn6w8g44o
   75AgWvGDSGhVnB1EtRxPf6M9jbRP1Rwq6C7lDdZmZfwjqerP4X33OUSqI
   ANEerVyof13gq4xnk3CXKR7Wz3/8T/DH0ho0yfz/txyJaGQIMWIESggsN
   lQVX0v/4t+mJ2ThwsNpwUz4aZX/OZEylhnB2jHESUWXGvYDEFoIj+C0qt
   j7yYYhdoxrx3dOsgjg/oSxa9jomi1YR5zHRgk2Bzfz13idKdNRJ9VT8PS
   A==;
X-CSE-ConnectionGUID: 80cd2dP1RLSfVqQh/3I2hw==
X-CSE-MsgGUID: LEZl849rRfKwrOXB94wX4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="75654613"
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="75654613"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 16:39:13 -0800
X-CSE-ConnectionGUID: OfZ4HEkuRhyIWHXTjR/tcQ==
X-CSE-MsgGUID: if1kyanTQXSEi5380gA62w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="210520385"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 03 Nov 2025 16:39:10 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vG544-000QgW-1B;
	Tue, 04 Nov 2025 00:38:45 +0000
Date: Tue, 4 Nov 2025 08:36:25 +0800
From: kernel test robot <lkp@intel.com>
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	Keith Busch <keith.busch@wdc.com>, Christoph Hellwig <hch@lst.de>,
	dm-devel@lists.linux.dev, Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
	Carlos Maiolino <cem@kernel.org>, linux-btrfs@vger.kernel.org,
	David Sterba <dsterba@suse.com>
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 04/15] block: introduce disk_report_zone()
Message-ID: <202511040843.y29M2yJp-lkp@intel.com>
References: <20251103133123.645038-5-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103133123.645038-5-dlemoal@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251103_163914_698653_87BDE080 
X-CRM114-Status: GOOD (  11.86  )
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

Hi Damien,

kernel test robot noticed the following build warnings:

[auto build test WARNING on ba6a8208cc205c6545c610b5863ea89466fc486a]

url:    https://github.com/intel-lab-lkp/linux/commits/Damien-Le-Moal/block-handle-zone-management-operations-completions/20251103-214422
base:   ba6a8208cc205c6545c610b5863ea89466fc486a
patch link:    https://lore.kernel.org/r/20251103133123.645038-5-dlemoal%40kernel.org
patch subject: [PATCH v2 04/15] block: introduce disk_report_zone()
config: sparc-randconfig-002-20251104 (https://download.01.org/0day-ci/archive/20251104/202511040843.y29M2yJp-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251104/202511040843.y29M2yJp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511040843.y29M2yJp-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/scsi/sd_zbc.c:47 function parameter 'args' not described in 'sd_zbc_parse_report'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

