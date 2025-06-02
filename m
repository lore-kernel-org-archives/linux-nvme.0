Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD229C54FB3
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Jun 2025 04:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2i2B9PsAzU4apQWppElyP4WslofXtiQHXBIMgEqPcKQ=; b=twH2rE/E2wuc/UI5O7KI0Khlz7
	4WlECvJGX4cxyrRmlEuZA7i+5326Z8uHR8SxIM0gK4aaoKfE+XBlZjZ+J+/lGO80m8pcuRlYjCS5o
	kPHkDZRkLBXC7AthdomA9EywHGwFWFCwVG26jMX9j2WNdLKCnfmR+OJN91mjuSeOB7Rvxb0lLS59S
	dWD89dG2TB7P/P2pQhWi0OThnirXpx7yDGguiCjNIgpb//r6y13G/zdId7u/lnyptQKXwcsD7GZJ1
	dxtUKoQ5JYf0awYQKe1oX8h6u8St1ocRECHZ9VmSK1P4lMUWPL2P7a9wU01sFSDXjMMBCrRxeduj1
	EaXPX0Hw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uLwtZ-00000006gNh-17eU;
	Mon, 02 Jun 2025 04:35:33 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uLwtW-00000006gKU-0Thp
	for linux-nvme@lists.infradead.org;
	Mon, 02 Jun 2025 04:35:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1748838929; x=1780374929;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OfV9yeSkJCmAf3lYFIh1gBwWKXiFP519DpqcSMTXeTo=;
  b=Iuh6awVQWFME51sOgcOCIf1kadk6XWiMyFd52BGGTZrVswyeTddkkTSO
   tUbwg74v6H9FrzFpG/m8TqN/xBps9E7iOdR+Dy5xijrAFfrIHSa091DAj
   HWV5OgNOfECYWEeJbi3jrXQ9DB126vqon5zYuNKTVlGG3CDrlpaFJVETB
   eEHzCBBFR2IbJMCXYwrZtAV0Ff+MBGykZ2nsvF2iV49BK6x+VAG39Dtj3
   tgK+A/LQ0WD8JFp/B+QdZhRz25e4RvnOBN9moPRkm7Gy+QnkKO/PxUPLe
   sbjkyNh9++n3lLViAaGD+6zLrZVnhvJ4R6ORuIxVoMGB2Jkw+3naHErV5
   Q==;
X-CSE-ConnectionGUID: cr4wjzciR7muvVUZ87vCjA==
X-CSE-MsgGUID: iSyXO9y5TWC2HFGyHQDeXQ==
X-IronPort-AV: E=Sophos;i="6.16,202,1744041600"; 
   d="scan'208";a="83253771"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jun 2025 12:35:29 +0800
IronPort-SDR: 683d1bb7_/1vn1N+cpNuP5sRIXFhq45QlHf7YjWgQAhmAEUJZxYN8VIZ
 zYIQviVaaz0rqWFpqWZSsu98oNZBnJGfp+5G7Dg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Jun 2025 20:34:16 -0700
WDCIronportException: Internal
Received: from 5cg217418x.ad.shared (HELO shinmob.wdc.com) ([10.224.163.195])
  by uls-op-cesaip01.wdc.com with ESMTP; 01 Jun 2025 21:35:28 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH 2/2] nvme-tcp: remove tag set when second admin queue config fails
Date: Mon,  2 Jun 2025 13:35:22 +0900
Message-ID: <20250602043522.55787-3-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602043522.55787-1-shinichiro.kawasaki@wdc.com>
References: <20250602043522.55787-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250601_213530_155900_39B3D574 
X-CRM114-Status: GOOD (  18.02  )
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

Commit 104d0e2f6222 ("nvme-fabrics: reset admin connection for secure
concatenation") modified nvme_tcp_setup_ctrl() to call
nvme_tcp_configure_admin_queue() twice. The first call prepares for
DH-CHAP negotitation, and the second call is required for secure
concatenation. However, this change triggered BUG KASAN slab-use-after-
free in blk_mq_queue_tag_busy_iter(). This BUG can be recreated by
repeating the blktests test case nvme/063 a few times [1].

When the BUG happens, nvme_tcp_create_ctrl() fails in the call chain
below:

nvme_tcp_create_ctrl()
 nvme_tcp_alloc_ctrl() new=true             ... Alloc nvme_tcp_ctrl and admin_tag_set
 nvme_tcp_setup_ctrl() new=true
  nvme_tcp_configure_admin_queue() new=true ... Succeed
   nvme_alloc_admin_tag_set()               ... Alloc the tag set for admin_tag_set
  nvme_stop_keep_alive()
  nvme_tcp_teardown_admin_queue() remove=false
  nvme_tcp_configure_admin_queue() new=false
   nvme_tcp_alloc_admin_queue()             ... Fail, but do not call nvme_remove_admin_tag_set()
 nvme_uninit_ctrl()
 nvme_put_ctrl()                            ... Free up the nvme_tcp_ctrl and admin_tag_set

The first call of nvme_tcp_configure_admin_queue() succeeds with
new=true argument. The second call fails with new=false argument. This
second call does not call nvme_remove_admin_tag_set() on failure, due to
the new=false argument. Then the admin tag set is not removed. However,
nvme_tcp_create_ctrl() assumes that nvme_tcp_setup_ctrl() would call
nvme_remove_admin_tag_set(). Then it frees up struct nvme_tcp_ctrl which
has admin_tag_set field. Later on, the timeout handler accesses the
admin_tag_set field and causes the BUG KASAN slab-use-after-free.

To not leave the admin tag set, call nvme_remove_admin_tag_set() when
the second nvme_tcp_configure_admin_queue() call fails. Do not return
from nvme_tcp_setup_ctrl() on failure. Instead, jump to "destroy_admin"
go-to label to call nvme_tcp_teardown_admin_queue() which calls
nvme_remove_admin_tag_set().

Fixes: 104d0e2f6222 ("nvme-fabrics: reset admin connection for secure concatenation")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/linux-nvme/6mhxskdlbo6fk6hotsffvwriauurqky33dfb3s44mqtr5dsxmf@gywwmnyh3twm/ [1]
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 drivers/nvme/host/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 14b9d67329b3..85acb4c9c977 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2350,7 +2350,7 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
 		nvme_tcp_teardown_admin_queue(ctrl, false);
 		ret = nvme_tcp_configure_admin_queue(ctrl, false);
 		if (ret)
-			return ret;
+			goto destroy_admin;
 	}
 
 	if (ctrl->icdoff) {
-- 
2.49.0


