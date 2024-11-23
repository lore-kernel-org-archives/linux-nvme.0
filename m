Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E8DEE6ADF8
	for <linux-nvme@archiver.kernel.org>; Sat, 23 Nov 2024 13:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mAAeUPzSxSLE1/Jv8QrW5Nda66nIWoJZku8hKTRv9U8=; b=Z+t8y2Tiam5C5fX7wj39STZoAA
	CgjE0pHvoim+oPZidoxPypw+wNFt1FEnh61eRkItNoz74HStsJ1jEL/mWZdhpK9ISKqIUmryPwvP4
	HmKwZhbNEi4E5WS4L6tnkYAqy/WWvwhCUinG2II88RKaLlJhz+Qzo/HGEHjnIryM4UGF5H8mpBsO8
	ahDnxThiLLLkpTgOVGm0YW7u6sZgp5LpFafX1IuoQ93QHA7bpFt6ZxKNnYTOjLgstkuyqoo6nbJJ5
	fZN1jTYP2eg8CtVYz/ZR1J1wN+e7Hu6a5oi9kHyMb+l3jg4MqcM23y8hFPZGXsIG+xuASnj2fmKaA
	1gubYpbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tEpmD-00000004LtZ-0Til;
	Sat, 23 Nov 2024 13:02:17 +0000
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tEpmB-00000004Lsp-2Pzl
	for linux-nvme@lists.infradead.org;
	Sat, 23 Nov 2024 13:02:16 +0000
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-720c286bcd6so2759478b3a.3
        for <linux-nvme@lists.infradead.org>; Sat, 23 Nov 2024 05:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732366935; x=1732971735; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mAAeUPzSxSLE1/Jv8QrW5Nda66nIWoJZku8hKTRv9U8=;
        b=QpjzaF8IxeqxFwvjNJGvlUnBib2IkM4foK0qQbIAD5yD77Lg1US74C/5KhLe7fHhAu
         k+QAI7lM9UX32IrqICe4KDRIwGB/WbFgx3oCQVT033HPSJZ8OoOBHSnZ2YHbtArBE007
         JHZKxIyW/lzRbm4BC87S8GfCGrBMEU64a3ysY6FsdrngVeemJsg65WG6wXy4eml+/qMt
         TckCfNBSNrXA6tEL0d7ijJVS0CBbZm6cF7BErUl2KyfGudxyOem1zHJ+hJyrr5V3SdPr
         /95whIU2r0N3sgNcjc130ywwTT3gMyhKwsOW4MQIL7u0zGi1C9trn2XYoPN7kRFFYjhn
         9J+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732366935; x=1732971735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mAAeUPzSxSLE1/Jv8QrW5Nda66nIWoJZku8hKTRv9U8=;
        b=drBMdBk1gDspCyPOIbLIIKw7ZQkqkMd/ZmpT86ar7283eLIb+B9aK5ZdKCFPzehyTO
         F1a3LEjtB37Fa2ciD/q8u73MTOhkVwHV9j6d8GlMPUX5TfZHbclezju1gbmJOllt9nQX
         PVDliTO3v+bGUwW9RncdfgcT7BtrDU29h6HD6BD2KcUb4UI8TiRxXwhmfB1QRpu8x1xD
         lvVRZd4488eenV4E+PmcgF6GgwZSR6Ppqi6JZrOr5eCwAsF686uiA8vyft/BRv5hxV1M
         jldSED2ssLg/X1RDqqrGlQaMKOlUzZjo3+qoxSTLJKXnS+Gj+xDSBH279uV/cJjfA/RR
         aj2w==
X-Gm-Message-State: AOJu0Yw+ykhAf7ILB4S19FsFH+JNEJLpa1dw01ZHm2RYeMUjPCoa1wJ3
	q+hxXUw8hT1oFmoq6bQLLFd2qlB2FeYF06ZhBTZdtd6++WKbpLce
X-Gm-Gg: ASbGncu4a5dqaTFABdDoDIO4tEVZCseMWtzkQ98l7Puy78+eDWYrjMAGF6mb2cCzZ8b
	IcDSzHfMe5nyJoncq0DInxCaCsq6+rKsrV/V8MUCFLYDxtaL+gIH5d3Ve5qwNwtntv4bTtAnTWZ
	kQyjY1+0Uljlef+ffzXupHf577TtQP1DDbBLsTW6vHa/XdX7XAX0Cpy2wAyu1A7HhMV5mYhruua
	9BnESvNOKI+q+WdZDJqD/ieh4w/YG23gWJgbAAJzgZqRMrDudypanA+s2qoSQ==
X-Google-Smtp-Source: AGHT+IGeTBhVsRC+WU8nIRo9X5kw2aNF0fkUaU1iy4LonaEXqWjjHBK7t8Gq4b+rktmOmvKBNHSBbg==
X-Received: by 2002:a17:90b:1e0e:b0:2ea:a9ac:eef2 with SMTP id 98e67ed59e1d1-2eb0e233942mr7446552a91.13.1732366934863;
        Sat, 23 Nov 2024 05:02:14 -0800 (PST)
Received: from localhost.localdomain ([143.92.64.18])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2eb0cff8fe8sm3295226a91.14.2024.11.23.05.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2024 05:02:14 -0800 (PST)
From: "brookxu.cn" <brookxu.cn@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] nvme-tcp: simplify nvme_tcp_configure_admin_queue()
Date: Sat, 23 Nov 2024 21:37:39 +0800
Message-Id: <c7006c36681afce811e01de7686d6e2df2c4ab0e.1732368538.git.chunguang.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1732368538.git.chunguang.xu@shopee.com>
References: <cover.1732368538.git.chunguang.xu@shopee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241123_050215_615588_14F971B3 
X-CRM114-Status: GOOD (  11.29  )
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

From: "Chunguang.xu" <chunguang.xu@shopee.com>

As nvme_tcp_configure_admin_queue() is the only one caller of
nvme_tcp_destroy_admin_queue(), so we can merge nvme_tcp_configure_admin_queue()
into nvme_tcp_destroy_admin_queue() to simplify the code.

Signed-off-by: Chunguang.xu <chunguang.xu@shopee.com>
---
 drivers/nvme/host/tcp.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 47d8f10b1f75..45cbaa7523e6 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2101,14 +2101,6 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 	return ret;
 }
 
-static void nvme_tcp_destroy_admin_queue(struct nvme_ctrl *ctrl, bool remove)
-{
-	nvme_tcp_stop_queue(ctrl, 0);
-	if (remove)
-		nvme_remove_admin_tag_set(ctrl);
-	nvme_tcp_free_admin_queue(ctrl);
-}
-
 static int nvme_tcp_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
 {
 	int error;
@@ -2163,9 +2155,11 @@ static void nvme_tcp_teardown_admin_queue(struct nvme_ctrl *ctrl,
 	blk_sync_queue(ctrl->admin_q);
 	nvme_tcp_stop_queue(ctrl, 0);
 	nvme_cancel_admin_tagset(ctrl);
-	if (remove)
+	if (remove) {
 		nvme_unquiesce_admin_queue(ctrl);
-	nvme_tcp_destroy_admin_queue(ctrl, remove);
+		nvme_remove_admin_tag_set(ctrl);
+	}
+	nvme_tcp_free_admin_queue(ctrl);
 	if (ctrl->tls_pskid) {
 		dev_dbg(ctrl->device, "Wipe negotiated TLS_PSK %08x\n",
 			ctrl->tls_pskid);
-- 
2.25.1


