Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D473C77B73
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Apr 2023 18:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xdl4FCfvCPQecp903wxkXhDl0G5ZA+x99cQdfm7HG5s=; b=XsfF9FHNHhiyy1Ja1zTcwHzYni
	emD7PtxLUaWhF1XYYDnuxtUIcCMUscN/hlDJ7xOSq5uNoNgb5cxbDRXYB+NpKATCfd9ycWcJNZlfr
	V3K1L5lSob7q8Um8IpuJgrUihJjAoBOTb5Vt1GoJRxQvlHtQeocDJuFuHeV2cthb9Wbyka9azkF+b
	g6tOVSo9eCSYQ+zDg3htjvbr/Gl8tlHsTWQYDH8dfLP0TmWvr4tFBXkIpr8jj+oEiD33DG9Pm6OgP
	S9h44/VX86FPntQ6Vq6vF/yGIG5uA8ubNhJrWx1peKt9Wiu4nzj0av/cCrdRvaFLD18tqvja7wFxk
	dLP7Vdew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ppCyU-006CBy-2o;
	Wed, 19 Apr 2023 18:56:14 +0000
Received: from mga11.intel.com ([192.55.52.93])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ppCyR-006CAD-2l
	for linux-nvme@lists.infradead.org;
	Wed, 19 Apr 2023 18:56:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681930571; x=1713466571;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QRGqBX37NR8aEdfN3qUrMJ+8qUa0XUBdBpWqWnI2SgM=;
  b=k7nNEQjSTl+6gEKpKtKznEQD13PcpXZZuBoQ6N1BWoHF2CBE15bHk1hh
   d8/efEQYjtdJUZrWYJL0CSluUCscE39h/Sr4BWuQhuaQA6KERiNwNHvnp
   Cqv4QX31Yrky6krvOHvwXYwPlWSBIf7CiJbE43WhS/wnM3ztE2RhkxNkH
   htvqBusDoxOujoElcgWOs7GjpPWtS6Dq6WG848tqd/XcBQ9ruIXMaZhIt
   1hBMsQtwIypJyXK5d5nlB4e5lXmL1ACQ6bDLteOT1xSEmxI3ABy6BePPw
   pu+DCm/6Ng7KXdWvhJ4FBGXNfiVksyFiQbg5SrqR3noskFE8Mzq1p8hHg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="343015576"
X-IronPort-AV: E=Sophos;i="5.99,210,1677571200"; 
   d="scan'208";a="343015576"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 11:56:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="780939661"
X-IronPort-AV: E=Sophos;i="5.99,210,1677571200"; 
   d="scan'208";a="780939661"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Apr 2023 11:56:01 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ppCyH-000f74-01;
	Wed, 19 Apr 2023 18:56:01 +0000
Date: Thu, 20 Apr 2023 02:55:53 +0800
From: kernel test robot <lkp@intel.com>
To: Nitesh Shetty <nj.shetty@samsung.com>, Jens Axboe <axboe@kernel.dk>,
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	dm-devel@redhat.com, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, bvanassche@acm.org, hare@suse.de,
	ming.lei@redhat.com, dlemoal@kernel.org, anuj20.g@samsung.com,
	joshi.k@samsung.com, nitheshshetty@gmail.com, gost.dev@samsung.com,
	Nitesh Shetty <nj.shetty@samsung.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v10 6/9] nvmet: add copy command support for bdev and
 file ns
Message-ID: <202304200240.fsLkpzvk-lkp@intel.com>
References: <20230419114320.13674-7-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230419114320.13674-7-nj.shetty@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230419_115611_913521_5B58236B 
X-CRM114-Status: GOOD (  18.06  )
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20230418]
[cannot apply to axboe-block/for-next device-mapper-dm/for-next linus/master v6.3-rc7 v6.3-rc6 v6.3-rc5 v6.3-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nitesh-Shetty/block-Add-copy-offload-support-infrastructure/20230419-204352
patch link:    https://lore.kernel.org/r/20230419114320.13674-7-nj.shetty%40samsung.com
patch subject: [PATCH v10 6/9] nvmet: add copy command support for bdev and file ns
config: m68k-randconfig-s032-20230416 (https://download.01.org/0day-ci/archive/20230420/202304200240.fsLkpzvk-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/420b04f7ba9a54898d62c1d60905f8cf952afde2
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Nitesh-Shetty/block-Add-copy-offload-support-infrastructure/20230419-204352
        git checkout 420b04f7ba9a54898d62c1d60905f8cf952afde2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=m68k SHELL=/bin/bash drivers/nvme/target/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304200240.fsLkpzvk-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/nvme/target/io-cmd-bdev.c:55:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le16 [usertype] mssrl @@
   drivers/nvme/target/io-cmd-bdev.c:55:27: sparse:     expected unsigned int [usertype] val
   drivers/nvme/target/io-cmd-bdev.c:55:27: sparse:     got restricted __le16 [usertype] mssrl
>> drivers/nvme/target/io-cmd-bdev.c:55:27: sparse: sparse: cast from restricted __le16
>> drivers/nvme/target/io-cmd-bdev.c:55:27: sparse: sparse: cast from restricted __le16
>> drivers/nvme/target/io-cmd-bdev.c:55:27: sparse: sparse: cast from restricted __le16
>> drivers/nvme/target/io-cmd-bdev.c:55:27: sparse: sparse: cast from restricted __le16
   drivers/nvme/target/io-cmd-bdev.c:57:29: sparse: sparse: cast from restricted __le16
   drivers/nvme/target/io-cmd-bdev.c:60:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le16 [usertype] mssrl @@
   drivers/nvme/target/io-cmd-bdev.c:60:27: sparse:     expected unsigned int [usertype] val
   drivers/nvme/target/io-cmd-bdev.c:60:27: sparse:     got restricted __le16 [usertype] mssrl
   drivers/nvme/target/io-cmd-bdev.c:60:27: sparse: sparse: cast from restricted __le16
   drivers/nvme/target/io-cmd-bdev.c:60:27: sparse: sparse: cast from restricted __le16
   drivers/nvme/target/io-cmd-bdev.c:60:27: sparse: sparse: cast from restricted __le16
   drivers/nvme/target/io-cmd-bdev.c:60:27: sparse: sparse: cast from restricted __le16

vim +55 drivers/nvme/target/io-cmd-bdev.c

    12	
    13	void nvmet_bdev_set_limits(struct block_device *bdev, struct nvme_id_ns *id)
    14	{
    15		/* Logical blocks per physical block, 0's based. */
    16		const __le16 lpp0b = to0based(bdev_physical_block_size(bdev) /
    17					      bdev_logical_block_size(bdev));
    18	
    19		/*
    20		 * For NVMe 1.2 and later, bit 1 indicates that the fields NAWUN,
    21		 * NAWUPF, and NACWU are defined for this namespace and should be
    22		 * used by the host for this namespace instead of the AWUN, AWUPF,
    23		 * and ACWU fields in the Identify Controller data structure. If
    24		 * any of these fields are zero that means that the corresponding
    25		 * field from the identify controller data structure should be used.
    26		 */
    27		id->nsfeat |= 1 << 1;
    28		id->nawun = lpp0b;
    29		id->nawupf = lpp0b;
    30		id->nacwu = lpp0b;
    31	
    32		/*
    33		 * Bit 4 indicates that the fields NPWG, NPWA, NPDG, NPDA, and
    34		 * NOWS are defined for this namespace and should be used by
    35		 * the host for I/O optimization.
    36		 */
    37		id->nsfeat |= 1 << 4;
    38		/* NPWG = Namespace Preferred Write Granularity. 0's based */
    39		id->npwg = lpp0b;
    40		/* NPWA = Namespace Preferred Write Alignment. 0's based */
    41		id->npwa = id->npwg;
    42		/* NPDG = Namespace Preferred Deallocate Granularity. 0's based */
    43		id->npdg = to0based(bdev_discard_granularity(bdev) /
    44				    bdev_logical_block_size(bdev));
    45		/* NPDG = Namespace Preferred Deallocate Alignment */
    46		id->npda = id->npdg;
    47		/* NOWS = Namespace Optimal Write Size */
    48		id->nows = to0based(bdev_io_opt(bdev) / bdev_logical_block_size(bdev));
    49	
    50		/*Copy limits*/
    51		if (bdev_max_copy_sectors(bdev)) {
    52			id->msrc = id->msrc;
    53			id->mssrl = cpu_to_le16((bdev_max_copy_sectors(bdev) <<
    54					SECTOR_SHIFT) / bdev_logical_block_size(bdev));
  > 55			id->mcl = cpu_to_le32(id->mssrl);
    56		} else {
    57			id->msrc = (u8)to0based(BIO_MAX_VECS - 1);
    58			id->mssrl = cpu_to_le16((BIO_MAX_VECS << PAGE_SHIFT) /
    59					bdev_logical_block_size(bdev));
    60			id->mcl = cpu_to_le32(id->mssrl);
    61		}
    62	}
    63	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

