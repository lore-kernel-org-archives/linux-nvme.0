Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5574C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 17 May 2022 04:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NGzhTNR0XCEikb+fgNJgLiOURkAph2Svr0uiWnPfvP4=; b=gHlzZ7Ohc2W9O1eYsiixDl34Do
	I5QwtBZ7s+GyN5NaW3MifW0gI4KNEPniUKVzcBX8TNXkBzhHyR0ejwlIuZocT7S6DYfvMUnGT8Dpn
	wIFR4mp2ouMoHPR1alh1nDakJ/4SKUEojt65yHhypmv5V0tvUszRQz9q+BYPcHKEC+Vif9RVfYMsy
	Cuu4FJ27lugAS4TdEpr9L5M9tS9j6F+rtAVe9so18ZWUWbiRrLIQwJeybEnGQqQP5kgdRYQ8F01JW
	WZC49Kdhl1iBh+JLIrKxW3wHTlE48OabG1b0c7dXpJKlGeFr/eErZeOnLw9ehAgpC/Ls3VhnBEnTU
	FXnbLtNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nqoaA-00BZKd-HE; Tue, 17 May 2022 04:13:14 +0000
Received: from mga06b.intel.com ([134.134.136.31] helo=mga06.intel.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nqoa7-00BZIy-1U
 for linux-nvme@lists.infradead.org; Tue, 17 May 2022 04:13:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652760791; x=1684296791;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=1drYWkhJXlza+p8qJe1jaRor29et4ZBJVwKRLeAW2M8=;
 b=HL5Q0Vk62kc8o6rDuAnSmA9hh2Exrr/Q9736A1GfbbR5d27BfK7kXsr5
 sBCOaTonLuPrqDVNE6cl5waWF4fN2Vl4WAMC8v9FtUugPiiKri1ESyhJd
 5p/78d8sVv0lUvIahnlR9BMU95DNoTKzZ+bxa6jVaAO+nbYaE0dROZBd4
 dBbVK9m6nJmMRMZDH0rUub3v6rNBykRVoIro2YKA7jXhTWZBVHzSw9R4g
 G1pgu+8KUmAWILpgR1ZHl3NB3hOpuBaySI2Al66wMEX0T5VUFU5KfuaEJ
 KQs8C9Fe1TezfHmK6l9UJvEyXJ4lV/QMzqcEiLlSwud65KarSgJYuiMma w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="331667010"
X-IronPort-AV: E=Sophos;i="5.91,231,1647327600"; d="scan'208";a="331667010"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 May 2022 21:13:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,231,1647327600"; d="scan'208";a="699868498"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
 by orsmga004.jf.intel.com with ESMTP; 16 May 2022 21:13:04 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
 (envelope-from <lkp@intel.com>) id 1nqoZz-0000ap-DK;
 Tue, 17 May 2022 04:13:03 +0000
Date: Tue, 17 May 2022 12:12:42 +0800
From: kernel test robot <lkp@intel.com>
To: Pankaj Raghav <p.raghav@samsung.com>, axboe@kernel.dk,
 damien.lemoal@opensource.wdc.com, pankydev8@gmail.com,
 dsterba@suse.com, hch@lst.de
Cc: kbuild-all@lists.01.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
 jiangbo.365@bytedance.com, linux-block@vger.kernel.org,
 gost.dev@samsung.com, p.raghav@samsung.com,
 linux-kernel@vger.kernel.org, dm-devel@redhat.com,
 Luis Chamberlain <mcgrof@kernel.org>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v4 11/13] null_blk: allow non power of 2 zoned devices
Message-ID: <202205171251.o9RZslnw-lkp@intel.com>
References: <20220516165416.171196-12-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516165416.171196-12-p.raghav@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220516_211311_204868_563D7806 
X-CRM114-Status: GOOD (  11.50  )
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

Thank you for the patch! Yet something to improve:

[auto build test ERROR on next-20220516]
[also build test ERROR on v5.18-rc7]
[cannot apply to axboe-block/for-next kdave/for-next device-mapper-dm/for-next linus/master v5.18-rc7 v5.18-rc6 v5.18-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Pankaj-Raghav/block-make-blkdev_nr_zones-and-blk_queue_zone_no-generic-for-npo2-zsze/20220517-015435
base:    3f7bdc402fb06f897ff1f492a2d42e1f7c2efedb
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20220517/202205171251.o9RZslnw-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/1fc6f61076425c29e51cfa376f8dee4dbf588ed1
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Pankaj-Raghav/block-make-blkdev_nr_zones-and-blk_queue_zone_no-generic-for-npo2-zsze/20220517-015435
        git checkout 1fc6f61076425c29e51cfa376f8dee4dbf588ed1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   m68k-linux-ld: drivers/block/null_blk/zoned.o: in function `null_init_zoned_dev':
>> zoned.c:(.text+0x9c6): undefined reference to `__udivdi3'
   `.exit.text' referenced in section `.data' of sound/soc/codecs/tlv320adc3xxx.o: defined in discarded section `.exit.text' of sound/soc/codecs/tlv320adc3xxx.o

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

