Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B3AC47079
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Jan 2024 08:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=GX1ImOrc6jlc5HF51JSkgp1wFvx8oJcDTj+AKpjJd14=; b=rEHktazgWX6qsabi86do27vjIM
	5YG3oITOoHJeBzd5i5kwR6HlfuQbvUD7r3hFhj9E+IHPeJzQNIemCggx9kivkoFF/Nv00kWtI6aVp
	mcavXDoIuFwYBCWNn+y/N+Xo0tAZxCEM0N5/GpeyLH2C6YeJalkcFGHLOOUx3fwXKu5Lj2msB7mtk
	SeRsHm/MfDscZ08J3VkmMPyLglELNIylYQTzG4PmaE3CUy5HwPVM303IKBwBybmdwqNAvZ/mGPtkg
	ktGTOCmm8eC6A9y0HCelw67TVELSu9EMAWXAksUblquK5SGNZTmXQYe5L1IcRW1yGCoZemDV04YvU
	GDYf5rUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLfLz-00GDWg-2s;
	Fri, 05 Jan 2024 08:14:55 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLfLw-00GDVV-2J
	for linux-nvme@lists.infradead.org;
	Fri, 05 Jan 2024 08:14:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704442489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GX1ImOrc6jlc5HF51JSkgp1wFvx8oJcDTj+AKpjJd14=;
	b=BogqwYv4drTDPH8QgKDPt7sqvB2M3YmAQrg6ASfJmTV6lIVq6TdLMx1smM5s9IxCu++DaV
	JJ45AYMjLvqCreRXMueWvuS18BcWdfX5qWtsSXXBbbNBsZfdXRI6G5A02vaRWoAdcH27n+
	6dKiWJw0AiXeI76AsQ7enxqjn49hYiI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-119-yIMKJNfoP9eJdRc-6MlZHg-1; Fri,
 05 Jan 2024 03:14:47 -0500
X-MC-Unique: yIMKJNfoP9eJdRc-6MlZHg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7C8BD2812940;
	Fri,  5 Jan 2024 08:14:47 +0000 (UTC)
Received: from kalibr.redhat.com (unknown [10.47.238.82])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BD720C15A0C;
	Fri,  5 Jan 2024 08:14:45 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: sagi@grimberg.me
Cc: zahavi.alon@gmail.com,
	chaitanyak@nvidia.com,
	linux-nvme@lists.infradead.org,
	kbusch@kernel.org
Subject: [PATCH V2] nvmet-tcp: Fix the H2C expected PDU len calculation
Date: Fri,  5 Jan 2024 09:14:44 +0100
Message-Id: <20240105081444.172961-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240105_001452_845978_260E59D0 
X-CRM114-Status: GOOD (  12.45  )
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

The nvmet_tcp_handle_h2c_data_pdu() function should take into
consideration the possibility that the header digest and/or the data
digests are enabled when calculating the expected PDU length, before
comparing it to the value stored in cmd->pdu_len.

Fixes: efa56305908b ("nvmet-tcp: Fix a kernel panic when host sends an invalid H2C PDU length")
Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---

v2: change the variable name, minor code style fixes.

 drivers/nvme/target/tcp.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 3569c1255c5e..4566be0ffe06 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -979,7 +979,7 @@ static int nvmet_tcp_handle_h2c_data_pdu(struct nvmet_tcp_queue *queue)
 {
 	struct nvme_tcp_data_pdu *data = &queue->pdu.data;
 	struct nvmet_tcp_cmd *cmd;
-	unsigned int plen;
+	unsigned int exp_data_len;
 
 	if (likely(queue->nr_cmds)) {
 		if (unlikely(data->ttag >= queue->nr_cmds)) {
@@ -999,9 +999,13 @@ static int nvmet_tcp_handle_h2c_data_pdu(struct nvmet_tcp_queue *queue)
 		goto err_proto;
 	}
 
-	plen = le32_to_cpu(data->hdr.plen);
+	exp_data_len = le32_to_cpu(data->hdr.plen) -
+			nvmet_tcp_hdgst_len(queue) -
+			nvmet_tcp_ddgst_len(queue) -
+			sizeof(*data);
+
 	cmd->pdu_len = le32_to_cpu(data->data_length);
-	if (unlikely(cmd->pdu_len != (plen - sizeof(*data)) ||
+	if (unlikely(cmd->pdu_len != exp_data_len ||
 		     cmd->pdu_len == 0 ||
 		     cmd->pdu_len > NVMET_TCP_MAXH2CDATA)) {
 		pr_err("H2CData PDU len %u is invalid\n", cmd->pdu_len);
-- 
2.39.3


