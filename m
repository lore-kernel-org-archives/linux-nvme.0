Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C994EB7EB6
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Mar 2026 10:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oMlg+JMuTmffXCpSX73qKnryNZhq1TzWjo6j1vEJx3g=; b=bIteKvSQRvYdTc2EXItukqeSEV
	YwY8pdB9NeI4cUjh1upEGEEouqPcsLtIVh9z3PLUaD3z8Jk5QZEynFaJgkKCPSH2ckvu52z+dfILf
	9VQ/NdsGGMdtdUhzuY9Zv0Q1gZaR0uuwrz2/BYPQX+WWT565YAwSuGZavpaGOmDguH6VowG7hDdAD
	IVNu0EjvO/q66W6K3Jo4AbSxjlJ12/jM++/xAsRdudXRzwPeA3VgUVfw7lgUYhZGRDome/ni+MY9S
	OZYFl/nSERYgwl+KHVToZ9bT35Nq9/2OCfGoJQXJkLdqhQWpZ6TvBt4mCRB3nAU15STwhnQX0POBp
	fFb6DEFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxjjX-0000000H0g4-2O7o;
	Wed, 04 Mar 2026 10:45:39 +0000
Received: from mgamail.intel.com ([198.175.65.14])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxjjS-0000000H0fJ-3Mc3
	for linux-nvme@lists.infradead.org;
	Wed, 04 Mar 2026 10:45:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772621135; x=1804157135;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=h7E/8o1/7HTV0SVvlIZbDHxgfXZolheekA9fIw186h4=;
  b=YL5lmrGr49z8xdbrhftan4XzHf/av8p8GYh5YQbye9y92WwzO7SjAyM9
   YmeVTO5wJBqbGl7/KAB7fmxpklUndxgcOpFFhyqZPec3V0OTsyfu5nGIB
   c3q93b1wDrVXs/9nb+/wS7kWhqs3QOUeP1EToTVr4VAVNycNgOSpmnlUB
   vLB4fka+FddDDiqX0esxzf2Waw/ab+j0K41gdtEmGdKbOy76BDt4DR+1B
   au91H1Az9solOIcpo1lYku4GSe1cR1ztDfwbvk0IhezBfJ6uopX8lcDXR
   nT2pPH6cd2D00ojoO7Birei4b2RhBj/DS1mvYFYPH1iakVRJw4C/CKLdg
   A==;
X-CSE-ConnectionGUID: cGNFVFsiTk2zqXlvR/tcdw==
X-CSE-MsgGUID: jM7ZhDBuR2Sf4HmsBfPnsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11718"; a="77522358"
X-IronPort-AV: E=Sophos;i="6.21,323,1763452800"; 
   d="scan'208";a="77522358"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 02:45:32 -0800
X-CSE-ConnectionGUID: oVDTgMTCR6Gc0LsRhX4bPw==
X-CSE-MsgGUID: 5mOij3zGQFObPS2/aj14bA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,323,1763452800"; 
   d="scan'208";a="222799590"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by orviesa004.jf.intel.com with ESMTP; 04 Mar 2026 02:45:28 -0800
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vxjjJ-000000001fd-2npX;
	Wed, 04 Mar 2026 10:45:25 +0000
Date: Wed, 4 Mar 2026 11:44:26 +0100
From: kernel test robot <lkp@intel.com>
To: alistair23@gmail.com, chuck.lever@oracle.com, hare@kernel.org,
	kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, kbusch@kernel.org, axboe@kernel.dk,
	hch@lst.de, sagi@grimberg.me, kch@nvidia.com, hare@suse.de,
	alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v7 4/5] nvme-tcp: Support KeyUpdate
Message-ID: <202603041124.uCwVY2n8-lkp@intel.com>
References: <20260304053500.590630-5-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304053500.590630-5-alistair.francis@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260304_024534_890029_4E4D4703 
X-CRM114-Status: GOOD (  11.76  )
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

kernel test robot noticed the following build errors:

[auto build test ERROR on trondmy-nfs/linux-next]
[also build test ERROR on net/main net-next/main linus/master v7.0-rc2 next-20260303]
[cannot apply to linux-nvme/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/alistair23-gmail-com/net-handshake-Store-the-key-serial-number-on-completion/20260304-134148
base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
patch link:    https://lore.kernel.org/r/20260304053500.590630-5-alistair.francis%40wdc.com
patch subject: [PATCH v7 4/5] nvme-tcp: Support KeyUpdate
config: x86_64-rhel-9.4-kunit (https://download.01.org/0day-ci/archive/20260304/202603041124.uCwVY2n8-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260304/202603041124.uCwVY2n8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603041124.uCwVY2n8-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/nvme/host/tcp.c: In function 'nvme_tcp_try_recv':
>> drivers/nvme/host/tcp.c:1429:31: error: 'const struct proto_ops' has no member named 'read_sock_cmsg'; did you mean 'read_sock'?
    1429 |         consumed = sock->ops->read_sock_cmsg(sk, &rd_desc, nvme_tcp_recv_skb,
         |                               ^~~~~~~~~~~~~~
         |                               read_sock


vim +1429 drivers/nvme/host/tcp.c

  1417	
  1418	static int nvme_tcp_try_recv(struct nvme_tcp_queue *queue)
  1419	{
  1420		struct socket *sock = queue->sock;
  1421		struct sock *sk = sock->sk;
  1422		read_descriptor_t rd_desc;
  1423		int consumed;
  1424	
  1425		rd_desc.arg.data = queue;
  1426		rd_desc.count = 1;
  1427		lock_sock(sk);
  1428		queue->nr_cqe = 0;
> 1429		consumed = sock->ops->read_sock_cmsg(sk, &rd_desc, nvme_tcp_recv_skb,
  1430						     nvme_tcp_recv_cmsg);
  1431		release_sock(sk);
  1432		return consumed == -EAGAIN ? 0 : consumed;
  1433	}
  1434	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

