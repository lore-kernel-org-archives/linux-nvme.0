Return-Path: <SRS0=FSxx=PM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1312BC433EF
	for <linux-nvme@archiver.kernel.org>; Sun, 24 Oct 2021 07:43:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B30A260E9C
	for <linux-nvme@archiver.kernel.org>; Sun, 24 Oct 2021 07:43:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B30A260E9C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=apB7P7js4jxl52WYZq4fESF0CSfiE5gzEKX6HwsC38s=; b=InGc+6BhhiJ/DfA2VYclGP0Q2H
	aIGmWcn6iSzUdYlLkxaxxyyUJ6JtgetuOUgAQgYtG2RhUSgtSbEle6FGj+tIMKBH3UVdqXxOXUA9N
	1ZyzAOmdotxWZjr5VGc5y0bZVsqQQRy8R/W48MgU7OfFOYCsCr8cPS8R+oIeiGfrUtpDoZEvyB1oQ
	QiCMxu4vqBf2pcSHSJAtGaHQ7UCc95Jr9zoO79EBiuTtRrdp1/AGVLfUnPIVUjnjZbe8maZL3C4VU
	J8SPmLSa4IpOBgrHrYcJvEOqK6Ouvk7o3g7XxFW2zbdIsc2F5FI00zK5QSlVC9VtwOjX4I00YBN8a
	fcWr7SRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1meYAO-00Dlok-8V; Sun, 24 Oct 2021 07:43:40 +0000
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1meYAL-00DloQ-Tl
 for linux-nvme@lists.infradead.org; Sun, 24 Oct 2021 07:43:39 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 71-20020a1c014a000000b0032cafd23b1dso2152530wmb.4
 for <linux-nvme@lists.infradead.org>; Sun, 24 Oct 2021 00:43:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=apB7P7js4jxl52WYZq4fESF0CSfiE5gzEKX6HwsC38s=;
 b=TS+nbCZG8g3VF7wQp+ywsFD/tA3D+ByUmW0/xIBbfMvh1sYMlyoHymli1HUtHaPkvt
 dlZgiKV7C8GO4OaDJa5GfrqQQIgWD626Vh3OYrLbayoIZe6o177B/IzebhGKfnUdOrbU
 IRUKY2U+x+w7Mecr0SFVGyd3KACU2YHcNwzd1W4uji5F8qEGlfOMUFgUxBehIxUAZEtE
 FXMPHIscGNHTdPiuaWGBPyXdhnOrXCCShtQd/qv8Uo00fyNGwvgDNcsi6ZsIxXhfpwXK
 u3+m/2MA5/N8rzrXMk93xOgJAiRHN8mA/Wz5zQZa1H2dP7CAIoERv0uF7uENtVVgkIG+
 TzrQ==
X-Gm-Message-State: AOAM5328Lw+kWoeKfe6xNLoiEOjmZN3Mh18zV0ENIwaU4JBFs8gHewW0
 mUVNRF0bmyPgNEPmlfcfkZiKOGl1Azk=
X-Google-Smtp-Source: ABdhPJxrpYKViwIj8KfIlfqYaqRpZW/4ZP378cuFqaFWYABDPkyDVFKJYG1SleI51DxdiuLrFn90lQ==
X-Received: by 2002:a7b:c94c:: with SMTP id i12mr8886700wml.67.1635061413027; 
 Sun, 24 Oct 2021 00:43:33 -0700 (PDT)
Received: from localhost.localdomain (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id j9sm805472wms.39.2021.10.24.00.43.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Oct 2021 00:43:31 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH] nvme-tcp: Fix H2CData PDU send accounting (again)
Date: Sun, 24 Oct 2021 10:43:31 +0300
Message-Id: <20211024074331.546635-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211024_004337_987700_0862EF47 
X-CRM114-Status: GOOD (  15.80  )
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

We should not access request members after the last send, even to
determine if indeed it was the last data payload send. The reason is
that a completion could have arrived and trigger a new execution of the
request which overridden these members. This was fixed by commit
825619b09ad3 ("nvme-tcp: fix possible use-after-completion").

Commit e371af033c56 broke that assumption again to address cases where
multiple r2t pdus are sent per request. To fix it, we need to record the
request data_sent and data_len and after the payload network send we
reference these counters to determine weather we should advance the
request iterator.

Fixes: e371af033c56 ("nvme-tcp: fix incorrect h2cdata pdu offset accounting")
Reported-by: Keith Busch <kbusch@kernel.org>
Cc: stable@vger.kernel.org # 5.10+ 
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/tcp.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 78966b8ddb1e..42b58eb1ba62 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -926,15 +926,17 @@ static void nvme_tcp_fail_request(struct nvme_tcp_request *req)
 static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
 {
 	struct nvme_tcp_queue *queue = req->queue;
+	int req_data_len = req->data_len;
 
 	while (true) {
 		struct page *page = nvme_tcp_req_cur_page(req);
 		size_t offset = nvme_tcp_req_cur_offset(req);
 		size_t len = nvme_tcp_req_cur_length(req);
-		bool last = nvme_tcp_pdu_last_send(req, len);
+		bool pdu_last = nvme_tcp_pdu_last_send(req, len);
+		int req_data_sent = req->data_sent;
 		int ret, flags = MSG_DONTWAIT;
 
-		if (last && !queue->data_digest && !nvme_tcp_queue_more(queue))
+		if (pdu_last && !queue->data_digest && !nvme_tcp_queue_more(queue))
 			flags |= MSG_EOR;
 		else
 			flags |= MSG_MORE | MSG_SENDPAGE_NOTLAST;
@@ -958,11 +960,11 @@ static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
 		 * in the request where we don't want to modify it as we may
 		 * compete with the RX path completing the request.
 		 */
-		if (req->data_sent + ret < req->data_len)
+		if (req_data_sent + ret < req_data_len)
 			nvme_tcp_advance_req(req, ret);
 
 		/* fully successful last send in current PDU */
-		if (last && ret == len) {
+		if (pdu_last && ret == len) {
 			if (queue->data_digest) {
 				nvme_tcp_ddgst_final(queue->snd_hash,
 					&req->ddgst);
-- 
2.30.2


