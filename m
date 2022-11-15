Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B64EC4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Nov 2022 00:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MM+yCgJeZB9YXU4NAyuOyfhIaZv3odMCG8J40mGiGpY=; b=R3rel/yZLMpXX9rzbwzUVe/dqN
	e4MGsYO0hxcfdjItdKlQvRQ6AirrTLwNEXyvHGiI3DZ0BCrsgO6jzEimSRGBwftvsU6YrS6meP8ya
	smJKFTjklohSp8p4XZavavbQfmrq8FRJI2h0eAakd2q3n+cpPCC7XYke9Vb4xv1Mf/P0u9W+HT9Kk
	2NQhURluO5qV5L+yQUop3oa+S0nYg1T/U7ppXjootq1AjMh8b0pBWtQfT5u6HZAEJHcNZA1+bblfy
	RpLXcZnP2A9U7AJj38qSSrxT0dwcugseHzVEaVLJEgHzCFgJZElKDFIxeIEXsnLlWqSbDR1gTLsB+
	4uzqQGlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oujtj-006BzK-21; Tue, 15 Nov 2022 00:33:55 +0000
Received: from mga07.intel.com ([134.134.136.100])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oujtg-006ByH-PF
	for linux-nvme@lists.infradead.org; Tue, 15 Nov 2022 00:33:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668472432; x=1700008432;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2SXILu42ZF80KNGoxelf/WosLvSlJNbz2CfkArbmfUs=;
  b=ke2YtYf1vbKuatQlEswWvdB3+m496PS7VbLYpSpW1mlr/qBiE3ThaxcZ
   570sH53GJS5og4xvW63BHmXTa/Fl+thaCOLoeIfqBSNHJhtzr7bHhILV1
   yQsBiMLnkXUN0WXdJL2tbzX8S4nFFqOO3OKZ9Ly+kgnGk5uwdWo1G5jIa
   6BGl0LFGdjZhOoaHeadSzBnP7LaQ61OsrbdZX/KrFHvXZnvgeqtvUBECw
   p/Q9qJzvUhCzfgLv7DA3O84uXiG5XyciZoPf8jU/OL2xQXcGm3sGNCIzc
   jNx0mdPqyVUELkugSxs+LRkkSdsMR1R1ELigu34vbKActHYT5elAPFMab
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="376387433"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="376387433"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 16:33:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="781139055"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="781139055"
Received: from lkp-server01.sh.intel.com (HELO ebd99836cbe0) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 14 Nov 2022 16:33:49 -0800
Received: from kbuild by ebd99836cbe0 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1oujtc-0000s5-1S;
	Tue, 15 Nov 2022 00:33:48 +0000
Date: Tue, 15 Nov 2022 08:33:28 +0800
From: kernel test robot <lkp@intel.com>
To: Jonathan Derrick <jonathan.derrick@linux.dev>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: oe-kbuild-all@lists.linux.dev, Keith Busch <kbusch@kernel.org>,
	Omar Sandoval <osandov@osandov.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>
Subject: Re: [PATCH] tests/nvme: Add admin-passthru+reset race test
Message-ID: <202211150846.9Fnwxsg4-lkp@intel.com>
References: <20221114203412.383-1-jonathan.derrick@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114203412.383-1-jonathan.derrick@linux.dev>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221114_163352_918024_F1E15074 
X-CRM114-Status: GOOD (  10.02  )
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

Hi Jonathan,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.1-rc5 next-20221114]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jonathan-Derrick/tests-nvme-Add-admin-passthru-reset-race-test/20221115-043752
patch link:    https://lore.kernel.org/r/20221114203412.383-1-jonathan.derrick%40linux.dev
patch subject: [PATCH] tests/nvme: Add admin-passthru+reset race test
reproduce:
        scripts/spdxcheck.py

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

spdxcheck warnings: (new ones prefixed by >>)
   drivers/cpufreq/amd-pstate-ut.c: 1:28 Invalid License ID: GPL-1.0-or-later
>> tests/nvme/046: 2:27 Invalid License ID: GPL-3.0+

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

