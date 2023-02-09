Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A39BFC636D6
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Feb 2023 16:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zQP0yX8Vzczb8XUGk6DgmBco9IufoIdCfdrdgghEZpM=; b=r4BkW9aLdY0r2rMGKp96nCtBF+
	jd7Mu6K4Pc+yu3y7gbbYOgtR21YTZlnRTaSv6pILQp4fYiFWQYlg1eh9LW3TP4ibEVQpYUacM7xHe
	8X4YgKRnMgRl5oHbUktdQRZ7sRzZB+DNAkaqrnJWW0bGf0zDdn67hNFeLky1V2ZsXZCk0cLF9lxFz
	JAq4a0poDxm0nIdt6p7mvrktimoIz681qJ6WDIuGznmQuk5VZ+yYA1QhjtNulPTBNOUfM0/OdvCdZ
	y1e0nAUXPYenTwYb6gsVTIsk8onAaQM6IzRLBifpplDm+DN94gBie0XwguASQFzB7o0iPN3a/o8de
	sxisXi9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQ9hK-002P0Z-FA; Thu, 09 Feb 2023 16:22:58 +0000
Received: from mga09.intel.com ([134.134.136.24])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQ9hH-002Ozv-H3
	for linux-nvme@lists.infradead.org; Thu, 09 Feb 2023 16:22:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675959775; x=1707495775;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hb8iCDJ0aTsCVjjHlP2Amw1KTUPvms2VDEUedaLEWbc=;
  b=hcuu1gztc7ZQohlymPI6oQe39XoJY3ly6F4pWCk3g20HNs6QCdr2IO9f
   hVk9tyGqYcnHsKFqmQ/xMOrr693Ih+HU0bWNG6SjOjG8k6Zc5W3Ar/IHz
   MnK3KJz9Sn7D9G4N/WUz034J6sWqfLVTq77XI7xM0+B+MWR38ZjtQ9ZTd
   Y/1HH2B8AxFPJjl7HYFsIQOYwr3776rPH2cCa9Uat8ToowwKcyRu1Wfwm
   88/1QCdaC+TLBzoXdCbvPniLE+hSfQGwEEUFJF0DeBvaMfUqEmXD5WYMp
   RAZyH6Xq1nr+7aPICYkz8orgC8c28ac7wWIkeSJkkVXJzJwMCnxJQ3m/H
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="331453826"
X-IronPort-AV: E=Sophos;i="5.97,284,1669104000"; 
   d="scan'208";a="331453826"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 08:22:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="731374997"
X-IronPort-AV: E=Sophos;i="5.97,284,1669104000"; 
   d="scan'208";a="731374997"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 09 Feb 2023 08:22:49 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1pQ9hA-0005Ag-0y;
	Thu, 09 Feb 2023 16:22:48 +0000
Date: Fri, 10 Feb 2023 00:22:31 +0800
From: kernel test robot <lkp@intel.com>
To: Kanchan Joshi <joshi.k@samsung.com>, shinichiro.kawasaki@wdc.com
Cc: oe-kbuild-all@lists.linux.dev, hch@lst.de,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH blktests] nvme/046: add test for unprivileged passthrough
Message-ID: <202302100053.tumPI2Xy-lkp@intel.com>
References: <20230209094541.248729-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209094541.248729-1-joshi.k@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230209_082255_681763_28D81B5A 
X-CRM114-Status: UNSURE (   9.94  )
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

Hi Kanchan,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on hch-configfs/for-next]
[also build test WARNING on linus/master v6.2-rc7 next-20230209]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kanchan-Joshi/nvme-046-add-test-for-unprivileged-passthrough/20230209-174831
base:   git://git.infradead.org/users/hch/configfs.git for-next
patch link:    https://lore.kernel.org/r/20230209094541.248729-1-joshi.k%40samsung.com
patch subject: [PATCH blktests] nvme/046: add test for unprivileged passthrough
reproduce:
        scripts/spdxcheck.py

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302100053.tumPI2Xy-lkp@intel.com/

spdxcheck warnings: (new ones prefixed by >>)
   drivers/cpufreq/amd-pstate-ut.c: 1:28 Invalid License ID: GPL-1.0-or-later
>> tests/nvme/046: 2:27 Invalid License ID: GPL-3.0+

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

