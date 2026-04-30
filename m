Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85343FF8875
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Apr 2026 04:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uUqDcer1B04x07OIUa27AijFEnzDCUYtkpP41N9T8I4=; b=qxmeRkfri/8W6cAbhnSYNKjhAU
	6Et8R6tDCmsISHjuK/q9uETeOG5Wc9kBNxLSmIS5sHF7VcurDIv761GK1fxImTCAwcT3QIpWm5cdu
	+5yNgk6cTq4onFrhTBm0bPUSgzuhMuBGJCHAXlGam5aCfCZylLn+7G2vW9yt3H8q+dK5e+IraSrLM
	C1szIrR5YZl/cNdE+AgH6bUVbiQbY3gQoToSERoYhGJq1znIyp74eMTNR/gKyEnaOsuzbFTXLLjpn
	6OzJocKI/WpHyZ6OyX1dx1xJT60NrjhxdCWYyg5ulUF9V8eIHjJGtbi4gjkDmJ+YC5QkrARcmKlHa
	EEk75Npw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIJ9f-00000004fPa-2vMq;
	Thu, 30 Apr 2026 04:37:39 +0000
Received: from mgamail.intel.com ([198.175.65.16])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIJ9c-00000004fPE-3hMq
	for linux-nvme@lists.infradead.org;
	Thu, 30 Apr 2026 04:37:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777523857; x=1809059857;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=7Ff6KXqii3nlF79VBg109uLkToNFhNehEDljOeDkC2w=;
  b=F6gQc9l2Iz4kTsCntpCkFQ6cm/iWa4qXUiHIiO9S19kmcxgNKzA4ddlZ
   vwBapuW6gfJbidU0xuJ3+uHL9E7ULt0ExE2OxUntbB0dliW9YePr0Y6Nr
   /iYRwh92sjuR7Nns2OX/AwsHl75frUhL7GV93w2A2ZkopZNIm/NYVG6sH
   e/gfSSeZZfaF3xxmd4ENKPjufWwYFRvxGY8E8W4curkKZKqnGYr1PkPyh
   K/qem5qujTzRl2oDU669pcoQaGOgDnK+Of58HSQJYXyfsfcQX2DraMk1i
   1aqh2U1Rgqm+79avtkdC+cVlN3IKOBURv5EcbBdHkdZGvESLWZFDWHD5y
   w==;
X-CSE-ConnectionGUID: 2D0Ulh5tQZq55ETb2m7beA==
X-CSE-MsgGUID: 6dd0AiN2SnSYrSpRhRxuLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78654391"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="78654391"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 21:37:35 -0700
X-CSE-ConnectionGUID: iBzBWf0RRDiRHa+HppVMGw==
X-CSE-MsgGUID: 8bKNr/5kR+uP5Wse+UarBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="236238135"
Received: from igk-lkp-server01.igk.intel.com (HELO bdf09bfdbd5f) ([10.211.93.152])
  by fmviesa004.fm.intel.com with ESMTP; 29 Apr 2026 21:37:32 -0700
Received: from kbuild by bdf09bfdbd5f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wIJ9V-000000004kD-3ad5;
	Thu, 30 Apr 2026 04:37:29 +0000
Date: Thu, 30 Apr 2026 06:37:18 +0200
From: kernel test robot <lkp@intel.com>
To: =?utf-8?B?7KCE66+87Iud?= <hmi.jeon@samsung.com>,
	"kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?7KCE66+87Iud?= <hmi.jeon@samsung.com>,
	=?utf-8?B?7J207J2A7IiY?= <euns212.lee@samsung.com>,
	=?utf-8?B?7Lm47LCs?= <joshi.k@samsung.com>
Subject: Re: [PATCH v6] nvme: Skip trace complete_rq on host path error
Message-ID: <202604300644.6qVuhQQC-lkp@intel.com>
References: <20260416010713epcms2p78575bd400f93f6edb7fe3f3ead5bf930@epcms2p7>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260416010713epcms2p78575bd400f93f6edb7fe3f3ead5bf930@epcms2p7>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260429_213737_012485_697EC52D 
X-CRM114-Status: GOOD (  14.10  )
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
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260430/202604300644.6qVuhQQC-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260430/202604300644.6qVuhQQC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604300644.6qVuhQQC-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/nvme/host/core.c:457:6: warning: no previous prototype for function '__nvme_complete_rq' [-Wmissing-prototypes]
     457 | void __nvme_complete_rq(struct request *req)
         |      ^
   drivers/nvme/host/core.c:457:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     457 | void __nvme_complete_rq(struct request *req)
         | ^
         | static 
   1 warning generated.


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

