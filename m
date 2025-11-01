Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7214CCFA06
	for <linux-nvme@archiver.kernel.org>; Sat,  1 Nov 2025 15:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=4KONE/SdMD56mnbuo0x81tjr9/FMx72Gf/j8l7lD5OE=; b=rCdPLH4eSkJtz0hMx+rq8O9SeG
	gAWoX0efRfvyJXm2qsK6niYRDStnAyYiaJ0aTJHEMJGGu7O8GSHlCIpoqo6qCHgdl4/yrw9Gl50eK
	zZwl8Qx3BEKLdsEhpzJIng3bhPdbNLunAKPOroA0oN0v2I6riWCXYS4v+I9dcHDr1edWa5CO//SlV
	ogv3KpndUWay7xoRxklYpm19qEqm7Xed+C7MZORbmF0L/1kJo621tl02J9CvEnFhPoajpCM4Y2h4F
	Lg7PCVpsvljNZlaYdYuJgRjtx0u2WS41T5yHFQKqwV9QOIPxdLasXl1Hrs2KdHnMI/vgNaQkQq050
	1zOnZbbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFDFi-00000007rdl-31Yt;
	Sat, 01 Nov 2025 15:10:50 +0000
Received: from mgamail.intel.com ([198.175.65.17])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFDFV-00000007rdL-0HKc
	for linux-nvme@lists.infradead.org;
	Sat, 01 Nov 2025 15:10:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762009836; x=1793545836;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CWu3cLMCgnhrtUrm7dJjljispOKeKdA8uglJomjaNEE=;
  b=TyrzIxN+ILj6JHidLLG318dJE97Xq7FJCWg8FxSlWQef23Vx4ObXM42O
   OMd011+ErdPwmj5acbzo0gs5LFKdbeYbjRqlLPaAANiZwi1ZDoYfxqKTn
   edS4gMxIO90xuFCnCWU2bfdKRCJK6chAkjRMCfkv40w212ALJ3ix0CbPt
   DypkrkdRBVuVAlYu2Wm3qRc4m3Y7iN1XGJMoe7/Gbp0u0PDMK6NDWEEi/
   wvJ0lIZx0wJ4c3GKn5nS6WyB+Dy1iBE7c4eD5pGeJnwOOlZqj3Ggzpbhq
   sBcmA5jVnrZ+dKzine+kAFh2H9r77eZi+OatIlb/sZBHnlt2fgb2fKoB3
   Q==;
X-CSE-ConnectionGUID: eN2IOApRRLKN7DyeG2B3VA==
X-CSE-MsgGUID: Yqt9Ed81R06w0d04VvXptQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64076445"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64076445"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2025 08:10:34 -0700
X-CSE-ConnectionGUID: f6OkcyKrRBCAmTCuL+92sA==
X-CSE-MsgGUID: S+CYppWYT/a9/JHsPduThg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,272,1754982000"; 
   d="scan'208";a="191619610"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 01 Nov 2025 08:10:34 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vFDFE-000ONO-1U;
	Sat, 01 Nov 2025 15:10:24 +0000
Date: Sat, 1 Nov 2025 23:08:21 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
Subject: [linux-nvme:nvme-6.19 21/21] drivers/nvme/common/auth.c:158:13:
 error: redefinition of 'nvme_auth_extract_key'
Message-ID: <202511012300.eAcEQQP5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251101_081037_175162_ED276B20 
X-CRM114-Status: UNSURE (   9.24  )
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

tree:   git://git.infradead.org/nvme.git nvme-6.19
head:   453ba3089d4570c2be2e230e1e7a287eac4b306b
commit: 453ba3089d4570c2be2e230e1e7a287eac4b306b [21/21] nvme: fixup nvme auth host/target dependency
config: x86_64-allmodconfig (https://download.01.org/0day-ci/archive/20251101/202511012300.eAcEQQP5-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251101/202511012300.eAcEQQP5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511012300.eAcEQQP5-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/nvme/common/auth.c:158:13: error: redefinition of 'nvme_auth_extract_key'
     158 | struct key *nvme_auth_extract_key(struct key *keyring, const u8 *secret,
         |             ^
   include/linux/nvme-auth.h:25:27: note: previous definition is here
      25 | static inline struct key *nvme_auth_extract_key(struct key *keyring,
         |                           ^
   1 error generated.


vim +/nvme_auth_extract_key +158 drivers/nvme/common/auth.c

f50fff73d620cd6 Hannes Reinecke 2022-06-27  157  
e30cd923b3ed107 Hannes Reinecke 2025-05-28 @158  struct key *nvme_auth_extract_key(struct key *keyring, const u8 *secret,
592f87de2971040 Hannes Reinecke 2025-05-28  159  				  size_t secret_len, bool *generated)
3ebed3749f17679 Mark O'Donovan  2023-10-17  160  {
e30cd923b3ed107 Hannes Reinecke 2025-05-28  161  	struct key *key;
3ebed3749f17679 Mark O'Donovan  2023-10-17  162  
592f87de2971040 Hannes Reinecke 2025-05-28  163  	key = nvme_dhchap_psk_lookup(keyring, secret);
592f87de2971040 Hannes Reinecke 2025-05-28  164  	if (!IS_ERR(key)) {
592f87de2971040 Hannes Reinecke 2025-05-28  165  		*generated = false;
592f87de2971040 Hannes Reinecke 2025-05-28  166  		return key;
592f87de2971040 Hannes Reinecke 2025-05-28  167  	}
e30cd923b3ed107 Hannes Reinecke 2025-05-28  168  	key = nvme_dhchap_psk_refresh(keyring, secret, secret_len);
592f87de2971040 Hannes Reinecke 2025-05-28  169  	if (!IS_ERR(key)) {
592f87de2971040 Hannes Reinecke 2025-05-28  170  		*generated = true;
592f87de2971040 Hannes Reinecke 2025-05-28  171  		pr_debug("generated dhchap key %s\n",
592f87de2971040 Hannes Reinecke 2025-05-28  172  			 key->description);
592f87de2971040 Hannes Reinecke 2025-05-28  173  	}
f50fff73d620cd6 Hannes Reinecke 2022-06-27  174  	return key;
f50fff73d620cd6 Hannes Reinecke 2022-06-27  175  }
f50fff73d620cd6 Hannes Reinecke 2022-06-27  176  EXPORT_SYMBOL_GPL(nvme_auth_extract_key);
f50fff73d620cd6 Hannes Reinecke 2022-06-27  177  

:::::: The code at line 158 was first introduced by commit
:::::: e30cd923b3ed10791cb23e15804b0b74af21e074 nvme-auth: switch to use 'struct key'

:::::: TO: Hannes Reinecke <hare@kernel.org>
:::::: CC: Keith Busch <kbusch@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

