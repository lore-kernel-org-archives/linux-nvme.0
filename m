Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7939BC282DE
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Mar 2025 02:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=sCQFhIgZWK3TkN0zKkcvVKnGuEhj6HlQGUmlPHkOFaA=; b=XQlKjAMdzkzcL1zsKypRhZ9+n6
	q9zcL4GhuoeFnZoaMrUBh99EB6bbQcWWaq1r2llZ7KbWCoDMDxRilmK91Diq131fGM9zIKMFnOvW2
	1QlhFNcaUDSSIZqfIIPFzB6Liy3DKzaK9zNeAiNNl99509r6+jxhzBPRidVEHJRdInQmPl0dpkA9M
	RenaiyJ1LOWk7U9pCu+hQzs7gIDXllRAr+c7Dygml7OAm0SAVlHcTNSjXkEcHiGWQPmVe+TmoK3Fk
	MHqOVFDl0KLw9cSgLGV7YSog0bcx8vR+TDrjWVsyeDHzufc5XsD8yvbTHgxnbW+/GpshgmZVLXlkM
	8GAzlT6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1trpZ4-00000004Rg6-0GFg;
	Tue, 11 Mar 2025 02:41:54 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1trpZ0-00000004ReT-3pl7;
	Tue, 11 Mar 2025 02:41:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1741660910; x=1773196910;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3M1RX7nQUNgedOmI/wuy5kV+UAWXYSfHp90hyMNHCQo=;
  b=WqvyEvAG7+3j61HZjWkiMcMkYickqnuru3pPGABkicysQfoSQdqnYBTn
   jdmU+3D1zaJRfki3rh7yPaIpO3/0sqUrzYZgJzs+oZm+0n6nRhlhLlh8P
   WqLWdv0kQ/2M9GHq528GxM42zrymhU9fJJStxKQccx0/0mmg5vKftw+4M
   fPIU1mfE+kjwpIPTyLuTDueVLQh9m7gSnc6rSr6VK6L/Cwj61JAzP3VQA
   PkXoqKckC0x7Jd9SWmV9l/phb0CSXJPEhGeSte1sBu5F2KHDi5S9bmoOu
   w7HNZ/tAJ4AJHoEUl5S+Ct59Gj/vk9aOsrN7K0JG+J+ByLQiEIjjGU4ko
   w==;
X-CSE-ConnectionGUID: e7hNKxbPQ4CdSugz5sal6g==
X-CSE-MsgGUID: YGQHGljVTOWgH2G/FEbL1g==
X-IronPort-AV: E=Sophos;i="6.14,237,1736784000"; 
   d="scan'208";a="47404410"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Mar 2025 10:41:48 +0800
IronPort-SDR: 67cf9517_wWvreogS923r57527WQCnFkIQh5zUlI6qXtLOIsiMZ8dP4a
 /emqhnrSXOqH9oVnILlo4ASMXsJWPfWPBBPzCLg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Mar 2025 18:42:47 -0700
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Mar 2025 19:41:46 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alan Adamson <alan.adamson@oracle.com>
Cc: virtualization@lists.linux.dev,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Sven Peter <sven@svenpeter.dev>,
	Janne Grunau <j@jannau.net>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH 0/2] block: nvme: fix blktests nvme/039 failure
Date: Tue, 11 Mar 2025 11:41:42 +0900
Message-ID: <20250311024144.1762333-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250310_194151_006253_F0694D49 
X-CRM114-Status: GOOD (  10.19  )
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

Commit 1f47ed294a2b ("block: cleanup and fix batch completion adding
conditions") in the kernel tag v6.14-rc3 triggered blktests nvme/039
failure [1].

The test case injects errors to the NVMe driver and confirms the errors
are logged. The first half of the test checks it for non-passthrough
requests, and the second half checks for passthrough requests. The
commit made both halves fail.

This series addresses the test case failure. The first patch covers the
passthrough requests, and the second patch covers the non-passthrough
requests.

[1] https://lkml.kernel.org/linux-block/y7m5kyk5r2eboyfsfprdvhmoo27ur46pz3r2kwb4puhxjhbvt6@zgh4dg3ewya3/

Shin'ichiro Kawasaki (2):
  nvme: move error logging from nvme_end_req() to __nvme_end_req()
  block: change blk_mq_add_to_batch() third argument type to
    blk_status_t

 drivers/block/null_blk/main.c |  2 +-
 drivers/block/virtio_blk.c    |  5 +++--
 drivers/nvme/host/apple.c     |  3 ++-
 drivers/nvme/host/core.c      | 15 ++++++++-------
 drivers/nvme/host/nvme.h      |  1 +
 drivers/nvme/host/pci.c       |  5 +++--
 include/linux/blk-mq.h        |  5 +++--
 7 files changed, 21 insertions(+), 15 deletions(-)

-- 
2.47.0


