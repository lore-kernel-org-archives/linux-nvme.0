Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 624F6C28B2E
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Mar 2025 10:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NZCnAOL0SeWf65quH9Oi51y08nslFhOegWHo8dPKp4M=; b=SXd4mHkUQyU8qy1EpdD0OyAzXv
	74bF7FahiXYKoGWs0Dixhonz7X6eXsqCxICGqRR2hUL8YmQRCF0K6jesaKYiEdJ1CGggjb9EDw6pC
	ut+WxUSm7Fpq7k59q9FLKAX96Qz28jlBNVDVlv6DAsidCtSFlHRKQGrlBVjEGkjySqVEBoM1v2Wcx
	OnkrE7lT9CyPFSFqvPg4NvrcbMyXH7sCALe41f1VhEfBzuZ2S5DZN/Gwa5janVWlqMghriohODMJN
	v2W+LjJzVb9tHr0GAL2H4ksTRTJHmhXs9/i9aBG1WZY6f5zRlkXlNyQwUbTYURYmM04Q2e0C8gQt4
	vApNIQLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1trx7d-00000005NE5-2JPL;
	Tue, 11 Mar 2025 10:46:05 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1trx5h-00000005MgJ-3kbP;
	Tue, 11 Mar 2025 10:44:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1741689845; x=1773225845;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qZkpL8+UK4Jf7ALWWjcCeKVGPKdF94sM7MXUzKsePGs=;
  b=PZADjgv4G3FITTrW9KLBdx+x+VK3yg2cg7+N56EAdPt6KvWbgdWI1KDl
   OHokqyHLFcRl1GhbJ4kiqA6cPuVNU2IAM9RHiUOoNxIlzmqovHGrZxLWS
   oYzVxYesv1a2dD7vKrUMYxUq/PbZoSFy4F0sy8cXu6XVZQzEquKz8FhH6
   6PoG8Lx5gIdu9leiIQWrhxwbHEr7JvEI+Co31SgicE14zvKK6DONvf+0B
   s8TlN+1Wk7ppBJ+2/uTnrLl3FRM0pftaN+J5muFSBHmHiq38DH3zT5SOX
   rofeT+1ksCvl+2hTRbRAD8YPMg9tqESwumCnP9WfssaBTeQs8eMaqIdP/
   w==;
X-CSE-ConnectionGUID: dqtqRfg+QA+3atCzb6PFAA==
X-CSE-MsgGUID: 03vgJBvWSX2RVvR+A6o7PQ==
X-IronPort-AV: E=Sophos;i="6.14,238,1736784000"; 
   d="scan'208";a="46946079"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Mar 2025 18:44:05 +0800
IronPort-SDR: 67d00620_r68Ck4ph0IbsWdoeEs6OgV6OcvQHLPeJ/84bMbqQ23oxfjB
 LEdy6yVRRpp44T8dXcxIO5KcM9HUyLW/oo4vv2g==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Mar 2025 02:45:04 -0700
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip01.wdc.com with ESMTP; 11 Mar 2025 03:44:02 -0700
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
	Hannes Reinecke <hare@suse.de>,
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
Subject: [PATCH v2 1/2] nvme: move error logging from nvme_end_req() to __nvme_end_req()
Date: Tue, 11 Mar 2025 19:43:58 +0900
Message-ID: <20250311104359.1767728-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250311104359.1767728-1-shinichiro.kawasaki@wdc.com>
References: <20250311104359.1767728-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250311_034405_931932_B7A44E4A 
X-CRM114-Status: GOOD (  15.52  )
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

Before the Commit 1f47ed294a2b ("block: cleanup and fix batch completion
adding conditions"), blk_mq_add_to_batch() did not add failed
passthrough requests to batch, and returned false. After the commit,
blk_mq_add_to_batch() always adds passthrough requests to batch
regardless of whether the request failed or not, and returns true. This
affected error logging feature in the NVME driver.

Before the commit, the call chain of failed passthrough request was as
follows:

nvme_handle_cqe()
 blk_mq_add_to_batch() .. false is returned, then call nvme_pci_complete_rq()
 nvme_pci_complete_rq()
  nvme_complete_rq()
   nvme_end_req()
    nvme_log_err_passthru() .. error logging
    __nvme_end_req()        .. end of the rqeuest

After the commit, the call chain is as follows:

nvme_handle_cqe()
 blk_mq_add_to_batch() .. true is returned, then set nvme_pci_complete_batch()
 ..
 nvme_pci_complete_batch()
  nvme_complete_batch()
   nvme_complete_batch_req()
    __nvme_end_req() .. end of the request, without error logging

To make the error logging feature work again for passthrough requests, move the
nvme_log_err_passthru() call from nvme_end_req() to __nvme_end_req().

While at it, move nvme_log_error() call for non-passthrough requests together
with nvme_log_err_passthru(). Even though the trigger commit does not affect
non-passthrough requests, move it together for code simplicity.

Fixes: 1f47ed294a2b ("block: cleanup and fix batch completion adding conditions")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f028913e2e62..8359d0aa0e44 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -431,6 +431,12 @@ static inline void nvme_end_req_zoned(struct request *req)
 
 static inline void __nvme_end_req(struct request *req)
 {
+	if (unlikely(nvme_req(req)->status && !(req->rq_flags & RQF_QUIET))) {
+		if (blk_rq_is_passthrough(req))
+			nvme_log_err_passthru(req);
+		else
+			nvme_log_error(req);
+	}
 	nvme_end_req_zoned(req);
 	nvme_trace_bio_complete(req);
 	if (req->cmd_flags & REQ_NVME_MPATH)
@@ -441,12 +447,6 @@ void nvme_end_req(struct request *req)
 {
 	blk_status_t status = nvme_error_status(nvme_req(req)->status);
 
-	if (unlikely(nvme_req(req)->status && !(req->rq_flags & RQF_QUIET))) {
-		if (blk_rq_is_passthrough(req))
-			nvme_log_err_passthru(req);
-		else
-			nvme_log_error(req);
-	}
 	__nvme_end_req(req);
 	blk_mq_end_request(req, status);
 }
-- 
2.47.0


