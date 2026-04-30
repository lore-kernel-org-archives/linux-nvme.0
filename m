Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8566FF886F
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Apr 2026 05:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EVw8iEoefowBoKQr3q1dGIvBxCc4EHuQlaNI4aNCfeY=; b=Ky2oIuEZJzcvI01IOxB9KHOTYm
	xu/V6ZyUmEe0Y0sJ6jF57dqVJgKHRxHXUf+61r0UdM3bcMSRZh3NY876u3GXT13tphwHUMzvZspNA
	CgJiINZNlJI3ZQ6WxpE4x4/ttqdjVIMjkyfYbNXSIEHUhjo7VTGF06vaTJjnBGKS07jEjlMKPQQWv
	4VGtbaS+aF0VgQXu4sgYpXHvLWoIB9oTrHaOKoAzOAuRq2d09/RaARyIXVGKtpkoRmgKtYVU/i8A5
	Ao1QrC4ktJus/HwuMutOCrtLa81jc0ui79ttb28J6nHfmt0zwP+fOWnIytKV8kMnR32imyQ9/+dQh
	EHJCF7sg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIJnK-00000004hx9-3Qaj;
	Thu, 30 Apr 2026 05:18:38 +0000
Received: from mgamail.intel.com ([198.175.65.19])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIJnI-00000004hwi-0gcv
	for linux-nvme@lists.infradead.org;
	Thu, 30 Apr 2026 05:18:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777526316; x=1809062316;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=4Iz1M7RoZHSTbh/ia2c9GjyjBo8DZlwGbCeY7ixg/sU=;
  b=Mj6ITWXZtsePpIL4ajXgPYgmFsBRh3W31FAyO1Iu2bq5S3WKCX2sNNOk
   WTcyV5XJ7HxR0cnvKtwFk/wrEATnRs1Y7E45pkqauDYNbqDrxFREvtrJ3
   asv980oxAOQILX7vz91oAL4bTWOZOHth+e751dSyxQePCHSTTcBeQdr3f
   treZ7cTo7EBapBH8wYKakDbWiX+JFxFnByARAl6HUYDBuhtwbE28hMT4k
   C6YaD7uz0x2ph2MZwCBGiWsJqS/VcXC4fGWzeq/SacupD05u7Divvweta
   XimKaqPiH9P/OErdOtCcNcESeGRLq0JDg0OB90xIFMNKnOnxqwdMqHuus
   g==;
X-CSE-ConnectionGUID: sRyrhNTSTHeWlhjULB0nWQ==
X-CSE-MsgGUID: VzKqrLhISMOZZVywLRTe2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78387360"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="78387360"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 22:18:35 -0700
X-CSE-ConnectionGUID: JlgVLdZaRUiQdb7pneuthg==
X-CSE-MsgGUID: LgXNk1BXT4myYCXXI+vvSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="239461002"
Received: from igk-lkp-server01.igk.intel.com (HELO bdf09bfdbd5f) ([10.211.93.152])
  by fmviesa005.fm.intel.com with ESMTP; 29 Apr 2026 22:18:32 -0700
Received: from kbuild by bdf09bfdbd5f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wIJnC-000000004kv-234Q;
	Thu, 30 Apr 2026 05:18:30 +0000
Date: Thu, 30 Apr 2026 07:18:28 +0200
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
Message-ID: <202604300750.YpUGtmek-lkp@intel.com>
References: <20260416010713epcms2p78575bd400f93f6edb7fe3f3ead5bf930@epcms2p7>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260416010713epcms2p78575bd400f93f6edb7fe3f3ead5bf930@epcms2p7>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260429_221836_275213_7353263B 
X-CRM114-Status: GOOD (  13.09  )
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
[also build test WARNING on linux-nvme/for-next linus/master v7.1-rc1]
[cannot apply to next-20260429]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/nvme-Skip-trace-complete_rq-on-host-path-error/20260416-180151
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git for-next
patch link:    https://lore.kernel.org/r/20260416010713epcms2p78575bd400f93f6edb7fe3f3ead5bf930%40epcms2p7
patch subject: [PATCH v6] nvme: Skip trace complete_rq on host path error
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20260430/202604300750.YpUGtmek-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260430/202604300750.YpUGtmek-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604300750.YpUGtmek-lkp@intel.com/

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

