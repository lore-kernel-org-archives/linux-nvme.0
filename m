Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73314C282EC
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Mar 2025 10:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KMMFank+BVa5yM0jNr8Lz7M2ib4O7ZxzsnpYwkdR2XA=; b=azbV/GogIBzinGoLDibx7A9Jnd
	vozQ/jrIW04IcLOg4TA91/AczUVkc4UBBjVrofQvwgd2fGNUQ9wlbmv+v6hw/uIc2+M28/Z5gbi+p
	ozZcI/YQJDkRUmtNAw4jXYsq3w82alOyaIGFaLN7BxjPHn+QtEZ06PBMy3v43doa98GgfxU4GFwnT
	vRF5jAEZylqSUaLI7HMeMQ3DEcTYq8xksa9p10C5+MCYYpjU4lLrQyrFD4umnCmtyc9tjuK/7uQ9h
	BkIL5A4ZpNGaYGKyx3goQRm0TnN0k2OETWoehhjvmau0WpP39uGZOlaVMaOX9BnHkHI3/FWj8uCQY
	+NBfMuHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1trx9F-00000005NRj-3dnD;
	Tue, 11 Mar 2025 10:47:45 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1trx5k-00000005Mh9-2NZQ;
	Tue, 11 Mar 2025 10:44:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1741689848; x=1773225848;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V/8yzlzSQwzG4hlLjx8C1beV8wQX1kn+h5Nq6Xl7qMs=;
  b=ZhYxbg1THQwRGzMljw+hntkc+F3kYU2slaQKE2EePoNFjAp1lviMA/Yg
   dkkDIsxpePQEsrAIBOWTmV58ic7F6D6XaNGrlhyUy8bF6DZSYw5XIQY/c
   VROD2uQNURIS7s7wTEuDEPXfm1o0KOiYl4j62bugVg1Kz7k8pkbnqAl2G
   oEqesXj3GJd+yPprw3Xvlf+ynxNxnirRSA0lRhck+4Kt34kfKdIedqnK1
   KzeTPraLPdO+jQMBNYe8FP0LbHb/11BRz3wF6tbDhFqOYRC/I8paLvUJO
   7ZdOtQ6AzwDh7tIzY+2Br1ZaRmd2KTEdDWrmuN3fMnAHGkUPwoDJTDYfz
   Q==;
X-CSE-ConnectionGUID: vxJUkhgeQ7GuKFJZoYYdNw==
X-CSE-MsgGUID: aYkxSbmFTTGVEwKn6HkGfw==
X-IronPort-AV: E=Sophos;i="6.14,238,1736784000"; 
   d="scan'208";a="46946110"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Mar 2025 18:44:08 +0800
IronPort-SDR: 67d00622_3ySvhWOAGKOFvYKNrE2sggdcuj5T8rtsDGG3MBlGHKsXjZL
 GTbZVMFNe9ZakcF/LYqsKgDvNy3UIj9ax4umZkg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Mar 2025 02:45:06 -0700
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip01.wdc.com with ESMTP; 11 Mar 2025 03:44:05 -0700
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
Subject: [PATCH v2 2/2] block: change blk_mq_add_to_batch() third argument type to bool
Date: Tue, 11 Mar 2025 19:43:59 +0900
Message-ID: <20250311104359.1767728-3-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250311104359.1767728-1-shinichiro.kawasaki@wdc.com>
References: <20250311104359.1767728-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250311_034408_607834_377A1536 
X-CRM114-Status: GOOD (  19.78  )
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
conditions") modified the evaluation criteria for the third argument,
'ioerror', in the blk_mq_add_to_batch() function. Initially, the
function had checked if 'ioerror' equals zero. Following the commit, it
started checking for negative error values, with the presumption that
such values, for instance -EIO, would be passed in.

However, blk_mq_add_to_batch() callers do not pass negative error
values. Instead, they pass status codes defined in various ways:

- NVMe PCI and Apple drivers pass NVMe status code
- virtio_blk driver passes the virtblk request header status byte
- null_blk driver passes blk_status_t

These codes are either zero or positive, therefore the revised check
fails to function as intended. Specifically, with the NVMe PCI driver,
this modification led to the failure of the blktests test case nvme/039.
In this test scenario, errors are artificially injected to the NVMe
driver, resulting in positive NVMe status codes passed to
blk_mq_add_to_batch(), which unexpectedly processes the failed I/O in a
batch. Hence the failure.

To correct the ioerror check within blk_mq_add_to_batch(), make all
callers to uniformly pass the argument as boolean. Modify the callers to
check their specific status codes and pass the boolean value 'is_error'.
Also describe the arguments of blK_mq_add_to_batch as kerneldoc.

Fixes: 1f47ed294a2b ("block: cleanup and fix batch completion adding conditions")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 drivers/block/null_blk/main.c |  4 ++--
 drivers/block/virtio_blk.c    |  5 +++--
 drivers/nvme/host/apple.c     |  3 ++-
 drivers/nvme/host/pci.c       |  5 +++--
 include/linux/blk-mq.h        | 11 ++++++++---
 5 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index d94ef37480bd..fdc7a0b2af10 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1549,8 +1549,8 @@ static int null_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
 		cmd = blk_mq_rq_to_pdu(req);
 		cmd->error = null_process_cmd(cmd, req_op(req), blk_rq_pos(req),
 						blk_rq_sectors(req));
-		if (!blk_mq_add_to_batch(req, iob, (__force int) cmd->error,
-					blk_mq_end_request_batch))
+		if (!blk_mq_add_to_batch(req, iob, cmd->error != BLK_STS_OK,
+					 blk_mq_end_request_batch))
 			blk_mq_end_request(req, cmd->error);
 		nr++;
 	}
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 6a61ec35f426..91cde76a4b3e 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1207,11 +1207,12 @@ static int virtblk_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
 
 	while ((vbr = virtqueue_get_buf(vq->vq, &len)) != NULL) {
 		struct request *req = blk_mq_rq_from_pdu(vbr);
+		u8 status = virtblk_vbr_status(vbr);
 
 		found++;
 		if (!blk_mq_complete_request_remote(req) &&
-		    !blk_mq_add_to_batch(req, iob, virtblk_vbr_status(vbr),
-						virtblk_complete_batch))
+		    !blk_mq_add_to_batch(req, iob, status != VIRTIO_BLK_S_OK,
+					 virtblk_complete_batch))
 			virtblk_request_done(req);
 	}
 
diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index a060f69558e7..8971aca41e63 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -599,7 +599,8 @@ static inline void apple_nvme_handle_cqe(struct apple_nvme_queue *q,
 	}
 
 	if (!nvme_try_complete_req(req, cqe->status, cqe->result) &&
-	    !blk_mq_add_to_batch(req, iob, nvme_req(req)->status,
+	    !blk_mq_add_to_batch(req, iob,
+				 nvme_req(req)->status != NVME_SC_SUCCESS,
 				 apple_nvme_complete_batch))
 		apple_nvme_complete_rq(req);
 }
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 640590b21728..75de86e235ad 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1130,8 +1130,9 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq,
 
 	trace_nvme_sq(req, cqe->sq_head, nvmeq->sq_tail);
 	if (!nvme_try_complete_req(req, cqe->status, cqe->result) &&
-	    !blk_mq_add_to_batch(req, iob, nvme_req(req)->status,
-					nvme_pci_complete_batch))
+	    !blk_mq_add_to_batch(req, iob,
+				 nvme_req(req)->status != NVME_SC_SUCCESS,
+				 nvme_pci_complete_batch))
 		nvme_pci_complete_rq(req);
 }
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 71f4f0cc3dac..d904e870e72d 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -855,9 +855,14 @@ static inline bool blk_mq_is_reserved_rq(struct request *rq)
 /*
  * Batched completions only work when there is no I/O error and no special
  * ->end_io handler.
+ *
+ * @req: The request to add to batch
+ * @iob: The batch to add the request
+ * @is_error: Specify true if the request failed with an error
+ * @io_comp_batch: The completaion handler for the request
  */
 static inline bool blk_mq_add_to_batch(struct request *req,
-				       struct io_comp_batch *iob, int ioerror,
+				       struct io_comp_batch *iob, bool is_error,
 				       void (*complete)(struct io_comp_batch *))
 {
 	/*
@@ -865,7 +870,7 @@ static inline bool blk_mq_add_to_batch(struct request *req,
 	 * 1) No batch container
 	 * 2) Has scheduler data attached
 	 * 3) Not a passthrough request and end_io set
-	 * 4) Not a passthrough request and an ioerror
+	 * 4) Not a passthrough request and failed with an error
 	 */
 	if (!iob)
 		return false;
@@ -874,7 +879,7 @@ static inline bool blk_mq_add_to_batch(struct request *req,
 	if (!blk_rq_is_passthrough(req)) {
 		if (req->end_io)
 			return false;
-		if (ioerror < 0)
+		if (is_error)
 			return false;
 	}
 
-- 
2.47.0


