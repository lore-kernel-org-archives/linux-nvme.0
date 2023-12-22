Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4CA1C46CD2
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Dec 2023 15:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PwLVvz4d5auqCH3ftD3xdgBYCz6pCS3SHGPQA3ASv60=; b=MBULxtRteE82wdDpw9bW9tr2FH
	wv85x6wNeA1aB+8sjh9mLsjvpv5EmBo77XqRc57cpNkMQWrzXNdMtYeqhwWzu3Qgb7WvWOiBe+xiY
	xOUgTel9/Vw662/ysS6cyyG4fwXOjoEdkq1muZ1vB8Oxa+0Y6xqpp7wVS/KfN9Oj8WdbzcbK279TV
	e/EtX9asdktjs6DAkfb+FqaPMqLEdnP6yGOn5wntND8TJlh3kZcVuY2qGW5JQCf4CPfypUB6Qs2xn
	ZF14OptMiSbITyHp7B2oDXtOQzkDR+FpVjEI4JAAvuN5iNNZJ9FPhmbCanpXsOBTmxZ4BzDY4Tm7r
	wZk7wsjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGhHt-006Dcn-0k;
	Fri, 22 Dec 2023 15:18:09 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGhHo-006DZY-1T
	for linux-nvme@lists.infradead.org;
	Fri, 22 Dec 2023 15:18:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703258282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PwLVvz4d5auqCH3ftD3xdgBYCz6pCS3SHGPQA3ASv60=;
	b=QHUL2EPhgHi+qoaxUAeq7zIuf0E//PU9x/Tm+M8TVvIUkpRSRE1xJZ92fabaQ7ij7qlIPm
	UcHXvd0l7vHve0Cit1ih/oUx6TcKa+ldEX5hi29W0fVCj+bfbYCvwu/RB5W31hczrr6CU7
	8sP9gn2N/1EbL8kJhkEHKiuoPWfJIHE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-LvzYa5HvMAyHVrXcybTYAg-1; Fri, 22 Dec 2023 10:18:01 -0500
X-MC-Unique: LvzYa5HvMAyHVrXcybTYAg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C6CD2101A555;
	Fri, 22 Dec 2023 15:18:00 +0000 (UTC)
Received: from kalibr.redhat.com (unknown [10.47.238.49])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E31F92166B31;
	Fri, 22 Dec 2023 15:17:58 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: sagi@grimberg.me
Cc: zahavi.alon@gmail.com,
	hch@lst.de,
	chaitanyak@nvidia.com,
	linux-nvme@lists.infradead.org,
	kbusch@kernel.org
Subject: [PATCH V2 3/3] nvmet-tcp: remove boilerplate code
Date: Fri, 22 Dec 2023 16:17:50 +0100
Message-Id: <20231222151750.655751-4-mlombard@redhat.com>
In-Reply-To: <20231222151750.655751-1-mlombard@redhat.com>
References: <20231222151750.655751-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231222_071804_563009_B698628E 
X-CRM114-Status: GOOD (  11.00  )
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

Simplify the nvmet_tcp_handle_h2c_data_pdu() function by removing
boilerplate code.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/target/tcp.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index b4b6a8ac8089..3569c1255c5e 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -985,8 +985,7 @@ static int nvmet_tcp_handle_h2c_data_pdu(struct nvmet_tcp_queue *queue)
 		if (unlikely(data->ttag >= queue->nr_cmds)) {
 			pr_err("queue %d: received out of bound ttag %u, nr_cmds %u\n",
 				queue->idx, data->ttag, queue->nr_cmds);
-			nvmet_tcp_fatal_error(queue);
-			return -EPROTO;
+			goto err_proto;
 		}
 		cmd = &queue->cmds[data->ttag];
 	} else {
@@ -997,9 +996,7 @@ static int nvmet_tcp_handle_h2c_data_pdu(struct nvmet_tcp_queue *queue)
 		pr_err("ttag %u unexpected data offset %u (expected %u)\n",
 			data->ttag, le32_to_cpu(data->data_offset),
 			cmd->rbytes_done);
-		/* FIXME: use path and transport errors */
-		nvmet_tcp_fatal_error(queue);
-		return -EPROTO;
+		goto err_proto;
 	}
 
 	plen = le32_to_cpu(data->hdr.plen);
@@ -1008,9 +1005,7 @@ static int nvmet_tcp_handle_h2c_data_pdu(struct nvmet_tcp_queue *queue)
 		     cmd->pdu_len == 0 ||
 		     cmd->pdu_len > NVMET_TCP_MAXH2CDATA)) {
 		pr_err("H2CData PDU len %u is invalid\n", cmd->pdu_len);
-		/* FIXME: use proper transport errors */
-		nvmet_tcp_fatal_error(queue);
-		return -EPROTO;
+		goto err_proto;
 	}
 	cmd->pdu_recv = 0;
 	nvmet_tcp_build_pdu_iovec(cmd);
@@ -1018,6 +1013,11 @@ static int nvmet_tcp_handle_h2c_data_pdu(struct nvmet_tcp_queue *queue)
 	queue->rcv_state = NVMET_TCP_RECV_DATA;
 
 	return 0;
+
+err_proto:
+	/* FIXME: use proper transport errors */
+	nvmet_tcp_fatal_error(queue);
+	return -EPROTO;
 }
 
 static int nvmet_tcp_done_recv_pdu(struct nvmet_tcp_queue *queue)
-- 
2.39.3


