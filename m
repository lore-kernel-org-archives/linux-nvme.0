Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F278FC433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Feb 2022 12:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CPV+qRwG/euXw41IgdnIhfKQUxisL013xC/cOtPXRvo=; b=kz/dpbn6KfEu/TI85roS4GhN3q
	ZzDw22p+SJvqjIbwyenDpxbbUvEI+Fw5ZNwwIUez3giP5b//m+hVCcLHOTnXLNpnfzaFJ8oqqk9y4
	FMtEEx1qgXMi4NpPnB5wRb2sHinaobUiE6Pxs1T+eCvgHnjVTSgbSib4fnImj5q+jR2Jm9CinwtQG
	9/KrEtbpGpZ1s9/8gvOKY+DO6dUjl06xjxDjzOBd+V43ehXxvx8GW4NWtswYI0PoFZGIkj1k+I2MY
	citOlOj1ZfxoXJQfhM01xB2X9IvurPIPov97Ce/T9KtOLlxmZ0/BczTTq5x6CwmBAe8HMlfRlEYWN
	4+lq8vyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nEsgV-00C7kC-3t; Tue, 01 Feb 2022 12:54:59 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nEsg0-00C7eZ-MD
 for linux-nvme@lists.infradead.org; Tue, 01 Feb 2022 12:54:29 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 o1-20020a1c4d01000000b0034d95625e1fso1874631wmh.4
 for <linux-nvme@lists.infradead.org>; Tue, 01 Feb 2022 04:54:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CPV+qRwG/euXw41IgdnIhfKQUxisL013xC/cOtPXRvo=;
 b=g2pvRi2pEKPGmjvWAWxvxMdrQikG4KyPdbzucJLItLo9rFy2mKyBc1L8/cyojReTJ8
 a/O4VGVM/YkMyAxNbhGKBKCitwSyFIz3cs6o6NBe3usEJHttJbCk/pOo1E+WaRRZ+MBm
 BxWAZ15daBlyg8vjCLFpjLpD5bEQu8mSdBPPns3SUZT6eitr5apJmWX8iDw0sNlRfoXw
 Cx65FbltqRkFmbr03jmQ6NKwq7z+D8yHO8ntkGzI/R60K9y5EsaBIf3joAApFoEhcSj3
 0AASHP1FXsoIr5lH1pFhBBVpBJ9RyWirD+aUVe976yhU8XPbC/mxzk+9oixzqyrTn+V7
 7tSw==
X-Gm-Message-State: AOAM532GjP9k/H/PQO5HS3Wl3d/khziC+MkTMj/BGmQYwB0LwPZFWDYB
 v3uC3dZfLmIZnOaXleyFfnSJPLjB6/k=
X-Google-Smtp-Source: ABdhPJyWhD1Nxm4ll8ugtn6wl4gcRKmM7wGHoTQKw100+brNheYWvaQhYsYPJ6jG5xUcDF8WlNTysw==
X-Received: by 2002:a1c:4b01:: with SMTP id y1mr1677187wma.178.1643720067056; 
 Tue, 01 Feb 2022 04:54:27 -0800 (PST)
Received: from localhost.localdomain (46-117-116-119.bb.netvision.net.il.
 [46.117.116.119])
 by smtp.gmail.com with ESMTPSA id x4sm14993878wrp.13.2022.02.01.04.54.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Feb 2022 04:54:26 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Cc: Chris Leech <cleech@redhat.com>
Subject: [PATCH v2 3/3] nvme-rdma: fix possible use-after-free in transport
 error_recovery work
Date: Tue,  1 Feb 2022 14:54:21 +0200
Message-Id: <20220201125421.177942-4-sagi@grimberg.me>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220201125421.177942-1-sagi@grimberg.me>
References: <20220201125421.177942-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220201_045428_749354_95D5D687 
X-CRM114-Status: GOOD (  13.23  )
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

While nvme_rdma_submit_async_event_work is checking the ctrl and queue
state before preparing the AER command and scheduling io_work, in order
to fully prevent a race where this check is not reliable the error
recovery work must flush async_event_work before continuing to destroy
the admin queue after setting the ctrl state to RESETTING such that
there is no race .submit_async_event and the error recovery handler
itself changing the ctrl state.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/rdma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 850f84d204d0..9c55e4be8a39 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1200,6 +1200,7 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
 			struct nvme_rdma_ctrl, err_work);
 
 	nvme_stop_keep_alive(&ctrl->ctrl);
+	flush_work(&ctrl->ctrl.async_event_work);
 	nvme_rdma_teardown_io_queues(ctrl, false);
 	nvme_start_queues(&ctrl->ctrl);
 	nvme_rdma_teardown_admin_queue(ctrl, false);
-- 
2.30.2


