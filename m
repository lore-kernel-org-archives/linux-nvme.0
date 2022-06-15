Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B24AC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jun 2022 14:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Te73s0EBNo48jKDeV8krKX2ns2jSyjSXnpnY3ZyPqRg=; b=x88I0N55DOhj04gANd7eGXX42Q
	pGsHyzyRhYmQ+kVwuc6sm89q7GUnGviCAYDyIuJIsnq8fLIdqUNZklGnXCqmHAbLRiyosr1pUj0wk
	Qc2n2LsqICx6+1fswTSHk8HAaLP/EHbtDZPytYSCx9FSbpp11Z96lN9QMpmQTtKsL8yE6Q9dzada5
	fFfr3d8lACIwV8VpmCR/r4gScVDdhETyL/Q4QUoVtiAScR4+PMNFUP2p9h5DRZQFVu1BXBB56jzQ6
	kYcLWNLQa+wPAY2l4yZWeAL9bRI7kmSKKz8eKwIjvPakxibTNeWH8giPTleorNJe5WJ6tTZTI2RA2
	SN6Uu24w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1Tsr-00Eupt-Kb; Wed, 15 Jun 2022 14:20:37 +0000
Received: from mga14.intel.com ([192.55.52.115])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1Tso-00Eunz-Dl
	for linux-nvme@lists.infradead.org; Wed, 15 Jun 2022 14:20:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655302834; x=1686838834;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BKDMg8fI4/oxE7Ct5GmeyilLeRcSIf/mmkwDwOrZrs4=;
  b=MInFXJZ1PgotxQ36s7ciFSXcJw8PQC5E8CAHzwBnlUAHree4QaOUmb1w
   rA2FDfZ80lNriP3//fCyhZcqd3X9eDO0JJtU17ig6j4ZpHP4nRdIv+jvk
   3sHL7vnOmluhUJB4UZJ/bKbe/bjtNAaw12393+P12zzKlYBLq0w8RcE2H
   OVFQH9jETPfEGET5QUlvE/PBx11v7z1UF3m45suLJGlqj64JQrdYCbxEf
   ksD+bmE6ZD4orCBTak9Zidd7te8Howy9vtfOxCGKE94EcjA6aSYtAknwj
   H4ka3I5xevfMYXH5fLwmtkMcxKB7a8Kan6HwlcBRKaAIkgTHkvkmfMs2H
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="279023173"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="279023173"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 07:20:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="727417450"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 15 Jun 2022 07:20:18 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
	(envelope-from <lkp@intel.com>)
	id 1o1TsX-000MvF-LV;
	Wed, 15 Jun 2022 14:20:17 +0000
Date: Wed, 15 Jun 2022 22:19:48 +0800
From: kernel test robot <lkp@intel.com>
To: Pankaj Raghav <p.raghav@samsung.com>, hch@lst.de, snitzer@redhat.com,
	damien.lemoal@opensource.wdc.com, axboe@kernel.dk
Cc: kbuild-all@lists.01.org, bvanassche@acm.org,
	linux-kernel@vger.kernel.org, jiangbo.365@bytedance.com,
	hare@suse.de, pankydev8@gmail.com, dm-devel@redhat.com,
	jonathan.derrick@linux.dev, gost.dev@samsung.com, dsterba@suse.com,
	jaegeuk@kernel.org, linux-nvme@lists.infradead.org,
	Johannes.Thumshirn@wdc.com, linux-block@vger.kernel.org,
	Pankaj Raghav <p.raghav@samsung.com>,
	Damien Le Moal <damien.lemoal@wdc.com>
Subject: Re: [PATCH v7 13/13] dm: add non power of 2 zoned target
Message-ID: <202206152257.pnoPyl7X-lkp@intel.com>
References: <20220615101920.329421-14-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615101920.329421-14-p.raghav@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220615_072034_528775_DE81B7E2 
X-CRM114-Status: GOOD (  15.17  )
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

Hi Pankaj,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on axboe-block/for-next]
[also build test WARNING on device-mapper-dm/for-next linus/master v5.19-rc2 next-20220615]
[cannot apply to song-md/md-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Pankaj-Raghav/block-make-blkdev_nr_zones-and-blk_queue_zone_no-generic-for-npo2-zsze/20220615-191927
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20220615/202206152257.pnoPyl7X-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/add4ab54d5b34d4a2f91f241007f23a56c164fb3
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Pankaj-Raghav/block-make-blkdev_nr_zones-and-blk_queue_zone_no-generic-for-npo2-zsze/20220615-191927
        git checkout add4ab54d5b34d4a2f91f241007f23a56c164fb3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/md/dm-zoned-npo2-target.c: In function 'dmz_npo2_ctr':
>> drivers/md/dm-zoned-npo2-target.c:62:13: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
      62 |         int ret = 0;
         |             ^~~


vim +/ret +62 drivers/md/dm-zoned-npo2-target.c

    53	
    54	/*
    55	 * <dev-path>
    56	 * This target works on the complete zoned device. Partial mapping is not
    57	 * supported
    58	 */
    59	static int dmz_npo2_ctr(struct dm_target *ti, unsigned int argc, char **argv)
    60	{
    61		struct dmz_npo2_target *dmh = NULL;
  > 62		int ret = 0;
    63		sector_t zsze;
    64		sector_t disk_size;
    65	
    66		if (argc < 1)
    67			return -EINVAL;
    68	
    69		dmh = kmalloc(sizeof(*dmh), GFP_KERNEL);
    70		if (!dmh)
    71			return -ENOMEM;
    72	
    73		ret = dm_get_device(ti, argv[0], dm_table_get_mode(ti->table),
    74				    &dmh->dev);
    75	
    76		zsze = blk_queue_zone_sectors(bdev_get_queue(dmh->dev->bdev));
    77	
    78		disk_size = get_capacity(dmh->dev->bdev->bd_disk);
    79	
    80		if (ti->len != disk_size || ti->begin) {
    81			DMERR("%pg Partial mapping of the target not supported",
    82			      dmh->dev->bdev);
    83			return -EINVAL;
    84		}
    85	
    86		if (is_power_of_2(zsze)) {
    87			DMERR("%pg zone size is power of 2", dmh->dev->bdev);
    88			return -EINVAL;
    89		}
    90	
    91		dmh->zsze = zsze;
    92		dmh->zsze_po2 = 1 << get_count_order_long(zsze);
    93		dmh->zsze_diff = dmh->zsze_po2 - dmh->zsze;
    94	
    95		ti->private = dmh;
    96		ti->num_flush_bios = 1;
    97		ti->num_discard_bios = 1;
    98		ti->num_secure_erase_bios = 1;
    99		ti->num_write_zeroes_bios = 1;
   100	
   101		dmh->nr_zones = npo2_zone_no(dmh, ti->len);
   102		ti->len = dmh->zsze_po2 * dmh->nr_zones;
   103	
   104		return 0;
   105	}
   106	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

