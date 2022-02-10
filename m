Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F29FC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Feb 2022 16:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1LgQRoPqySbeyXH8Oy9sTA+r9QA1tzYDIJRi6iCtkOk=; b=wc/g42tFpkfJtkVg5MRDaPaQiS
	JcvNtd4lxhQk/RZlxateS/YnAvGTSuYNDjCXypl9fMjM3AVaMKzX9LfU3NBzoPYUf8LKL0AjovaAa
	mLOjdksAU3tXdRHh8OdvNljKgh4imaRs1S4VmNPek5U7PnxdTlYWk8apnGdrC5cug/JbLu9Fzyufd
	toucYwd9uyD4usmanCy4VCdPFXcFksgrnK96Zq3cw7OyO2UIqP8n2yg7bh7tZAIY1b1b3EWhzw1RY
	NtBCllj4IbB4yVW1HDRsbNSvxzVWlEl+O3KlnSEQHZbMJhjvACpS9e2Rr9wxx+kJc+SB1nWUu2Gb2
	5/29sF3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nIBu1-004J2d-GU; Thu, 10 Feb 2022 16:02:37 +0000
Received: from mga01.intel.com ([192.55.52.88])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nI4re-0034kz-40
 for linux-nvme@lists.infradead.org; Thu, 10 Feb 2022 08:31:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644481902; x=1676017902;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=8c00mtbRrdA18FyTX012jqJDs1wrgVfFCJpPUSIXoOg=;
 b=HUU7iRJu0yyMNCG+ZVIbD9PY9qb4z2aWgoBmqjo1bpycAz9pN9QDslzN
 srrWvgUagYngnaXpcN1udIHGgnIszafTMUurZouHnWuMSkXegZVvMLaTN
 cc6b4vQK0YoilnExRWtrceT91FIlOlDb5SkM2yduB/6ApCPjnr5M8+maO
 narKpIZMVoWq7/KWtNSB/6x0xWFUvC/EhrDayby3FWB+PmTSBrAEVl5/8
 PI0a3lAE+3F4yxD3w6+FE5rEJhUjqZBvqhgd/371trAxo2GifQKMWaAaI
 NNJaBwlVjqfQbXT1dXjfCGtSPxy+ROXhIOi6BvtxkeAyDnviq+mgc6oUp A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="273989253"
X-IronPort-AV: E=Sophos;i="5.88,358,1635231600"; d="scan'208";a="273989253"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2022 00:31:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,358,1635231600"; d="scan'208";a="629615271"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
 by fmsmga002.fm.intel.com with ESMTP; 10 Feb 2022 00:31:34 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1nI4rW-0002yF-8m; Thu, 10 Feb 2022 08:31:34 +0000
Date: Thu, 10 Feb 2022 16:31:10 +0800
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
Subject: Re: [PATCH v2 07/10] nvmet: add copy command support for bdev and
 file ns
Message-ID: <202202101647.VtWTgalm-lkp@intel.com>
References: <20220207141348.4235-8-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207141348.4235-8-nj.shetty@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220210_003142_213298_8E9B5A0A 
X-CRM114-Status: GOOD (  19.71  )
X-Mailman-Approved-At: Thu, 10 Feb 2022 08:02:26 -0800
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
[also build test WARNING on linus/master v5.17-rc3 next-20220209]
[cannot apply to device-mapper-dm/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Nitesh-Shetty/block-make-bio_map_kern-non-static/20220207-231407
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
config: arm64-randconfig-s032-20220207 (https://download.01.org/0day-ci/archive/20220210/202202101647.VtWTgalm-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/6bb6ea64499e1ac27975e79bb2eee89f07861893
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Nitesh-Shetty/block-make-bio_map_kern-non-static/20220207-231407
        git checkout 6bb6ea64499e1ac27975e79bb2eee89f07861893
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/nvme/target/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/nvme/target/io-cmd-bdev.c:52:25: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] mcl @@     got restricted __le64 [usertype] @@
   drivers/nvme/target/io-cmd-bdev.c:52:25: sparse:     expected restricted __le32 [usertype] mcl
   drivers/nvme/target/io-cmd-bdev.c:52:25: sparse:     got restricted __le64 [usertype]
>> drivers/nvme/target/io-cmd-bdev.c:53:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] mssrl @@     got restricted __le32 [usertype] @@
   drivers/nvme/target/io-cmd-bdev.c:53:27: sparse:     expected restricted __le16 [usertype] mssrl
   drivers/nvme/target/io-cmd-bdev.c:53:27: sparse:     got restricted __le32 [usertype]
>> drivers/nvme/target/io-cmd-bdev.c:55:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned char [usertype] msrc @@     got restricted __le16 @@
   drivers/nvme/target/io-cmd-bdev.c:55:26: sparse:     expected unsigned char [usertype] msrc
   drivers/nvme/target/io-cmd-bdev.c:55:26: sparse:     got restricted __le16
   drivers/nvme/target/io-cmd-bdev.c:58:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned char [usertype] msrc @@     got restricted __le16 @@
   drivers/nvme/target/io-cmd-bdev.c:58:34: sparse:     expected unsigned char [usertype] msrc
   drivers/nvme/target/io-cmd-bdev.c:58:34: sparse:     got restricted __le16
   drivers/nvme/target/io-cmd-bdev.c:59:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] mssrl @@     got restricted __le32 [usertype] @@
   drivers/nvme/target/io-cmd-bdev.c:59:35: sparse:     expected restricted __le16 [usertype] mssrl
   drivers/nvme/target/io-cmd-bdev.c:59:35: sparse:     got restricted __le32 [usertype]
>> drivers/nvme/target/io-cmd-bdev.c:61:35: sparse: sparse: cast to restricted __le32
>> drivers/nvme/target/io-cmd-bdev.c:61:35: sparse: sparse: cast from restricted __le16
   drivers/nvme/target/io-cmd-bdev.c:61:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] mcl @@     got restricted __le64 [usertype] @@
   drivers/nvme/target/io-cmd-bdev.c:61:33: sparse:     expected restricted __le32 [usertype] mcl
   drivers/nvme/target/io-cmd-bdev.c:61:33: sparse:     got restricted __le64 [usertype]
   drivers/nvme/target/io-cmd-bdev.c:65:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned char [usertype] msrc @@     got restricted __le16 @@
   drivers/nvme/target/io-cmd-bdev.c:65:34: sparse:     expected unsigned char [usertype] msrc
   drivers/nvme/target/io-cmd-bdev.c:65:34: sparse:     got restricted __le16
   drivers/nvme/target/io-cmd-bdev.c:66:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] mssrl @@     got restricted __le32 [usertype] @@
   drivers/nvme/target/io-cmd-bdev.c:66:35: sparse:     expected restricted __le16 [usertype] mssrl
   drivers/nvme/target/io-cmd-bdev.c:66:35: sparse:     got restricted __le32 [usertype]
   drivers/nvme/target/io-cmd-bdev.c:68:35: sparse: sparse: cast to restricted __le32
   drivers/nvme/target/io-cmd-bdev.c:68:35: sparse: sparse: cast from restricted __le16
   drivers/nvme/target/io-cmd-bdev.c:68:35: sparse: sparse: cast to restricted __le32
   drivers/nvme/target/io-cmd-bdev.c:68:35: sparse: sparse: cast from restricted __le16
   drivers/nvme/target/io-cmd-bdev.c:68:35: sparse: sparse: cast to restricted __le32
   drivers/nvme/target/io-cmd-bdev.c:68:35: sparse: sparse: cast from restricted __le16
   drivers/nvme/target/io-cmd-bdev.c:68:35: sparse: sparse: cast to restricted __le32
   drivers/nvme/target/io-cmd-bdev.c:68:35: sparse: sparse: cast from restricted __le16
   drivers/nvme/target/io-cmd-bdev.c:68:35: sparse: sparse: cast to restricted __le32
   drivers/nvme/target/io-cmd-bdev.c:68:35: sparse: sparse: cast from restricted __le16
   drivers/nvme/target/io-cmd-bdev.c:68:35: sparse: sparse: cast to restricted __le32
   drivers/nvme/target/io-cmd-bdev.c:68:35: sparse: sparse: cast from restricted __le16
   drivers/nvme/target/io-cmd-bdev.c:68:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] mcl @@     got restricted __le64 [usertype] @@
   drivers/nvme/target/io-cmd-bdev.c:68:33: sparse:     expected restricted __le32 [usertype] mcl
   drivers/nvme/target/io-cmd-bdev.c:68:33: sparse:     got restricted __le64 [usertype]
--
>> drivers/nvme/target/admin-cmd.c:533:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned char [usertype] msrc @@     got restricted __le16 @@
   drivers/nvme/target/admin-cmd.c:533:26: sparse:     expected unsigned char [usertype] msrc
   drivers/nvme/target/admin-cmd.c:533:26: sparse:     got restricted __le16
>> drivers/nvme/target/admin-cmd.c:534:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] mssrl @@     got restricted __le32 [usertype] @@
   drivers/nvme/target/admin-cmd.c:534:27: sparse:     expected restricted __le16 [usertype] mssrl
   drivers/nvme/target/admin-cmd.c:534:27: sparse:     got restricted __le32 [usertype]
>> drivers/nvme/target/admin-cmd.c:535:27: sparse: sparse: cast to restricted __le32
>> drivers/nvme/target/admin-cmd.c:535:27: sparse: sparse: cast from restricted __le16
>> drivers/nvme/target/admin-cmd.c:535:25: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] mcl @@     got restricted __le64 [usertype] @@
   drivers/nvme/target/admin-cmd.c:535:25: sparse:     expected restricted __le32 [usertype] mcl
   drivers/nvme/target/admin-cmd.c:535:25: sparse:     got restricted __le64 [usertype]

vim +52 drivers/nvme/target/io-cmd-bdev.c

    11	
    12	void nvmet_bdev_set_limits(struct block_device *bdev, struct nvme_id_ns *id)
    13	{
    14		const struct queue_limits *ql = &bdev_get_queue(bdev)->limits;
    15		/* Number of logical blocks per physical block. */
    16		const u32 lpp = ql->physical_block_size / ql->logical_block_size;
    17		/* Logical blocks per physical block, 0's based. */
    18		const __le16 lpp0b = to0based(lpp);
    19	
    20		/*
    21		 * For NVMe 1.2 and later, bit 1 indicates that the fields NAWUN,
    22		 * NAWUPF, and NACWU are defined for this namespace and should be
    23		 * used by the host for this namespace instead of the AWUN, AWUPF,
    24		 * and ACWU fields in the Identify Controller data structure. If
    25		 * any of these fields are zero that means that the corresponding
    26		 * field from the identify controller data structure should be used.
    27		 */
    28		id->nsfeat |= 1 << 1;
    29		id->nawun = lpp0b;
    30		id->nawupf = lpp0b;
    31		id->nacwu = lpp0b;
    32	
    33		/*
    34		 * Bit 4 indicates that the fields NPWG, NPWA, NPDG, NPDA, and
    35		 * NOWS are defined for this namespace and should be used by
    36		 * the host for I/O optimization.
    37		 */
    38		id->nsfeat |= 1 << 4;
    39		/* NPWG = Namespace Preferred Write Granularity. 0's based */
    40		id->npwg = lpp0b;
    41		/* NPWA = Namespace Preferred Write Alignment. 0's based */
    42		id->npwa = id->npwg;
    43		/* NPDG = Namespace Preferred Deallocate Granularity. 0's based */
    44		id->npdg = to0based(ql->discard_granularity / ql->logical_block_size);
    45		/* NPDG = Namespace Preferred Deallocate Alignment */
    46		id->npda = id->npdg;
    47		/* NOWS = Namespace Optimal Write Size */
    48		id->nows = to0based(ql->io_opt / ql->logical_block_size);
    49	
    50		/*Copy limits*/
    51		if (ql->max_copy_sectors) {
  > 52			id->mcl = cpu_to_le64((ql->max_copy_sectors << 9) / ql->logical_block_size);
  > 53			id->mssrl = cpu_to_le32((ql->max_copy_range_sectors << 9) /
    54					ql->logical_block_size);
  > 55			id->msrc = to0based(ql->max_copy_nr_ranges);
    56		} else {
    57			if (ql->zoned == BLK_ZONED_NONE) {
    58				id->msrc = to0based(BIO_MAX_VECS);
    59				id->mssrl = cpu_to_le32(
    60						(BIO_MAX_VECS << PAGE_SHIFT) / ql->logical_block_size);
  > 61				id->mcl = cpu_to_le64(le32_to_cpu(id->mssrl) * BIO_MAX_VECS);
    62	#ifdef CONFIG_BLK_DEV_ZONED
    63			} else {
    64				/* TODO: get right values for zoned device */
    65				id->msrc = to0based(BIO_MAX_VECS);
    66				id->mssrl = cpu_to_le32(min((BIO_MAX_VECS << PAGE_SHIFT),
    67						ql->chunk_sectors) / ql->logical_block_size);
    68				id->mcl = cpu_to_le64(min(le32_to_cpu(id->mssrl) * BIO_MAX_VECS,
    69							ql->chunk_sectors));
    70	#endif
    71			}
    72		}
    73	}
    74	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

