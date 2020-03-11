Return-Path: <SRS0=tokg=44=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C4FC10F27
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Mar 2020 15:01:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3378206C0
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Mar 2020 15:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eTyHAxoy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3378206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=nXziEfZLbZiw8eOK5RuN9tV/S8q/6w53NsotPJsESDc=; b=eTyHAxoyUxe/Wg80QaQOgFym1e
	7L/FBfBCtXwS+4mUTEymfDfR6cpar9JEIjamKRUNVv/gVDq/MgITj5AFWgHypbKgsLDhry0Tqu5tX
	/cLHhgd7ArixGjU/9UzkVRQWzwQbcEqHnaoGFwj1X6DUfNNOmzBmu3YCbYBxdx37hlwhbhmOH3man
	NZSdegdYLnRU74y9t2B83Bv2d81iG1VzgS1467GmrAbEpQkuK93HqUwBlD2WDPnrKoPevDRgcQWNx
	EDP1cfcHp4+3/09bGIF0l/P/4edqC3Trdo9oWuCCxozpRhb+HDWmb/N348Hee8B1pQ4VVkv0jscem
	58g6lxxA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jC2rV-0004dC-I2; Wed, 11 Mar 2020 15:01:33 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jC2qx-0004QB-44
 for linux-nvme@lists.infradead.org; Wed, 11 Mar 2020 15:01:01 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 israelr@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 11 Mar 2020 17:00:51 +0200
Received: from rsws50.mtr.labs.mlnx (rsws50.mtr.labs.mlnx [10.209.40.61])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 02BF0oVo002953;
 Wed, 11 Mar 2020 17:00:50 +0200
From: Israel Rukshin <israelr@mellanox.com>
To: Linux-nvme <linux-nvme@lists.infradead.org>,
 Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH 3/4] nvme: Remove unused return code from nvme_delete_ctrl_sync
Date: Wed, 11 Mar 2020 17:00:48 +0200
Message-Id: <1583938849-5787-4-git-send-email-israelr@mellanox.com>
X-Mailer: git-send-email 1.8.4.3
In-Reply-To: <1583938849-5787-1-git-send-email-israelr@mellanox.com>
References: <1583938849-5787-1-git-send-email-israelr@mellanox.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200311_080059_567214_A2DAEA0C 
X-CRM114-Status: UNSURE (   7.85  )
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

The return code of nvme_delete_ctrl_sync is never used, so change it to
void.

Signed-off-by: Israel Rukshin <israelr@mellanox.com>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
---
 drivers/nvme/host/core.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 17cd39b..c0d9b19 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -192,21 +192,16 @@ int nvme_delete_ctrl(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_delete_ctrl);
 
-static int nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl)
+static void nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl)
 {
-	int ret = 0;
-
 	/*
 	 * Keep a reference until nvme_do_delete_ctrl() complete,
 	 * since ->delete_ctrl can free the controller.
 	 */
 	nvme_get_ctrl(ctrl);
-	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_DELETING))
-		ret = -EBUSY;
-	if (!ret)
+	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_DELETING))
 		nvme_do_delete_ctrl(ctrl);
 	nvme_put_ctrl(ctrl);
-	return ret;
 }
 
 static blk_status_t nvme_error_status(u16 status)
-- 
1.8.3.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
