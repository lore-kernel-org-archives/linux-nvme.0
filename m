Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA2BC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Mar 2022 16:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xx6Ve/1+Lp2J2zqFFljK9D1e1j3IZHddS3ulwux1K8o=; b=jB/2PvXC6lL7QaRAk+YYLVQOSq
	pr3WUvsOwG5wAKjGE9OF9NIe7ubnVr+qoNgoquaQNfGugBooNd0P1ZP6vO89KEyrIRwlM94tyCdc+
	IHO4RkPp1KdRu2r1Gip9hdHt9APIlT+BnrTEcfvQYJBMUjrrphnmevH4sZBCgEp/gsf+Gtcs1K08a
	s9oESHzpYd82EGG4is46fLlPbMSxkbFE9R1oF6h3q+8CtfnUQBmHNS6hUFkGhePhbxqpdUVLjI0W9
	z1+VV4X+HJKbBHRsPj82dqJr2rfcJLO5lE7GbYe9w+ty1qHOVVuaxOpTP2aeBQ38few9gLCsVyLxp
	fTDszGvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nX3qH-00EFDy-Ez; Wed, 23 Mar 2022 16:28:13 +0000
Received: from mga02.intel.com ([134.134.136.20])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nX3qD-00EFCY-Lc
 for linux-nvme@lists.infradead.org; Wed, 23 Mar 2022 16:28:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1648052889; x=1679588889;
 h=date:from:to:cc:subject:message-id:mime-version;
 bh=Msa++tQ4AK5Bp/+DsBQrMxGWGzUFUL6ooMHoafDYlfI=;
 b=m0cA86gq6gbGk/kP0IXAub12xPzYvz9mwgKo39W6lA64fMfD4+uhl+33
 UubvCjI7Jmy3kbc24u+GB5v5GGHGbaMvb2S6GOWc8jNJqypDbOyMIHGcw
 YPOMfGgEUwLZbltahaH7owFJk8cJls3FFiSqdLXwQ3WHQrluL6mo96Q99
 x9EEgUBiSDaPlO+r6AK297gA1dYGHlCeayqHlUHCQwVHE7lWSsHd3hNa0
 E1eddtUl7M3iX5cRTJRG5TwtZN6uXKXgp9rowdr5w/DdZA4CfxbJNjo7u
 AjQTMua/T9y7J5ce6Sm5wfJ+epY/K1mByP/DhN4Qr6F9xfaT2sjIJh4b2 g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="245633253"
X-IronPort-AV: E=Sophos;i="5.90,204,1643702400"; d="scan'208";a="245633253"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2022 09:21:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,204,1643702400"; d="scan'208";a="519421339"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
 by orsmga006.jf.intel.com with ESMTP; 23 Mar 2022 09:21:35 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1nX3jq-000KDJ-GO; Wed, 23 Mar 2022 16:21:34 +0000
Date: Thu, 24 Mar 2022 00:20:47 +0800
From: kernel test robot <lkp@intel.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: kbuild-all@lists.01.org, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [linux-nvme:nvme-5.18 4/5] ERROR: modpost: "nvmet_wq"
 [drivers/nvme/target/nvmet-fc.ko] undefined!
Message-ID: <202203240012.gJehzedI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220323_092809_800092_70383C79 
X-CRM114-Status: GOOD (  11.55  )
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

tree:   git://git.infradead.org/nvme.git nvme-5.18
head:   84db0c76f3bda283a82c0e883c8f3171048a30bf
commit: ade7dda8539580e02c9004f124783f320924709b [4/5] nvmet: use a private workqueue instead of the system workqueue
config: i386-randconfig-a003 (https://download.01.org/0day-ci/archive/20220324/202203240012.gJehzedI-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce (this is a W=1 build):
        git remote add linux-nvme git://git.infradead.org/nvme.git
        git fetch --no-tags linux-nvme nvme-5.18
        git checkout ade7dda8539580e02c9004f124783f320924709b
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "nvmet_wq" [drivers/nvme/target/nvmet-fc.ko] undefined!
>> ERROR: modpost: "nvmet_wq" [drivers/nvme/target/nvme-loop.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

