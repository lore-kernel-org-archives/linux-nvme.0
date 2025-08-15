Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8452ECA0EE4
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Aug 2025 21:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iDDd1aHiYIPnVW9O8TyA1K6cKIgFSke2d0Llehx+AeQ=; b=pInwEhNs2l3gt/CQaF8qmdwaa9
	GRk+TIIks4jSDJLB0zn8329I1gMTrMhIByThZEzsWlMBhdrBejI78scynX3WwodQISrGfWVbalVKl
	ztFWQYHemyD0xycGd2gdSC8ujwFIV2uoJgjEIEkzItpLEE7+fSfTHNBtbuDGQBNFljekEQicR1QH5
	vlMMR6ltcgOc6SODRhcvB3WcEv4zDC5vhj7689I5wNVUrE7LAfP19h1Tbb0VN+a6rMjzaRy0jBwci
	q+o7A2/OjGWQTm3LXHJEEFJO7bDj+Xul0E6YiHcW8U3WC1EXwOWbvO+wCKA+0S+Sgd7zU1NWi/78F
	gGlph1Xw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1un2IW-00000003a8O-3JmK;
	Fri, 15 Aug 2025 21:49:16 +0000
Received: from mgamail.intel.com ([192.198.163.11])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1un2IU-00000003a7x-0mZG
	for linux-nvme@lists.infradead.org;
	Fri, 15 Aug 2025 21:49:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755294554; x=1786830554;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7/DESvwD3138OtQA65/DUWMV7oCqWuC7zjK3tOXv16k=;
  b=faNrEmUtnTP59Ltdp3yGuxOYVUXFSGDrqMi3T0kA4Uv0ECBjL5VBlMil
   NtT8CWPDJb8oX061NxG4NcmyTL8Nhj9SGSDyFxaOp3DLzkhIPtaTf4mwn
   1599mXqS7MRcHkLNkwxETN9r77/nLoLdEsNivInhPucC5uwoBLCJnSpJR
   UtgxRoJr3T65MwhI6OtENfn0+X6SP2KwrNZNjnUJkt6z7SmA5lr7JRGQm
   TkLtO++28xHfDncK6tfvwxSDDCRTcA7wclpdz8afE6xa+HJG6K5JWzO/D
   CCZQdCYlIbqeb9JNQkvi4V9kUVI4DLfT8IIhF0a5DmOwWMj01IQeTiaRy
   A==;
X-CSE-ConnectionGUID: R4Rgw55jRWGQkvu1vMBvhQ==
X-CSE-MsgGUID: yQCuyVXmQGK25jO5jALKOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11523"; a="68220431"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="68220431"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 14:49:13 -0700
X-CSE-ConnectionGUID: QnRETjyrRLavnrXXHKJkKg==
X-CSE-MsgGUID: p65L7qcuScGyVUlLkIq0Mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="166321491"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 15 Aug 2025 14:49:10 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1un2IM-000CNc-0o;
	Fri, 15 Aug 2025 21:49:06 +0000
Date: Sat, 16 Aug 2025 05:48:51 +0800
From: kernel test robot <lkp@intel.com>
To: alistair23@gmail.com, chuck.lever@oracle.com, hare@kernel.org,
	kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, kbusch@kernel.org,
	axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH 3/8] net/handshake: Expose handshake_sk_destruct_req
 publically
Message-ID: <202508160510.XOTeniWX-lkp@intel.com>
References: <20250815050210.1518439-4-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815050210.1518439-4-alistair.francis@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250815_144914_237871_39576414 
X-CRM114-Status: GOOD (  11.91  )
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

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on trondmy-nfs/linux-next]
[also build test WARNING on net/main net-next/main linus/master linux-nvme/for-next v6.17-rc1 next-20250815]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/alistair23-gmail-com/net-handshake-Store-the-key-serial-number-on-completion/20250815-130804
base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
patch link:    https://lore.kernel.org/r/20250815050210.1518439-4-alistair.francis%40wdc.com
patch subject: [PATCH 3/8] net/handshake: Expose handshake_sk_destruct_req publically
config: arm-mps2_defconfig (https://download.01.org/0day-ci/archive/20250816/202508160510.XOTeniWX-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 93d24b6b7b148c47a2fa228a4ef31524fa1d9f3f)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250816/202508160510.XOTeniWX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508160510.XOTeniWX-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/handshake/request.c:312:6: warning: no previous prototype for function 'handshake_req_cancel' [-Wmissing-prototypes]
     312 | bool handshake_req_cancel(struct sock *sk)
         |      ^
   net/handshake/request.c:312:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     312 | bool handshake_req_cancel(struct sock *sk)
         | ^
         | static 
>> net/handshake/request.c:349:6: warning: no previous prototype for function 'handshake_sk_destruct_req' [-Wmissing-prototypes]
     349 | void handshake_sk_destruct_req(struct sock *sk)
         |      ^
   net/handshake/request.c:349:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     349 | void handshake_sk_destruct_req(struct sock *sk)
         | ^
         | static 
   2 warnings generated.


vim +/handshake_sk_destruct_req +349 net/handshake/request.c

   344	
   345	/**
   346	 * handshake_sk_destruct_req - destroy an existing request
   347	 * @sk: socket on which there is an existing request
   348	 */
 > 349	void handshake_sk_destruct_req(struct sock *sk)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

