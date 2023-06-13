Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C9D9EB64D7
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Jun 2023 20:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=z6Zfi36pCXC8WVBSh5Fv0llIdSfYgqk259xPWZZm0jY=; b=eUPiMXkyYmQIaveMIGQpUtXDcP
	suB2Gg1fWyz4lP8e5s3GZ8uEWSOUH4BGESN7EMvWZcdMdBGWIQ+zbpH/dwP9ZMTc+yXO+JsXHJlmD
	jPqxqcptjn6ZhdOhoJN5BIMxlll8tz5X+rhZVzRNAxWKIZtT+BtRpPTLPc7ruwgf5KSLSyKYXYBDA
	tjnKZL8C5uclz1Z3q/CRQftAvEJskS2lq41eFcfuorTpP0XP8y6Yx943pHGAB+mtesm7lDK6Q36oA
	9Gz0x10SFLmftjhS70Qm9NWa7F791ELwTPqiqKhErbqyKO5CGDWKrgO/yfjGSorNEPpk1bytzlnvb
	SuauNLGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q9Asc-00980v-1Y;
	Tue, 13 Jun 2023 20:44:42 +0000
Received: from mga11.intel.com ([192.55.52.93])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q9AsW-0097zI-07
	for linux-nvme@lists.infradead.org;
	Tue, 13 Jun 2023 20:44:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686689076; x=1718225076;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=X7MiNBmxKG11wYBAtd8RJnGq4nHocac+BkiDsfdC/uM=;
  b=Gr/6r21zxbK7iHT+r3koJldsjnxTfiCcX7eOS7AMrjHj1C96rHrEf6gG
   cEhBqkjcRBfQwcuTaetaRHcFxJzbW1lL8K0o4+T1fm/NFE1dktXLJA+LV
   1gtrvo00JpLR3gi004t6FjS/bKTotu2w8tk1dGnZGH60KOxtONOWI1IsX
   NifPYX69YqFmanoiCWd/BHp8R4F8asmegcfgTCgLKcCvANwNfo0F5Toaj
   1F7CmahkS6yA9hp+Wqz+H6MH46FTFh5nf3HfOgyLkcG+0TzdHfVoC2Enq
   0ItXmm4+DfG087UzY0HXLrHoAc3s/S84ZSbtKZAzFyu83dWtwHIz562XX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="355945929"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="355945929"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 13:44:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="711788245"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="711788245"
Received: from lkp-server01.sh.intel.com (HELO 211f47bdb1cb) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 13 Jun 2023 13:44:20 -0700
Received: from kbuild by 211f47bdb1cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1q9AsF-0001kq-31;
	Tue, 13 Jun 2023 20:44:19 +0000
Date: Wed, 14 Jun 2023 04:43:56 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>,
	Christian Brauner <brauner@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: [linux-nvme:nvme-6.5-merged 197/227] drivers/block/swim3.c:919:15:
 error: too many arguments to function 'floppy_locked_ioctl'
Message-ID: <202306140401.DgFYAeVz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230613_134436_144288_6754981B 
X-CRM114-Status: GOOD (  14.36  )
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

tree:   git://git.infradead.org/nvme.git nvme-6.5-merged
head:   84a1df76eb397f3b8bf3a386bfcfb2e84f75554b
commit: 0f306bf5ab2690b12d1708273aaa974c790f838e [197/227] block: replace fmode_t with a block-specific type for block open flags
config: powerpc-buildonly-randconfig-r002-20230612 (https://download.01.org/0day-ci/archive/20230614/202306140401.DgFYAeVz-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add linux-nvme git://git.infradead.org/nvme.git
        git fetch --no-tags linux-nvme nvme-6.5-merged
        git checkout 0f306bf5ab2690b12d1708273aaa974c790f838e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/block/

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306140401.DgFYAeVz-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/block/swim3.c: In function 'floppy_ioctl':
>> drivers/block/swim3.c:919:15: error: too many arguments to function 'floppy_locked_ioctl'
     919 |         ret = floppy_locked_ioctl(bdev, mode, cmd, param);
         |               ^~~~~~~~~~~~~~~~~~~
   drivers/block/swim3.c:885:12: note: declared here
     885 | static int floppy_locked_ioctl(struct block_device *bdev,
         |            ^~~~~~~~~~~~~~~~~~~
   drivers/block/swim3.c: At top level:
   drivers/block/swim3.c:1280:5: warning: no previous prototype for 'swim3_init' [-Wmissing-prototypes]
    1280 | int swim3_init(void)
         |     ^~~~~~~~~~


vim +/floppy_locked_ioctl +919 drivers/block/swim3.c

^1da177e4c3f41 Linus Torvalds    2005-04-16  912  
0f306bf5ab2690 Christoph Hellwig 2023-06-08  913  static int floppy_ioctl(struct block_device *bdev, blk_mode_t mode,
8a6cfeb6deca3a Arnd Bergmann     2010-07-08  914  				 unsigned int cmd, unsigned long param)
8a6cfeb6deca3a Arnd Bergmann     2010-07-08  915  {
8a6cfeb6deca3a Arnd Bergmann     2010-07-08  916  	int ret;
8a6cfeb6deca3a Arnd Bergmann     2010-07-08  917  
2a48fc0ab24241 Arnd Bergmann     2010-06-02  918  	mutex_lock(&swim3_mutex);
8a6cfeb6deca3a Arnd Bergmann     2010-07-08 @919  	ret = floppy_locked_ioctl(bdev, mode, cmd, param);
2a48fc0ab24241 Arnd Bergmann     2010-06-02  920  	mutex_unlock(&swim3_mutex);
8a6cfeb6deca3a Arnd Bergmann     2010-07-08  921  
8a6cfeb6deca3a Arnd Bergmann     2010-07-08  922  	return ret;
8a6cfeb6deca3a Arnd Bergmann     2010-07-08  923  }
8a6cfeb6deca3a Arnd Bergmann     2010-07-08  924  

:::::: The code at line 919 was first introduced by commit
:::::: 8a6cfeb6deca3a8fefd639d898b0d163c0b5d368 block: push down BKL into .locked_ioctl

:::::: TO: Arnd Bergmann <arnd@arndb.de>
:::::: CC: Jens Axboe <jaxboe@fusionio.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

