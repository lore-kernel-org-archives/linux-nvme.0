Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A11FC021AA
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Feb 2025 17:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=XOM/3cNfrcweRQ8Edju5P9sWQF/1XC5ZNDUONHsiH+E=; b=xjPfpylCpjTadmhWzCAEsOgp70
	VRLyhSaGAUgNJkkiGDLPVdpnyYP7pIqNAV2izKNk36sLbmyZQG+9jalvir5y4G15aOGyMEn7W0Ltw
	ngQcz3pORY3fy9MabxW8rkIYCnRXhtT9Z7DWiTabIAf3NTvD4u+OYOqOIEIWlHzje1YEvIx/sk+Tj
	P8yudCLUE4oFcowh9LXmGelv2Go9yQQfj+pmMwgj/UHKHPXzccXzL6XNgT25K7SsVETG1Np5Q8tk4
	0+uYlrNEF6XrT7gPG+4axIJVoXT8xPyBn0vUCi6Z5DsZdN3bSd1QmWjPqHbbz+XIS+f1vhIcxGvHA
	hPUct1aw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tk4of-00000005QxQ-21mC;
	Mon, 17 Feb 2025 17:21:57 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tk3fj-00000005Czl-02Lk
	for linux-nvme@lists.infradead.org;
	Mon, 17 Feb 2025 16:08:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739808517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XOM/3cNfrcweRQ8Edju5P9sWQF/1XC5ZNDUONHsiH+E=;
	b=atkPOg/wTjaRPWiRAxZrH6IQSXgxqqVizv13KsHL8eLCYe/rmNtrX6fLJvoKjBz5rMNux5
	Ulw8Fy4ELII4rGmATuUNxVbyeBpP9kMHrGWB6lxpZC+onFpayCJNUAnGUKl5rRK+MOwrGC
	+hOBIHbEzTDnb56roEq/WuRsDP7jVRY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-277-J8JgPKk4Nh-Eey3T4-2jDw-1; Mon,
 17 Feb 2025 11:08:35 -0500
X-MC-Unique: J8JgPKk4Nh-Eey3T4-2jDw-1
X-Mimecast-MFC-AGG-ID: J8JgPKk4Nh-Eey3T4-2jDw_1739808513
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CFF501979057;
	Mon, 17 Feb 2025 16:08:32 +0000 (UTC)
Received: from rocky.redhat.com (unknown [10.44.34.9])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EFC93300019E;
	Mon, 17 Feb 2025 16:08:28 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@kernel.org
Cc: axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	hare@kernel.org,
	mlombard@bsdbackstore.eu
Subject: [PATCH V2] nvme-tcp: add basic support for the C2HTermReq PDU
Date: Mon, 17 Feb 2025 17:08:27 +0100
Message-ID: <20250217160827.369977-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5eFTTCUL0pX8U5vrJtdUl3uElPTLor-1t71zhIrEmuY_1739808513
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250217_080839_119137_4AB1193D 
X-CRM114-Status: GOOD (  15.35  )
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

Previously, the NVMe/TCP host driver did not handle the C2HTermReq PDU,
instead printing "unsupported pdu type (3)" when received. This patch adds
support for processing the C2HTermReq PDU, allowing the driver
to print the Fatal Error Status field.

Example of output:
nvme nvme4: Received C2HTermReq (FES = Invalid PDU Header Field)

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---

v2: Skip Header and Data digest checks when receiving a C2HTermReq PDU
    replace "N/A" with "Unknown".

 drivers/nvme/host/tcp.c  | 43 ++++++++++++++++++++++++++++++++++++++++
 include/linux/nvme-tcp.h |  2 ++
 2 files changed, 45 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 841238f38fdd..038b35238c26 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -763,6 +763,40 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
 	return 0;
 }
 
+static void nvme_tcp_handle_c2h_term(struct nvme_tcp_queue *queue,
+		struct nvme_tcp_term_pdu *pdu)
+{
+	u16 fes;
+	const char *msg;
+	u32 plen = le32_to_cpu(pdu->hdr.plen);
+
+	static const char * const msg_table[] = {
+		[NVME_TCP_FES_INVALID_PDU_HDR] = "Invalid PDU Header Field",
+		[NVME_TCP_FES_PDU_SEQ_ERR] = "PDU Sequence Error",
+		[NVME_TCP_FES_HDR_DIGEST_ERR] = "Header Digest Error",
+		[NVME_TCP_FES_DATA_OUT_OF_RANGE] = "Data Transfer Out Of Range",
+		[NVME_TCP_FES_R2T_LIMIT_EXCEEDED] = "R2T Limit Exceeded",
+		[NVME_TCP_FES_UNSUPPORTED_PARAM] = "Unsupported Parameter",
+	};
+
+	if (plen < NVME_TCP_MIN_C2HTERM_PLEN ||
+	    plen > NVME_TCP_MAX_C2HTERM_PLEN) {
+		dev_err(queue->ctrl->ctrl.device,
+			"Received a malformed C2HTermReq PDU (plen = %u)\n",
+			plen);
+		return;
+	}
+
+	fes = le16_to_cpu(pdu->fes);
+	if (fes && fes < ARRAY_SIZE(msg_table))
+		msg = msg_table[fes];
+	else
+		msg = "Unknown";
+
+	dev_err(queue->ctrl->ctrl.device,
+		"Received C2HTermReq (FES = %s)\n", msg);
+}
+
 static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 		unsigned int *offset, size_t *len)
 {
@@ -784,6 +818,15 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 		return 0;
 
 	hdr = queue->pdu;
+	if (unlikely(hdr->type == nvme_tcp_c2h_term)) {
+		/*
+		 * C2HTermReq never includes Header or Data digests.
+		 * Skip the checks.
+		 */
+		nvme_tcp_handle_c2h_term(queue, (void *)queue->pdu);
+		return -EINVAL;
+	}
+
 	if (queue->hdr_digest) {
 		ret = nvme_tcp_verify_hdgst(queue, queue->pdu, hdr->hlen);
 		if (unlikely(ret))
diff --git a/include/linux/nvme-tcp.h b/include/linux/nvme-tcp.h
index e07e8978d691..e435250fcb4d 100644
--- a/include/linux/nvme-tcp.h
+++ b/include/linux/nvme-tcp.h
@@ -13,6 +13,8 @@
 #define NVME_TCP_ADMIN_CCSZ	SZ_8K
 #define NVME_TCP_DIGEST_LENGTH	4
 #define NVME_TCP_MIN_MAXH2CDATA 4096
+#define NVME_TCP_MIN_C2HTERM_PLEN	24
+#define NVME_TCP_MAX_C2HTERM_PLEN	152
 
 enum nvme_tcp_pfv {
 	NVME_TCP_PFV_1_0 = 0x0,
-- 
2.43.5


