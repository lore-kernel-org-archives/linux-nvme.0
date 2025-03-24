Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9C79C36002
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Mar 2025 10:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4OFcTnVhgU0nSguQK3Fdq2GmunO6SNz0VfmUj8GqK7M=; b=lcWIvQjZ5VQC6H4oUFz7QcIuAi
	zvB2t578G9CDMh2siCWokPw/3lk+NcmG/3xhYg+BZ0n1b7dxzQhMHvZ23y6l65XHeQ69Jvquz1yCv
	8iZcP46AGKSkCzNo6Y2vM6rfDHKooyuHqBRUhH+wUlK3HjQkf3LpiHOXEd+lLzKUMMNh7CF4xFwWL
	dWbkEqtrxxiNTAHaRQLphfZcYdcrXW9zEhQ1pVE/wjLvugDSvOrdS2reHq3fZ4CPLTagnU/wEkTYH
	KosJWFL5kZ9xMn6htpeEXFmmv7tcctC6UG0JflRI8jMgNt31scdA8LC55PcqgRVh1NRlHW/EcF8qc
	mOqT5czg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1twez0-00000002oTW-0GgM;
	Mon, 24 Mar 2025 10:24:38 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tweyN-00000002oIe-0etg
	for linux-nvme@lists.infradead.org;
	Mon, 24 Mar 2025 10:24:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742811838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4OFcTnVhgU0nSguQK3Fdq2GmunO6SNz0VfmUj8GqK7M=;
	b=EapGJG4JH15pEMAeaDfcpSIwkKlxRF2Nfzg4B8qXyn996Wedn9F9YwYupoE6JNzwaaCyCU
	xGZ0WhE0IRHYYejO5IzLoVYQURRi/jorB/gqL5MjE+P01wK/HDnGdtA3O+/6fxNpGpli0W
	HzjAAb13Pn8P7hPMotXV4TtYyt62bfI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-364-RILudQVHNEGyKV_a8wr0Eg-1; Mon,
 24 Mar 2025 06:23:53 -0400
X-MC-Unique: RILudQVHNEGyKV_a8wr0Eg-1
X-Mimecast-MFC-AGG-ID: RILudQVHNEGyKV_a8wr0Eg_1742811831
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6B91D180025A;
	Mon, 24 Mar 2025 10:23:51 +0000 (UTC)
Received: from rocky.redhat.com (unknown [10.47.238.77])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C52B2180A801;
	Mon, 24 Mar 2025 10:23:48 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: sagi@grimberg.me
Cc: kbusch@kernel.org,
	linux-nvme@lists.infradead.org,
	jmeneghi@redhat.com,
	hare@suse.de,
	cleech@redhat.com
Subject: [PATCH RFC v3 10/11] nvmet: command tracking
Date: Mon, 24 Mar 2025 11:23:09 +0100
Message-ID: <20250324102310.658007-11-mlombard@redhat.com>
In-Reply-To: <20250324102310.658007-1-mlombard@redhat.com>
References: <20250324102310.658007-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ayZDWKcQjmkk0eefnoJNW2PV_BWJh3W6G7i-zsMKJ68_1742811831
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250324_032359_263492_C950308A 
X-CRM114-Status: GOOD (  14.38  )
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

From: Chris Leech <cleech@redhat.com>

Enable tracking of all outstanding requests in an XArray

Signed-off-by: Chris Leech <cleech@redhat.com>
---
 drivers/nvme/target/core.c  | 29 ++++++++++++++++++++++++++++-
 drivers/nvme/target/nvmet.h |  4 ++++
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 5622b0608d55..b446db3804f1 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -809,10 +809,23 @@ static void __nvmet_req_complete(struct nvmet_req *req, u16 status)
 		nvmet_put_namespace(ns);
 }
 
+#if IS_ENABLED(CONFIG_NVME_TARGET_DELAY_REQUESTS)
+static void nvmet_delayed_execute_req(struct work_struct *work);
+#endif
+
 void nvmet_req_complete(struct nvmet_req *req, u16 status)
 {
 	struct nvmet_sq *sq = req->sq;
+#if IS_ENABLED(CONFIG_NVME_TARGET_DELAY_REQUESTS)
+	unsigned long flags;
 
+	/* only need to update the xarray if this was a delayed request */
+	if (req->req_work.work.func == nvmet_delayed_execute_req) {
+		xa_lock_irqsave(&sq->outstanding_requests, flags);
+		__xa_erase(&sq->outstanding_requests, req->cmd->common.command_id);
+		xa_unlock_irqrestore(&sq->outstanding_requests, flags);
+	}
+#endif
 	__nvmet_req_complete(req, status);
 	percpu_ref_put(&sq->ref);
 }
@@ -984,7 +997,9 @@ int nvmet_sq_init(struct nvmet_sq *sq)
 	init_completion(&sq->free_done);
 	init_completion(&sq->confirm_done);
 	nvmet_auth_sq_init(sq);
-
+#if IS_ENABLED(CONFIG_NVME_TARGET_DELAY_REQUESTS)
+	xa_init_flags(&sq->outstanding_requests, XA_FLAGS_LOCK_IRQ);
+#endif
 	return 0;
 }
 EXPORT_SYMBOL_GPL(nvmet_sq_init);
@@ -1766,6 +1781,7 @@ void nvmet_execute_request(struct nvmet_req *req) {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	int delay_count;
 	u32 delay_msec;
+	unsigned long flags;
 
 	if (unlikely(req->sq->qid == 0))
 		return req->execute(req);
@@ -1777,6 +1793,17 @@ void nvmet_execute_request(struct nvmet_req *req) {
 	if (!(ctrl && delay_count && delay_msec))
 		return req->execute(req);
 
+	xa_lock_irqsave(&req->sq->outstanding_requests, flags);
+	int ret = __xa_insert(&req->sq->outstanding_requests,
+			    req->cmd->common.command_id, req, GFP_KERNEL);
+	xa_unlock_irqrestore(&req->sq->outstanding_requests, flags);
+
+	if (ret) {
+		pr_err("nvmet: failure to delay command %d",
+		       req->cmd->common.command_id);
+		return req->execute(req);
+	}
+
 	INIT_DELAYED_WORK(&req->req_work, nvmet_delayed_execute_req);
 	queue_delayed_work(nvmet_wq, &req->req_work, msecs_to_jiffies(delay_msec));
 }
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 1bfdddceda15..fc61f28c63da 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -172,6 +172,9 @@ struct nvmet_sq {
 #endif
 	struct completion	free_done;
 	struct completion	confirm_done;
+#if IS_ENABLED(CONFIG_NVME_TARGET_DELAY_REQUESTS)
+	struct xarray		outstanding_requests;
+#endif
 };
 
 struct nvmet_ana_group {
@@ -573,6 +576,7 @@ size_t nvmet_req_transfer_len(struct nvmet_req *req);
 bool nvmet_check_transfer_len(struct nvmet_req *req, size_t len);
 bool nvmet_check_data_len_lte(struct nvmet_req *req, size_t data_len);
 void nvmet_req_complete(struct nvmet_req *req, u16 status);
+void nvmet_req_complete_delayed(struct nvmet_req *req, u16 status);
 int nvmet_req_alloc_sgls(struct nvmet_req *req);
 void nvmet_req_free_sgls(struct nvmet_req *req);
 
-- 
2.43.5


