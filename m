Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D92C369A6
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Apr 2025 15:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PLCKLD7jJginmrqRR1ygojgIzLVA1xBJqojnWd8D0nQ=; b=CY6+Tx+8IoD4eoNY44sGgwME/u
	V4leig+BsVf8W+ZWWrx9kjlLrCGXIjBsZAUkgB0vA8ilemDca5DlV+KEpK5agCC3//qWb8mexfuDZ
	Wgg3HQwTkCDhup4ctX/8dSQ7OfKJ6IhGGAmonmztbCUVgmKr4doRPMuCwyMAD6CWCCvsc85X7DInb
	oKZThwvITLZOWimSHHWHgzL07xBXLL1NnFcXXG2hRC0cyjDxqjvM1Qbrwdk+cJ/4c53absye8q+yb
	9EUAzxs2NZv8m6yUNoEKBPWddKQn2NjUWx6/Ds2YbYzqY7BsGrfiGeu5QfQ9TBZxvHeHi8R4WQ2Ie
	sDlYTsrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2Atk-00000004cTI-1mRL;
	Tue, 08 Apr 2025 15:30:00 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2AtC-00000004cIN-3hGK
	for linux-nvme@lists.infradead.org;
	Tue, 08 Apr 2025 15:29:27 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 0D6B45C5E24;
	Tue,  8 Apr 2025 15:27:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79D86C4CEE5;
	Tue,  8 Apr 2025 15:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744126165;
	bh=O5GHwCVJjRcxblaYbgVMKB2kCGt6YrQb7Ba5ru7hUuo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=B/P2rIHL6acwI//GuwPxF9W4886pJxQCrbbkjHHMcNrjaLOFOjwx//wZ9f7+YZqK6
	 +fQscAGwC+bsz19GNevNIfrmKmms8VmAUzW946bebPOJ6mHDod9uNUStMdyjyA9Edu
	 0RJweyEDCRH799Hjqf05sI7/zKno+XnqMgl/+RtcPUJybo4YER2LldsENj/E+wDE/F
	 DF9g7tp+FAzuNDcdhbAsJzSiXvoEoQppmioO2GqLskGMISJn0EPDKNZvWszRqmJHk0
	 Bn7okh5zyI6AaSh23ZpJ6qW8H6IMfbJgCT8nDW7nxP+CoHy1wpvf9knIDcQPjTNOPy
	 4xt4nva6aa8EA==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 08 Apr 2025 17:29:07 +0200
Subject: [PATCH 5/8] nvmet-fc: inline nvmet_fc_free_hostport
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-nvmet-fcloop-part-one-v1-5-382ec97ab7eb@kernel.org>
References: <20250408-nvmet-fcloop-part-one-v1-0-382ec97ab7eb@kernel.org>
In-Reply-To: <20250408-nvmet-fcloop-part-one-v1-0-382ec97ab7eb@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
 Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>
Cc: James Smart <jsmart2021@gmail.com>, linux-nvme@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250408_082926_983751_1067AE18 
X-CRM114-Status: GOOD (  12.52  )
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

No need for this tiny helper with only one user, let's inline it.

And since the hostport ref counter needs to stay in sync, it's not
optional anymore to give back the reference.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fc.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 6487c46ebba8d12e573d19fe8c39d526492c506a..6d64dadcb356b78b522d0deaa433cc745bfcd8f6 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -995,16 +995,6 @@ nvmet_fc_hostport_get(struct nvmet_fc_hostport *hostport)
 	return kref_get_unless_zero(&hostport->ref);
 }
 
-static void
-nvmet_fc_free_hostport(struct nvmet_fc_hostport *hostport)
-{
-	/* if LLDD not implemented, leave as NULL */
-	if (!hostport || !hostport->hosthandle)
-		return;
-
-	nvmet_fc_hostport_put(hostport);
-}
-
 static struct nvmet_fc_hostport *
 nvmet_fc_match_hostport(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 {
@@ -1184,7 +1174,7 @@ nvmet_fc_target_assoc_free(struct kref *ref)
 	/* Send Disconnect now that all i/o has completed */
 	nvmet_fc_xmt_disconnect_assoc(assoc);
 
-	nvmet_fc_free_hostport(assoc->hostport);
+	nvmet_fc_hostport_put(assoc->hostport);
 	spin_lock_irqsave(&tgtport->lock, flags);
 	oldls = assoc->rcv_disconn;
 	spin_unlock_irqrestore(&tgtport->lock, flags);
@@ -1449,11 +1439,6 @@ nvmet_fc_free_tgtport(struct kref *ref)
 	struct nvmet_fc_tgtport *tgtport =
 		container_of(ref, struct nvmet_fc_tgtport, ref);
 	struct device *dev = tgtport->dev;
-	unsigned long flags;
-
-	spin_lock_irqsave(&nvmet_fc_tgtlock, flags);
-	list_del(&tgtport->tgt_list);
-	spin_unlock_irqrestore(&nvmet_fc_tgtlock, flags);
 
 	nvmet_fc_free_ls_iodlist(tgtport);
 
@@ -1614,6 +1599,11 @@ int
 nvmet_fc_unregister_targetport(struct nvmet_fc_target_port *target_port)
 {
 	struct nvmet_fc_tgtport *tgtport = targetport_to_tgtport(target_port);
+	unsigned long flags;
+
+	spin_lock_irqsave(&nvmet_fc_tgtlock, flags);
+	list_del(&tgtport->tgt_list);
+	spin_unlock_irqrestore(&nvmet_fc_tgtlock, flags);
 
 	nvmet_fc_portentry_unbind_tgt(tgtport);
 

-- 
2.49.0


