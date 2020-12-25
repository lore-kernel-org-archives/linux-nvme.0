Return-Path: <SRS0=S77o=F5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C528C433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Dec 2020 21:11:21 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3AEE22255
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Dec 2020 21:11:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3AEE22255
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To
	:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=z7TJl82h7ctn2MW4aaFPi3Kw+xxDnkXmBxFMrlCAuy4=; b=h29HSUmx1xmYcw5XdhjtjFF0A
	h5cpchQmj2R/uhN5yKgN5hAxrgq1ouHlezvlG4oqGqxfGznvG4eGM4kX8UhgnkizmhL0oxEB7k0Ku
	icMVKwpjco9HR2JwPJERRaP8MKUgoEm3cCuslgY7WKHKJi7NjMQYMpCcqte17QG/qzJLxBSiYEuUE
	nqpkZAnljT8fei8gl3NUP3wmxa3W+hYYW4rhJR3szid2FBVomZtRtk3Q6Cf5fAihyBfil8MbOT6Ol
	cYOhG0qOznDXOivthr354Ciyw31qOYjryNpKL06VeG9OsPXUY0A+b2D52gg8PmXIgzjF+vibU7Bzz
	W+/nE/Ktg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ksuMe-0005fg-Rr; Fri, 25 Dec 2020 21:11:08 +0000
Received: from mga07.intel.com ([134.134.136.100])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ksuMU-0005fC-J4
 for linux-nvme@lists.infradead.org; Fri, 25 Dec 2020 21:11:00 +0000
IronPort-SDR: iH4x8cT61ZECeI4bWaCd3oaberRjLnhWOI2OZV3qrVNlPPkGidM4z5fxzKjNUAhQfEsv7DDaAv
 ishdoKO8GQEA==
X-IronPort-AV: E=McAfee;i="6000,8403,9845"; a="240319083"
X-IronPort-AV: E=Sophos;i="5.78,449,1599548400"; 
 d="gz'50?scan'50,208,50";a="240319083"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Dec 2020 13:10:52 -0800
IronPort-SDR: LG1hT8VsOGbRx+r2rxpmirFjn1GFwuqmoYhpUAAo/NHvIK+ZNesqnEsw4LxS2yFdG9/NfJmSZB
 WwYgaUKCqRag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,449,1599548400"; 
 d="gz'50?scan'50,208,50";a="383908846"
Received: from lkp-server02.sh.intel.com (HELO 4242b19f17ef) ([10.239.97.151])
 by orsmga007.jf.intel.com with ESMTP; 25 Dec 2020 13:10:48 -0800
Received: from kbuild by 4242b19f17ef with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1ksuMK-0001k1-A1; Fri, 25 Dec 2020 21:10:48 +0000
Date: Sat, 26 Dec 2020 05:09:51 +0800
From: kernel test robot <lkp@intel.com>
To: leonid.ravich@dell.com, james.smart@broadcom.com
Subject: Re: [PATCH] nvmet-fc: associations list replaced with hlist rcu,
Message-ID: <202012260522.CWx3LxcY-lkp@intel.com>
References: <20201224110542.22219-1-leonid.ravich@dell.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
In-Reply-To: <20201224110542.22219-1-leonid.ravich@dell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201225_161059_156949_69E3770D 
X-CRM114-Status: GOOD (  25.22  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: kbuild-all@lists.01.org, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, clang-built-linux@googlegroups.com,
 Leonid Ravich <Leonid.Ravich@dell.com>, Christoph Hellwig <hch@lst.de>,
 lravich@gmail.com
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.10 next-20201223]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/leonid-ravich-dell-com/nvmet-fc-associations-list-replaced-with-hlist-rcu/20201224-191206
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 58cf05f597b03a8212d9ecf2c79ee046d3ee8ad9
config: s390-randconfig-r031-20201224 (attached as .config)
compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project cee1e7d14f4628d6174b33640d502bff3b54ae45)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://github.com/0day-ci/linux/commit/db9dbc6efce5ef6533984b7fbe395b365d71ce7f
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review leonid-ravich-dell-com/nvmet-fc-associations-list-replaced-with-hlist-rcu/20201224-191206
        git checkout db9dbc6efce5ef6533984b7fbe395b365d71ce7f
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=s390 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   include/uapi/linux/swab.h:19:12: note: expanded from macro '___constant_swab32'
           (((__u32)(x) & (__u32)0x000000ffUL) << 24) |            \
                     ^
   In file included from drivers/nvme/target/fc.c:8:
   In file included from include/linux/blk-mq.h:5:
   In file included from include/linux/blkdev.h:26:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:80:
   include/asm-generic/io.h:490:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:34:59: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
                                                             ^
   include/uapi/linux/swab.h:119:21: note: expanded from macro '__swab32'
           ___constant_swab32(x) :                 \
                              ^
   include/uapi/linux/swab.h:20:12: note: expanded from macro '___constant_swab32'
           (((__u32)(x) & (__u32)0x0000ff00UL) <<  8) |            \
                     ^
   In file included from drivers/nvme/target/fc.c:8:
   In file included from include/linux/blk-mq.h:5:
   In file included from include/linux/blkdev.h:26:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:80:
   include/asm-generic/io.h:490:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:34:59: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
                                                             ^
   include/uapi/linux/swab.h:119:21: note: expanded from macro '__swab32'
           ___constant_swab32(x) :                 \
                              ^
   include/uapi/linux/swab.h:21:12: note: expanded from macro '___constant_swab32'
           (((__u32)(x) & (__u32)0x00ff0000UL) >>  8) |            \
                     ^
   In file included from drivers/nvme/target/fc.c:8:
   In file included from include/linux/blk-mq.h:5:
   In file included from include/linux/blkdev.h:26:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:80:
   include/asm-generic/io.h:490:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:34:59: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
                                                             ^
   include/uapi/linux/swab.h:119:21: note: expanded from macro '__swab32'
           ___constant_swab32(x) :                 \
                              ^
   include/uapi/linux/swab.h:22:12: note: expanded from macro '___constant_swab32'
           (((__u32)(x) & (__u32)0xff000000UL) >> 24)))
                     ^
   In file included from drivers/nvme/target/fc.c:8:
   In file included from include/linux/blk-mq.h:5:
   In file included from include/linux/blkdev.h:26:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:80:
   include/asm-generic/io.h:490:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:34:59: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
                                                             ^
   include/uapi/linux/swab.h:120:12: note: expanded from macro '__swab32'
           __fswab32(x))
                     ^
   In file included from drivers/nvme/target/fc.c:8:
   In file included from include/linux/blk-mq.h:5:
   In file included from include/linux/blkdev.h:26:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:80:
   include/asm-generic/io.h:501:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:511:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:521:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:609:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsb(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:617:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsw(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:625:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsl(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:634:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesb(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:643:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesw(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:652:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesl(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
>> drivers/nvme/target/fc.c:1156:6: warning: no previous prototype for function 'nvmet_assoc_free_queue_rcu' [-Wmissing-prototypes]
   void nvmet_assoc_free_queue_rcu(struct rcu_head *rcu_head) {
        ^
   drivers/nvme/target/fc.c:1156:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void nvmet_assoc_free_queue_rcu(struct rcu_head *rcu_head) {
   ^
   static 
   drivers/nvme/target/fc.c:175:1: warning: unused function 'nvmet_fc_iodnum' [-Wunused-function]
   nvmet_fc_iodnum(struct nvmet_fc_ls_iod *iodptr)
   ^
   drivers/nvme/target/fc.c:181:1: warning: unused function 'nvmet_fc_fodnum' [-Wunused-function]
   nvmet_fc_fodnum(struct nvmet_fc_fcp_iod *fodptr)
   ^
   23 warnings generated.


vim +/nvmet_assoc_free_queue_rcu +1156 drivers/nvme/target/fc.c

  1155	
> 1156	void nvmet_assoc_free_queue_rcu(struct rcu_head *rcu_head) {
  1157		struct nvmet_fc_tgt_assoc *assoc =
  1158			container_of(rcu_head, struct nvmet_fc_tgt_assoc, rcu_head);
  1159		struct nvmet_fc_tgtport *tgtport = assoc->tgtport;
  1160	
  1161		kfree(assoc);
  1162		dev_info(tgtport->dev,
  1163			"{%d:%d} Association freed\n",
  1164			tgtport->fc_target_port.port_num, assoc->a_id);
  1165	}
  1166	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--HcAYCG3uE/tztfnV
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
NLzvpWZRxCnb4f8HYXiO2l/gAAA=

--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--HcAYCG3uE/tztfnV--

