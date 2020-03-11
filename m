Return-Path: <SRS0=tokg=44=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA73C10F27
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Mar 2020 15:01:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D3D8206C0
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Mar 2020 15:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jew0VZ6Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D3D8206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=kfqg5aMrfNP0hjkGT5Ub70vB6TFDNIrGEwOLGv+3sjo=; b=jew0VZ6YgdDfoJ5/WkqW9sTG7l
	0aWhyOg93HzxYWT+1fWT9SzXrEaiD651bXgwx0JsDJ3HkJ+eMuPHlN3Sd64iSvpUQ9st84Z79YkA1
	gkbkBxhYalntHVUkb8EWx6qYW4hIJs9J7Z/UQGYS8CG0PifSjA251MBvh55i5bEBCpj3IMGa2Te3w
	BowkOWM0OjUpxGl+nPtS9RXuqP+vXJIPLWRFDcYv1xzNcHk603pAx3t56ZeQ6XsvBcwA1T1Vs9Wtn
	d5ZVYtGI6QBorhyaiVxP30keip7nH7GFlsqsLhVyUFSEsqguiHx77lYjY8v7CHaNRuFtlXMDNYbKQ
	IjbHuaeg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jC2rl-0004sq-NW; Wed, 11 Mar 2020 15:01:49 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jC2qw-0004Q9-Uz
 for linux-nvme@lists.infradead.org; Wed, 11 Mar 2020 15:01:01 +0000
Received: from Internal Mail-Server by MTLPINE2 (envelope-from
 israelr@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 11 Mar 2020 17:00:51 +0200
Received: from rsws50.mtr.labs.mlnx (rsws50.mtr.labs.mlnx [10.209.40.61])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 02BF0oVn002953;
 Wed, 11 Mar 2020 17:00:50 +0200
From: Israel Rukshin <israelr@mellanox.com>
To: Linux-nvme <linux-nvme@lists.infradead.org>,
 Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/4] nvme-tcp: Fix warning at nvme_tcp_setup_ctrl
Date: Wed, 11 Mar 2020 17:00:47 +0200
Message-Id: <1583938849-5787-3-git-send-email-israelr@mellanox.com>
X-Mailer: git-send-email 1.8.4.3
In-Reply-To: <1583938849-5787-1-git-send-email-israelr@mellanox.com>
References: <1583938849-5787-1-git-send-email-israelr@mellanox.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200311_080059_402266_698131FC 
X-CRM114-Status: UNSURE (   9.54  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Israel Rukshin <israelr@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The transition to LIVE state should not fail in case of a new controller.
Moving to DELETING state before nvme_tcp_create_ctrl() takes a refcount
on the controller may leads to controller use after free.

Signed-off-by: Israel Rukshin <israelr@mellanox.com>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
---
 drivers/nvme/host/tcp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 2af7e8c..145b96c 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1877,8 +1877,12 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
 	}
 
 	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE)) {
-		/* state change failure is ok if we're in DELETING state */
-		WARN_ON_ONCE(ctrl->state != NVME_CTRL_DELETING);
+		/*
+		 * state change failure is ok if we're in DELETING state,
+		 * unless we're during creation of a new controller to
+		 * avoid use after free (ctrl refcount is not taken yet).
+		 */
+		WARN_ON_ONCE(ctrl->state != NVME_CTRL_DELETING || new);
 		ret = -EINVAL;
 		goto destroy_io;
 	}
-- 
1.8.3.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
