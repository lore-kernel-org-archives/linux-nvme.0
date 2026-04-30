Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 055E2FF8875
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Apr 2026 04:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qCuq/oA+R1e+4Gb5FSPFkBk57AtU1SuaSBCq9booXjA=; b=5GrZLdWTaHj+I4OUGlOfE84Kmv
	JhLYzf5/iPJjLPu3ZgZ8AQCVq4h0xf4TZSR78kZ09H6uWhS5ukQorfuaJ6gSnAzWD2ggdHnBTOuSR
	QmNs9PqoF5zp7zjq6R0h/uYP58Fsnw02GdT9pVqSTw0acE/G/pIGw/JZQK67X2DItAmk+8Wt3oD38
	WS3Sdv03LhzTycicWypKZmUb7GNBV/azkmg2rKqa0iAZ+2MkBo/pb91cKdDvQahfueDVB4azY7S89
	PoHDG8ZyQ5XPkoxX3PRVME1T6sVIsbih6iWSXesGb9/Yyn7Osp3OZ/0O8gM5pzXsnhUi9UiOUFCTT
	otH8ahyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIJSg-00000004gWE-0vWX;
	Thu, 30 Apr 2026 04:57:18 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIJSd-00000004gVX-478p
	for linux-nvme@bombadil.infradead.org;
	Thu, 30 Apr 2026 04:57:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=qCuq/oA+R1e+4Gb5FSPFkBk57AtU1SuaSBCq9booXjA=; b=ah+viibpgLtqxQI6AVxT0ecWUa
	7hXxgIz1PlMJXpjtGoIiwKnQNjmsF9Fjw7kq+0poZH/I8jwBnIzGewiYbHZA57PtlakktR/fjfRlE
	Bnl5AlXozEzdOQ7Y67kfhmRhFF8uuOyTosjRNJb/C8dnrWtWjTwx09YbV0GQ4auECwWdcl7OYWxVI
	d6IWXY1d6oSBSObWeaAc5QWnQ+beGp3nm09BT7xkUfNzmnRSZwQDBi23NuDuXywAkBaXfNNdaUaW1
	GwtTMBF28yBzKmGA/L64yWaiMifLjO32uZXdzrn2vopbPZmhPKdzfxpwVz/XRVhVEzub/LffspRnC
	ygGBXUMw==;
Received: from mgamail.intel.com ([198.175.65.11])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIJSD-00000006dhI-2tKl
	for linux-nvme@lists.infradead.org;
	Thu, 30 Apr 2026 04:57:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777525010; x=1809061010;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Wez0hevobkt6W2t6RiznoOv0vhul7I9agw+z4dZSKMQ=;
  b=d5VDVhalJS48WJmNMhBCYvO2Yg2y+X/HNaxwUYXa7a2z9XNyO2vvWRef
   knIl7JPoXL9eLE7ufqjE5/SwMG+0JqEzxachNzcK6Zo6mRZnbwmOfhF2T
   j1poM8SEosyB1QJolfEYFI5tBGAaes/RESyqWMIXwiebrBttdg4YYAwDp
   RcviMuVbl7T+gYG+DTPnPFf2g2VBfEyydq0JsSbERrDxzzLcy4s/zlWOj
   PKbxNkYisxGT36GG8jeuwWPllo2LgkSjzfYnM0r6wZajO/9CBgIXpR/NF
   /+d4d1cpFeZx/2udT8HnY+s6xKjh7x9cW2KYQRYQoqjzughnfye68NKFs
   g==;
X-CSE-ConnectionGUID: ML9PKkKKQzmKs+xzbpVS5Q==
X-CSE-MsgGUID: VsTMrx1STwOBtmCrC9FqAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="88778441"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="88778441"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 21:56:46 -0700
X-CSE-ConnectionGUID: ciK/l3zkTKG3EjRZ+PcYVw==
X-CSE-MsgGUID: W0CQZRxURKyQDVN35x4RdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="238446318"
Received: from lkp-server01.sh.intel.com (HELO aa799cca880d) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 29 Apr 2026 21:56:43 -0700
Received: from kbuild by aa799cca880d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wIJS4-00000000Bxk-0jLb;
	Thu, 30 Apr 2026 04:56:40 +0000
Date: Thu, 30 Apr 2026 12:56:37 +0800
From: kernel test robot <lkp@intel.com>
To: =?utf-8?B?7KCE66+87Iud?= <hmi.jeon@samsung.com>,
	"kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>
Cc: oe-kbuild-all@lists.linux.dev, "axboe@kernel.dk" <axboe@kernel.dk>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?7KCE66+87Iud?= <hmi.jeon@samsung.com>,
	=?utf-8?B?7J207J2A7IiY?= <euns212.lee@samsung.com>,
	=?utf-8?B?7Lm47LCs?= <joshi.k@samsung.com>
Subject: Re: [PATCH v6] nvme: Skip trace complete_rq on host path error
Message-ID: <202604301237.jC9FNHxS-lkp@intel.com>
References: <20260416010713epcms2p78575bd400f93f6edb7fe3f3ead5bf930@epcms2p7>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260416010713epcms2p78575bd400f93f6edb7fe3f3ead5bf930@epcms2p7>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260430_055704_120367_A4212EC1 
X-CRM114-Status: GOOD (  12.86  )
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

Hi 전민식,

kernel test robot noticed the following build warnings:

[auto build test WARNING on axboe/for-next]
[also build test WARNING on linux-nvme/for-next hch-configfs/for-next linus/master v7.1-rc1]
[cannot apply to next-20260429]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/nvme-Skip-trace-complete_rq-on-host-path-error/20260416-180151
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git for-next
patch link:    https://lore.kernel.org/r/20260416010713epcms2p78575bd400f93f6edb7fe3f3ead5bf930%40epcms2p7
patch subject: [PATCH v6] nvme: Skip trace complete_rq on host path error
config: sh-allyesconfig (https://download.01.org/0day-ci/archive/20260430/202604301237.jC9FNHxS-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260430/202604301237.jC9FNHxS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604301237.jC9FNHxS-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/nvme/host/core.c:457:6: warning: no previous prototype for '__nvme_complete_rq' [-Wmissing-prototypes]
     457 | void __nvme_complete_rq(struct request *req)
         |      ^~~~~~~~~~~~~~~~~~


vim +/__nvme_complete_rq +457 drivers/nvme/host/core.c

   456	
 > 457	void __nvme_complete_rq(struct request *req)
   458	{
   459		struct nvme_ctrl *ctrl = nvme_req(req)->ctrl;
   460	
   461		nvme_cleanup_cmd(req);
   462	
   463		/*
   464		 * Completions of long-running commands should not be able to
   465		 * defer sending of periodic keep alives, since the controller
   466		 * may have completed processing such commands a long time ago
   467		 * (arbitrarily close to command submission time).
   468		 * req->deadline - req->timeout is the command submission time
   469		 * in jiffies.
   470		 */
   471		if (ctrl->kas &&
   472		    req->deadline - req->timeout >= ctrl->ka_last_check_time)
   473			ctrl->comp_seen = true;
   474	
   475		switch (nvme_decide_disposition(req)) {
   476		case COMPLETE:
   477			nvme_end_req(req);
   478			return;
   479		case RETRY:
   480			nvme_retry_req(req);
   481			return;
   482		case FAILOVER:
   483			nvme_failover_req(req);
   484			return;
   485		case AUTHENTICATE:
   486	#ifdef CONFIG_NVME_HOST_AUTH
   487			queue_work(nvme_wq, &ctrl->dhchap_auth_work);
   488			nvme_retry_req(req);
   489	#else
   490			nvme_end_req(req);
   491	#endif
   492			return;
   493		}
   494	}
   495	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

