Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42F49C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Feb 2022 09:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VxVKcUeLVlaHcwpnrav2ClKOcFWeDW25zqCOaiTjSzo=; b=HE1HuCo38xgGAQSU103arWYuyX
	KNoAo23WpQMnUb/JWJP0pIfBkhRgFpmL+GjCXGuDbPs0RNn+FjGVt7m0V2SV3t2QY6aj8OOil0Rea
	/h5ZOGat1sjtifzsYtrOfWhHWUCQlDnpP93vaUjUTh7hUHDPc9Z/08AXRaK5ftz1PDQy+dSrTpp91
	9X4cN3x5Gpa4jlpXvl577lpSZk5cyKfGnalmUPm5/YJ4JXAd8r74fZGnRM+S9H8CtDFbKoq7h4vxD
	f/Tkmi/c6pEtZ/IwjWY+YRhMoLoZkh54JhnJqOBWDtXMCagLa+vdeiodeF5EPfmtHxZCvqHMwGmFF
	Gg4yF3Mg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nJXcZ-00EEFh-GH; Mon, 14 Feb 2022 09:26:11 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nJXKg-00EALO-Mi
 for linux-nvme@lists.infradead.org; Mon, 14 Feb 2022 09:07:44 +0000
Received: by mail-wr1-f44.google.com with SMTP id i14so25588384wrc.10
 for <linux-nvme@lists.infradead.org>; Mon, 14 Feb 2022 01:07:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VxVKcUeLVlaHcwpnrav2ClKOcFWeDW25zqCOaiTjSzo=;
 b=pch1tNGEA7+ULmXR6qTFpPw2WxuBt/J6x+FAAE8J0g6XxSt7h3sZ6teTuWF3AP6XlC
 +t+UxOV78vZcNSa9BrR9sNojUFnv9laHui0kav9W82PQghxX3HHUGEHZk68ap+pDHPf2
 NmOGZPcPoQbvyJ8zARPYklvz9hZG4LTm/gJt3rZL4PLhmDxE+pEQFd91iFFkW1DRt2fl
 +cbqBKCrf+MlOHeNe7zMN7lQgsiA/0zFAP3F7C4asUaA+AIfWi/GnoBK9MO2xX1rH7Cd
 B5hqhxbmHnOZmgtg83pTJphSHZSx/V7eNNtdd3xzjelRk1i+OsB8IkY7K1/5J0EAxJMc
 TBIQ==
X-Gm-Message-State: AOAM530E6A6dq+Istrm58FJns+3Sgm9h0Gju2S47XTx0nrI7oOT7HV+9
 a6vkoCva19sf4v0pXThAmOGu7ZFY0dM=
X-Google-Smtp-Source: ABdhPJz8l3234bNnrOSPI/wQl9kvZEuDl64/T7FrDMAYxaHUBMjipbHyaXoipBQ+gSFFOg2CPQHJPw==
X-Received: by 2002:adf:f58b:: with SMTP id f11mr10251475wro.427.1644829660536; 
 Mon, 14 Feb 2022 01:07:40 -0800 (PST)
Received: from localhost.localdomain (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id h4sm34595498wre.0.2022.02.14.01.07.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Feb 2022 01:07:40 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH 7/7] nvmet-tcp: replace ida_simple[get|remove] with the simler
 ida_[alloc|free]
Date: Mon, 14 Feb 2022 11:07:32 +0200
Message-Id: <20220214090732.479193-8-sagi@grimberg.me>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220214090732.479193-1-sagi@grimberg.me>
References: <20220214090732.479193-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220214_010742_778552_33F8FC81 
X-CRM114-Status: GOOD (  12.61  )
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

ida_simple_[get|remove] are wrappers anyways.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/tcp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 7c1c43ce466b..83ca577f72be 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1473,7 +1473,7 @@ static void nvmet_tcp_release_queue_work(struct work_struct *w)
 	nvmet_tcp_free_cmds(queue);
 	if (queue->hdr_digest || queue->data_digest)
 		nvmet_tcp_free_crypto(queue);
-	ida_simple_remove(&nvmet_tcp_queue_ida, queue->idx);
+	ida_free(&nvmet_tcp_queue_ida, queue->idx);
 
 	page = virt_to_head_page(queue->pf_cache.va);
 	__page_frag_cache_drain(page, queue->pf_cache.pagecnt_bias);
@@ -1613,7 +1613,7 @@ static int nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 	init_llist_head(&queue->resp_list);
 	INIT_LIST_HEAD(&queue->resp_send_list);
 
-	queue->idx = ida_simple_get(&nvmet_tcp_queue_ida, 0, 0, GFP_KERNEL);
+	queue->idx = ida_alloc(&nvmet_tcp_queue_ida, GFP_KERNEL);
 	if (queue->idx < 0) {
 		ret = queue->idx;
 		goto out_free_queue;
@@ -1646,7 +1646,7 @@ static int nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 out_free_connect:
 	nvmet_tcp_free_cmd(&queue->connect);
 out_ida_remove:
-	ida_simple_remove(&nvmet_tcp_queue_ida, queue->idx);
+	ida_free(&nvmet_tcp_queue_ida, queue->idx);
 out_free_queue:
 	kfree(queue);
 	return ret;
-- 
2.30.2


