Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 604CAC433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Feb 2022 12:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Wc42Ez+Nibg3QROEwPp9iEOFKA+Ri8WZc/J4b/2SvAI=; b=mFqNPnAkHPBvicXmvzMEOO/OjI
	iCdbNoMVtCC4NUjnApisrBVrnwrpjcHw5v4KCIrpfemMw4TDTQ68vLA6+ce7C6L7b3n8Ldrv5O7dZ
	LuUy08nqZYgaCtrsp+DLWeFK6oRKJjDX7vNy/yOBotkkF57gla7rXX105Tsrk6BflGKGToq4LXAU1
	m6+CZM/N/exss5N/WXLLVuY+mGYjQF9nQ+TNLjGoTNowH8/0S+g772A2yK0EILuqZNbNPbtjy/Vme
	Ki5h3nBF32Tj6KIn07j455PFlW+5sTlfYPgBAQlkb1JzoPu74ChDfsLl4+MM0mr7lNkY2LqKpb6fQ
	qOVA2tUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nEsgK-00C7hd-Pk; Tue, 01 Feb 2022 12:54:48 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nEsfz-00C7e8-LY
 for linux-nvme@lists.infradead.org; Tue, 01 Feb 2022 12:54:29 +0000
Received: by mail-wr1-f50.google.com with SMTP id e8so31923703wrc.0
 for <linux-nvme@lists.infradead.org>; Tue, 01 Feb 2022 04:54:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Wc42Ez+Nibg3QROEwPp9iEOFKA+Ri8WZc/J4b/2SvAI=;
 b=AVCuIL7JaOy8HJqxDLsfp3ST+RbPt9RifFOJ2O7+eCTja2vOduoH6teIGxA8zaSCvX
 ai+X/TnC6/7zk5/S8nD7bdAGbDo4Y3OqymN/hoOP/HWr+wucPY97v5BMGkyEJtU287oy
 Of+wuS1MLROLtkSrDrAW+qGs6kb4pZCYDbYRyDGs3IhyuGFuNNgT33iLzaCQsPhMvSU4
 Hzq0FhWDNCrhL6z/5W0O2nUm9QVjR1k1bRSZPFKVDoXWcj2WNDztk1uGUMH15Oi8Rtws
 3kJAjocLPnn333IsAqxCnkvfxUBAmuWYzJcOdnP6b2ZH0j0w/e4jHNzEBAy57f9SGA+h
 JjAw==
X-Gm-Message-State: AOAM532wPsRx58OWcJyb2CIg8pveHHEdLa19r0345XQ5Fautx7XAuSxp
 tHclbygZONUbUEV/8TNS2UnBqCxOd+g=
X-Google-Smtp-Source: ABdhPJyTTauU8ge+fcF8UXB/kRg4iC0XYeSxmw3Wqk2vX0+Uf2JuV86QMHqE2neHEUWcXMuOsujC6Q==
X-Received: by 2002:a5d:47af:: with SMTP id 15mr21794040wrb.88.1643720066015; 
 Tue, 01 Feb 2022 04:54:26 -0800 (PST)
Received: from localhost.localdomain (46-117-116-119.bb.netvision.net.il.
 [46.117.116.119])
 by smtp.gmail.com with ESMTPSA id x4sm14993878wrp.13.2022.02.01.04.54.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Feb 2022 04:54:25 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Cc: Chris Leech <cleech@redhat.com>
Subject: [PATCH v2 2/3] nvme-tcp: fix possible use-after-free in transport
 error_recovery work
Date: Tue,  1 Feb 2022 14:54:20 +0200
Message-Id: <20220201125421.177942-3-sagi@grimberg.me>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220201125421.177942-1-sagi@grimberg.me>
References: <20220201125421.177942-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220201_045427_722641_2675654A 
X-CRM114-Status: GOOD (  13.09  )
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

Tested-by: Chris Leech <cleech@redhat.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/tcp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 4ceb28675fdf..01e24b5703db 100644
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


