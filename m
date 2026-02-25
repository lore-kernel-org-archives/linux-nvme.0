Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3112FD45F1
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Feb 2026 21:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rQxW9oGERxWcnChQb7DgHSFrE1RdpwQnnIERZA2TQao=; b=g3wb/kJFo0chrYxMkUhlYjNNNZ
	E5h4GTPc77T2B6SLzASf5VMaya5Du2BJYMAqSY3ehWOdWvmPc+brK9NPEZo+PmsK16qKcd3PWRXUl
	xoCHgHB3gTW2OuMm4AewRVKpYw5zX5F/hveNL58gwPhL+dUNQF8inWrAK/DiYjBYn7rEm8XcR/f7b
	1iDiUJMVn1Bs2xbKHZwERbKQGFeaKvAy6JZh4ZTdl04YvU2MtHhFRaT2CSEQzHSicTrbeFUp+jtVC
	WecDxQL53R5FY+EztwQgmUmoyQFVP1DRB3an6a19DY+zIMbdi/d0gwDd4How0YYBuRzXjFjA2Zk6u
	rxp62eyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvMaO-00000004vgV-48Zn;
	Wed, 25 Feb 2026 21:38:24 +0000
Received: from mgamail.intel.com ([192.198.163.17])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvMaL-00000004vfk-2UDv
	for linux-nvme@lists.infradead.org;
	Wed, 25 Feb 2026 21:38:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772055501; x=1803591501;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Wk4UoQl72s+9QTyqX2dBCxC919tJAENrmFZzVWmpIdo=;
  b=b/MUID0ANabqukN/3CNRL5jTXjw6UDAo6dFH21kV8EQj2iJRILcihIrt
   4uKSfOZqztZ2IVYNe4TX4Ve9RbPTyh1W7Ntvvx/ZSIWrr2y14JaIVFMXU
   /E9wnIiBHFH5rMiFFhIwqGjn1vUSSyuZ59JIb1CK3Bp1PwD5BI1NawudH
   UaVxxZ2ODa/NW7YHjII6LW1Dk4BXPbzEiXXWq/+/WPN0yfvdfAlj1tIu1
   I3FZbRaprT5Z3krC+2j+viJe636MCI9s62urEgKHFDY+UB7KdWnlxTkQY
   q4dVE+TX1ki1iYrsdRypI4wEUbOpByNrBq8AnxDP8hPEabjc6JYLO14ak
   w==;
X-CSE-ConnectionGUID: U4nivN9dTAGQ1Fa44yeU/g==
X-CSE-MsgGUID: t3lUbG9yQGS4yNJi/ifNuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="73016688"
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; 
   d="scan'208";a="73016688"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 13:38:20 -0800
X-CSE-ConnectionGUID: KFgPQ3ZMTa+oDBHD7CnioA==
X-CSE-MsgGUID: eykxMU/JSo+bRXLMIY+0xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; 
   d="scan'208";a="244052943"
Received: from lkp-server02.sh.intel.com (HELO a3936d6a266d) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 25 Feb 2026 13:38:17 -0800
Received: from kbuild by a3936d6a266d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vvMZq-000000007Qn-2ucw;
	Wed, 25 Feb 2026 21:37:54 +0000
Date: Thu, 26 Feb 2026 05:37:12 +0800
From: kernel test robot <lkp@intel.com>
To: Maurizio Lombardi <mlombard@redhat.com>, kbusch@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, hch@lst.de, hare@suse.de,
	chaitanyak@nvidia.com, bvanassche@acm.org,
	linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
	James.Bottomley@hansenpartnership.com, mlombard@arkamax.eu,
	jmeneghi@redhat.com, emilne@redhat.com, bgurney@redhat.com
Subject: Re: [PATCH V3 2/3] nvme-core: register namespaces in order during
 async scan
Message-ID: <202602260543.EHcJPG8y-lkp@intel.com>
References: <20260225161203.76168-3-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225161203.76168-3-mlombard@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260225_133821_650295_F2A47197 
X-CRM114-Status: GOOD (  11.74  )
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

Hi Maurizio,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jejb-scsi/for-next]
[also build test WARNING on mkp-scsi/for-next linus/master v7.0-rc1 next-20260225]
[cannot apply to linux-nvme/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Maurizio-Lombardi/lib-Introduce-completion-chain-helper/20260226-001842
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git for-next
patch link:    https://lore.kernel.org/r/20260225161203.76168-3-mlombard%40redhat.com
patch subject: [PATCH V3 2/3] nvme-core: register namespaces in order during async scan
config: x86_64-randconfig-161-20260226 (https://download.01.org/0day-ci/archive/20260226/202602260543.EHcJPG8y-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
smatch version: v0.5.0-8994-gd50c5a4c
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260226/202602260543.EHcJPG8y-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602260543.EHcJPG8y-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/nvme/host/core.c:4117 struct member 'chain_entry' not described in 'async_scan_task'
>> Warning: drivers/nvme/host/core.c:4117 struct member 'chain_entry' not described in 'async_scan_task'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

