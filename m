Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 610C4F3092B
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Mar 2026 10:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MKn5CrCjMrQlqHVJLqDwLoIu5IzqPmEXPxjkdcaeFHo=; b=JhWzLB2t/tM7HtaX1feLdNu8w7
	+h9c0IznGM6eh/5WK+zBdqw2vcxPFwH95xfQgW7x9HpnCTrpd7Axbh6C8EDGqjq8HtHmDQ7d8YRf5
	/AZSMS1peh21XnnwIRGMge9h/5r1i0ESipPf6brDGDnKSYEew+0Fyrj/aA/3w5zVihHHls2mgzXs/
	h6GOpJE2E+WoLzGdnFFU4HCdBHVx51gbfkaOVAt9fmLTOaw0kJvEPXg2V6pDJJz2XOk6hEIaU7+jX
	fQtWyheJNM+EcFX2CkpwiVfbq2u0/l2h5caiLZ0qDBr5NFbBhptLkGKNML3x6EvsJL6z+Gtti7QMI
	+TlWKwYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vy5iQ-00000001X5W-1mBJ;
	Thu, 05 Mar 2026 10:13:58 +0000
Received: from mgamail.intel.com ([198.175.65.15])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vy5iL-00000001X45-1pmL
	for linux-nvme@lists.infradead.org;
	Thu, 05 Mar 2026 10:13:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772705633; x=1804241633;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=os8pElF8hPySTMJ5OPZITsFHgDhyLLsZZ4pcbD3N9g0=;
  b=gLdKziWqYIW5ZSzGd+fkb/ADEhsWuakWFBSFdgfcweJv89ekRo+8ti75
   cRBR7gPmZg5C/hyy+fDzWD+vtP+z260WgcLAI8VaKfYD3K9GzIA6oE8H/
   QaohBFDCweO9xYzwrEIWfGRZtqrfAplpMt05NAsnBxPUUQN1xC1BoErQQ
   l9SRkLtYaGGe/n51O0YIJ0LbCC6o76k7M+y08aQ+exrTQOdWa0h2Z4AyK
   /Ge9dQm2ZlHsUOqDkLSB5pQTwP9q4ilKwS9N9ZT4VppC6rRE8L3Ic9lQK
   l17F7yT8iprMj0Q0TMOwgcwiGqJ4mh1z4h9Ve+wbsLQRHpbafil92DmYO
   w==;
X-CSE-ConnectionGUID: tBZMTLP9TjGooPHP1Cpotg==
X-CSE-MsgGUID: N6+7HV2VSUGTI+BEgzLRIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="77391131"
X-IronPort-AV: E=Sophos;i="6.23,102,1770624000"; 
   d="scan'208";a="77391131"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 02:13:52 -0800
X-CSE-ConnectionGUID: nICofMrEQPe2MvR9s8A7Xw==
X-CSE-MsgGUID: Zmo+veC5TJWOCqBPQ7Aaew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,102,1770624000"; 
   d="scan'208";a="249102013"
Received: from lkp-server01.sh.intel.com (HELO cadc4577a874) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 05 Mar 2026 02:13:49 -0800
Received: from kbuild by cadc4577a874 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vy5iD-000000000Sw-0g4v;
	Thu, 05 Mar 2026 10:13:45 +0000
Date: Thu, 5 Mar 2026 18:13:09 +0800
From: kernel test robot <lkp@intel.com>
To: alistair23@gmail.com, chuck.lever@oracle.com, hare@kernel.org,
	kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, kbusch@kernel.org, axboe@kernel.dk,
	hch@lst.de, sagi@grimberg.me, kch@nvidia.com, hare@suse.de,
	alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v7 4/5] nvme-tcp: Support KeyUpdate
Message-ID: <202603051846.RCN7R5uj-lkp@intel.com>
References: <20260304053500.590630-5-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304053500.590630-5-alistair.francis@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260305_021353_556314_F96A2264 
X-CRM114-Status: GOOD (  11.34  )
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
[also build test ERROR on net/main net-next/main linus/master v7.0-rc2 next-20260304]
[cannot apply to linux-nvme/for-next horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/alistair23-gmail-com/net-handshake-Store-the-key-serial-number-on-completion/20260304-134148
base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
patch link:    https://lore.kernel.org/r/20260304053500.590630-5-alistair.francis%40wdc.com
patch subject: [PATCH v7 4/5] nvme-tcp: Support KeyUpdate
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20260305/202603051846.RCN7R5uj-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260305/202603051846.RCN7R5uj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603051846.RCN7R5uj-lkp@intel.com/

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

