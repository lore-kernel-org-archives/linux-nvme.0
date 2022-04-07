Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0935DC433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Apr 2022 09:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jfyCIs7l9+mySd4DV7cn2FGFeF4pUfF9UOpSJXxCPrQ=; b=TRtBwbGibTaIBsjANDtl0f0Lbe
	/9iuAv9OMz7YxGuwDvgMzScFsIojdN7p5m506f89e7nqB+70GzrPjLZNPqcoMaBJi2if1vNVhv5uW
	sfGMkPlFvWHr3sUIPGKWLbKn1/LiObmgw6h8LiWoU2FNv1yNrCK7G24HOe0ImcQPMudncMSMODVdl
	K6ARiemu+nLzZL24ki6R3+VMOGqdQp/Ilec7bovZScIGSl/1HfflpR47ZE42nCnTgNSTj6R9yEhQz
	C1Fo1aRlxXRJ1oN4db8Z302AdOA9XNS2XtcMcHuopreGu5XjIpgMvzOuIReJpCfm+tU3pPlBpC1ZP
	rRvQ4CCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ncOmu-00B0vP-9m; Thu, 07 Apr 2022 09:50:48 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ncOOl-00Aq6Y-TY
 for linux-nvme@lists.infradead.org; Thu, 07 Apr 2022 09:25:53 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id AC8EB1F85B
 for <linux-nvme@lists.infradead.org>; Thu,  7 Apr 2022 09:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1649323546; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=jfyCIs7l9+mySd4DV7cn2FGFeF4pUfF9UOpSJXxCPrQ=;
 b=y4GVnKQyT0olRZOgRFSkteo29GRb5PpFUNLGQYk2dqlq8j+66DTFXmWQLuHP9osc2o4Vt9
 UMJofEFl3kWilnwLcWcXDAy62amI6qs6WQaCRpaTUQBWljHqNZf4nxKWhOro6SzBCIStoL
 a5LNFG6uLfHkvia45zxhkcTDC3FLaOQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1649323546;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=jfyCIs7l9+mySd4DV7cn2FGFeF4pUfF9UOpSJXxCPrQ=;
 b=8E3VN4BAiRv71p9U9Rla4i3EBo2I6/EgT24s2ISIz3/r9oz5kWmmOJndW1Pkr3RvdoPQ5O
 zzsC9W/zjZ/ZOHDA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id A74D7A3B8A;
 Thu,  7 Apr 2022 09:25:46 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
 id 9A68D5193BD6; Thu,  7 Apr 2022 11:25:46 +0200 (CEST)
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: Daniel Wagner <dwagner@suse.de>
Subject: [PATCH] nvme-tcp: handle failing req immediately for
 REQ_FAILFAST_DRIVER
Date: Thu,  7 Apr 2022 11:25:40 +0200
Message-Id: <20220407092540.66227-1-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220407_022552_150355_4FEA2807 
X-CRM114-Status: GOOD (  13.60  )
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

When nvme_tcp_try_send fails to send a request is usually defers the
error handling to upper layers but it ignores the REQ_FAILFAST_DRIVER
flag.

This can lead to very long shutdown delays when the users issues a
'nvme disconnect-all':

 [44888.710527] nvme nvme0: Removing ctrl: NQN "xxx"
 [44898.981684] nvme nvme0: failed to send request -32
 [44960.982977] nvme nvme0: queue 0: timeout request 0x18 type 4
 [44960.983099] nvme nvme0: Property Set error: 881, offset 0x14

At timestamp [44898.981684] nvme_tcp_try_send fails to send but we have
to wait for the timeout handler to expires at [44960.982977] before we
make any progress.

With honoring the REQ_FAILFAST_DRIVER flag the log looks like this:

 [ 8999.227495] nvme nvme1: Removing ctrl: NQN "xxx"
 [ 9016.680447] nvme nvme1: failed to send request -32
 [ 9016.680477] nvme nvme1: Property Set error: 880, offset 0x14

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/tcp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 10fc45d95b86..f714d7ad38c0 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1145,9 +1145,11 @@ static int nvme_tcp_try_send(struct nvme_tcp_queue *queue)
 	if (ret == -EAGAIN) {
 		ret = 0;
 	} else if (ret < 0) {
+		struct request *rq = blk_mq_rq_from_pdu(queue->request);
 		dev_err(queue->ctrl->ctrl.device,
 			"failed to send request %d\n", ret);
-		if (ret != -EPIPE && ret != -ECONNRESET)
+		if ((ret != -EPIPE && ret != -ECONNRESET) ||
+		    rq->cmd_flags & REQ_FAILFAST_DRIVER)
 			nvme_tcp_fail_request(queue->request);
 		nvme_tcp_done_send_req(queue);
 	}
-- 
2.29.2


