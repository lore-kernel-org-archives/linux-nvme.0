Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C3E5D609B9
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Nov 2024 08:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3WpxC1ak5i/GsjHW0+FMk1rTOqPJjGGRzFkrWXfXPjw=; b=FRln2DPK94oblTxSuk0XerNg5q
	2/01gXARx7kG5uLemwpYpQ+4m6KMM4wm4cY+NIbSHO23VuVPAVrFbfZNO3Ml9nvmiUv0sJeXVnR/N
	NV/KlWOQH8tnEIt7kZ/qSwVOeJkhjwDQn2uveMdw5kDqXHcClROPga64g1XfzVZ3vQvp9cwFGmkt7
	fSz/qps54wM0lHJN7AVqiMqCs1NMisVhQV5Y0vBH5GRw3oJ9lFBJ4Sr4tgcAKIqsQAwu0p9fkSoic
	NDBqOzM2XzZd9Ls8MH5B9a0Cj7cPVhzmZreerPvUKET0/gM0sDkb35QMamSLeSn80vas6t8thLYqV
	N6AakgJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGDmi-0000000CcTn-2RX9;
	Wed, 27 Nov 2024 08:52:32 +0000
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGDmf-0000000CcRe-3qbt
	for linux-nvme@lists.infradead.org;
	Wed, 27 Nov 2024 08:52:31 +0000
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-7e9e38dd5f1so5499291a12.0
        for <linux-nvme@lists.infradead.org>; Wed, 27 Nov 2024 00:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732697549; x=1733302349; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3WpxC1ak5i/GsjHW0+FMk1rTOqPJjGGRzFkrWXfXPjw=;
        b=evb4i9c+vl9VM6vwGTa56DlpLMpcs2aW7FrJllMTPEF8q3XTuQtgzDWeayuO0rawiB
         Ia2wXL/r7d6Fiq5yfZFqrz8Q3rLh34k6EdN4SotGQ0Xx6qUFHIbQxV+m6EQgX3aAskDK
         JXvqNqxWZZjSVmGtoHx3f/SpwMLqHR1IfeCbNg5grsqm0vQHU89Ral3KXmBySH7op4mT
         ZH1n1GCy6ARQ6dgimJ6NkLwY/HJD9kESBG24Hb+kkWAP11MOFGLRLgVMUfznzjMYUNba
         jejosijuHhsHy15qKglCYWqRV+rscoZR7WqYpTqB9NywKtaOAEcbrZx5RCcc5IqjSmt7
         U9SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732697549; x=1733302349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3WpxC1ak5i/GsjHW0+FMk1rTOqPJjGGRzFkrWXfXPjw=;
        b=RrIIOGWAoKIw6yn9qLq/zfD9kKyXAceHbe7Se5PcSb04ApJJLFghqxfTxccH05p8j4
         G98J8jcJHTFiJzEe+jmdEJCRiuk+1r44A++8ZnxP9a0QPok0nQxdSgZPFbpNI49c1dKC
         0rchZPW7PKRwXrjWO3LLgXM9Pw386dBAIA0CCodmQsM6RJoh1tYsmvhlYuKzPi5fRvdJ
         Kp7c1J5eIexOxpioWZzpM9Gt3vB5qV+dkUL2T+YzKqoAXvl5RvlHr0QZHTUMFT+WeeDJ
         BsRA9QIY0PwGm/rJY3pW2bKhxUVGZBrFJEomSM0ewS9XJkDNc6tIwPUWTSFhPrjH/ldK
         xV4A==
X-Gm-Message-State: AOJu0YwmR33NRmBgy7FjN4mfr6Um5OqBFZQnp4mj4XQo7uHdWdHTQXoK
	ovGGwNizwPGiJC+K8+JaIqA3bEdkQAK8C8F8CR1fmruwwi1w/UCG
X-Gm-Gg: ASbGncuRm6ZsEBvqlnYsh08K7wdDCfE1dd1tcFaSpvaGkLu+DLu1KbVnabDj8XBGpOh
	UzOowIpA/xR8SroGkE6OnKSlgfq6rRqcUjtOt1vCT8CAxxlPkdz4csiCJLu3Krn7njO1BCZWtox
	ePOmcor02ks6XFFUkF9a2FylSJuOoFcDNxrjAyXid+XlftnU3JH6K9/nGB8VpITQeKVZiJqrWcz
	ol1wNldOV2xtWn37skZN4KcBcDa9SNsrpWmRA0GMar6OvjOvt8wXKxhTf1HWQ==
X-Google-Smtp-Source: AGHT+IE7W77IZPGT6pO6nsofu0SApJz/06UMb2dL6eXuQw16iAZ3rYd5M/ikmsqDsnhpiwQuFqFmdQ==
X-Received: by 2002:a05:6a20:9144:b0:1e0:c50c:9842 with SMTP id adf61e73a8af0-1e0e0b5cc99mr4084950637.31.1732697549421;
        Wed, 27 Nov 2024 00:52:29 -0800 (PST)
Received: from localhost.localdomain ([143.92.64.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee0fa60091sm960531a91.20.2024.11.27.00.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 00:52:28 -0800 (PST)
From: "brookxu.cn" <brookxu.cn@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	hare@suse.de
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] nvme-tcp: simplify nvme_tcp_configure_admin_queue()
Date: Wed, 27 Nov 2024 17:27:50 +0800
Message-Id: <8282314c0d688f51be9f9ee90cd3463ff76baa1f.1732699313.git.chunguang.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1732699313.git.chunguang.xu@shopee.com>
References: <cover.1732699313.git.chunguang.xu@shopee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241127_005229_953466_573BCBAB 
X-CRM114-Status: GOOD (  12.43  )
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
index 98bf758dc6fc..28c76a3e1bd2 100644
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


