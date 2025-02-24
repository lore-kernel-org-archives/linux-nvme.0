Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C187C021B5
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2025 11:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2s4Slpvg23Q8+W64pDcpTsIacl0lFncqCWszfdy/rSk=; b=c0dkFJxaSMKVMp+hRSW+iyOyaD
	8ZAxtMqHzdT9wBATvw1I5EO4H6rm9Xx9QAr4512y5swcYDgnoTUcpRHO5DCWEVasg8ZEXOmyir7IP
	jerBHaaGUwvbB6hwTF+Gs70KoiEAV7YGzGoQkANlxI4rB/dyTZWJGw1HA7KgV5oDynvoJJfh4HfHL
	y3IUSyPT+T9tDix4SHQXItfS6xIrW7Q+N6r926kIHWqJNCUIEYHGnCFvdt6zxKxq1h7PjtLhsiPht
	JrJa/Q98rnPI7+OB3mNivQnQnMZ1yvNvR9qWUtCrgX66h17QRf595Ep4agUX3NM3AL0zs3Yw7cSCx
	diZpBFbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmWjN-0000000DQNd-497c;
	Mon, 24 Feb 2025 11:34:37 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmWVe-0000000DKOq-2gna
	for linux-nvme@lists.infradead.org;
	Mon, 24 Feb 2025 11:20:27 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 31FBE5C6A59;
	Mon, 24 Feb 2025 11:19:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BD58C4CEEB;
	Mon, 24 Feb 2025 11:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740396025;
	bh=bwWqZcqslCrnTxZAJGJxH75X7i7Q0AGJPhsWGc/FhxM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qLo0ACEmS9Fc4iDoXuLQ/xNQTnp12A3axuaBdzOZ7quo+PavVlpbQIpHJULEg9cpF
	 hjed1cfDT383hGo/+r5E67h0dSeeUHzrrA1M/FgNQg23yvvCFkHkiu3TYMzp0HH+Cu
	 ySi7tbzjn1PEXWZmgFOYrVOCxS0svy7qcU83spiKgfq/wD/f4RMp/7fb6MT8035pTx
	 yNOULhTP6nsgSMuoHj4bdxaQi3c4UXTBBdDj8fe8IniE3Agcul7W4JbQxsy/WC/i/q
	 LDJe8mu1mhbFHHer1wG4SgyQ7iLf1mYBy5HZfiLtM6Tkj+S++vxxsCR5qI5x6s0g8O
	 ncOVEGvuPvUmQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Maurizio Lombardi <mlombard@redhat.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 09/12] nvme-tcp: add basic support for the C2HTermReq PDU
Date: Mon, 24 Feb 2025 06:19:57 -0500
Message-Id: <20250224112002.2214613-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224112002.2214613-1-sashal@kernel.org>
References: <20250224112002.2214613-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.129
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250224_032026_769330_F899D35C 
X-CRM114-Status: GOOD (  15.38  )
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

From: Maurizio Lombardi <mlombard@redhat.com>

[ Upstream commit 84e009042d0f3dfe91bec60bcd208ee3f866cbcd ]

Previously, the NVMe/TCP host driver did not handle the C2HTermReq PDU,
instead printing "unsupported pdu type (3)" when received. This patch adds
support for processing the C2HTermReq PDU, allowing the driver
to print the Fatal Error Status field.

Example of output:
nvme nvme4: Received C2HTermReq (FES = Invalid PDU Header Field)

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/tcp.c  | 43 ++++++++++++++++++++++++++++++++++++++++
 include/linux/nvme-tcp.h |  2 ++
 2 files changed, 45 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 29489c2c52fb9..f7ef727ee44e3 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -694,6 +694,40 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
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
@@ -715,6 +749,15 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
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
index 57ebe1267f7fb..0278ce3ad1fbd 100644
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
2.39.5


