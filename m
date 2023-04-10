Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D20E8C77B61
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Apr 2023 21:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2R3aZfbxemWlOT8F2Y+IUuyvIwKz3ANVSxsEPbAk+to=; b=wVH07KwuMLoRQjoHlXHapE1IAB
	gJMEZRclirlfa5188XK1mwXsbV8LKmtot7CyH/JJ5+nHW3ukkJMX/PdKs+6W3VgRDPik9y04kzZQI
	7I5p4vaennxrG/SVJU4M8jZgZiFtDBsd7tGA/qdE0iEAuovuvJ7FERgZN6h1a3oop88ZwIrwehPGg
	X3XijwGYs+d2zLJevoDBZ9RE9VUIj717EGlohLpXSq/vW+WLj2sAsvdK3DIK2kZy1OXdXDvY+L6/9
	KuCxv03nQV6C1z1Wc1lFmO0I1X7KnbAjC3RawtgUFDqxBmzB3hLDDmkdsXZKT/ObieI3IXTYBbqq0
	bAEdOPvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1plyf2-00FvlX-11;
	Mon, 10 Apr 2023 21:02:48 +0000
Received: from mga09.intel.com ([134.134.136.24])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1plyez-00Fvka-1V
	for linux-nvme@lists.infradead.org;
	Mon, 10 Apr 2023 21:02:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681160565; x=1712696565;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/iFIhWoDac+UT40gLNkBeOwuDo3E6+5ZVwgNZZpo0ak=;
  b=MucQqzsZYqFCsBtqoRGPNEzzFQVhLvd9JRXnWiySUN6RQlQRW16gboUE
   xKw3TVfPC433GIY2pWUV7fdTmsmT46KE/scbngN4IX2wKURp2HsijmNQX
   f8aO8UEndyviD4wzkPFES8NiwtLe4V2j2Z6cmwa99TPwBpLdjYkOoM6Dc
   zDI0DcrcZCd9mxGtUPe2kElhXMqNnVQsEE2NJNekZNnK8R6dBi/YtgdWy
   gwgcE6IDKsjIpeECMQFJKXulTCPrt4IAru5ZqUKCny4mjOD/nFnP7mPbJ
   F9DZVDT0Q7FrCdnI3rOWE+XqlxzBw6rY8w3wBinfvv5fo3AxG+kK75n3E
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="345240687"
X-IronPort-AV: E=Sophos;i="5.98,333,1673942400"; 
   d="scan'208";a="345240687"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 14:02:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="832096656"
X-IronPort-AV: E=Sophos;i="5.98,333,1673942400"; 
   d="scan'208";a="832096656"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 10 Apr 2023 14:02:39 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1plyes-000VfZ-2X;
	Mon, 10 Apr 2023 21:02:38 +0000
Date: Tue, 11 Apr 2023 05:02:22 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, io-uring@vger.kernel.org,
	axboe@kernel.dk, hch@lst.de
Cc: oe-kbuild-all@lists.linux.dev, sagi@grimberg.me, joshi.k@samsung.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 2/5] nvme: simplify passthrough bio cleanup
Message-ID: <202304110443.e026C3nq-lkp@intel.com>
References: <20230407191636.2631046-3-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230407191636.2631046-3-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230410_140245_574216_79E04442 
X-CRM114-Status: GOOD (  13.21  )
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on axboe-block/for-next]
[also build test WARNING on next-20230406]
[cannot apply to linus/master v6.3-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Keith-Busch/block-add-request-polling-helper/20230408-031926
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20230407191636.2631046-3-kbusch%40meta.com
patch subject: [PATCHv2 2/5] nvme: simplify passthrough bio cleanup
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20230411/202304110443.e026C3nq-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/9a32e7ca02dd8cff559b273fe161b5347b5b5c97
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Keith-Busch/block-add-request-polling-helper/20230408-031926
        git checkout 9a32e7ca02dd8cff559b273fe161b5347b5b5c97
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/nvme/host/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304110443.e026C3nq-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/nvme/host/ioctl.c: In function 'nvme_submit_user_cmd':
   drivers/nvme/host/ioctl.c:232:21: warning: variable 'bio' set but not used [-Wunused-but-set-variable]
     232 |         struct bio *bio;
         |                     ^~~
   drivers/nvme/host/ioctl.c: In function 'nvme_uring_cmd_end_io_meta':
>> drivers/nvme/host/ioctl.c:528:36: warning: unused variable 'pdu' [-Wunused-variable]
     528 |         struct nvme_uring_cmd_pdu *pdu = nvme_uring_cmd_pdu(ioucmd);
         |                                    ^~~


vim +/pdu +528 drivers/nvme/host/ioctl.c

c0a7ba77e81b84 Jens Axboe    2022-09-21  523  
c0a7ba77e81b84 Jens Axboe    2022-09-21  524  static enum rq_end_io_ret nvme_uring_cmd_end_io_meta(struct request *req,
c0a7ba77e81b84 Jens Axboe    2022-09-21  525  						     blk_status_t err)
c0a7ba77e81b84 Jens Axboe    2022-09-21  526  {
c0a7ba77e81b84 Jens Axboe    2022-09-21  527  	struct io_uring_cmd *ioucmd = req->end_io_data;
c0a7ba77e81b84 Jens Axboe    2022-09-21 @528  	struct nvme_uring_cmd_pdu *pdu = nvme_uring_cmd_pdu(ioucmd);
c0a7ba77e81b84 Jens Axboe    2022-09-21  529  	void *cookie = READ_ONCE(ioucmd->cookie);
c0a7ba77e81b84 Jens Axboe    2022-09-21  530  
c0a7ba77e81b84 Jens Axboe    2022-09-21  531  	/*
c0a7ba77e81b84 Jens Axboe    2022-09-21  532  	 * For iopoll, complete it directly.
c0a7ba77e81b84 Jens Axboe    2022-09-21  533  	 * Otherwise, move the completion to task work.
c0a7ba77e81b84 Jens Axboe    2022-09-21  534  	 */
c0a7ba77e81b84 Jens Axboe    2022-09-21  535  	if (cookie != NULL && blk_rq_is_poll(req))
9d2789ac9d60c0 Jens Axboe    2023-03-20  536  		nvme_uring_task_meta_cb(ioucmd, IO_URING_F_UNLOCKED);
c0a7ba77e81b84 Jens Axboe    2022-09-21  537  	else
c0a7ba77e81b84 Jens Axboe    2022-09-21  538  		io_uring_cmd_complete_in_task(ioucmd, nvme_uring_task_meta_cb);
c0a7ba77e81b84 Jens Axboe    2022-09-21  539  
de671d6116b521 Jens Axboe    2022-09-21  540  	return RQ_END_IO_NONE;
456cba386e94f2 Kanchan Joshi 2022-05-11  541  }
456cba386e94f2 Kanchan Joshi 2022-05-11  542  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

