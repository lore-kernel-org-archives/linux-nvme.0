Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECFE9C433EF
	for <linux-nvme@archiver.kernel.org>; Sat, 23 Jul 2022 00:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/Fq0sRTckRmXMaBLpt7xwB9MPrE5InWAcCZzqKDQQ7w=; b=3edm/ZyyTZsCMgxdGbjmXd2c4C
	+cP5TKWes5M2DKXiMNZ4KTkosqzWj4VwCzF7QsA0w4Mr3N1x5ivbxRb+NlkzhiEiO8Su3IsG4jg5/
	MYSyXytYwzHb4zc4MDmqJuaw0NKxi36eRspa859fvDRP251t+WOzoAB+vWb68StFO+itbkj91Qs7b
	fZuqHWe4Hm9xEKoIvM1zVyi8ZEPYg0+vx2vNHr57I58Ro08LMGU5h8JoHy8nz587ZgeP5h7GpMCC0
	EZoHJDIbwElSvxjkzK8zjFh+3KTdSfQg3mkex3BqUaNXQxB6tS7WFmJ+2My8i5Ut7l9Bc0vNbvAVk
	gFRsr5xQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oF3P5-00Ds0u-4S; Sat, 23 Jul 2022 00:53:59 +0000
Received: from mga17.intel.com ([192.55.52.151])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oF3Oz-00DrxH-6j
	for linux-nvme@lists.infradead.org; Sat, 23 Jul 2022 00:53:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658537633; x=1690073633;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6HObmke7qbQlG2tmhlmrsc1HGXyA4mOB0pDb52JNZtw=;
  b=hFv0TM+51ORAh/NOifiWMo92JXjB4wWYaRGZT6Ag3YXS6xlDh7O5ybc7
   60jp0T+pZ8SYmqiDmzO3CyuCNF0AyndD320PH8VCOqMdLKTqXFlhEsGzo
   gcKDkps2BEP/0gqPs3uAXENEwDSgSnrve5AzG1LIH6LpCPeqv5A5gv4WM
   Xll1foYOLlBSD2uVfN4uXsvVJzRVBNFJbu2Nz89aaxVmlns/IPXlaAQ2A
   IugsEpuXWY50fmslGI2KKFOOhug2SMKwf7+zn1w1PG7FjikbPKCp1mvRO
   OC6K27179SU6Sm0dv6SX3tSo7yOybg1XC+kC0k8e9/VBPnQlZ9Z2LOwmb
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10416"; a="267826339"
X-IronPort-AV: E=Sophos;i="5.93,186,1654585200"; 
   d="scan'208";a="267826339"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 17:53:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,186,1654585200"; 
   d="scan'208";a="666852088"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 22 Jul 2022 17:53:48 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1oF3Ot-0001yj-1R;
	Sat, 23 Jul 2022 00:53:47 +0000
Date: Sat, 23 Jul 2022 08:52:49 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: llvm@lists.linux.dev, kbuild-all@lists.01.org,
	linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [linux-nvme:nvme-5.20 6/23] ERROR: modpost: "nvme_get_opcode_str"
 [drivers/nvme/host/nvme.ko] undefined!
Message-ID: <202207230815.GclNqpQx-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220722_175353_326673_EC39A50C 
X-CRM114-Status: UNSURE (   9.62  )
X-CRM114-Notice: Please train this message.
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

tree:   git://git.infradead.org/nvme.git nvme-5.20
head:   db6c4eb373fed6bb78f4aab2c9e4de0cc8e9c7ed
commit: 25399ce891e72e1f70c265a95fa4d12deba0736f [6/23] nvme-pci: print the command name of aborted commands
config: powerpc-randconfig-r012-20220721 (https://download.01.org/0day-ci/archive/20220723/202207230815.GclNqpQx-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 72686d68c137551cce816416190a18d45b4d4e2a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc cross compiling tool for clang build
        # apt-get install binutils-powerpc-linux-gnu
        git remote add linux-nvme git://git.infradead.org/nvme.git
        git fetch --no-tags linux-nvme nvme-5.20
        git checkout 25399ce891e72e1f70c265a95fa4d12deba0736f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "nvme_get_opcode_str" [drivers/nvme/host/nvme.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

