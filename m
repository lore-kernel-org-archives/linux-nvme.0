Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 491BFC433EF
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Jan 2022 09:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Vg/NwWDeBehiFNVXgLwWx8+gBGVgLV9N0svEKCt/ZCU=; b=nlWdu8wxH/GI68Yusq7d39Uep0
	YP4oeEch2WG128fisjlOlPoV0Fkzsh/cQixFHu7QAgLwFhCenqMQ+Ps5UUPE7pZoGkHkPXixKWKqZ
	6WUjdSB805OngIInV9BNmuEU0zKH/xO7fULMVTvxa8ePFE9/KzvgFGnpszDzBK59N+6TH3nXbE4LS
	rDf+Y/UWssDmsJ+qXINlermXAyikwOyyih0gcFygHoUmaaMGXghvQuRlAb90BeshJx/Dw4KHmshAX
	QmWZcgnCvnfgLdy4tYsy2vbjg/KDBaT4mo3CQqwyk6RNjgmz3qurzCHepb60whzLwbM9TDKLir0Ys
	fimVO1eQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nE6PO-006DLs-Bu; Sun, 30 Jan 2022 09:22:06 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nE6Ok-006DDw-IP
 for linux-nvme@lists.infradead.org; Sun, 30 Jan 2022 09:21:27 +0000
Received: by mail-wr1-f44.google.com with SMTP id a13so19552297wrh.9
 for <linux-nvme@lists.infradead.org>; Sun, 30 Jan 2022 01:21:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Vg/NwWDeBehiFNVXgLwWx8+gBGVgLV9N0svEKCt/ZCU=;
 b=cmWzwmCe+YCw7Y/+J6u8iP975Quvb4zhbA32WNbo83yn26uhtupmUg3YiUglmM6hZi
 Wh0LorHp/99+RrpJGKjAUZGKF43h+34S6QKgnTPVnhz5hTJH7UiJt5Jh0Q67yJNrr0C9
 Lamv5RVfg3ECBbZiaDznvxNldR3U7TCXASbhCGDYvfSFsk/ZZQ8f4Y9cAVzfZWhi6Bs2
 PX5XW4MKncp2sraSfI6TocXSuUb7wsUY8RntHfNGRyvSsT8X71DiOsgnPIaGNSn2+INr
 YUntGibZDvZ9mh8NgnHR8s6Gdz9Wqr00Xai2QAdL8eSbLN1CxskwsI3x/FlHR1kSK9se
 1Qig==
X-Gm-Message-State: AOAM53328rdVRMDbuwrMQP62CudpV+tQLWXdw0GmomPzhDw/SvnmD7Dm
 8nYNNoEr4MPzHZ66avKx5N26o4Rz5pQ=
X-Google-Smtp-Source: ABdhPJxnLuoNWVfp3TJou6x1OPWsRK5CYEoJTB2qlQzSmJhtg1qIw0P8FMpZNcZwatqi3CLCLt3R1g==
X-Received: by 2002:a5d:5283:: with SMTP id c3mr13054405wrv.554.1643534484987; 
 Sun, 30 Jan 2022 01:21:24 -0800 (PST)
Received: from localhost.localdomain (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id o15sm6861452wms.9.2022.01.30.01.21.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Jan 2022 01:21:24 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Cc: Chris Leech <cleech@redhat.com>
Subject: [PATCH 4/4] nvme-rdma: fix possible use-after-free in transport
 error_recovery work
Date: Sun, 30 Jan 2022 11:21:19 +0200
Message-Id: <20220130092119.595854-5-sagi@grimberg.me>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220130092119.595854-1-sagi@grimberg.me>
References: <20220130092119.595854-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220130_012126_626977_330395E0 
X-CRM114-Status: GOOD (  11.84  )
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

CC: stable@vger.kernel.org
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/rdma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 780e8fbf503f..78e787c0e103 100644
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


