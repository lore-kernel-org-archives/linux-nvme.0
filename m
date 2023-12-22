Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EC85C41535
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Dec 2023 15:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TkgeZt69u90jIcddOngCJyzF0OBjvQB142Um7sV13OA=; b=tQAg9gBCZ9PPAYLEq72mc8meTD
	Kkjfkk7i5PCETn+YOrC5h9KAbMAalJ4r0tXa4+O9yPlof1vI1u1q+8BXuqQYkgdSVH38RL8yCSqVR
	QuSZ1W6R+UOaPH0ynyfGzY2c3ysZDDiff4W4THoGcp3BwkLr+OUGujaWAH9aJSHz02hlWYY6MGBvy
	gjjUUDe614JY7GQYVXIlCV7eUkSvsCGphXtKMMypFgS/Mo2g4Gjh+Fa6Otd3ykU4aq7Qwq35/y2eI
	ctPjcdz3f7eGrCBgvLuCYAd4mSVwvRYvD7Y5EscUm3s1zXTFyFnVVx+ypXUtWATgZVUOyf2lSdfIe
	654fAJcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGhHq-006Db1-1W;
	Fri, 22 Dec 2023 15:18:06 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGhHn-006DZV-02
	for linux-nvme@lists.infradead.org;
	Fri, 22 Dec 2023 15:18:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703258282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TkgeZt69u90jIcddOngCJyzF0OBjvQB142Um7sV13OA=;
	b=UN/0/aXFQaSMPNKIFWeJ6vcmbKY+xAqDeW/N1aeibtQP9emQ03CHwqpq/gT7f4rns6vTE8
	5jetp06mwIW86XtkAUEcqfg3VuNGYY9szeN4Jf/1ju/koFQkSUKxw/fuBoqj0xtSTzD6zv
	AXNNXNN9PIcTmQ5fpvHkskDqq2KaQRM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-s2qGSYc1NUeTqqFGpdFoVA-1; Fri, 22 Dec 2023 10:17:57 -0500
X-MC-Unique: s2qGSYc1NUeTqqFGpdFoVA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 14A77101A555;
	Fri, 22 Dec 2023 15:17:56 +0000 (UTC)
Received: from kalibr.redhat.com (unknown [10.47.238.49])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3354A2166B31;
	Fri, 22 Dec 2023 15:17:53 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: sagi@grimberg.me
Cc: zahavi.alon@gmail.com,
	hch@lst.de,
	chaitanyak@nvidia.com,
	linux-nvme@lists.infradead.org,
	kbusch@kernel.org
Subject: [PATCH V2 1/3] nvmet-tcp: Fix a kernel panic when host sends an invalid H2C PDU length
Date: Fri, 22 Dec 2023 16:17:48 +0100
Message-Id: <20231222151750.655751-2-mlombard@redhat.com>
In-Reply-To: <20231222151750.655751-1-mlombard@redhat.com>
References: <20231222151750.655751-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231222_071803_119969_F2BFCCF8 
X-CRM114-Status: GOOD (  15.11  )
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

If the host sends an H2CData command with an invalid DATAL,
the kernel may crash in nvmet_tcp_build_pdu_iovec().

Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000000
lr : nvmet_tcp_io_work+0x6ac/0x718 [nvmet_tcp]
Call trace:
  process_one_work+0x174/0x3c8
  worker_thread+0x2d0/0x3e8
  kthread+0x104/0x110

Fix the bug by raising a fatal error if DATAL isn't coherent
with the packet size.
Also, the PDU length should never exceed the MAXH2CDATA parameter which
has been communicated to the host in nvmet_tcp_handle_icreq().

Fixes: 872d26a391da ("nvmet-tcp: add NVMe over TCP target driver")
Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/target/tcp.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 4cc27856aa8f..ad16795934b8 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -24,6 +24,7 @@
 #include "nvmet.h"
 
 #define NVMET_TCP_DEF_INLINE_DATA_SIZE	(4 * PAGE_SIZE)
+#define NVMET_TCP_MAXH2CDATA		0x400000 /* 16M arbitrary limit */
 
 static int param_store_val(const char *str, int *val, int min, int max)
 {
@@ -923,7 +924,7 @@ static int nvmet_tcp_handle_icreq(struct nvmet_tcp_queue *queue)
 	icresp->hdr.pdo = 0;
 	icresp->hdr.plen = cpu_to_le32(icresp->hdr.hlen);
 	icresp->pfv = cpu_to_le16(NVME_TCP_PFV_1_0);
-	icresp->maxdata = cpu_to_le32(0x400000); /* 16M arbitrary limit */
+	icresp->maxdata = cpu_to_le32(NVMET_TCP_MAXH2CDATA);
 	icresp->cpda = 0;
 	if (queue->hdr_digest)
 		icresp->digest |= NVME_TCP_HDR_DIGEST_ENABLE;
@@ -978,6 +979,7 @@ static int nvmet_tcp_handle_h2c_data_pdu(struct nvmet_tcp_queue *queue)
 {
 	struct nvme_tcp_data_pdu *data = &queue->pdu.data;
 	struct nvmet_tcp_cmd *cmd;
+	unsigned int plen;
 
 	if (likely(queue->nr_cmds)) {
 		if (unlikely(data->ttag >= queue->nr_cmds)) {
@@ -1001,7 +1003,16 @@ static int nvmet_tcp_handle_h2c_data_pdu(struct nvmet_tcp_queue *queue)
 		return -EPROTO;
 	}
 
+	plen = le32_to_cpu(data->hdr.plen);
 	cmd->pdu_len = le32_to_cpu(data->data_length);
+	if (unlikely(cmd->pdu_len != (plen - sizeof(*data)) ||
+		     cmd->pdu_len == 0 ||
+		     cmd->pdu_len > NVMET_TCP_MAXH2CDATA)) {
+		pr_err("H2CData PDU len %u is invalid\n", cmd->pdu_len);
+		/* FIXME: use proper transport errors */
+		nvmet_tcp_fatal_error(queue);
+		return -EPROTO;
+	}
 	cmd->pdu_recv = 0;
 	nvmet_tcp_build_pdu_iovec(cmd);
 	queue->cmd = cmd;
-- 
2.39.3


