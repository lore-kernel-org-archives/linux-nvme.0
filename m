Return-Path: <SRS0=tokg=44=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBA6C10F27
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Mar 2020 15:02:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B975B206C0
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Mar 2020 15:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GfkG4YSP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B975B206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=fFm0Er2L2fQ/y8gYdLNTMNcmTwStWhASPxCdBFa3joQ=; b=GfkG4YSPVSbCoyVLO+aKTNoVu+
	kQD/EaL0x6hbrn41BNNDpWUkxzAzEiOtoiaKLCVCjT4QEEEj/6U+mbfqdsAdmL+Ll219KX/ZQhZNi
	ES1sOKUHLJvHf4cm8hrklFb+JEY2S/9b1LK/jH4Tk5NzaHtd1DphgRiO6HnRHef0FN44sdlL9pJlO
	C44xyz8bfydmiTLnzpPCwFnpRewO/1ZRTJVUgINZVXyqD36dm+xi9GJa1x3JS4glI6yCXH1Wwhovg
	najxI0CBPgkAk0yZvEhBr1I5HZp6mIAtCm0K6wfF7fq4hIoZyRuVd64mCOKZt5WBm6Nb3cF362QaW
	PxFk5Taw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jC2rz-000530-Uo; Wed, 11 Mar 2020 15:02:03 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jC2qx-0004QA-03
 for linux-nvme@lists.infradead.org; Wed, 11 Mar 2020 15:01:01 +0000
Received: from Internal Mail-Server by MTLPINE2 (envelope-from
 israelr@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 11 Mar 2020 17:00:51 +0200
Received: from rsws50.mtr.labs.mlnx (rsws50.mtr.labs.mlnx [10.209.40.61])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 02BF0oVp002953;
 Wed, 11 Mar 2020 17:00:51 +0200
From: Israel Rukshin <israelr@mellanox.com>
To: Linux-nvme <linux-nvme@lists.infradead.org>,
 Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH 4/4] nvme: Fix controller use after free at create_ctrl
 callback
Date: Wed, 11 Mar 2020 17:00:49 +0200
Message-Id: <1583938849-5787-5-git-send-email-israelr@mellanox.com>
X-Mailer: git-send-email 1.8.4.3
In-Reply-To: <1583938849-5787-1-git-send-email-israelr@mellanox.com>
References: <1583938849-5787-1-git-send-email-israelr@mellanox.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200311_080059_437904_4A5D2641 
X-CRM114-Status: GOOD (  11.35  )
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

Calling nvme_sysfs_delete() when the controller is in the middle of
creation may cause several bugs. If the controller is in NEW state we
remove delete_controller file and don't delete the controller. The user
will not be able to use nvme disconnect command on that controller again,
although the controller may be active. Other bugs may happen if the
controller is in the middle of create_ctrl callback and
nvme_do_delete_ctrl() starts. For example, freeing I/O tagset at
nvme_do_delete_ctrl() before it was created or controller use after free
at create_ctrl callback.

To fix all this races don't allow the user to delete the controller
before it was fully created.

Signed-off-by: Israel Rukshin <israelr@mellanox.com>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
---
 drivers/nvme/host/core.c    | 4 ++++
 drivers/nvme/host/fabrics.c | 1 +
 drivers/nvme/host/nvme.h    | 1 +
 3 files changed, 6 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c0d9b19..7976955 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3224,6 +3224,10 @@ static ssize_t nvme_sysfs_delete(struct device *dev,
 {
 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
 
+	/* Can't delete non-created controllers */
+	if (!ctrl->created)
+		return -EBUSY;
+
 	if (device_remove_file_self(dev, attr))
 		nvme_delete_ctrl_sync(ctrl);
 	return count;
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index c09230e..d6e3d67 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -1055,6 +1055,7 @@ void nvmf_free_options(struct nvmf_ctrl_options *opts)
 		ret = PTR_ERR(ctrl);
 		goto out_module_put;
 	}
+	ctrl->created = true;
 
 	module_put(ops->module);
 	return ctrl;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index d0bfa2b..e7623d2 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -294,6 +294,7 @@ struct nvme_ctrl {
 	u16 maxcmd;
 	int nr_reconnects;
 	struct nvmf_ctrl_options *opts;
+	bool created;
 
 	struct page *discard_page;
 	unsigned long discard_page_busy;
-- 
1.8.3.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
