Return-Path: <SRS0=ZZT4=DF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3849C2D0A8
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 12:36:21 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77F092158C
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 12:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PZwZhDbC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ldnA+v2t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77F092158C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Myg2uMOsqxkY3br1dQrb7qZwmYRuxLWR8x94S/E7CUk=; b=PZwZhDbCadl7QGmUWS1XC8f6K
	VH3ostyHtROwG4wcY9v2pllpBUr/j9ij0Ixqn73yFndMnw9E0M0za1HbEhi/cCPuVZ5ojKWtVuE0Z
	67GChgzwOCUW9AOl+v7hVZxwQM19dwxgXOlWT14aDwVpMVzOsnqwTojnjUxULiJpeR2oSWXvX7Wb5
	SuC9qz6UOGYsOalNXoE3JJaehZ/ZJj/lZCLrrYQdEKGPG7bog4ZU6elAyJsn0INeP02j2pjDxySZr
	SdbCKWNZPDf61YviLYWddVI+Ve8r6VFcFJdape3E3WvgYE6vqSO78/oeh0Pt9T7TQ2MtWzsFNtAnQ
	2xV3jji6A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kMsO9-0002rC-MR; Mon, 28 Sep 2020 12:36:17 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kMsNR-0002TK-5H
 for linux-nvme@merlin.infradead.org; Mon, 28 Sep 2020 12:35:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=TCKMniK+Zd3GnbP0NdotO+VashZMo+1mPiNKVr9i988=; b=ldnA+v2tCZnocCsbgOwGaIeIna
 Af9d0cPhwa+dTspuhprlHIcmyq4qFdazlrb7lKlhDIdX/V9sN2lGSPNywJaodZXShv6sY+40+EVic
 E8wa2cMvvIS9BSi2wIkhTHeRlPYhn62itUEvYjiXy3Ihc8KiAlFbzd3VqHrr1euNUwBonc00w4SQU
 Er1TyEnzB+qE6K//1zSN2hTSr73/28Ewn5/1zz6sRO7DFs9EHxbS2K4mvmyhVQyIKErD3jDGOy425
 P5UuvSiaCQoSHBMrlNtQHlKUysimp32MRfF13diW+5hN7rgpKcVihhA1eUOenl0WkHN7xeZOpm/zn
 Nqf9sFBQ==;
Received: from [2001:4bb8:180:7b62:3a1d:d74e:d75b:5fe7] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kMsNP-0004mx-Fx; Mon, 28 Sep 2020 12:35:32 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 19/20] nvme: refactor nvme_validate_ns
Date: Mon, 28 Sep 2020 14:35:01 +0200
Message-Id: <20200928123502.435373-20-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200928123502.435373-1-hch@lst.de>
References: <20200928123502.435373-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Move the logic to revalidate the block_device size or remove the
namespace from the caller into nvme_validate_ns.  This removes
the return value and thus the status code translation.  Additionally
it also catches non-permanent errors from nvme_update_ns_info using
the existing logic.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 37 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 07309f6c14faab..0b88a377a47f6e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3899,6 +3899,7 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 	if (test_and_set_bit(NVME_NS_REMOVING, &ns->flags))
 		return;
 
+	set_capacity(ns->disk, 0);
 	nvme_fault_inject_fini(&ns->fault_inject);
 
 	mutex_lock(&ns->ctrl->subsys->lock);
@@ -3936,58 +3937,54 @@ static void nvme_ns_remove_by_nsid(struct nvme_ctrl *ctrl, u32 nsid)
 	}
 }
 
-static int nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_ids *ids)
+static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_ids *ids)
 {
 	struct nvme_ctrl *ctrl = ns->ctrl;
 	struct nvme_id_ns *id;
-	int ret = 0;
+	int ret = -ENODEV;
 
-	if (test_bit(NVME_NS_DEAD, &ns->flags)) {
-		set_capacity(ns->disk, 0);
-		return -ENODEV;
-	}
+	if (test_bit(NVME_NS_DEAD, &ns->flags))
+		goto out;
 
 	ret = nvme_identify_ns(ctrl, ns->head->ns_id, ids, &id);
 	if (ret)
 		goto out;
 
+	ret = -ENODEV;
 	if (!nvme_ns_ids_equal(&ns->head->ids, ids)) {
 		dev_err(ctrl->device,
 			"identifiers changed for nsid %d\n", ns->head->ns_id);
-		ret = -ENODEV;
-		goto free_id;
+		goto out_free_id;
 	}
 
 	ret = nvme_update_ns_info(ns, id);
-free_id:
+
+out_free_id:
 	kfree(id);
 out:
 	/*
-	 * Only fail the function if we got a fatal error back from the
+	 * Only remove the namespace if we got a fatal error back from the
 	 * device, otherwise ignore the error and just move on.
+	 *
+	 * TODO: we should probably schedule a delayed retry here.
 	 */
-	if (ret == -ENOMEM || (ret > 0 && !(ret & NVME_SC_DNR)))
-		ret = 0;
-	else if (ret > 0)
-		ret = blk_status_to_errno(nvme_error_status(ret));
-	return ret;
+	if (ret && ret != -ENOMEM && !(ret > 0 && !(ret & NVME_SC_DNR)))
+		nvme_ns_remove(ns);
+	else
+		revalidate_disk_size(ns->disk, true);
 }
 
 static void nvme_validate_or_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 {
 	struct nvme_ns_ids ids = { };
 	struct nvme_ns *ns;
-	int ret;
 
 	if (nvme_identify_ns_descs(ctrl, nsid, &ids))
 		return;
 
 	ns = nvme_find_get_ns(ctrl, nsid);
 	if (ns) {
-		ret = nvme_validate_ns(ns, &ids);
-		revalidate_disk_size(ns->disk, ret == 0);
-		if (ret)
-			nvme_ns_remove(ns);
+		nvme_validate_ns(ns, &ids);
 		nvme_put_ns(ns);
 		return;
 	}
-- 
2.28.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
