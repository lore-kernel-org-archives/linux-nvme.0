Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B23EC47074
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jan 2024 11:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=QMGe0KHYdbZeRShVRKJfpLb+IJ0FpYnaN+RV0bx4wG4=; b=XLGKSdkAWJVCAISzv1hVvL8kb4
	Ji5al7HVZWwRO1fTK1VZDTz5dMzfjWEu9WsnfcUAL/tNOXX7umHBQvjl6NfG+JdA2I/6YWx0CWKgS
	6xjvf553W2+Favfv7BqgBJVaggO59Cvgxrp1y8wDsWsEAspzzQIWWmNqP6iDnvis1iE8Y8gCN5U49
	y7e+iHEU98fnYqHxuTv20b9A885e32bG/Vt8OBfl0YRuWyws+owXckcaAyWCuFZ+lw9hGGsT/w4mo
	h6DTbpU1zO6D69dxQRgpo3DnMDQAacZlTE0cHqUjwdYkBjg2VMAaMkv/Hqx5eHWutqh8eAZaT2aTb
	eo5FCXzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rKz6i-00ATT5-2l;
	Wed, 03 Jan 2024 11:08:20 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rKz6f-00ATSa-2i
	for linux-nvme@lists.infradead.org;
	Wed, 03 Jan 2024 11:08:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704280091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QMGe0KHYdbZeRShVRKJfpLb+IJ0FpYnaN+RV0bx4wG4=;
	b=OW+z+WkbDopxmGzXNVdoRp8UbY2EaZxoZONlE1jW5BamlhqZWCo8erAMFPDkVIfgl4smne
	63OPIyZYOq+cFgavFZIZnOxc679mnxNBomgQHBbmVq7aSnUN+WwY5oBR/GTmDrBV1EPTk2
	rVkVrhgWrjvSKTyA8ormfnLEVk7rlZQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-_X0UJI7xNy6smYkMD2RnxQ-1; Wed, 03 Jan 2024 06:08:08 -0500
X-MC-Unique: _X0UJI7xNy6smYkMD2RnxQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1BF37101AA6A;
	Wed,  3 Jan 2024 11:08:08 +0000 (UTC)
Received: from kalibr.redhat.com (unknown [10.47.238.82])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 570953C27;
	Wed,  3 Jan 2024 11:08:06 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: sagi@grimberg.me
Cc: zahavi.alon@gmail.com,
	chaitanyak@nvidia.com,
	linux-nvme@lists.infradead.org,
	kbusch@kernel.org
Subject: [PATCH] nvmet-tcp: Fix the H2C expected PDU len calculation
Date: Wed,  3 Jan 2024 12:08:04 +0100
Message-Id: <20240103110804.129921-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240103_030817_977529_965446A1 
X-CRM114-Status: GOOD (  12.38  )
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
digests are enabled when calculating the expected PDU length before
comparing it to the value stored in cmd->pdu_len.

Fixes: efa56305908b ("nvmet-tcp: Fix a kernel panic when host sends an invalid H2C PDU length")
Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/target/tcp.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 3569c1255c5e..717ea1e5f4c3 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -979,7 +979,7 @@ static int nvmet_tcp_handle_h2c_data_pdu(struct nvmet_tcp_queue *queue)
 {
 	struct nvme_tcp_data_pdu *data = &queue->pdu.data;
 	struct nvmet_tcp_cmd *cmd;
-	unsigned int plen;
+	unsigned int expected_len;
 
 	if (likely(queue->nr_cmds)) {
 		if (unlikely(data->ttag >= queue->nr_cmds)) {
@@ -999,9 +999,12 @@ static int nvmet_tcp_handle_h2c_data_pdu(struct nvmet_tcp_queue *queue)
 		goto err_proto;
 	}
 
-	plen = le32_to_cpu(data->hdr.plen);
+	expected_len = le32_to_cpu(data->hdr.plen);
+	expected_len -= nvmet_tcp_hdgst_len(queue);
+	expected_len -= nvmet_tcp_ddgst_len(queue);
+	expected_len -= sizeof(*data);
 	cmd->pdu_len = le32_to_cpu(data->data_length);
-	if (unlikely(cmd->pdu_len != (plen - sizeof(*data)) ||
+	if (unlikely(cmd->pdu_len != expected_len ||
 		     cmd->pdu_len == 0 ||
 		     cmd->pdu_len > NVMET_TCP_MAXH2CDATA)) {
 		pr_err("H2CData PDU len %u is invalid\n", cmd->pdu_len);
-- 
2.39.3


