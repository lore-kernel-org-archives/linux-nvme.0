Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2115C4707B
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Jan 2024 18:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YkL9+IaZL1qRobXKY78NwRR56bxY1pr5+2dRgzIbPA4=; b=gYhbXqi6241eSG5Uk0lU0sv4QC
	5d35+b0SRYDwNUgw/yvVr3COsfwbZVtWHUuAq78n/7pTmeqsyinIIL1RNETT5/9qDzFNH66io3ZXn
	dJXN6P+5b1h5ZOlHMdvbeOtIyHu393LeAjgzOeoj/v/6p52J1B0tJ3sL24/bedreGLjwQS4FYyMgL
	xOkHW8y/62RaVqRtiXuCT9v4qs3sOEu/wxEqFuUPw8KEEndiXX0nW2AvsLsTk3mR/sINZgUB3AnZn
	k//pCZIatVMqG2X5Po+FMtf7VZy8nqnrX7gl/noL944CeZO1y2uTDGNlCthKNGhF/IY+FEETVfoWg
	TgM3jtgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rNdK6-00DS5f-05;
	Wed, 10 Jan 2024 18:29:06 +0000
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rNdK3-00DS3D-1t
	for linux-nvme@lists.infradead.org;
	Wed, 10 Jan 2024 18:29:04 +0000
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5f325796097so81657587b3.1
        for <linux-nvme@lists.infradead.org>; Wed, 10 Jan 2024 10:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704911339; x=1705516139; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YkL9+IaZL1qRobXKY78NwRR56bxY1pr5+2dRgzIbPA4=;
        b=MSElOEN/0xY9AZ3New6iFUvqv+Fw4yYSyrZLuad1OHL93A90G5QA9xUrop06SEuG7H
         vnYOwJ65g1ofIM0BecAR+6MDk7s/MvNtSoukAl9SXg0lEs5XbZfSEAkxc6bqzdAop0h5
         sZSC2UN+WZEYKv7py2BmJxFgaUjOgXpHdaL1l89Msp0PQYJ0t2NXHcIb+eJ+PQFDPLhn
         Qun5ir9wanOXaM5Ty+gOV/6KzFbjn7RfbusLemPviQUbkEzhg/98tgFFtJ+DUj/2rGyc
         AYERzBvAEjcxuUb0sjINwQtHR0tTCOJDizqmtnKNj7LyHmRl4B1FeMjcWc2CJvW2CSjB
         yJ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704911339; x=1705516139;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YkL9+IaZL1qRobXKY78NwRR56bxY1pr5+2dRgzIbPA4=;
        b=Bncq7FTO0/Nqe0y4fjz9xPjGOlgmqDpr5NTBwj2+dfxw6fKW+Zgm70I99aHHZjR3Tk
         8kwGtiS9h2wbXaSy1qPKr6rYSHfya8ehI+rONYWLlELVog8SggWuIGT7Tgg32gmRTmg7
         yGQewfWUoeBZ0wrQ9oPtFZnfGPLPtr293XDyrFNxHTovBsTJF0ADVx5vI3iBnVckVT59
         91VH4ejbrnW0nBeK0Omrpszg9w8TnAgROjbkrvsDX0qQe2p7unBy5zFW4uEy3LbCINAn
         Qu6Rvplz8zv72i55yf+pFThL2m/2fBpoSFa3ulH3N7Bgtu+ijAqBzgelDw8kTq8Ulw77
         MUVw==
X-Gm-Message-State: AOJu0Yz7iQhdW6/e/OCYh4RFCWN3mN2jUE82bRLfeSnXDeYd0P4y/blG
	ViQTycv+UA24D/xIhhfUkA5VOw4hRMTWZw==
X-Google-Smtp-Source: AGHT+IH7cJZ/Hw+qJqoWaeA9yPVQRmrmWDFe1fyYKiD6ai5Gl7Cxo52TcYX6lpZB4QluW9Rx00HI6z8=
X-Received: from willb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:491])
 (user=wab job=sendgmr) by 2002:a0d:e4c5:0:b0:5f8:b9b8:aa0a with SMTP id
 n188-20020a0de4c5000000b005f8b9b8aa0amr23354ywe.2.1704911339353; Wed, 10 Jan
 2024 10:28:59 -0800 (PST)
Date: Wed, 10 Jan 2024 18:28:55 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.275.g3460e3d667-goog
Message-ID: <20240110182855.1833512-1-wab@google.com>
Subject: [PATCH] nvme: Inform controller of doorbell config before unquiescing
 IO queues
From: William Butler <wab@google.com>
To: Keith Busch <kbusch@kernel.org>, Pavel Emelyanov <xemul@openvz.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, William Butler <wab@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240110_102903_663346_127303BA 
X-CRM114-Status: GOOD (  13.84  )
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

During resets, if queues are unquiesced first, then the host can submit
IOs to the controller using shadow doorbell logic but the controller
won't be aware. This can lead to necessary MMIO doorbells from being
not issued, causing requests to be delayed and timed-out.

Signed-off-by: William Butler <wab@google.com>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 61af7ff1a9d6..f87c51a946b3 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2743,10 +2743,10 @@ static void nvme_reset_work(struct work_struct *work)
 	 * controller around but remove all namespaces.
 	 */
 	if (dev->online_queues > 1) {
+		nvme_dbbuf_set(dev);
 		nvme_unquiesce_io_queues(&dev->ctrl);
 		nvme_wait_freeze(&dev->ctrl);
 		nvme_pci_update_nr_queues(dev);
-		nvme_dbbuf_set(dev);
 		nvme_unfreeze(&dev->ctrl);
 	} else {
 		dev_warn(dev->ctrl.device, "IO queues lost\n");
-- 
2.43.0.275.g3460e3d667-goog


