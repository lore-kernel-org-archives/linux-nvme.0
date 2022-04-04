Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0193C433F5
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Apr 2022 07:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R/oqiKPMQuk0AzPFn+ktnkm6uUMRIWKvoKiS8GmICHA=; b=dArza3ZPd+HTBJSgFojAWDmqQF
	NETUJhzZ02fHJAx6HxmG22Q4ncDloNVByy3NDxRdhlXH8jaZbDh2xXPjNC5DhbV2Pq1TyqaC6IDWM
	+ppHfe4SAGJhDqneBwaMMLau3av6ZvYsZeGft8M3AQkHDloMtx7ZZ3MhYkam6ZeoG0VZjUVtK1mor
	4wWcDfZUJ+AJ9Voe0JE5Hgzu53xdQEW3W6t82MgMOnbst4Ee1uT8UXWeXgMrvAFkB0/zAAaQnRMB0
	t/RnlTNxXMh/q9OFnEXC55Tr36ikIAZh+9OPwf9hWM8jTGNVOAu8U8T6dm3qCoFWQqLfVfXUewCKp
	+/5MbWQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nbH2D-00Db8b-Uc; Mon, 04 Apr 2022 07:21:57 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nbH2B-00Db81-OA
 for linux-nvme@lists.infradead.org; Mon, 04 Apr 2022 07:21:57 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 0A42068AFE; Mon,  4 Apr 2022 09:21:53 +0200 (CEST)
Date: Mon, 4 Apr 2022 09:21:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, asml.silence@gmail.com,
 ming.lei@redhat.com, mcgrof@kernel.org, pankydev8@gmail.com,
 javier@javigon.com, joshiiitr@gmail.com, anuj20.g@samsung.com
Subject: Re: [RFC 0/5] big-cqe based uring-passthru
Message-ID: <20220404072152.GE444@lst.de>
References: <CGME20220401110829epcas5p39f3cf4d3f6eb8a5c59794787a2b72b15@epcas5p3.samsung.com>
 <20220401110310.611869-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220401110310.611869-1-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220404_002156_121410_7CE5B64E 
X-CRM114-Status: GOOD (  22.77  )
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

I really can't get excited about the pdu thingy.  Here is a patch
(on top of the series and the patch sent in reply to patch 4) that
does away with it and just adds a oob_user field to struct io_uring_cmd
to simplify the handling a fair bit:

---
From 426fa5de1d5f5a718b797eda2fc3ea47010662f7 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Mon, 4 Apr 2022 08:24:43 +0200
Subject: io_uring: explicit support for out of band data in io_uring_cmd

Instead of the magic pdu byte array, which in its current form causes
unaligned pointers and a lot of casting add explicit support for out
of band data in struct io_uring_cmd and just leave a normal private
data pointer to the driver.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/ioctl.c | 35 +++++++----------------------------
 include/linux/io_uring.h  | 10 ++++++++--
 2 files changed, 15 insertions(+), 30 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index ea6cfd4321942..b93c6ecfcd2ab 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -37,27 +37,9 @@ static int nvme_ioctl_finish_metadata(struct bio *bio, int ret,
 	return ret;
 }
 
-/*
- * This overlays struct io_uring_cmd pdu.
- * Expect build errors if this grows larger than that.
- */
-struct nvme_uring_cmd_pdu {
-	union {
-		struct bio *bio;
-		struct request *req;
-	};
-	void __user *meta_buffer;
-} __packed;
-
-static struct nvme_uring_cmd_pdu *nvme_uring_cmd_pdu(struct io_uring_cmd *ioucmd)
-{
-	return (struct nvme_uring_cmd_pdu *)&ioucmd->pdu;
-}
-
 static void nvme_uring_task_cb(struct io_uring_cmd *ioucmd)
 {
-	struct nvme_uring_cmd_pdu *pdu = nvme_uring_cmd_pdu(ioucmd);
-	struct request *req = pdu->req;
+	struct request *req = ioucmd->private;
 	struct bio *bio = req->bio;
 	int status;
 	u64 result;
@@ -71,7 +53,7 @@ static void nvme_uring_task_cb(struct io_uring_cmd *ioucmd)
 	blk_mq_free_request(req);
 	blk_rq_unmap_user(bio);
 
-	status = nvme_ioctl_finish_metadata(bio, status, pdu->meta_buffer);
+	status = nvme_ioctl_finish_metadata(bio, status, ioucmd->oob_user);
 	result = le64_to_cpu(nvme_req(req)->result.u64);
 	io_uring_cmd_done(ioucmd, status, result);
 }
@@ -79,12 +61,10 @@ static void nvme_uring_task_cb(struct io_uring_cmd *ioucmd)
 static void nvme_end_async_pt(struct request *req, blk_status_t err)
 {
 	struct io_uring_cmd *ioucmd = req->end_io_data;
-	struct nvme_uring_cmd_pdu *pdu = nvme_uring_cmd_pdu(ioucmd);
-	/* extract bio before reusing the same field for request */
-	struct bio *bio = pdu->bio;
+	struct bio *bio = ioucmd->private;
 
-	pdu->req = req;
 	req->bio = bio;
+	ioucmd->private = req;
 
 	/* this takes care of moving rest of completion-work to task context */
 	io_uring_cmd_complete_in_task(ioucmd, nvme_uring_task_cb);
@@ -381,7 +361,6 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 {
 	struct nvme_passthru_cmd64 *cmd =
 		(struct nvme_passthru_cmd64 *)ioucmd->cmd;
-	struct nvme_uring_cmd_pdu *pdu = nvme_uring_cmd_pdu(ioucmd);
 	struct request_queue *q = ns ? ns->queue : ctrl->admin_q;
 	struct nvme_command c;
 	struct request *req;
@@ -415,10 +394,10 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 		return PTR_ERR(req);
 
 	/* to free bio on completion, as req->bio will be null at that time */
-	pdu->bio = req->bio;
-	pdu->meta_buffer = nvme_to_user_ptr(cmd->metadata);
-	req->end_io_data = ioucmd;
+	ioucmd->private = req->bio;
+	ioucmd->oob_user = nvme_to_user_ptr(cmd->metadata);
 
+	req->end_io_data = ioucmd;
 	blk_execute_rq_nowait(req, 0, nvme_end_async_pt);
 	return -EIOCBQUEUED;
 }
diff --git a/include/linux/io_uring.h b/include/linux/io_uring.h
index 0aba7b50cde65..95b56e45cd539 100644
--- a/include/linux/io_uring.h
+++ b/include/linux/io_uring.h
@@ -23,8 +23,14 @@ struct io_uring_cmd {
 	u32             flags;
 	u32             cmd_op;
 	u16		cmd_len;
-	u16		unused;
-	u8		pdu[28]; /* available inline for free use */
+
+	void		*private;
+
+	/*
+	 * Out of band data can be used for data that is not the main data.
+	 * E.g. block device PI/metadata or additional information.
+	 */
+	void __user	*oob_user;
 };
 
 #if defined(CONFIG_IO_URING)
-- 
2.30.2


