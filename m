Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0234EC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 24 May 2022 15:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=edFCCB9/Lsm6V//RHCNayRbCZljGLa23E/lUNTJgpX0=; b=HBOnzmlamb7/QyBFJVkA/hEtEq
	keP0dwIHADjVfzIsyKwC429KX8irtlISpRMguSf+obCoHznfhKF1OwVVPbl1b7QJK/YjEwjYlTTD2
	lPvIkLtMlrd18P7FX14A7KSJaWgP+s33C3cM4Os/3OwvfSFDnbRB7FvvQrkwI8N3gR7JOb31V9uei
	1UocfVV0MxutX/XnZ2PC6M24U5zlo/tQFAKrT2sJ+CZKJyA7sYpJRnrGAKc+7O6BA0MRfGTccX181
	UOrXUdNE9n6d4vDH/pP7WgR/3Em+3Bc345rX7qTmEAjZiG+9fZoa9zfrc9iRvwFpR4pRCqJITXZHu
	HhIFOlJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ntWMw-008Qdf-AE; Tue, 24 May 2022 15:22:46 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ntWMs-008QbQ-KV
 for linux-nvme@lists.infradead.org; Tue, 24 May 2022 15:22:44 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 8C32661718;
 Tue, 24 May 2022 15:22:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA47EC34113;
 Tue, 24 May 2022 15:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1653405760;
 bh=Zavzl0EUlZlFuUnnulu91af2QlQ6Gvei0hqhIXk6Wjw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=to3yzRafvciUEnSb39LYNBe/xWkqQtoh1rmu/hFlMGci2JbBXauyj76DC9AMEfxzS
 ffO+lAl6i2S9Zz1l5owGqBHPe22GTPYHHiIeU9rUsR0jU3xGyzbZ9D2q3OEnI4W8wp
 nIM6Axb4zHKmMDEhsP4hb9W6LE17upO5Ats4LCpry32oe5WDbyzX1OFVzIiBGFKP2z
 FrA6N6I6/BIJE/MsTDD0pQGMSCrcSHpEmE7iK+94QeldEb3H64qKLPGJlm82NgWy16
 6epR8L9e+ryAf6/GrttwejgG2mPbZkMXbziYxjvbeyyyijvWgH12jR5BQ+3Tqt8Kvm
 R4Tjnx4n5E88Q==
Date: Tue, 24 May 2022 08:22:38 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: kernel test robot <lkp@intel.com>, axboe@kernel.dk, hch@lst.de,
 snitzer@redhat.com, damien.lemoal@opensource.wdc.com, hare@suse.de,
 Johannes.Thumshirn@wdc.com, llvm@lists.linux.dev,
 kbuild-all@lists.01.org, linux-nvme@lists.infradead.org,
 dm-devel@redhat.com, dsterba@suse.com, jiangbo.365@bytedance.com,
 linux-kernel@vger.kernel.org, gost.dev@samsung.com,
 linux-block@vger.kernel.org, jaegeuk@kernel.org,
 Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v5 5/7] null_blk: allow non power of 2 zoned devices
Message-ID: <Yoz4PsQjWzVxz+YO@dev-arch.thelio-3990X>
References: <20220523161601.58078-6-p.raghav@samsung.com>
 <CGME20220524024108eucas1p26a6384cd77f143bb0fa628f01866e0a0@eucas1p2.samsung.com>
 <202205241034.izkLMTcH-lkp@intel.com>
 <7656fdc2-0511-722e-de6a-c2a2460cb048@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7656fdc2-0511-722e-de6a-c2a2460cb048@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220524_082242_789487_5E874DE6 
X-CRM114-Status: GOOD (  21.81  )
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

On Tue, May 24, 2022 at 09:30:41AM +0200, Pankaj Raghav wrote:
> On 5/24/22 04:40, kernel test robot wrote:
> > Hi Pankaj,
> > 
> > Thank you for the patch! Yet something to improve:
> > 
> > [auto build test ERROR on axboe-block/for-next]
> > [also build test ERROR on device-mapper-dm/for-next linus/master hch-configfs/for-next v5.18 next-20220523]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch]
> > 
> > url:    https://protect2.fireeye.com/v1/url?k=8acc50e6-d557681b-8acddba9-000babff317b-0ca211d60a57a8c6&q=1&e=5ef82219-ef70-445f-a7d0-0ae0a30be69f&u=https%3A%2F%2Fgithub.com%2Fintel-lab-lkp%2Flinux%2Fcommits%2FPankaj-Raghav%2Fblock-make-blkdev_nr_zones-and-blk_queue_zone_no-generic-for-npo2-zsze%2F20220524-011616
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
> > config: hexagon-randconfig-r045-20220523 (https://protect2.fireeye.com/v1/url?k=0dc32741-52581fbc-0dc2ac0e-000babff317b-fb6f258f0c80ebb9&q=1&e=5ef82219-ef70-445f-a7d0-0ae0a30be69f&u=https%3A%2F%2Fdownload.01.org%2F0day-ci%2Farchive%2F20220524%2F202205241034.izkLMTcH-lkp%40intel.com%2Fconfig)
> > compiler: clang version 15.0.0 (https://protect2.fireeye.com/v1/url?k=afbb4f4f-f02077b2-afbac400-000babff317b-a4413fa4cefe1877&q=1&e=5ef82219-ef70-445f-a7d0-0ae0a30be69f&u=https%3A%2F%2Fgithub.com%2Fllvm%2Fllvm-project 10c9ecce9f6096e18222a331c5e7d085bd813f75)
> > reproduce (this is a W=1 build):
> >         wget https://protect2.fireeye.com/v1/url?k=718573dc-2e1e4b21-7184f893-000babff317b-b6c06a1c569b0d77&q=1&e=5ef82219-ef70-445f-a7d0-0ae0a30be69f&u=https%3A%2F%2Fraw.githubusercontent.com%2Fintel%2Flkp-tests%2Fmaster%2Fsbin%2Fmake.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://protect2.fireeye.com/v1/url?k=247d070f-7be63ff2-247c8c40-000babff317b-6fd7f2f6a5a5bc60&q=1&e=5ef82219-ef70-445f-a7d0-0ae0a30be69f&u=https%3A%2F%2Fgithub.com%2Fintel-lab-lkp%2Flinux%2Fcommit%2F3d3c81da0adbd40eb0d2125327b7e227582b2a37
> >         git remote add linux-review https://protect2.fireeye.com/v1/url?k=081be8db-5780d026-081a6394-000babff317b-d12fdca0fccd0493&q=1&e=5ef82219-ef70-445f-a7d0-0ae0a30be69f&u=https%3A%2F%2Fgithub.com%2Fintel-lab-lkp%2Flinux
> >         git fetch --no-tags linux-review Pankaj-Raghav/block-make-blkdev_nr_zones-and-blk_queue_zone_no-generic-for-npo2-zsze/20220524-011616
> >         git checkout 3d3c81da0adbd40eb0d2125327b7e227582b2a37
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash
> > 
> > If you fix the issue, kindly add following tag where applicable
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All errors (new ones prefixed by >>, old ones prefixed by <<):
> > 
> >>> ERROR: modpost: "__hexagon_umoddi3" [drivers/block/null_blk/null_blk.ko] undefined!
> 
> I am able to apply my patches cleanly against next-20220523, build it
> without any errors with GCC and boot into it in my x86_64 machine. Not
> sure why this error is popping up.

Do a 32-bit build and you'll see it. With GCC 12.1.0, ARCH=i386
defconfig + CONFIG_BLK_DEV_NULL_BLK=y + CONFIG_BLK_DEV_ZONED=y
reproduces it for me:

$ make -skj"$(nproc)" ARCH=i386 defconfig menuconfig all
ld: drivers/block/null_blk/zoned.o: in function `null_init_zoned_dev':
zoned.c:(.text+0x112e): undefined reference to `__umoddi3'
...

roundup() does a plain division with a 64-bit dividend, which will cause
issues with 32-bit architectures. I suspect that you should really be
using DIV_ROUND_UP_SECTOR_T() for the nr_zones calculation or maybe one
of the other rounding macros in include/linux/math.h but I am not sure.

Cheers,
Nathan

