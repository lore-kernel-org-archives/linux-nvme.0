Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 319FDC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Apr 2022 15:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0Hx+QOKSjyi1qAH8c3HTcdFxLLzYH4OYaDN6R36Y9MU=; b=uuXmTRkLYYO5twE+SYJ/htoj3N
	63QDVSMd3u2jOkvzGaNDf+bbzu9t7j1nMbDwyqr25V38TDnyGHHwSjlOT4Y0r/erEvJEyoDYWr+hM
	UvCv5igNRV7hk0YZy2/G63fRBGnn8vj74Ud5zKp0BOIw4YVF9FtumYii1aL8hqNmHfwoyhDYoi4Se
	xm1zGftif+P1RZbUXG8+oD7Oj0VH7IZ1wC8TRPbN0ehFte0cQ3kkBj/+Qtpx+rsNZ0VlNvwVCX97q
	bq0GJnyN826r5LsoQIUvoR9hkK9nHMkh5QqK8p0TgjFXlTAZNX8KOGCt18tXH/KLe7n211aQTUziU
	JK3sksGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nk5iN-007aOy-1g; Thu, 28 Apr 2022 15:05:55 +0000
Received: from mga18.intel.com ([134.134.136.126])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nk5Wh-007Y2t-K8
 for linux-nvme@lists.infradead.org; Thu, 28 Apr 2022 14:53:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651157631; x=1682693631;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=laK4u97EX9doYugJxLEEbIUOUAx/Qz9PAszFYjC5IiA=;
 b=GYTQTIbyuiZPy7fZuZ9pGj5Y4O+Q3TwD2LTRljhhcJviQyYPhTnkW62a
 O6u9ZKd9JfsBKYkyl7OyuSH9CF555QzZOg1yeqFt3o/oqCSdmnuwuJm2O
 6pLBjKJdYrAFrqFeTNpiI31OESizT8E+wSacsqHgeatLEJ7F0CO2SMJUj
 yvdr1wg0NWYLz6vXu3vNnfWDP/lkNjmvOrDP8oE1nXhv9c55S0xTjYDQd
 dqxSffcynXZhrtVYyF4R8Qb3mrzJ/LTcD0HuVmhrxcHtt8xk4n5lbN2ZB
 sMTo6m5A1pUwSRN1CKLSk6H5lwavZOG6uL6P2+b3u2IaiJxxpEIWPVXqE g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="248244687"
X-IronPort-AV: E=Sophos;i="5.91,295,1647327600"; d="scan'208";a="248244687"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2022 07:53:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,295,1647327600"; d="scan'208";a="514327844"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
 by orsmga003.jf.intel.com with ESMTP; 28 Apr 2022 07:53:43 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
 (envelope-from <lkp@intel.com>) id 1nk5WY-0005Sd-BN;
 Thu, 28 Apr 2022 14:53:42 +0000
Date: Thu, 28 Apr 2022 22:53:21 +0800
From: kernel test robot <lkp@intel.com>
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: kbuild-all@lists.01.org, chaitanyak@nvidia.com,
 linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 dm-devel@redhat.com, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, axboe@kernel.dk, msnitzer@redhat.com,
 bvanassche@acm.org, martin.petersen@oracle.com, hare@suse.de,
 kbusch@kernel.org, hch@lst.de, Frederick.Knight@netapp.com,
 osandov@fb.com, lsf-pc@lists.linux-foundation.org,
 djwong@kernel.org, josef@toxicpanda.com, clm@fb.com,
 dsterba@suse.com, tytso@mit.edu, jack@suse.com,
 nitheshshetty@gmail.com, gost.dev@samsung.com,
 Arnav Dawn <arnav.dawn@samsung.com>, Nitesh Shetty <nj.shetty@samsung.com>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, James Smart <james.smart@broadcom.com>
Subject: Re: [PATCH v4 06/10] nvmet: add copy command support for bdev and
 file ns
Message-ID: <202204282248.B5VfX8LS-lkp@intel.com>
References: <20220426101241.30100-7-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426101241.30100-7-nj.shetty@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220428_075351_750597_5E785574 
X-CRM114-Status: GOOD (  17.96  )
X-Mailman-Approved-At: Thu, 28 Apr 2022 08:05:49 -0700
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

[auto build test WARNING on next-20220422]
[cannot apply to axboe-block/for-next device-mapper-dm/for-next linus/master v5.18-rc4 v5.18-rc3 v5.18-rc2 v5.18-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Nitesh-Shetty/block-Introduce-queue-limits-for-copy-offload-support/20220426-201825
base:    e7d6987e09a328d4a949701db40ef63fbb970670
config: s390-randconfig-s032-20220427 (https://download.01.org/0day-ci/archive/20220428/202204282248.B5VfX8LS-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/intel-lab-lkp/linux/commit/6a9ea8570c34a7222786ca4d129578f48426d2f2
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Nitesh-Shetty/block-Introduce-queue-limits-for-copy-offload-support/20220426-201825
        git checkout 6a9ea8570c34a7222786ca4d129578f48426d2f2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=s390 SHELL=/bin/bash drivers/md/ drivers/nvme/target/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/nvme/target/io-cmd-bdev.c:56:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned char [usertype] msrc @@     got restricted __le16 @@
   drivers/nvme/target/io-cmd-bdev.c:56:26: sparse:     expected unsigned char [usertype] msrc
   drivers/nvme/target/io-cmd-bdev.c:56:26: sparse:     got restricted __le16
   drivers/nvme/target/io-cmd-bdev.c:59:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned char [usertype] msrc @@     got restricted __le16 @@
   drivers/nvme/target/io-cmd-bdev.c:59:34: sparse:     expected unsigned char [usertype] msrc
   drivers/nvme/target/io-cmd-bdev.c:59:34: sparse:     got restricted __le16
--
>> drivers/nvme/target/admin-cmd.c:537:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned char [usertype] msrc @@     got restricted __le16 @@
   drivers/nvme/target/admin-cmd.c:537:26: sparse:     expected unsigned char [usertype] msrc
   drivers/nvme/target/admin-cmd.c:537:26: sparse:     got restricted __le16

vim +56 drivers/nvme/target/io-cmd-bdev.c

    12	
    13	void nvmet_bdev_set_limits(struct block_device *bdev, struct nvme_id_ns *id)
    14	{
    15		const struct queue_limits *ql = &bdev_get_queue(bdev)->limits;
    16		/* Number of logical blocks per physical block. */
    17		const u32 lpp = ql->physical_block_size / ql->logical_block_size;
    18		/* Logical blocks per physical block, 0's based. */
    19		const __le16 lpp0b = to0based(lpp);
    20	
    21		/*
    22		 * For NVMe 1.2 and later, bit 1 indicates that the fields NAWUN,
    23		 * NAWUPF, and NACWU are defined for this namespace and should be
    24		 * used by the host for this namespace instead of the AWUN, AWUPF,
    25		 * and ACWU fields in the Identify Controller data structure. If
    26		 * any of these fields are zero that means that the corresponding
    27		 * field from the identify controller data structure should be used.
    28		 */
    29		id->nsfeat |= 1 << 1;
    30		id->nawun = lpp0b;
    31		id->nawupf = lpp0b;
    32		id->nacwu = lpp0b;
    33	
    34		/*
    35		 * Bit 4 indicates that the fields NPWG, NPWA, NPDG, NPDA, and
    36		 * NOWS are defined for this namespace and should be used by
    37		 * the host for I/O optimization.
    38		 */
    39		id->nsfeat |= 1 << 4;
    40		/* NPWG = Namespace Preferred Write Granularity. 0's based */
    41		id->npwg = lpp0b;
    42		/* NPWA = Namespace Preferred Write Alignment. 0's based */
    43		id->npwa = id->npwg;
    44		/* NPDG = Namespace Preferred Deallocate Granularity. 0's based */
    45		id->npdg = to0based(ql->discard_granularity / ql->logical_block_size);
    46		/* NPDG = Namespace Preferred Deallocate Alignment */
    47		id->npda = id->npdg;
    48		/* NOWS = Namespace Optimal Write Size */
    49		id->nows = to0based(ql->io_opt / ql->logical_block_size);
    50	
    51		/*Copy limits*/
    52		if (ql->max_copy_sectors) {
    53			id->mcl = cpu_to_le32((ql->max_copy_sectors << 9) / ql->logical_block_size);
    54			id->mssrl = cpu_to_le16((ql->max_copy_range_sectors << 9) /
    55					ql->logical_block_size);
  > 56			id->msrc = to0based(ql->max_copy_nr_ranges);
    57		} else {
    58			if (ql->zoned == BLK_ZONED_NONE) {
    59				id->msrc = to0based(BIO_MAX_VECS);
    60				id->mssrl = cpu_to_le16(
    61						(BIO_MAX_VECS << PAGE_SHIFT) / ql->logical_block_size);
    62				id->mcl = cpu_to_le32(le16_to_cpu(id->mssrl) * BIO_MAX_VECS);
    63	#ifdef CONFIG_BLK_DEV_ZONED
    64			} else {
    65				/* TODO: get right values for zoned device */
    66				id->msrc = to0based(BIO_MAX_VECS);
    67				id->mssrl = cpu_to_le16(min((BIO_MAX_VECS << PAGE_SHIFT),
    68						ql->chunk_sectors) / ql->logical_block_size);
    69				id->mcl = cpu_to_le32(min(le16_to_cpu(id->mssrl) * BIO_MAX_VECS,
    70							ql->chunk_sectors));
    71	#endif
    72			}
    73		}
    74	}
    75	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

