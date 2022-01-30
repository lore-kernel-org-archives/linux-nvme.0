Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 509BAC433EF
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Jan 2022 09:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ky0pbxo+lzKtrktAx82CiD5eFtsifGGiDwxAEq+mVkU=; b=o2v02KzV6QYi5utft0KeuTC3Ag
	6CwPyFxnG84nX6kAnG8YrF3yz0L+1oOEERVd+0szX0Do5DpRSn2z/MMLipWm8+PstXt4R2Ikngi8x
	ND/AKVjY2dVSczCf/L4vt/VLpDchcZWOCWwAVTjVKyR0R2cy+libN21vJOWQbOzXXseeOttzIIxJP
	EYweTU7z4CLCgaXMhqmLlF/w1AaLbRz6W1UrsCRJIJ/Vmi5LhH1OClT2Vje8nEFlKP3KFsrixJRbF
	dWyx5gMcaDXc7B27bIoS+09Rr44Nu/r1SWUaHi21sOC9vTMcJpArSedSXfFg6+X9zovOvjarh6rTT
	nF5nx/vA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nE6Ou-006DFZ-NR; Sun, 30 Jan 2022 09:21:36 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nE6Oi-006DCx-1v
 for linux-nvme@lists.infradead.org; Sun, 30 Jan 2022 09:21:25 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 l35-20020a05600c1d2300b0034d477271c1so7262661wms.3
 for <linux-nvme@lists.infradead.org>; Sun, 30 Jan 2022 01:21:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ky0pbxo+lzKtrktAx82CiD5eFtsifGGiDwxAEq+mVkU=;
 b=l6NU1qSuWoNYV+03AaGpqyt34/60evwceuoXNzmOq31nirqlRLaVHB080HtHSv/bjk
 kb/6dCF6S+g0NVYfBYCa0fAnRm5kCfuXCrJ4q4BTUnU+mnEc46RhvF+NDbikLXVGblAk
 tQF0IHEGs/AVGI7V7Hi6Ocu2wBq7XvhwsI3qO6/Rah8vXBO0e503LN6meTeWFFQWNaSl
 pTc9nNR7mEyX6vBs/WY7xn0oRGZ6w4JtCKzaarLf0WreFhVfaFESCrBlsfUnFLdFrIvk
 LIfL0KyaGw2y1XVHKrHM93EwDi5MUIvqhuQW9egrNI5oQ0rmRnWrZDr6uFGQ3P0lut9n
 bEsg==
X-Gm-Message-State: AOAM5322lW7VGc7kFiDh8mhe7WIFHRs6QfHBLekyRDHV+KzmkOw474Ed
 sWqrc1SDPXp/rSEYOsvkrtf3Wwk+DmI=
X-Google-Smtp-Source: ABdhPJw5nTSjOxP/ADDV3ZQIkVFHaL6a8xXY5DtfW3Bn577ZsPDYvmmBP+9TVlLVUnohN3EnPxCXJg==
X-Received: by 2002:a7b:c851:: with SMTP id c17mr22451214wml.125.1643534482463; 
 Sun, 30 Jan 2022 01:21:22 -0800 (PST)
Received: from localhost.localdomain (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id o15sm6861452wms.9.2022.01.30.01.21.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Jan 2022 01:21:22 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Cc: Chris Leech <cleech@redhat.com>
Subject: [PATCH 1/4] nvme-tcp: fix a possible use-after-free in controller
 reset during load
Date: Sun, 30 Jan 2022 11:21:16 +0200
Message-Id: <20220130092119.595854-2-sagi@grimberg.me>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220130092119.595854-1-sagi@grimberg.me>
References: <20220130092119.595854-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220130_012124_117271_127D7650 
X-CRM114-Status: GOOD (  15.60  )
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

Unlike .queue_rq, .submit_async_event does not check the ctrl and
queue readiness for submitting a AER. This may lead to a use-after-free
condition in the following scenario:
1. nvme_tcp_reset_ctrl_work
2. -> nvme_stop_ctrl flushes ctrl async_event_work
3. ctrl sends AEN which is received by the host, which in turn
   schedules AEN handling
4. teardown admin queue (which releases the queue socket)
5. AEN processed, submits another AER, calling nvme-tcp driver to submit
   prepares the cmd and schedules io_work
6. io_work triggers and attempts to send the cmd
==> use-after-free

In order to fix that, add ctrl and queue state check to validate the driver
is actually able to accept the socket send.

This solves the above race in the reset flow because the ctrl state is
changed to RESETTING, then the async_event_work is flushed, hence from
that point, any other AER command will find the ctrl state to be RESETTING
and bail out without scheduling io_work.

CC: stable@vger.kernel.org
Tested-by: Chris Leech <cleech@redhat.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/tcp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 4ceb28675fdf..447bae34f2cb 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2211,6 +2211,10 @@ static void nvme_tcp_submit_async_event(struct nvme_ctrl *arg)
 	struct nvme_tcp_cmd_pdu *pdu = ctrl->async_req.pdu;
 	struct nvme_command *cmd = &pdu->cmd;
 	u8 hdgst = nvme_tcp_hdgst_len(queue);
+	bool queue_ready = test_bit(NVME_TCP_Q_LIVE, &queue->flags);
+
+	if (ctrl->ctrl.state != NVME_CTRL_LIVE || !queue_ready)
+		return;
 
 	memset(pdu, 0, sizeof(*pdu));
 	pdu->hdr.type = nvme_tcp_cmd;
-- 
2.30.2


