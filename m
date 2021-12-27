Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2352C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Dec 2021 18:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/cV8bOexI36dbYD//NeuxQBp4NhBt320J/GOgzpXwaU=; b=rLpUpjSwn8GFukpnXrdysZ9uTU
	v+uj5c5dTNzwoibrcsmMqRcKs2c/PJ7T78Cu1AlaPEIiujUpxRLrTAsihZlhxpzA/fyqsZ+L9Qvm/
	QAwiIVu1ILi9EsO6M14LqXfiWZyEUyP44qeOL7ziq0HPoM8qwWdypYiPky7lCquH9fL7YuWGOOL6j
	DPZN/eHdyjJ3qoadzvo0KrN9FsI0t53+178QOMwVni//GKMs7cHQVeCaUhoOMRWXCx9YolOSNVoqH
	xxvziAfdZabGj2FS2xfsWoqCTuQM2BxBGYrl+4YATiEwc0d8owoByvALwUY9N3w26W9U4LQQ5FEXG
	P8vc87UQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1n1v3z-00HKNK-Rt; Mon, 27 Dec 2021 18:49:39 +0000
Received: from mga06.intel.com ([134.134.136.31])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n1v3w-00HKMu-48
 for linux-nvme@lists.infradead.org; Mon, 27 Dec 2021 18:49:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1640630976; x=1672166976;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=wqi9+sKwm2vC++423JmaqCHB1wNc1hYUmf0h4FyVQ1I=;
 b=FDEqBSwtCIIJQUkdrhwGATiaREojxt6Ad7NL9ccMnFtjyy2CD9kx8vI6
 CrzZjTdAJY+vTIZxNa5G9zK4m8eNRqMPldk4q452BJOLHF5iO+6orU9g/
 Jg/7tf4xo/6dJoiYHRs90CMInN9uB4kXsLT1eJrnCRlazL9B8LxrNjUKC
 6KHg1/CcHTTcuj7pbQvmQNooYoTSY4LI8+9IPxNIrOpKgs/n90NvNB8YR
 WkvtOKAzbuQTbW8zGMtnXUCwESxYAgCLdFNob1D3IGRZ6N2QA0lNirtFo
 LQA7E1mpz2vRCVhVAGmskU2BIDf7y52tgmeX6OaW62+rqWHcMXFFm9Q9E Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10210"; a="302012392"
X-IronPort-AV: E=Sophos;i="5.88,240,1635231600"; d="scan'208";a="302012392"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Dec 2021 10:49:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,240,1635231600"; d="scan'208";a="509940859"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
 by orsmga007.jf.intel.com with ESMTP; 27 Dec 2021 10:49:33 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1n1v3s-0006hk-O3; Mon, 27 Dec 2021 18:49:32 +0000
Date: Tue, 28 Dec 2021 02:49:10 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, axboe@kernel.dk
Cc: kbuild-all@lists.01.org, hch@lst.de, sagi@grimberg.me,
 Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 2/3] block: introduce rq_list_move
Message-ID: <202112280210.F89j103t-lkp@intel.com>
References: <20211227164138.2488066-2-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211227164138.2488066-2-kbusch@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211227_104936_262665_C4F495CA 
X-CRM114-Status: GOOD (  14.79  )
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

Hi Keith,

I love your patch! Perhaps something to improve:

[auto build test WARNING on axboe-block/for-next]
[also build test WARNING on linux-review/Xie-Yongji/nbd-Don-t-use-workqueue-to-handle-recv-work/20211227-171406 linus/master v5.16-rc7 next-20211224]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Keith-Busch/block-introduce-rq_list_for_each_safe-macro/20211228-004304
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20211228/202112280210.F89j103t-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/81098ed2c64adf477eae9c21a4188916e0ef5918
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Keith-Busch/block-introduce-rq_list_for_each_safe-macro/20211228-004304
        git checkout 81098ed2c64adf477eae9c21a4188916e0ef5918
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from arch/um/drivers/ubd_kern.c:27:
>> include/linux/blk-mq.h:227:1: warning: 'inline' is not at beginning of declaration [-Wold-style-declaration]
     227 | static void inline rq_list_move(struct request **src, struct request **dst,
         | ^~~~~~
--
   In file included from include/linux/blktrace_api.h:5,
                    from block/bfq-iosched.h:9,
                    from block/bfq-cgroup.c:16:
>> include/linux/blk-mq.h:227:1: warning: 'inline' is not at beginning of declaration [-Wold-style-declaration]
     227 | static void inline rq_list_move(struct request **src, struct request **dst,
         | ^~~~~~
   block/bfq-cgroup.c:1437:6: warning: no previous prototype for 'bfqg_and_blkg_get' [-Wmissing-prototypes]
    1437 | void bfqg_and_blkg_get(struct bfq_group *bfqg) {}
         |      ^~~~~~~~~~~~~~~~~


vim +/inline +227 include/linux/blk-mq.h

   215	
   216	#define rq_dma_dir(rq) \
   217		(op_is_write(req_op(rq)) ? DMA_TO_DEVICE : DMA_FROM_DEVICE)
   218	
   219	/**
   220	 * rq_list_move() - move a struct request from one list to another
   221	 * @src: The source list @rq is currently in
   222	 * @dst: The destination list that @rq will be appended to
   223	 * @rq: The request to move
   224	 * @prv: The request preceding @rq in @src (NULL if @rq is the head)
   225	 * @nxt: The request following @rq in @src (NULL if @rq is the tail)
   226	 */
 > 227	static void inline rq_list_move(struct request **src, struct request **dst,
   228					struct request *rq, struct request *prv,
   229					struct request *nxt)
   230	{
   231		if (prv)
   232			prv->rq_next = nxt;
   233		else
   234			*src = nxt;
   235		rq_list_add(dst, rq);
   236	}
   237	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

