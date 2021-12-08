Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 441B0C433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Dec 2021 13:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=9Fv92ar0lfk54vQvyoBwv3Gc3WNuLixCFAC3iY3bVzU=; b=RvSdJjY2WlSX37tY6lRlhJf8q/
	f9Nr1dJB1HCZ8pxbu/KdcUFg8JAxokUqX0MV0aGbp1pVLu6IYSk7VHZ39SodgjUbC6mXkUIMEnxnW
	5iYOtYbkFnsMHEmCC3bH92W8d4ROYFI4aYEsy4EpwknDMIGuhXJeLfo7ZDwQsN86fo1majRLCVhbP
	5oJjTKjARtKuqeJjkw2blc3B9zz8Sl4CwZPrZTJmKTLRA/FNdQ5hBIJBJ8k8WmhXNb+wzs3/yba1n
	kMLcNGisTuiE8HTvGHxtPyAt83SppspJxoDB9hRzFljEKdAjlNsMVzyHsGD1oN8VvghjX1y6yZF5S
	aTZ+vGow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mux6W-00CnU6-A1; Wed, 08 Dec 2021 13:35:28 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mux6F-00CnRF-HC
 for linux-nvme@lists.infradead.org; Wed, 08 Dec 2021 13:35:12 +0000
Received: by mail-wr1-f50.google.com with SMTP id c4so4092393wrd.9
 for <linux-nvme@lists.infradead.org>; Wed, 08 Dec 2021 05:35:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9Fv92ar0lfk54vQvyoBwv3Gc3WNuLixCFAC3iY3bVzU=;
 b=no6nISk8plxPWFn5IyMG4aFASQmP6ulUZJqlL0smLNDxRz3oiD9/hrgiexpZmKbTs+
 SM7Z/7fgkLxuiqeOBY7mYC2bQvcGblDOEtnikDDmD6pfeAVziZ7GOx4vTAyl2rviE68x
 8L7kvIX2d3JFIyvYMYp2pUIzpJpMLoi6J4+TSz+0DUxIQJzqdrPnvm7xwU/CUXBfcu1n
 2Y7H07P2K2Qqqg7A+MeQzUk8eBotqEymmnE5lbRTmgmc8CMZAACJ4KN/wBY989uMUVrF
 WV6qMa00e0kkCiQIeUBIizoDsLJ4GRYRwxXqfH7K66I3FgnjSbETzIbewfKuWjCk8Zke
 J3Wg==
X-Gm-Message-State: AOAM531NpbedfF7qfqZZvZZOr2qw47EZrrKOrBa/+jvvsru3lN31AHWz
 gLq5IXkre4CAra32+dwtci+Qm/TEcRg=
X-Google-Smtp-Source: ABdhPJyJXUtRsemaCl6DGGjAA9Ryn5gbH3A6lM0MlFuoi1JLHKMI/Ty666NhdEJObzIjig6iQ5HO7g==
X-Received: by 2002:adf:8b0e:: with SMTP id n14mr55833067wra.281.1638970509335; 
 Wed, 08 Dec 2021 05:35:09 -0800 (PST)
Received: from localhost.localdomain (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id r62sm2659839wmr.35.2021.12.08.05.35.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Dec 2021 05:35:08 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH] nvmet-tcp: fix possible list corruption for unexpected
 command failure
Date: Wed,  8 Dec 2021 15:35:06 +0200
Message-Id: <20211208133506.92918-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211208_053511_591082_4F581C0A 
X-CRM114-Status: GOOD (  12.64  )
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

nvmet_tcp_handle_req_failure needs to understand weather to prepare
for incoming data or the next pdu. However if we misidentify this, we
will wait for 0-length data, and queue the response although nvmet_req_init
already did that.

The particular command was namespace management command with no data,
which was incorrectly categorized as a command with incapsule data.

Also, add a code comment of what we are trying to do here.

Reported-by: Witold Baryluk
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/tcp.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index cb6a473c3eaf..7c1c43ce466b 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -922,7 +922,14 @@ static void nvmet_tcp_handle_req_failure(struct nvmet_tcp_queue *queue,
 	size_t data_len = le32_to_cpu(req->cmd->common.dptr.sgl.length);
 	int ret;
 
-	if (!nvme_is_write(cmd->req.cmd) ||
+	/*
+	 * This command has not been processed yet, hence we are trying to
+	 * figure out if there is still pending data left to receive. If
+	 * we don't, we can simply prepare for the next pdu and bail out,
+	 * otherwise we will need to prepare a buffer and receive the
+	 * stale data before continuing forward.
+	 */
+	if (!nvme_is_write(cmd->req.cmd) || !data_len ||
 	    data_len > cmd->req.port->inline_data_size) {
 		nvmet_prepare_receive_pdu(queue);
 		return;
-- 
2.30.2


