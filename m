Return-Path: <SRS0=LBLG=7C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 636FAC433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2020 11:57:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E887207C4
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2020 11:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AqTjkdzk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ji7Se44G";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B5byfl2J";
	dkim=neutral (0-bit key) header.d=redhat.com header.i=@redhat.com header.b="M5Wqtuvi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E887207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6lOFtTgl3OLKwKk/QPXAl4fIYctntMwC11DQX2dmVmw=; b=AqTjkdzkCl6Rze
	8s/wy8QH/bLBx/ifwRZjUWzbT1DeTM2v1KR30DijKqfjgXkuYFMssr2ATHjYE0jqX/EOAxYuj4Hd0
	sp2oZrKpNFnCrz/buLoNYpznjsQNQuny0j/m+fGYyF0ZJtqzLJKpREle4O+hxKzYWT5GnWZiuiW6/
	Fs231FaPK1M+Qu7j6DqDPh/THMfmnMa0oA5daz0t/1AWEUN9B+ufD2gU35Kepq4LLMwID9LpS0gM3
	xNJdoQtQqtDl6TfV4iDK1Ub+TtCFVEh5vfVWR9983XmlUNqXQFvbzlvG39PCzUkgMWKS3nJAlNmt3
	UMbUsH+2HyLMnR8psdNQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jbNM9-00086I-U8; Wed, 20 May 2020 11:57:54 +0000
Received: from merlin.infradead.org ([205.233.59.134])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jbNM3-0007ze-AL
 for linux-nvme@bombadil.infradead.org; Wed, 20 May 2020 11:57:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=GBME5VSXnFGx9scGEIfsYchYGWKkURWlktqEtdC0dks=; b=ji7Se44GvlphNE/iQG2tL0ovvt
 s3lLqfF4aLjgw9gqBpXPbZpnYcspD1OGVR41zM508OyunyfX9eW1YjR4luHx9Ynj982LnSlF5NmxO
 Q9AMM1toVgJO6gHERGW7FtkrHPK9uB3D77cPo2m8+I1g1MgQS3oAKqFYz/WjhRtSRnU/0mzu5aPtE
 pk+uE7AWhDwsRxhROQ8vF1RfRc7cpModqGFt/5yLNB9yBzqN7iIarbi5i7oIh7GYsqIu4fY2//Gka
 2zhUZ+z/XfHrvQEGuF8DvVIRaW37llRiIKCrJncmN2Rk/cY4YI/k4loBpNaUjJUFBzhPC0CQNGFDH
 tGflkHkQ==;
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]
 helo=us-smtp-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jbNM2-0007Nf-4I
 for linux-nvme@lists.infradead.org; Wed, 20 May 2020 11:57:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589975847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GBME5VSXnFGx9scGEIfsYchYGWKkURWlktqEtdC0dks=;
 b=B5byfl2JPPHSXSgqs/6VWGHdOu3U85SrHSRJ1Pf9IGEyZL6363YaaDry16MKkw9lbKy+Jv
 2CU/3txpY9pV9Aom5KKCqW4nOZIHR8gPvQBmYsX70qdo/syEDUOyXwLXTX9ybO8k+8bP8U
 0zawvq8P2To9qTXtSqf52mtF9Qs5voQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589975865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GBME5VSXnFGx9scGEIfsYchYGWKkURWlktqEtdC0dks=;
 b=M5WqtuvizLY374VRJ2I5VJ2EbEQHQ/zsVsNHEG8k6nxrjWeTCrQgYvzUl0u+w//Vwyltxz
 SHwfo/gDgAgZpx+xFdzS3rGrmlHM/vfPxUhWgK+2yth25ZhlAe9yqpTqeyu48l9qw9g7jA
 Cfm5fDwZ3muaKWGsugLf6S4S4C19ZYU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-47cSIoHyM5KUADO2tn_ssQ-1; Wed, 20 May 2020 07:57:25 -0400
X-MC-Unique: 47cSIoHyM5KUADO2tn_ssQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 62BBA18FF660;
 Wed, 20 May 2020 11:57:24 +0000 (UTC)
Received: from localhost (ovpn-12-81.pek2.redhat.com [10.72.12.81])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8DFA8707B8;
 Wed, 20 May 2020 11:57:23 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Subject: [PATCH 3/3] nvme-pci: make nvme reset more reliable
Date: Wed, 20 May 2020 19:56:55 +0800
Message-Id: <20200520115655.729705-4-ming.lei@redhat.com>
In-Reply-To: <20200520115655.729705-1-ming.lei@redhat.com>
References: <20200520115655.729705-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Max Gurtovoy <maxg@mellanox.com>, Alan Adamson <alan.adamson@oracle.com>,
 Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

During waiting for in-flight IO completion in reset handler, timeout
or controller failure still may happen, then the controller is deleted
and all inflight IOs are failed. This way is too violent.

Improve the reset handling by replacing nvme_wait_freeze with query
& check controller. If all ns queues are frozen, the controller is reset
successfully, otherwise check and see if the controller has been disabled.
If yes, break from the current recovery and schedule a fresh new reset.

This way avoids to failing IO & removing controller unnecessarily.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Max Gurtovoy <maxg@mellanox.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/pci.c | 37 ++++++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index ce0d1e79467a..b5aeed33a634 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -24,6 +24,7 @@
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/sed-opal.h>
 #include <linux/pci-p2pdma.h>
+#include <linux/delay.h>
 
 #include "trace.h"
 #include "nvme.h"
@@ -1235,9 +1236,6 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 	 * shutdown, so we return BLK_EH_DONE.
 	 */
 	switch (dev->ctrl.state) {
-	case NVME_CTRL_CONNECTING:
-		nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
-		/* fall through */
 	case NVME_CTRL_DELETING:
 		dev_warn_ratelimited(dev->ctrl.device,
 			 "I/O %d QID %d timeout, disable controller\n",
@@ -2393,7 +2391,8 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 		u32 csts = readl(dev->bar + NVME_REG_CSTS);
 
 		if (dev->ctrl.state == NVME_CTRL_LIVE ||
-		    dev->ctrl.state == NVME_CTRL_RESETTING) {
+		    dev->ctrl.state == NVME_CTRL_RESETTING ||
+		    dev->ctrl.state == NVME_CTRL_CONNECTING) {
 			freeze = true;
 			nvme_start_freeze(&dev->ctrl);
 		}
@@ -2504,12 +2503,29 @@ static void nvme_remove_dead_ctrl(struct nvme_dev *dev)
 		nvme_put_ctrl(&dev->ctrl);
 }
 
+static bool nvme_wait_freeze_and_check(struct nvme_dev *dev)
+{
+	bool frozen;
+
+	while (true) {
+		frozen = nvme_frozen(&dev->ctrl);
+		if (frozen)
+			break;
+		if (!dev->online_queues)
+			break;
+		msleep(5);
+	}
+
+	return frozen;
+}
+
 static void nvme_reset_work(struct work_struct *work)
 {
 	struct nvme_dev *dev =
 		container_of(work, struct nvme_dev, ctrl.reset_work);
 	bool was_suspend = !!(dev->ctrl.ctrl_config & NVME_CC_SHN_NORMAL);
 	int result;
+	bool reset_done = true;
 
 	if (WARN_ON(dev->ctrl.state != NVME_CTRL_RESETTING)) {
 		result = -ENODEV;
@@ -2606,8 +2622,9 @@ static void nvme_reset_work(struct work_struct *work)
 		nvme_free_tagset(dev);
 	} else {
 		nvme_start_queues(&dev->ctrl);
-		nvme_wait_freeze(&dev->ctrl);
-		nvme_dev_add(dev);
+		reset_done = nvme_wait_freeze_and_check(dev);
+		if (reset_done)
+			nvme_dev_add(dev);
 		nvme_unfreeze(&dev->ctrl);
 	}
 
@@ -2622,7 +2639,13 @@ static void nvme_reset_work(struct work_struct *work)
 		goto out;
 	}
 
-	nvme_start_ctrl(&dev->ctrl);
+	/* New error happens during reset, so schedule a new reset */
+	if (!reset_done) {
+		dev_warn(dev->ctrl.device, "new error during reset\n");
+		nvme_reset_ctrl(&dev->ctrl);
+	} else {
+		nvme_start_ctrl(&dev->ctrl);
+	}
 	return;
 
  out_unlock:
-- 
2.25.2


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
