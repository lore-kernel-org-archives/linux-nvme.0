Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15B7AC433F5
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Jan 2022 09:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hjZclpirChtniWo8LL/ELqK3wO7/SB5T/fk16Tfi6X4=; b=XJ750vHbfwJ3RachOmDjUXtrLO
	i4VrcQiPLprt+rxGY88/z5vClklhJ5iN4VICLKhwYdq9kgfBy2LxsAAONCHV+DusB5i+juZJOKbdP
	NmYaqdM9XvQIN8HCD8hssHWVGtksLw5zy+Wt2OzYXRyj2aSenYF++KkJJWDtpVxyrkOc/FYVqMiz2
	BhSeYD5lu2mhQQ2MH8ymfl/imQwDCV92O8c+n7hVCwEqSM87857/tGDz+K1wfpLYea/nN3VSGYJ9N
	kuJf2VJZaqVy55xR3XbhbptwRSQgWimiNWnnVlApTF+apF91DKkqtrsS8QLU7gBsYC4u/V1W1tJWK
	PPWp4Zgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nE6P4-006DGy-8a; Sun, 30 Jan 2022 09:21:46 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nE6Oi-006DDB-K3
 for linux-nvme@lists.infradead.org; Sun, 30 Jan 2022 09:21:25 +0000
Received: by mail-wm1-f50.google.com with SMTP id n8so8026778wmk.3
 for <linux-nvme@lists.infradead.org>; Sun, 30 Jan 2022 01:21:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hjZclpirChtniWo8LL/ELqK3wO7/SB5T/fk16Tfi6X4=;
 b=pL13v7emx22FpsVXdCDoGpDv6Ih/AJJ68yv6oZpVlQJUGrzqqkmzGmeB8CTf9Zc+bF
 GQQFFPqfuISDfXvCKceCRXMpUsgIjwbKZKeaLCdJ+7GJs7ficCfn+S/viKRB0VwwmO2u
 CLzc6Iew1a98T/95RMDgm1rEzJqdPrQnmAi9C21k2ZU0KivJBiQiQjqW8DSAKJuiWGvl
 LVyOXpMFPUr+mPKJxq5ZuLbInPUa6j7Kdjo4Y+0U816jpzhBmnJFSr8sVort6OGel5yI
 vnKkR3oeyLTGonO4sppmbl1ClHM84c7w2GU8FrN0cO72akAxxqg2iktkaqWRbWR2CaGk
 wlrQ==
X-Gm-Message-State: AOAM532HYCOcrAksYcam8Kc7soEGbF5HsCe0kSXjHej+0DHHEShZP6Rk
 fYrpZ0f5+5DFgmKZ08r6m0WySgX1MwU=
X-Google-Smtp-Source: ABdhPJzX4uGoC7bbXWLXgKOvm4zrWwFJ5w9usqgGBrx1n9Xw2uUrZfYUlXVgX2E4XzmXJ+4A8zIwTw==
X-Received: by 2002:a05:600c:4341:: with SMTP id
 r1mr4240509wme.99.1643534483322; 
 Sun, 30 Jan 2022 01:21:23 -0800 (PST)
Received: from localhost.localdomain (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id o15sm6861452wms.9.2022.01.30.01.21.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Jan 2022 01:21:23 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Cc: Chris Leech <cleech@redhat.com>
Subject: [PATCH 2/4] nvme-tcp: fix possible use-after-free in transport
 error_recovery work
Date: Sun, 30 Jan 2022 11:21:17 +0200
Message-Id: <20220130092119.595854-3-sagi@grimberg.me>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220130092119.595854-1-sagi@grimberg.me>
References: <20220130092119.595854-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220130_012124_678365_F34A72AD 
X-CRM114-Status: GOOD (  12.00  )
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

While nvme_tcp_submit_async_event_work is checking the ctrl and queue
state before preparing the AER command and scheduling io_work, in order
to fully prevent a race where this check is not reliable the error
recovery work must flush async_event_work before continuing to destroy
the admin queue after setting the ctrl state to RESETTING such that
there is no race .submit_async_event and the error recovery handler
itself changing the ctrl state.

CC: stable@vger.kernel.org
Tested-by: Chris Leech <cleech@redhat.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/tcp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 447bae34f2cb..f8001b35a9c9 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2096,6 +2096,7 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
 	struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
 
 	nvme_stop_keep_alive(ctrl);
+	flush_work(&ctrl->async_event_work);
 	nvme_tcp_teardown_io_queues(ctrl, false);
 	/* unquiesce to fail fast pending requests */
 	nvme_start_queues(ctrl);
-- 
2.30.2


