Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E54B1C43458
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2026 05:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=UCXPFf3lx+nqMPOv+q+ywzlIPYrdCXgejjR9i4xbnDQ=; b=w0GMxTaFthvon/ti7FP4xV85AX
	NLCONqq0cEwwouPSz9Ekfn3LQKSclKecANGZAMhw5TBPDYwGfMCadURQrFbLUBCUEdHbKd0mrTopL
	TndJz5gavSUfJ/CgUcS48LVZNdP8tLfn5/ZLdpenFJzTfg9Za8IBuRyOYSHzjK6GvYvdA+HD8gYBv
	9doBxzmqUUm5ZorAk4OLyhWP/Tp0bA3+cO18rWI616LH060ur+pGpDuIyZYEt+SGcmQOhbNcXdKqY
	Eurr7JXsX87v6jRJk3mRGSBs2YMsUpx31buD4TRg6IcmwmVYyb8f/9LnWL8K+d0GVN+6VCa1HVUbo
	iZgya8aw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1we4La-0000000DhLM-2yRN;
	Mon, 29 Jun 2026 05:15:54 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1we4LU-0000000DhKM-1eBu
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jun 2026 05:15:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1782710149; x=1814246149;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dYG/M4mKxi518AMskepviyT27phsj06S2qC8Bpvd2k8=;
  b=QvdbXKZWSsZ41B3vri0CndfxQFVDRjCT9WGtc83cyDItqup9P36/piZO
   IYmDOvr40ATDeXQUHq4GLEjEPzdX0/Q5nHvcTSm6ebD13xQk8RY6opY+0
   1WLeCBiz43zUrCKR/HaJyvy69oabC8ZLmiDKBBGQyy+lkLoqxORGjIWr1
   dj0Og2zhTUYIVQRvNgAfrtAOlx8e2ARqAUDC7fcokOUG3NSeEBE56XXrc
   /u/tO7KhIsMtSEcUv9lm1MkFzNdv3pw/b3y03nZ814O69CC0zf+d+1UIj
   njoR8N2vL7uC7enQXUSYANyYjM0dEwOrJSfIXS2yGAXaqnGwczQI/4EDx
   A==;
X-CSE-ConnectionGUID: vPlolDmSQRyhR8g3xPjTCA==
X-CSE-MsgGUID: YOKhG+tpT7SwZ4OSxUHPGw==
X-IronPort-AV: E=Sophos;i="6.24,231,1774281600"; 
   d="scan'208";a="150909809"
Received: from unknown (HELO uls-op-esad2-o.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2026 13:15:47 +0800
X-CSE-ConnectionGUID: B8cymhxpSUi1AnrE58SNVg==
X-CSE-MsgGUID: gJBbhfGnSmiHS3hCFo47Cg==
IronPort-SDR: 6a41ff72_rEA3f652rKWgYiVw1s6TdUZJllG+cqYDdBvVf/SRj8C59ng
 mALq0tk9v4Us8lY3skLeWTF2ckLV599QRbFQ09w==
Received: from uls-op-esai2-o.wdc.com ([10.248.3.38])
  by uls-op-esad2-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jun 2026 22:15:29 -0700
X-CSE-ConnectionGUID: IreS3r0OQkmXezaJlJOrjA==
X-CSE-MsgGUID: v74nCZG4Rjy8hZcWMLtdVw==
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.67.30])
  by uls-op-esai2-o.wdc.com with ESMTP; 28 Jun 2026 22:15:29 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH 0/2] nvmet-rdma: fix response resource leak on queue teardown
Date: Mon, 29 Jun 2026 14:15:26 +0900
Message-ID: <20260629051529.810925-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260628_221548_513565_17D59C78 
X-CRM114-Status: GOOD (  11.11  )
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

When an nvme target with rdma transport is removed while I/Os are in
flight, a response can be posted but its send completion is never
delivered before the connection is torn down. This leaks the request
SGLs and the RDMA read/write context. The leaks are recreated by
running blktests nvme/061 with rdma transport and the siw driver [1].

[1] https://lore.kernel.org/linux-nvme/ajtk1CaN1pBreS4O@shinmob/

This series addresses the problem. The first patch is a preparation
refactoring. The second patch fixes the problem by reclaiming memory
objects on queue QP teardown.


Shin'ichiro Kawasaki (2):
  nvmet-rdma: factor out response resource cleanup
  nvmet-rdma: fix response resource leak on queue teardown

 drivers/nvme/target/rdma.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

-- 
2.54.0


