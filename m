Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E117C3DA4A
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Aug 2024 07:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=4NNfUJqXxW0guk5iWKWuJ/3YPxfru0tV/ZahUBoV2Zk=; b=mNBxd8w4ggDi7PDLk80JNWapBd
	LYyEauj9mrlDlAtAM6Q5xFIPvM+/z6RLzNTSHzTzawc9M0ZjVo2If/HGHDPV0OMhkMIR1mcP65jqk
	Vnc4TYs0EaTmiQvneq3h6hlvSSynRfoSc9ysDtwBUhhnwmfv5F5jOT9BdDVqWQVRMo3YwxbLuXsoB
	S5HGEhWoMR8KvlU/ekYRiBu7EKAtIZrLtxtzdg4KPchQ6ObBNl4d7/o/leXayyrwS8yFUnK6pDqPe
	Y7PF9V6B+NhloBf/n2lZvkdwS3YrXXBnE9O9E0iy2iIgQfB15rOLa71al2Ed5cq9uSmLUbgYVdcM+
	8YIqD9Sw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sfwyV-00000000fJh-199w;
	Mon, 19 Aug 2024 07:38:47 +0000
Received: from mgamail.intel.com ([198.175.65.10])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sfwyS-00000000fJA-130i
	for linux-nvme@lists.infradead.org;
	Mon, 19 Aug 2024 07:38:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724053123; x=1755589123;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GHNlXChSEZLHEgtaa029sUkYmjK/+ufE2Y4TCO3ph2I=;
  b=nRXcBFifj7sentBvJes8JokgjO1ToMAB0VnpaOCU+YnonsOkYN07hHmW
   MH59MJqR50OIwNOpzSd38NdlgGxfPLF1s3TIQuqrR+voZ5NzL7fN3YOYs
   lcMOU4rxroXyYLao/C2zGKf/He3CxCbBDHButSm2qE3D3jrisHz9vYW9x
   kcxBgoHEExfWmjByBL3QajmUVhMHZqXYhxGhI9SSS2OUUoM7N3RcefI2J
   Jo0T08o7GH/2nVrI+gY47YIiPPkCWccKpdQ9boM/zoBsToXvvazF01kGE
   Sf7IK9S8XGflueXVC+M9zgHSvyycx7YyaV/0dIIV5UZIhDrsMBC3CZdyk
   A==;
X-CSE-ConnectionGUID: NHyWjiogQXyxGvsFo8bUzQ==
X-CSE-MsgGUID: DeOxwEizS/K5k/Ot5XrBEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="39746991"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="39746991"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 00:38:32 -0700
X-CSE-ConnectionGUID: BafQaHQ8QBSPT2Rjue77HQ==
X-CSE-MsgGUID: xlPMBOrrQ/mZU3b67HBEWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="60341090"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 19 Aug 2024 00:38:31 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sfwyC-0008kE-2L;
	Mon, 19 Aug 2024 07:38:28 +0000
Date: Mon, 19 Aug 2024 15:37:39 +0800
From: kernel test robot <lkp@intel.com>
To: Hannes Reinecke <hare@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Christoph Hellwig <hch@lst.de>
Subject: [linux-nvme:nvme-6.11 3/8] fabrics.c:undefined reference to
 `nvme_tls_key_lookup'
Message-ID: <202408191523.ZNkulRyq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240819_003844_355183_B2B8F010 
X-CRM114-Status: UNSURE (   9.37  )
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

tree:   git://git.infradead.org/nvme.git nvme-6.11
head:   e219e08d3a1f14dd34d6a9903de744173faadd53
commit: 05b4eed6f7c3162d877a6ab325b88951575a47a6 [3/8] nvme-tcp: check for invalidated or revoked key
config: sparc64-randconfig-r112-20240818 (https://download.01.org/0day-ci/archive/20240819/202408191523.ZNkulRyq-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 14.1.0
reproduce: (https://download.01.org/0day-ci/archive/20240819/202408191523.ZNkulRyq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408191523.ZNkulRyq-lkp@intel.com/

All errors (new ones prefixed by >>):

   sparc64-linux-ld: drivers/nvme/host/fabrics.o: in function `nvmf_parse_key':
>> fabrics.c:(.text+0xb9c): undefined reference to `nvme_tls_key_lookup'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

