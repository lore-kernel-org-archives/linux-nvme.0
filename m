Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B3FBC5CFC1
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2026 22:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Q8yItw7tVPVwpfW3e4RiXaP9OW9tydpyEk9jvfND54k=; b=w7+V0dltdrC6aqeW++Cdg/7Dwk
	jq9ETNcvN05wr+4nr5INArK8CHKZqi7quACG9dqPY8R9bFHGUNXRwmvmZaeZLw/Ls8OsxqT0DOCcB
	1r/3yt4uk1etgNe6AUDhWMJIV2nTAIsD8NDtTnhqyUk1/lZtx9TEzGTka7p/zSlTvxxnvar/dep4D
	X1iIieAHm0sb5NgLRN58fUEg4jCrVckX45ZzquK6g7gIoGMHgNqu6InkCanMsO8tmXF640y+k50tF
	DsuvRG/iQUZTeF5WcR39y+ozKe4tEETa6xiiKeOOS0K8VlSRcAsXvKFbmtsJCvUqtGzTvoLMgWilc
	V38rbtBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wv0pA-00000003HYl-3Lyh;
	Fri, 14 Aug 2026 22:56:28 +0000
Received: from mgamail.intel.com ([198.175.65.9])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wv0p7-00000003HYQ-34ms
	for linux-nvme@lists.infradead.org;
	Fri, 14 Aug 2026 22:56:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786748186; x=1818284186;
  h=date:from:to:cc:subject:message-id;
  bh=Z9zRnw2hPmmakSFiJ+IxfdvsQNlQe3US79x2aTOoF20=;
  b=G5bPGoCUBN62X2NmG2psx22/cFI58QD8smjBeFtlv00saBjdmRioQhq8
   R05CeibnORyCfUudv6W2DipzAtlC+qXrAmNGY//oKbSfJg1AScu/BLV6P
   bVe3mtQoJ8TfyoRkSJl2InPMx7c0BkFByVJfjVLvk1DUPBMqr72llfU8p
   jnv7BukjzBZMbtUp0KFcLfMQBtjjATxER7KpZTlX0hKVywABWNLKQe81G
   u2OJeDVnxotTz5o1yhQ/iqAieUgastu3rDQ0U5tCqkRUrNFqHVymeDRij
   gaHJPfN/4NoxGamitUcgcUNrqN0pzee4YxgsWppGF8tmJTaTt6+XSRLSp
   Q==;
X-CSE-ConnectionGUID: 9GKi/HDKTOyLyBP1KsG/Gw==
X-CSE-MsgGUID: XFB3+1A/SbeoNlVyLdoHGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11875"; a="110115864"
X-IronPort-AV: E=Sophos;i="6.25,224,1779174000"; 
   d="scan'208";a="110115864"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 15:56:24 -0700
X-CSE-ConnectionGUID: kGiugzNERWCYG6RAjn/vxw==
X-CSE-MsgGUID: YaImckvSR7OfMU33Ha00xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,224,1779174000"; 
   d="scan'208";a="261702983"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 14 Aug 2026 15:56:22 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wv0p2-00000000aQq-2Lvu;
	Fri, 14 Aug 2026 22:56:20 +0000
Date: Sat, 15 Aug 2026 06:55:49 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-7.3] BUILD SUCCESS WITH UNVERIFIED WARNING
 f1a8846e06388113dfdbb89dee005083fa9afdf9
Message-ID: <202608150635.GSfpuhHl-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260814_155625_812303_5F0C26BA 
X-CRM114-Status: UNSURE (   3.84  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-7.3
branch HEAD: f1a8846e06388113dfdbb89dee005083fa9afdf9  nvmet: fix max_qid race between configfs and controller allocation

Unverified Warning (likely false positive, kindly check if interested):

    https://lore.kernel.org/oe-kbuild/202607291634.E5clnaLh-lkp@intel.com

    drivers/nvme/host/multipath.c:249:38: warning: reading variable 'current_path' requires holding __ctx_lock_RCU 'RCU' [-Wthread-safety-analysis]

Warning ids grouped by kconfigs:

recent_errors
`-- loongarch-defconfig
    `-- drivers-nvme-host-multipath.c:warning:reading-variable-current_path-requires-holding-__ctx_lock_RCU-RCU

elapsed time: 802m

configs tested: 15
configs skipped: 1

tested configs:
alpha             allnoconfig    gcc-16.1.0
alpha            allyesconfig    gcc-16.1.0
alpha               defconfig    gcc-16.1.0
arc              allmodconfig    gcc-16.1.0
arc              allyesconfig    gcc-16.1.0
csky             allmodconfig    gcc-16.1.0
i386             allmodconfig    gcc-14
loongarch           defconfig    clang-24
nios2            allmodconfig    gcc-11.5.0
nios2             allnoconfig    gcc-11.5.0
parisc           allmodconfig    gcc-16.1.0
parisc           allyesconfig    gcc-16.1.0
parisc              defconfig    gcc-16.1.0
powerpc    amigaone_defconfig    gcc-16.1.0
sh                  defconfig    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

