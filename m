Return-Path: <SRS0=aESL=MZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D26C4338F
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Aug 2021 11:30:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B6EC60FC2
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Aug 2021 11:30:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9B6EC60FC2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CRTQPQI3ZyN7n6TD/GoGZ9jpG/VWxRPe2wCkKRY0IZg=; b=Lns1GLFK+q+/9s
	/dkR2D1VMEuFyGLJ/oGzLPJK7YVOla3Plr3s02IZ1N50n0x0wFKsV8UbrkoR5x0KJ0itDBsf4mcGi
	MeGByJSIFZQ2BWP8slGxNX8Ymm/Kbpgf7XC+FHk9mpruTDVSVaNxRTw28cJ9B75eGf1K7dr5cguBK
	RPW33DJQLxrPLdoysKVzXoikWNRSyuHM7/65jUu/eISrxINatrqrSM+PwzI4IVga1gCyMETw0s651
	F1gUvqVhnOwo4yXfXRFJFFqor3vye0oGQBseXXQpRd7Ig6PWaAHYDTkgGR/3FA4wccycqUiVFpdPW
	wBFK300wGHxYCoqICb6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mAW94-00FweP-Cj; Mon, 02 Aug 2021 11:30:10 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mAW6G-00Fvji-T4
 for linux-nvme@lists.infradead.org; Mon, 02 Aug 2021 11:27:18 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 1832E1FF7F;
 Mon,  2 Aug 2021 11:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1627903628; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CzLqnDMPgV4X2TVtB9CFgIWVEvkNhP+8WThUlGoV9nM=;
 b=id3afhjHrLuLzLNg3bp7J8byiyMuh8CFuwIGCFN6otealbcZu5ejOF0v0isNETl7pX95LT
 yqRV3/bSa/bNsuXh239UDdOO0VvdKkvVvv1ltk5TcFB8EW+cL9y4dhEFx6fS0r4BpBOSNI
 CROFn6rjmZerSr4OGTq4z1kt4euhP4E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1627903628;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CzLqnDMPgV4X2TVtB9CFgIWVEvkNhP+8WThUlGoV9nM=;
 b=mpOw64a8qGPcPLO0gAVPTqrEPqMvcIibjtGoa0VLDjHoaavLzOwGP22JXZ7jrfkQMWJPoh
 6M2XbU6Dh2hnRkBA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 08017A3BCB;
 Mon,  2 Aug 2021 11:27:08 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
 id 030F9518C0B4; Mon,  2 Aug 2021 13:27:08 +0200 (CEST)
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>,
 Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
 Wen Xiong <wenxiong@us.ibm.com>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v4 8/8] nvme-rdma: Unfreeze queues on reconnect
Date: Mon,  2 Aug 2021 13:26:58 +0200
Message-Id: <20210802112658.75875-9-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210802112658.75875-1-dwagner@suse.de>
References: <20210802112658.75875-1-dwagner@suse.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210802_042717_131670_6149F177 
X-CRM114-Status: GOOD (  11.59  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

During the queue teardown in nvme_rdma_teardown_io_queues() freeze is
called unconditionally. When we reconnect we need to pair the freeze
with an unfreeze to avoid hanging I/Os. For newly created connection
this is not needed.

Fixes: 9f98772ba307 ("nvme-rdma: fix controller reset hang during traffic")
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/rdma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index de2a8950d282..21a8a5353af0 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -901,6 +901,8 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 			error = PTR_ERR(ctrl->ctrl.admin_q);
 			goto out_cleanup_fabrics_q;
 		}
+	} else {
+		nvme_unfreeze(&ctrl->ctrl);
 	}
 
 	error = nvme_rdma_start_queue(ctrl, 0);
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
