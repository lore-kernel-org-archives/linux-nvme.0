Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FD89EEF312
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Mar 2026 07:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QMTJ1PozO2AoZ88j3KDpW5zK0e/FOV/W6F1EMmR8npY=; b=2ZQJwLOSzcow25Y0M0yzPRdAbE
	b44nQjriMGSdDbMeF4DdDyO5zLbDry2ZNYAZFfwLs5wGSuoDf3V3KsjX/TOsWKspvGKV0SWWxVlbX
	hwr4IQUKo1q8BelSxlZoaTaMBC0LJZqUzgcWc0btLmkpOV3nioEtRymsz53eHARLtX7wJ1DI8obR2
	03iRWVboW29Mg36F6pR/nRX7IRWS0b5hrk7HG9h+AOhm5Ys0G8GepaotSpN9PW+1hfSC/pSL1nQfV
	QIK7m098YCth0ehQH8p6nxyZwK6XPqmX+zVRLj7SXZ+UJTP8zHht9tQTgaZvaxwD6szL8J/DHKEVq
	/NjQxATg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vy3Wj-0000000181h-0zvs;
	Thu, 05 Mar 2026 07:53:45 +0000
Received: from mgamail.intel.com ([192.198.163.12])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vy3Wb-00000001815-2Ym5
	for linux-nvme@lists.infradead.org;
	Thu, 05 Mar 2026 07:53:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772697218; x=1804233218;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0IRCN5orXpBlDp5bbe+hP/a4OpxCZ/kKP/mq46MHsUc=;
  b=eN88D4P4J5QSC5grjNSbbiQvTfextxbEKU+PyncPPcpMi5c8FvU+GHON
   qUDJoXxEj0ISyOTz/n12B4dPcltcmrmldNp8BA7okCzF3IkBzJ8sUMQah
   gGB/wK50q0OoO+6WJqon56m0lFGSQx+f6P3/Ny9UlUaS0Vh5DQja/acVG
   AOnAqTLX0rDld1empT5Quh9V1YH9CRGQ3kOXfR6WYG5h/s2WIPOKNEDS+
   Q5EJPKDH5XhUi/XRj9QApvBZ9H9Bqcu0Wet8k0VVfAy0OuGpzUk/PbkIT
   iRo76hquAnidwflHZNRHjzu1FkRIKrPae7lD66LPD6PkjjZh1UCtuZoHZ
   Q==;
X-CSE-ConnectionGUID: fRfK4e7bShi3FWMsWMTalg==
X-CSE-MsgGUID: RU91O+kfQHiYcmZA2hYGmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="77646907"
X-IronPort-AV: E=Sophos;i="6.21,325,1763452800"; 
   d="scan'208";a="77646907"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 23:53:32 -0800
X-CSE-ConnectionGUID: w663kWYfQVa8o27u4O5rSw==
X-CSE-MsgGUID: kwe5FhppRZ2RDxvcFi9xoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,325,1763452800"; 
   d="scan'208";a="221500100"
Received: from lkp-server01.sh.intel.com (HELO cadc4577a874) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 04 Mar 2026 23:53:27 -0800
Received: from kbuild by cadc4577a874 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vy3WF-000000000Du-3zCf;
	Thu, 05 Mar 2026 07:53:15 +0000
Date: Thu, 5 Mar 2026 15:52:39 +0800
From: kernel test robot <lkp@intel.com>
To: alistair23@gmail.com, chuck.lever@oracle.com, hare@kernel.org,
	kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, kbusch@kernel.org,
	axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	hare@suse.de, alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v7 4/5] nvme-tcp: Support KeyUpdate
Message-ID: <202603051502.9qxZ0noK-lkp@intel.com>
References: <20260304053500.590630-5-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304053500.590630-5-alistair.francis@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260304_235338_014126_8A5CD80B 
X-CRM114-Status: GOOD (  12.03  )
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
config: x86_64-buildonly-randconfig-006-20260305 (https://download.01.org/0day-ci/archive/20260305/202603051502.9qxZ0noK-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260305/202603051502.9qxZ0noK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603051502.9qxZ0noK-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/nvme/host/tcp.c:1429:24: error: no member named 'read_sock_cmsg' in 'struct proto_ops'
    1429 |         consumed = sock->ops->read_sock_cmsg(sk, &rd_desc, nvme_tcp_recv_skb,
         |                    ~~~~~~~~~  ^
   1 error generated.


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

