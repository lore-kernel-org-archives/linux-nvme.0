Return-Path: <SRS0=UXA3=OE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB79C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Sep 2021 15:39:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F97461056
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Sep 2021 15:39:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5F97461056
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=YcXeSEDz2BTN9mzU0clgTMVyvM6FltO3F5l0ocjAaq8=; b=s3TKLyt/Pyuc/8
	t4EyFOyxgX3JoFPSlP/z8At68vuTd9xnPpnB6lDw1AJ7ydtdY1XgZNP5G2EDyGp4hvXX+goFtiR+v
	Kj46DxiVko5iZlnQ4/Nuq9jBfPDuxxUFzH3O7at4YI8GzdMnU6Y3ZFONI5Iw1G63sdEvweEm+5eco
	Gy3LkkveNXSHeso+3OtqWJfKWW5lR9Hlztx6DIf3KQiyXIeKmoaxXG59Q6icJoQ8DJ1FkpKGAaoWr
	yIFtG9jv0Glavp20cJVW9+4D5UxkAFXG2fgHjjMUljUrrRt19CqsoDsqZ6n+GCclHnOLWPmcoE+mE
	zVWYS2TUFMAHWLY93LnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mQAWV-006F3s-Gu; Tue, 14 Sep 2021 15:39:03 +0000
Received: from mail-ed1-f49.google.com ([209.85.208.49])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQAWS-006F3W-80
 for linux-nvme@lists.infradead.org; Tue, 14 Sep 2021 15:39:01 +0000
Received: by mail-ed1-f49.google.com with SMTP id z94so14399151ede.8
 for <linux-nvme@lists.infradead.org>; Tue, 14 Sep 2021 08:38:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=S8YvMyK3E/v0sgFrmr95ZRmLAMbqYw4mLs8r73vYGSg=;
 b=QNUtjfJEGI4AFzpsfACF41hkSRS8x5usb27r8Y14C2G+18IifUhTaIC9uWzq0algeA
 RHSTdIwwbRki/b7MObWdidH9PhxI1gxXRBugsifDCkQ3ClA4kEnGfGiazlz3SA9+/hjh
 KBvC5gBA4l+bmYLXnNcB++2ZSoe7RsfgeE6OHFSErbC3q03tVX2a7DQvey0xcZ2TDxGY
 PnV+VhxsXlvgoC5z5J+nqpiOgvdYs+ThpAjfZrEaSQX7cMWB49MEyPeDZD1UEIcS5JiW
 scM0j7xOgPfZLu+LbCQIOAK9jVBQuDDuFEYCDiQyuQbf+lw25oDFX3dNJQPqR5zogOzD
 Eg0A==
X-Gm-Message-State: AOAM531Ud+tnSGoGKWc533W0hokKOaQiJMaQH8VGQvSkmDDT/GB8QlGr
 jhOoksEW+umKMn4DfYkr76UCfKAictE=
X-Google-Smtp-Source: ABdhPJzSTvKDtBhUQ9kqj/MG+vwH3ZOhYZE/epmf1mcaShzYu7kevrI+CfC7LQCaCzs/OjQCGCjm0g==
X-Received: by 2002:a05:6402:28ad:: with SMTP id
 eg45mr18285777edb.226.1631633938117; 
 Tue, 14 Sep 2021 08:38:58 -0700 (PDT)
Received: from localhost.localdomain (109-186-240-23.bb.netvision.net.il.
 [109.186.240.23])
 by smtp.gmail.com with ESMTPSA id k15sm5018295ejb.92.2021.09.14.08.38.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Sep 2021 08:38:57 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH] nvme-tcp: fix incorrect h2cdata pdu offset accounting
Date: Tue, 14 Sep 2021 18:38:55 +0300
Message-Id: <20210914153855.16177-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210914_083900_332473_CF5C6A86 
X-CRM114-Status: GOOD (  16.25  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

When the controller sends us multiple r2t PDUs in a single
request we need to account for it correctly as our send/recv
context run concurrently (i.e. we get a new r2t with r2t_offset
before we updated our iterator and req->data_sent marker). This
can cause wrong offsets to be sent to the controller.

To fix that, we will first know that this may happen only in
the send sequence of the last page, hence we will take
the r2t_offset to the h2c PDU data_offset, and in
nvme_tcp_try_send_data loop, we make sure to increment
the request markers also when we completed a PDU but
we are expecting more r2t PDUs as we still did not send
the entire data of the request.

Fixes: 825619b09ad3 ("nvme-tcp: fix possible use-after-completion")
Reported-by: Nowak, Lukasz <Lukasz.Nowak@Dell.com>
Tested-by: Nowak, Lukasz <Lukasz.Nowak@Dell.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
- Keith, can you ask the WD team to test this as well?

 drivers/nvme/host/tcp.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 645025620154..87b73eb94041 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -607,7 +607,7 @@ static int nvme_tcp_setup_h2c_data_pdu(struct nvme_tcp_request *req,
 		cpu_to_le32(data->hdr.hlen + hdgst + req->pdu_len + ddgst);
 	data->ttag = pdu->ttag;
 	data->command_id = nvme_cid(rq);
-	data->data_offset = cpu_to_le32(req->data_sent);
+	data->data_offset = pdu->r2t_offset;
 	data->data_length = cpu_to_le32(req->pdu_len);
 	return 0;
 }
@@ -939,7 +939,15 @@ static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
 			nvme_tcp_ddgst_update(queue->snd_hash, page,
 					offset, ret);
 
-		/* fully successful last write*/
+		/*
+		 * update the request iterator except for the last payload send
+		 * in the request where we don't want to modify it as we may
+		 * compete with the RX path completing the request.
+		 */
+		if (req->data_sent + ret < req->data_len)
+			nvme_tcp_advance_req(req, ret);
+
+		/* fully successful last send in current PDU */
 		if (last && ret == len) {
 			if (queue->data_digest) {
 				nvme_tcp_ddgst_final(queue->snd_hash,
@@ -951,7 +959,6 @@ static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
 			}
 			return 1;
 		}
-		nvme_tcp_advance_req(req, ret);
 	}
 	return -EAGAIN;
 }
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
