Return-Path: <SRS0=W+Vz=CJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 219C8C433E2
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Aug 2020 11:04:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E34422072D
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Aug 2020 11:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="A9jiW1+V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E34422072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=RL+GCLx8x5bIG71sY81b5uebmqNcyrP+9fFAmFbunaY=; b=A9jiW1+VVPfgT9Hp+PqeD/SFq
	aHWvixLjqLaWTNwMEP50LNXyFVCgrrPVKAyIYVKLlZzPbQyCsRDSbkGEszgnwroFoHkCo96Ow0lJN
	yIV3XWzRemWW0kFLEb01S6XgWpUBHvXhdyDMOX4jthidPCjfOb45Jhv+NycsR8B0YBhwxGkWHre0Y
	5qa3XUVyxcu0o9Zl1OSYQHZ/PSE8usZoyQMpOhy3belrcg4gwpt+uS9/QSTt286Qbqeiau2F0qymi
	85ZIFmqws7zqHiS8FMY0oVmf/MSzO7KnfSGdWI5xEJSp+JCm25INLeGwhWhMBv0zLzL6Dbcd1C3T1
	WJ17mBI3A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kChc6-00031U-Jb; Mon, 31 Aug 2020 11:04:38 +0000
Received: from smtp.h3c.com ([60.191.123.50] helo=h3cspam02-ex.h3c.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kChc3-0002zY-1k
 for linux-nvme@lists.infradead.org; Mon, 31 Aug 2020 11:04:37 +0000
Received: from DAG2EX02-BASE.srv.huawei-3com.com ([10.8.0.65])
 by h3cspam02-ex.h3c.com with ESMTPS id 07VB3phN027079
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 31 Aug 2020 19:03:51 +0800 (GMT-8)
 (envelope-from tian.xianting@h3c.com)
Received: from DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) by
 DAG2EX02-BASE.srv.huawei-3com.com (10.8.0.65) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 31 Aug 2020 19:03:54 +0800
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074])
 by DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074%7])
 with mapi id 15.01.1713.004; Mon, 31 Aug 2020 19:03:54 +0800
From: Tianxianting <tian.xianting@h3c.com>
To: kernel test robot <lkp@intel.com>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Subject: RE: [PATCH] nvme-pci: check req to prevent crash in nvme_handle_cqe()
Thread-Topic: [PATCH] nvme-pci: check req to prevent crash in nvme_handle_cqe()
Thread-Index: AQHWf2RcPXKUYIdfu0aQ67Gvv7x69alRcK+AgACNmNA=
Date: Mon, 31 Aug 2020 11:03:54 +0000
Message-ID: <fa48ae527de8458aa173bb242b83a97a@h3c.com>
References: <20200831065311.40731-1-tian.xianting@h3c.com>
 <202008311754.Gbt69JQN%lkp@intel.com>
In-Reply-To: <202008311754.Gbt69JQN%lkp@intel.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.99.141.128]
x-sender-location: DAG2
MIME-Version: 1.0
X-DNSRBL: 
X-MAIL: h3cspam02-ex.h3c.com 07VB3phN027079
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200831_070436_587948_1F145E70 
X-CRM114-Status: GOOD (  20.02  )
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
Cc: "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

I am very sorry, I used the wrong patch file :(
I send it again. Please review, thanks.

-----Original Message-----
From: kernel test robot [mailto:lkp@intel.com] 
Sent: Monday, August 31, 2020 5:41 PM
To: tianxianting (RD) <tian.xianting@h3c.com>; kbusch@kernel.org; axboe@fb.com; hch@lst.de; sagi@grimberg.me
Cc: kbuild-all@lists.01.org; linux-nvme@lists.infradead.org; linux-kernel@vger.kernel.org; tianxianting (RD) <tian.xianting@h3c.com>
Subject: Re: [PATCH] nvme-pci: check req to prevent crash in nvme_handle_cqe()

Hi Xianting,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on v5.9-rc2]
[also build test ERROR on next-20200828] [cannot apply to linus/master v5.9-rc3] [If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Xianting-Tian/nvme-pci-check-req-to-prevent-crash-in-nvme_handle_cqe/20200831-155653
base:    d012a7190fc1fd72ed48911e77ca97ba4521bccd
config: parisc-randconfig-r004-20200831 (attached as .config)
compiler: hppa-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=parisc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/nvme/host/pci.c: In function 'nvme_handle_cqe':
>> drivers/nvme/host/pci.c:3244: error: unterminated argument list invoking macro "dev_warn"
    3244 | module_exit(nvme_exit);
         | 
>> drivers/nvme/host/pci.c:966:3: error: 'dev_warn' undeclared (first use in this function); did you mean '_dev_warn'?
     966 |   dev_warn(nvmeq->dev->ctrl.device,
         |   ^~~~~~~~
         |   _dev_warn
   drivers/nvme/host/pci.c:966:3: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/nvme/host/pci.c:966:11: error: expected ';' at end of input
     966 |   dev_warn(nvmeq->dev->ctrl.device,
         |           ^
         |           ;
   ......
    3244 | module_exit(nvme_exit);
         |            
>> drivers/nvme/host/pci.c:966:3: error: expected declaration or 
>> statement at end of input
     966 |   dev_warn(nvmeq->dev->ctrl.device,
         |   ^~~~~~~~
>> drivers/nvme/host/pci.c:966:3: error: expected declaration or 
>> statement at end of input
   drivers/nvme/host/pci.c: At top level:
   drivers/nvme/host/pci.c:105:13: warning: 'nvme_dev_disable' declared 'static' but never defined [-Wunused-function]
     105 | static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown);
         |             ^~~~~~~~~~~~~~~~
   drivers/nvme/host/pci.c:106:13: warning: '__nvme_disable_io_queues' declared 'static' but never defined [-Wunused-function]
     106 | static bool __nvme_disable_io_queues(struct nvme_dev *dev, u8 opcode);
         |             ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/nvme/host/pci.c:901:13: warning: 'nvme_pci_complete_rq' defined but not used [-Wunused-function]
     901 | static void nvme_pci_complete_rq(struct request *req)
         |             ^~~~~~~~~~~~~~~~~~~~
   drivers/nvme/host/pci.c:853:21: warning: 'nvme_queue_rq' defined but not used [-Wunused-function]
     853 | static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
         |                     ^~~~~~~~~~~~~
   drivers/nvme/host/pci.c:484:13: warning: 'nvme_commit_rqs' defined but not used [-Wunused-function]
     484 | static void nvme_commit_rqs(struct blk_mq_hw_ctx *hctx)
         |             ^~~~~~~~~~~~~~~
   drivers/nvme/host/pci.c:427:12: warning: 'nvme_pci_map_queues' defined but not used [-Wunused-function]
     427 | static int nvme_pci_map_queues(struct blk_mq_tag_set *set)
         |            ^~~~~~~~~~~~~~~~~~~
   drivers/nvme/host/pci.c:403:12: warning: 'nvme_init_request' defined but not used [-Wunused-function]
     403 | static int nvme_init_request(struct blk_mq_tag_set *set, struct request *req,
         |            ^~~~~~~~~~~~~~~~~
   drivers/nvme/host/pci.c:392:12: warning: 'nvme_init_hctx' defined but not used [-Wunused-function]
     392 | static int nvme_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
         |            ^~~~~~~~~~~~~~
   drivers/nvme/host/pci.c:379:12: warning: 'nvme_admin_init_hctx' defined but not used [-Wunused-function]
     379 | static int nvme_admin_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
         |            ^~~~~~~~~~~~~~~~~~~~
   drivers/nvme/host/pci.c:371:15: warning: 'nvme_pci_iod_alloc_size' defined but not used [-Wunused-function]
     371 | static size_t nvme_pci_iod_alloc_size(void)
         |               ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/nvme/host/pci.c:294:13: warning: 'nvme_dbbuf_set' defined but not used [-Wunused-function]
     294 | static void nvme_dbbuf_set(struct nvme_dev *dev)
         |             ^~~~~~~~~~~~~~
   drivers/nvme/host/pci.c:282:13: warning: 'nvme_dbbuf_init' defined but not used [-Wunused-function]
     282 | static void nvme_dbbuf_init(struct nvme_dev *dev,
         |             ^~~~~~~~~~~~~~~
   drivers/nvme/host/pci.c:241:12: warning: 'nvme_dbbuf_dma_alloc' defined but not used [-Wunused-function]
     241 | static int nvme_dbbuf_dma_alloc(struct nvme_dev *dev)
         |            ^~~~~~~~~~~~~~~~~~~~

# https://github.com/0day-ci/linux/commit/e3761e6c554adb55d40e176915df361ad9e272e1
git remote add linux-review https://github.com/0day-ci/linux git fetch --no-tags linux-review Xianting-Tian/nvme-pci-check-req-to-prevent-crash-in-nvme_handle_cqe/20200831-155653
git checkout e3761e6c554adb55d40e176915df361ad9e272e1
vim +/dev_warn +3244 drivers/nvme/host/pci.c

b60503ba432b16 drivers/block/nvme.c      Matthew Wilcox 2011-01-20  3239  
b60503ba432b16 drivers/block/nvme.c      Matthew Wilcox 2011-01-20  3240  MODULE_AUTHOR("Matthew Wilcox <willy@linux.intel.com>");
b60503ba432b16 drivers/block/nvme.c      Matthew Wilcox 2011-01-20  3241  MODULE_LICENSE("GPL");
c78b47136f7ade drivers/block/nvme-core.c Keith Busch    2014-11-21  3242  MODULE_VERSION("1.0");
b60503ba432b16 drivers/block/nvme.c      Matthew Wilcox 2011-01-20  3243  module_init(nvme_init);
b60503ba432b16 drivers/block/nvme.c      Matthew Wilcox 2011-01-20 @3244  module_exit(nvme_exit);

---
0-DAY CI Kernel Test Service, Intel Corporation https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
