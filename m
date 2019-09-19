Return-Path: <SRS0=DlcY=XO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74367C3A5A6
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Sep 2019 21:35:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4415921907
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Sep 2019 21:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CMPkz8Md";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cwuT1QkS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4415921907
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Tun89VKsY782crN3eDh5FP+Vigd5wrG3Km+Z/vXHIzM=; b=CMPkz8MdXLRdYh
	+dy33AbYMcQy8Zd1wRjz8dkcRNvHaTOz8T7qyu+blXdoNgK86Au1JYl0k2eLze6hoJdx3JDnSG911
	GF2DKn0of5ck9kBSglibrrAwq3fflPzlfCoWrJVu06QkxnMKyHHDykWKrjwwCXv9Ga1I+7XcFOwSR
	Dii/UZsU7Goxbw+OlGXqvk8u+f3mML9+FtlBDRRs6a7l9J9i7UG9vqUHWD+QtwpRL5SC+1OGtyFzB
	SPx6nPwvSXR8M26KF0n6qST2HwZejuLY1PuMHvhXF0Z3o7ZwYaYQ/nHkwIDwpFRIWv1lWhEDfWwQG
	9yM6xnpO1uhiAu3d53vQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iB45U-0004Bx-Dk; Thu, 19 Sep 2019 21:35:40 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iB44Y-0002EI-PK
 for linux-nvme@lists.infradead.org; Thu, 19 Sep 2019 21:34:44 +0000
Received: from washi1.fujisawa.hgst.com (unknown [199.255.47.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B167D2196E;
 Thu, 19 Sep 2019 21:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1568928882;
 bh=psXJ6MJ6S6j3WCV1X0TiDLIpnu63F5tER9SbzMxmfZ4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=cwuT1QkSN4DUmWKJIP7J3WhHJz01xyvni0yWQmad9CRWi9U+Bf8nEyvJNac468Sk8
 aiCKzkYlOxj3BwOVY4vY0WTSrX6hhpJnxF5CRMf54EvwIRrhc4Jd1oAGXzD7nS4PI/
 fLIJQSjrzz0ex4hiidAcZ4qHJBESVdxKNrvcHliQ=
From: kbusch@kernel.org
To: linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
 Christoph Hellwig <hch@lst.de>
Subject: [PATCHv2 4/6] nvme: Introduce nvme_reset_continue
Date: Fri, 20 Sep 2019 06:34:29 +0900
Message-Id: <20190919213431.7864-5-kbusch@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190919213431.7864-1-kbusch@kernel.org>
References: <20190919213431.7864-1-kbusch@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190919_143442_840146_897D0F01 
X-CRM114-Status: GOOD (  12.75  )
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
Cc: Keith Busch <kbusch@kernel.org>,
 Edmund Nadolski <edmund.nadolski@intel.com>,
 James Smart <james.smart@broadcom.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Keith Busch <kbusch@kernel.org>

There are times we need to reset the controller in two parts where the
initialization happens in a different context than the disabling. We need
to be able to set the state to RESETTING first in order to prevent another
reset from scheduling while performing a critical section that handles
the disable part. Introduce a new helpwer function, nvme_reset_continue()
that can be called from such contexts after they've set the controller
state to RESETTING.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 12 ++++++++++--
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e03b1765fc01..95b74d020506 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -117,14 +117,22 @@ static void nvme_queue_scan(struct nvme_ctrl *ctrl)
 		queue_work(nvme_wq, &ctrl->scan_work);
 }
 
-int nvme_reset_ctrl(struct nvme_ctrl *ctrl)
+int nvme_reset_continue(struct nvme_ctrl *ctrl)
 {
-	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
+	if (ctrl->state != NVME_CTRL_RESETTING)
 		return -EBUSY;
 	if (!queue_work(nvme_reset_wq, &ctrl->reset_work))
 		return -EBUSY;
 	return 0;
 }
+EXPORT_SYMBOL_GPL(nvme_reset_continue);
+
+int nvme_reset_ctrl(struct nvme_ctrl *ctrl)
+{
+	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
+		return -EBUSY;
+	return nvme_reset_continue(ctrl);
+}
 EXPORT_SYMBOL_GPL(nvme_reset_ctrl);
 
 int nvme_reset_ctrl_sync(struct nvme_ctrl *ctrl)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 55ffae820c8f..3ad16a81370b 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -497,6 +497,7 @@ int nvme_get_features(struct nvme_ctrl *dev, unsigned int fid,
 int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count);
 void nvme_stop_keep_alive(struct nvme_ctrl *ctrl);
 int nvme_reset_ctrl(struct nvme_ctrl *ctrl);
+int nvme_reset_continue(struct nvme_ctrl *ctrl);
 int nvme_reset_ctrl_sync(struct nvme_ctrl *ctrl);
 int nvme_delete_ctrl(struct nvme_ctrl *ctrl);
 
-- 
2.21.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
