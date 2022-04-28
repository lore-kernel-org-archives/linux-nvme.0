Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C46BC433F5
	for <linux-nvme@archiver.kernel.org>; Fri,  6 May 2022 15:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Bx5JrMN5d17zrKYRbOCFk99wqZE/eeba4eQtt4rwFK8=; b=cR9BrJPP1B3EmfCinEwfoZlWo5
	QXmkeAKDWMliUyuQY+Y/Ll66wkOIC9MBlkPKiFQs9DHLvm8psoYb9xbemxFe33Nx22fE5Y/BNSwlo
	QP63peG4kq65Ei1B/EpTS1jptlF8g6ScvlVr9OXsDSz6XBW5ET8yYpYuosIe/U8CCj7WlrEkhchIQ
	gsv5s34GNnYD7yXJvwyhxsNG3xAGXykkrRTHw5B/cDvxNyKvykXNVv4u2LS9br3ED7t4Dlp5hc656
	nuaIsCKIg3+H7To0qCrsIGYByQORdVkLfc5uyqF7Ni06ChPWmEc8rkov4FDGbu7oJL2aC4tk9a0Lx
	Lfw3F0aw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nmzTl-003wPq-Vz; Fri, 06 May 2022 15:02:50 +0000
Received: from mga04.intel.com ([192.55.52.120])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nk6UE-007kCc-JN
 for linux-nvme@lists.infradead.org; Thu, 28 Apr 2022 15:55:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651161322; x=1682697322;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=9BimimfYrZUnTbXW408UFheZhJCa7AI21cga9+oD2hA=;
 b=YUocbHdv/DOJXKqlQ6R/ZVXuqEHY4mDH0At1oqpmvFwN9GTYuTnOhcyd
 1q2/vwdVEI6+eWk+OARbjAs5+HDlcJ6mXuJCGch33NRrRhBRT0QbcS3Ow
 YhBZGW/Xn0jW7GAUbrBUbLVNE8gXFlSUi72CD0N4p+huMEq+vHCzCF8UQ
 k7+HyYnRh6itRw/Ij22L/4E+TxztILNsYlBtF8NYfIeX45tccgLtvAc3h
 Dxsk7aVbipItugaDLTQjDKhke5y9dX0OydMM/hUSSlfQ5zfQuQu6dX+kr
 dy/vdvQL1ZeJDboRw5/uxhHOE6GXx/Y7RWIUpY6paTuTjRo2BLE5Wt8p3 A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="265181323"
X-IronPort-AV: E=Sophos;i="5.91,295,1647327600"; d="scan'208";a="265181323"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2022 08:55:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,295,1647327600"; d="scan'208";a="514363012"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
 by orsmga003.jf.intel.com with ESMTP; 28 Apr 2022 08:55:15 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
 (envelope-from <lkp@intel.com>) id 1nk6U6-0005VH-CQ;
 Thu, 28 Apr 2022 15:55:14 +0000
Date: Thu, 28 Apr 2022 23:54:46 +0800
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
 Nitesh Shetty <nj.shetty@samsung.com>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, James Smart <james.smart@broadcom.com>,
 Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v4 07/10] dm: Add support for copy offload.
Message-ID: <202204282336.7AY0GVKz-lkp@intel.com>
References: <20220426101241.30100-8-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426101241.30100-8-nj.shetty@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220428_085522_691679_67278E9C 
X-CRM114-Status: GOOD (  14.31  )
X-Mailman-Approved-At: Fri, 06 May 2022 08:02:49 -0700
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
config: s390-randconfig-s032-20220427 (https://download.01.org/0day-ci/archive/20220428/202204282336.7AY0GVKz-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/intel-lab-lkp/linux/commit/913c8c5197fea28ee3c8424e16eadd8b159a91f0
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Nitesh-Shetty/block-Introduce-queue-limits-for-copy-offload-support/20220426-201825
        git checkout 913c8c5197fea28ee3c8424e16eadd8b159a91f0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=s390 SHELL=/bin/bash drivers/md/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/md/dm.c:1602:24: sparse: sparse: incorrect type in return expression (different base types) @@     expected restricted blk_status_t @@     got int @@
   drivers/md/dm.c:1602:24: sparse:     expected restricted blk_status_t
   drivers/md/dm.c:1602:24: sparse:     got int

vim +1602 drivers/md/dm.c

  1582	
  1583	/*
  1584	 * Select the correct strategy for processing a non-flush bio.
  1585	 */
  1586	static blk_status_t __split_and_process_bio(struct clone_info *ci)
  1587	{
  1588		struct bio *clone;
  1589		struct dm_target *ti;
  1590		unsigned len;
  1591	
  1592		ti = dm_table_find_target(ci->map, ci->sector);
  1593		if (unlikely(!ti))
  1594			return BLK_STS_IOERR;
  1595		else if (unlikely(ci->is_abnormal_io))
  1596			return __process_abnormal_io(ci, ti);
  1597	
  1598		if ((unlikely(op_is_copy(ci->bio->bi_opf)) &&
  1599					max_io_len(ti, ci->sector) < ci->sector_count)) {
  1600			DMERR("%s: Error IO size(%u) is greater than maximum target size(%llu)\n",
  1601					__func__, ci->sector_count, max_io_len(ti, ci->sector));
> 1602			return -EIO;
  1603		}
  1604		/*
  1605		 * Only support bio polling for normal IO, and the target io is
  1606		 * exactly inside the dm_io instance (verified in dm_poll_dm_io)
  1607		 */
  1608		ci->submit_as_polled = ci->bio->bi_opf & REQ_POLLED;
  1609	
  1610		len = min_t(sector_t, max_io_len(ti, ci->sector), ci->sector_count);
  1611		setup_split_accounting(ci, len);
  1612		clone = alloc_tio(ci, ti, 0, &len, GFP_NOIO);
  1613		__map_bio(clone);
  1614	
  1615		ci->sector += len;
  1616		ci->sector_count -= len;
  1617	
  1618		return BLK_STS_OK;
  1619	}
  1620	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

