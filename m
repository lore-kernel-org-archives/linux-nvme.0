Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29193C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Mar 2022 13:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=CMn/xxQBSJYbEp7rgTteqzxR/ylgRJlIpnpTgHBVsC4=; b=abgPd1DpDVO3jIn+FPNDj18Of1
	oR8BFWsevP7T85NJq/7Oh7JOWqcKh9fuaEbwB/6dTIjV85l+d0eK5p4D1oxeAD0BodKfKBbykF7kQ
	SC0CsxqijCiLqtkSFqRQgFfHE2B/8+ZGp6B3fHR3/k3weZn9fNXoExLjPJ2hI5UB6MLkzr+np4hwo
	p/ny0iVr+dco99SsbhGVpvEitLGnhR0Jq6BqCAQM3kGI5g9Lgl46qUXnOv/nqA2yKo0Ih0r71ndjW
	BdzvN3Y+7XXrv5KZKBwrSPB6SgsW0+HvBJtRrCtQBqWSCNddIn+ayJfxdvC73u9+0THm/hgSbYqEe
	T20sf/eQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nTky6-005Ybh-TA; Mon, 14 Mar 2022 13:42:38 +0000
Received: from mga18.intel.com ([134.134.136.126])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nTky3-005Yb0-Qd
 for linux-nvme@lists.infradead.org; Mon, 14 Mar 2022 13:42:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647265355; x=1678801355;
 h=date:from:to:cc:subject:message-id:mime-version;
 bh=HegtT6HhOD8M81t86CGPGH1oeeF+O+8JG2hI9HDmioA=;
 b=BczZZAjUYaIZ2inzB0ZSs0F8imYuyOzZm5VtdpOs1xhZDvFXySVoX2HL
 iisTlPvrsr0npd82M5J9dvo7t7n6uk+yuDuLvTjzc37ZrJ9q01pWmwzxb
 a6ykQXG8Ndk45CaiaXptf9VAaeixShBDz9iC64gDxFiOHXNE2N3Jr91ql
 wUDUmTHXS4Y+onjT3i6cOcysc/D2Ij8HebxtFMI4YFm0yDehMOtPeINib
 oKLsd9SdUn8DpjUql6AQr9+gpiNp6yOj1N8zgdpQoqTLQ7sKkp6tuyP2l
 J+GiyqfVK6kwVbuHzvzwS2fyZCUXVbiC/y5t0V4Or+63O0/SRODXfHaSA w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10285"; a="238198680"
X-IronPort-AV: E=Sophos;i="5.90,180,1643702400"; d="scan'208";a="238198680"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Mar 2022 06:42:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,180,1643702400"; d="scan'208";a="497613979"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
 by orsmga003.jf.intel.com with ESMTP; 14 Mar 2022 06:42:33 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1nTky1-0009to-8o; Mon, 14 Mar 2022 13:42:33 +0000
Date: Mon, 14 Mar 2022 21:42:25 +0800
From: kernel test robot <lkp@intel.com>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: kbuild-all@lists.01.org, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>
Subject: [linux-nvme:nvme-5.18 11/12] arc-elf-ld: discovery.c:undefined
 reference to `nvmet_get_feat_async_event'
Message-ID: <202203142117.gVyaPma6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220314_064235_930884_6A9931B8 
X-CRM114-Status: GOOD (  12.11  )
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
commit: 7d36f577e5a3f73768327ca237f444e59140e261 [11/12] nvmet: open code nvmet_get_feat_async_event()
config: arc-buildonly-randconfig-r001-20220314 (https://download.01.org/0day-ci/archive/20220314/202203142117.gVyaPma6-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add linux-nvme git://git.infradead.org/nvme.git
        git fetch --no-tags linux-nvme nvme-5.18
        git checkout 7d36f577e5a3f73768327ca237f444e59140e261
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arc-elf-ld: drivers/nvme/target/discovery.o: in function `nvmet_execute_disc_get_features':
   discovery.c:(.text+0xe8): undefined reference to `nvmet_get_feat_async_event'
>> arc-elf-ld: discovery.c:(.text+0xe8): undefined reference to `nvmet_get_feat_async_event'
   `.exit.text' referenced in section `.data' of sound/soc/codecs/tlv320adc3xxx.o: defined in discarded section `.exit.text' of sound/soc/codecs/tlv320adc3xxx.o

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

