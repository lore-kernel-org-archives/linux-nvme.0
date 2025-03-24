Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBF47C36013
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Mar 2025 10:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q6foHnbzXmY5Zr8M56UxpvuEJtEqEaIjg/PBwX/DniM=; b=420QpkfMUEPHnUuFpxPGp+wmN/
	lKqhaXDLF1DgEq4ceHN7BDuWVrcivsjWCJnhN5Lstkn0EsENgedQjFP0yVINKCJTUdpwUMKH2JNPO
	OYoKWWpl/wXXDaUlDH6V9ep5dpggtJ1oDuwT87hTfajcbACuNG3vR1cbAI+musI/fcPwbhgLf+cVX
	JOgT1u2Z8V+Gq5QsZIDN6jbcPEnqPscDG9bmNFtF0oaS3d3dCkNvGZHy8g4uRUTec0l/krNYgLS3l
	9Xfz+dfYXyNVtCcg2qPbGrnFNGAq7AoIjRFhRFmVK7/qK0230lvGR8ySAWGiVGMOeYZJdZqUXeJ2M
	pjz6nWJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tweyz-00000002oSL-1Gs8;
	Mon, 24 Mar 2025 10:24:37 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tweyF-00000002oGs-0QEK
	for linux-nvme@lists.infradead.org;
	Mon, 24 Mar 2025 10:23:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742811830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q6foHnbzXmY5Zr8M56UxpvuEJtEqEaIjg/PBwX/DniM=;
	b=LDmO4R+I2sE2Z3+26S+I4Vm68+ocVjd23Kq3VGhnWoYOWs33RNQgGxVnMoEmwWsPXCwD8h
	cvpGtdR+s0CNEispH9ecdr1I6eV4FN9AswzqZr5xTwEHw3SLpGuuBvRbPs5LFijRSpw4LL
	ZUKsuASVMjj6Ko42hWVbk+mSu9KSXaE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-44-fuGm23XQNlWD4S0eEi9VTw-1; Mon,
 24 Mar 2025 06:23:49 -0400
X-MC-Unique: fuGm23XQNlWD4S0eEi9VTw-1
X-Mimecast-MFC-AGG-ID: fuGm23XQNlWD4S0eEi9VTw_1742811828
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2A23418EBE99;
	Mon, 24 Mar 2025 10:23:48 +0000 (UTC)
Received: from rocky.redhat.com (unknown [10.47.238.77])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 851E3180B488;
	Mon, 24 Mar 2025 10:23:45 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: sagi@grimberg.me
Cc: kbusch@kernel.org,
	linux-nvme@lists.infradead.org,
	jmeneghi@redhat.com,
	hare@suse.de,
	cleech@redhat.com
Subject: [PATCH RFC v3 09/11] nvmet: delay requests
Date: Mon, 24 Mar 2025 11:23:08 +0100
Message-ID: <20250324102310.658007-10-mlombard@redhat.com>
In-Reply-To: <20250324102310.658007-1-mlombard@redhat.com>
References: <20250324102310.658007-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OIO5kol-TtxHvgL329SXMs-GWYx8Zz0Sc30GaboDOPw_1742811828
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250324_032351_205459_D2C2DB06 
X-CRM114-Status: GOOD (  13.31  )
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

Allow requests to be delayed for testing.

Signed-off-by: Chris Leech <cleech@redhat.com>
---
 drivers/nvme/target/core.c  | 30 ++++++++++++++++++++++++++++++
 drivers/nvme/target/nvmet.h |  8 ++++++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 3e22dacddd76..5622b0608d55 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -6,7 +6,9 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 #include <linux/module.h>
 #include <linux/random.h>
+#include <linux/jiffies.h>
 #include <linux/rculist.h>
+#include <linux/workqueue.h>
 #include <linux/pci-p2pdma.h>
 #include <linux/scatterlist.h>
 
@@ -1753,6 +1755,34 @@ ssize_t nvmet_ctrl_host_traddr(struct nvmet_ctrl *ctrl,
 	return ctrl->ops->host_traddr(ctrl, traddr, traddr_len);
 }
 
+#if IS_ENABLED(CONFIG_NVME_TARGET_DELAY_REQUESTS)
+static void nvmet_delayed_execute_req(struct work_struct *work) {
+	struct nvmet_req *req =
+		container_of(to_delayed_work(work), struct nvmet_req, req_work);
+	req->execute(req);
+}
+
+void nvmet_execute_request(struct nvmet_req *req) {
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	int delay_count;
+	u32 delay_msec;
+
+	if (unlikely(req->sq->qid == 0))
+		return req->execute(req);
+
+	if (ctrl) {
+		delay_count = atomic_dec_if_positive(&ctrl->delay_count) + 1;
+		delay_msec = ctrl->delay_msec;
+	}
+	if (!(ctrl && delay_count && delay_msec))
+		return req->execute(req);
+
+	INIT_DELAYED_WORK(&req->req_work, nvmet_delayed_execute_req);
+	queue_delayed_work(nvmet_wq, &req->req_work, msecs_to_jiffies(delay_msec));
+}
+EXPORT_SYMBOL_GPL(nvmet_execute_request);
+#endif
+
 static struct nvmet_subsys *nvmet_find_get_subsys(struct nvmet_port *port,
 		const char *subsysnqn)
 {
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 7a360285b254..1bfdddceda15 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -496,6 +496,9 @@ struct nvmet_req {
 	u16			error_loc;
 	u64			error_slba;
 	struct nvmet_pr_per_ctrl_ref *pc_ref;
+#if IS_ENABLED(CONFIG_NVME_TARGET_DELAY_REQUESTS)
+	struct delayed_work	req_work;
+#endif
 };
 
 #define NVMET_MAX_MPOOL_BVEC		16
@@ -971,5 +974,10 @@ struct nvmet_feat_arbitration {
 	u8		ab;
 };
 
+#if IS_ENABLED(CONFIG_NVME_TARGET_DELAY_REQUESTS)
+void nvmet_execute_request(struct nvmet_req *req);
+#else
 static inline void nvmet_execute_request(struct nvmet_req *req) { req->execute(req); }
+#endif
+
 #endif /* _NVMET_H */
-- 
2.43.5


