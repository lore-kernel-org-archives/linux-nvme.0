Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5743CC433FE
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Nov 2022 11:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0xXPCV2hS5GmWL1a0xoA9WfAFjNpigsXniwBM7Ehft8=; b=PMfVCyB82Is4zdKDRK50UCy8Wu
	9tEvFpKf/r+8igLW06DkKhdg21lrxUoD0t/XFRuRyJWbTX6NctDUoHohSUbtk/lOjnk6+oh0IZ8GG
	vcU+F11N1KpdvhK0HpETA6DVMKDUIiFLrgKZlHzCSjoxbH7hul1pUgOcmQommFJJwYqay89e2iWyS
	MHEUNgC8nELRQMD+smhqcJbvFbveVpO07YE/uoxYoYr6s74vhslpvJ7XwFcU33ltpxI0e+Z8iQhUw
	HeRyEX69R1oMObZFrPXwkiS0H4+uclqA7FmypJLVkW9PM6/i9zkXQ4cQL+qJzuAFQIzvz0nyibnIr
	SpZm+ndA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouBBE-00B8HR-AV; Sun, 13 Nov 2022 11:29:43 +0000
Received: from mail-wm1-f41.google.com ([209.85.128.41])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouB6Z-00B6VS-4U
	for linux-nvme@lists.infradead.org; Sun, 13 Nov 2022 11:24:52 +0000
Received: by mail-wm1-f41.google.com with SMTP id m7-20020a05600c090700b003cf8a105d9eso5839152wmp.5
        for <linux-nvme@lists.infradead.org>; Sun, 13 Nov 2022 03:24:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0xXPCV2hS5GmWL1a0xoA9WfAFjNpigsXniwBM7Ehft8=;
        b=5S8jU5nHgwlgyK5otca3L/auQ/X1b49FTEpn0m9aw7lriF9pn4rL/TiA65NZLQ1Mya
         BAFg/S1wM4me2Nl4wxmZeaQMB61dL4fCuMzgZ0zVEu8RMzEBcKsSwPRwkPZDArL/JbRc
         fwPYdTiB9fDlcy/fHzbDmmOZ8a6G2FvQy7dXPWAsCU8NEtx+3PKjbUiA7YYeAIEFepT/
         NYmTBkIXmLBmq9IXCYTR+JM4hUeJdqZOWNaI8BqwOPQSV0nkMMX44RFC6o6XnRGAnAJy
         S28GrDvw+VMb/YAnI48EygN9pyWF6LdX8O4OKqw/WYDIZZG7LyzklbnOxRUcvc8UxF5D
         Z2Mg==
X-Gm-Message-State: ANoB5pkVZ8tf0P/7hSX9uWy9z+njVv5RXBfMAp7hnrALoa8YBOdJAD4/
	PXf77u1/CjSX7jUe0qm68qumBUxPTtg=
X-Google-Smtp-Source: AA0mqf7C+gAaSVBjX/n4qv6N/Wt482PQdjNwJI4RZGT5nFnzyAM5qRvI/LlZU+LVmoPPwPNEKnl9WQ==
X-Received: by 2002:a05:600c:18a1:b0:3cf:86b8:71f7 with SMTP id x33-20020a05600c18a100b003cf86b871f7mr5794947wmp.76.1668338689110;
        Sun, 13 Nov 2022 03:24:49 -0800 (PST)
Received: from localhost.localdomain (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id p1-20020a1c5441000000b003b4868eb71bsm14318393wmi.25.2022.11.13.03.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 03:24:48 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH v2 19/20] nvme-tcp: stop auth work after tearing down queues in error recovery
Date: Sun, 13 Nov 2022 13:24:23 +0200
Message-Id: <20221113112424.1049834-20-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221113112424.1049834-1-sagi@grimberg.me>
References: <20221113112424.1049834-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221113_032451_225760_80CBC9D1 
X-CRM114-Status: GOOD (  13.82  )
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

when starting error recovery there might be a authentication work
running, and it involves I/O commands. Given the controller is tearing
down there is no chance for the I/O to complete other than timing out
which may unnecessarily take a full io timeout.

So first tear down the queues, fail/cancel all inflight I/O (including
potentially authentication) and only then stop authentication. This
ensures that failover is not stalled due to blocked authentication I/O.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 9b47dcb2a7d9..65077da58096 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2128,7 +2128,6 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
 				struct nvme_tcp_ctrl, err_work);
 	struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
 
-	nvme_auth_stop(ctrl);
 	nvme_stop_keep_alive(ctrl);
 	flush_work(&ctrl->async_event_work);
 	nvme_tcp_teardown_io_queues(ctrl, false);
@@ -2136,6 +2135,7 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
 	nvme_start_queues(ctrl);
 	nvme_tcp_teardown_admin_queue(ctrl, false);
 	nvme_start_admin_queue(ctrl);
+	nvme_auth_stop(ctrl);
 
 	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING)) {
 		/* state change failure is ok if we started ctrl delete */
-- 
2.34.1


