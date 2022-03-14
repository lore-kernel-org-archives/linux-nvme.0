Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14719C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Mar 2022 13:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=vNZRuE7TYNSjoCUNCUOuEi/9yGrfmGwvGC+fJ/+b6CM=; b=zt4KI0KKooZJl/xPjU6Mc3v8b8
	nisyBibWmbzIL6ZWBiUf0dwDRrJCEizLa/6GDe9y1dd3xuDbjxjWAY+dAXb9ppvGR5fd9yDKJ5V6y
	rtJxOF4I1juxcPul2ixxMNbu64DLhaeIIhk7RCsqC5oIoyO3oFGbk5MIO3h3eIJ16Zzq1DPrHbEtb
	zZdl3eR/3YljliXBI2nhKWFX39OYK6pW2YENcNC0i1amtVpnL5u7cvVRqFqbvWdAEH0f2W76pF5S7
	io39dSq2SvGPWxx0XkeZq2twUYuOxRLEYJWQSJ+Jxkuuzm3FzPC+u9QoFY4G+CnMwBw9TYeOVBObO
	umHatOpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nTkei-005WpE-EN; Mon, 14 Mar 2022 13:22:36 +0000
Received: from mga03.intel.com ([134.134.136.65])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nTkef-005Wof-V5
 for linux-nvme@lists.infradead.org; Mon, 14 Mar 2022 13:22:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647264153; x=1678800153;
 h=date:from:to:cc:subject:message-id:mime-version;
 bh=LFGE/ENWL5o64pxiR30k/wcPVR9+frjR3S/GgeQfWmM=;
 b=kPvyQzY6bJRdlOG625TyNvn1QW0lHZ6pFKo6XKaN9t+NWwVABk/jy+kg
 2R4oJ0ywmS+v3UHUoXvl9sb6n4ngWldLmjEPhglRFDBL/OVr/oGxmEH3U
 TkNjJv07z6o9/nSOGAzT3v4o4SyV4waXnkQq87ZMi5Ft6pC+9OrRk+aTq
 jxRfbdMNANoJJT+r73a7Awa9RxXWfn5qJN/ZkciptEn9zpbFQcHOqXz8O
 Fyoe1/nVKkm7GT9zaIDj0Yh19Ox2CZWgt3q1rIRTWubrQ6igQsrvaqDLt
 +pqaHVYk8kZLLpcdotbp1pj3ckp3FSE/LnXq6X3k9ssJyzOvqW3P4rE/4 w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10285"; a="255976419"
X-IronPort-AV: E=Sophos;i="5.90,180,1643702400"; d="scan'208";a="255976419"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Mar 2022 06:22:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,180,1643702400"; d="scan'208";a="539964544"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
 by orsmga007.jf.intel.com with ESMTP; 14 Mar 2022 06:22:31 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1nTked-0009ss-27; Mon, 14 Mar 2022 13:22:31 +0000
Date: Mon, 14 Mar 2022 21:21:58 +0800
From: kernel test robot <lkp@intel.com>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: kbuild-all@lists.01.org, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>
Subject: [linux-nvme:nvme-5.18 12/12] arm-linux-gnueabi-ld:
 discovery.c:undefined reference to `nvmet_get_feat_async_event'
Message-ID: <202203142114.jASwxczN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220314_062234_070042_0B7C2FE4 
X-CRM114-Status: UNSURE (   9.84  )
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

tree:   git://git.infradead.org/nvme.git nvme-5.18
head:   0ad57fcd030f0bda79a3b6c2fb8fc29b871d9538
commit: 0ad57fcd030f0bda79a3b6c2fb8fc29b871d9538 [12/12] nvmet: open code nvmet_get_feat_kato()
config: arm-randconfig-c002-20220314 (https://download.01.org/0day-ci/archive/20220314/202203142114.jASwxczN-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add linux-nvme git://git.infradead.org/nvme.git
        git fetch --no-tags linux-nvme nvme-5.18
        git checkout 0ad57fcd030f0bda79a3b6c2fb8fc29b871d9538
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: drivers/nvme/target/discovery.o: in function `nvmet_execute_disc_get_features':
   discovery.c:(.text+0x26c): undefined reference to `nvmet_get_feat_kato'
>> arm-linux-gnueabi-ld: discovery.c:(.text+0x27a): undefined reference to `nvmet_get_feat_async_event'

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

