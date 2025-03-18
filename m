Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9893C282EC
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Mar 2025 10:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uDCRLvCKB0ruGJ/+gczkieJH/Kf2Kzwafw1fGjHvJHQ=; b=nb8Tb3JYtg1zMQNICXvQW8GpB+
	GI+Ym/DddsLAdWIgPdLAaOrepP3+Y3mNB+FX8uhLu8GVHHBj2GdcIWor+o5aIcEnBzc9IpSh2mylQ
	XDviIdsQU3WuqdhQvS+i1yAJBXhP2lRX4oSC4ZMSps7llgvWmkiTateiR1cdqPO4MO/Xb+U8q/x7u
	kLRBWyDdUaqMIkm9AkaLuhIiaoNyApQsKSiJZK4EPwe67mXd/mSEbptUx8CT6ApQs+W5P8yBP5tLG
	vKVNtoxxtfHv3S5zRI4YGrPEfz0DsJ/AKNPLVpyxHWpLgqt25NE8/gNbGRSpJV5Te+uivnpQYUBsa
	7ZdIfmRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuUNA-00000005YDf-15VA;
	Tue, 18 Mar 2025 10:40:36 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tuUN7-00000005Y8y-1SBh
	for linux-nvme@lists.infradead.org;
	Tue, 18 Mar 2025 10:40:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E4E0A5C58A8;
	Tue, 18 Mar 2025 10:38:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3427BC4CEDD;
	Tue, 18 Mar 2025 10:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742294432;
	bh=JC937a4WiT0yhSJrrMII/tHbHGidchlnnE5lLue4zIg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Xp3U6+ri9/AyBtjKRjeCoDwn8OB2dqNIF6QZ6v46Y1dU0qna4dGYJ+GsAAI7CRBQq
	 J6C4FW8kc/vbT6AOCXIJLwes7r2YKs5gd+Sr9Cl22k/6HWxZYMiYX98PGA0Ykt2ek6
	 rtA+UrjowDSFqo7MmsdskHEsCxfQpXXukFmYNZJGjyw9iWdJHLvwn8hy75Ynebys4s
	 d6wjiUffsXL9h3aKsv0XIc8RFlEFDSLIdFy5bDeuEFajAhKEZC/sxUI9gqOEpP7TRc
	 WVs0Phb4JoahLHxkThtmkqoIYqDOFsjHGtlBoYFOApnwPInx/RvqSofEkBcCTXfJeE
	 PJ8LYKGfGwbaA==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 18 Mar 2025 11:40:06 +0100
Subject: [PATCH v3 12/18] nvmet-fc: inline nvmet_fc_free_hostport
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-nvmet-fcloop-v3-12-05fec0fc02f6@kernel.org>
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
In-Reply-To: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250318_034033_445755_D42CC5C7 
X-CRM114-Status: GOOD (  11.84  )
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
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fc.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 05290506602469fc98d8463d0f1fcb6cf2422fde..20ea3acd7a5ff6f7c27b55b8c00f22b2a0768b7b 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1007,16 +1007,6 @@ nvmet_fc_hostport_get(struct nvmet_fc_hostport *hostport)
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
@@ -1196,7 +1186,7 @@ nvmet_fc_target_assoc_free(struct kref *ref)
 	/* Send Disconnect now that all i/o has completed */
 	nvmet_fc_xmt_disconnect_assoc(assoc);
 
-	nvmet_fc_free_hostport(assoc->hostport);
+	nvmet_fc_hostport_put(assoc->hostport);
 	spin_lock_irqsave(&tgtport->lock, flags);
 	oldls = assoc->rcv_disconn;
 	spin_unlock_irqrestore(&tgtport->lock, flags);
@@ -1459,11 +1449,6 @@ nvmet_fc_free_tgtport(struct kref *ref)
 	struct nvmet_fc_tgtport *tgtport =
 		container_of(ref, struct nvmet_fc_tgtport, ref);
 	struct device *dev = tgtport->dev;
-	unsigned long flags;
-
-	spin_lock_irqsave(&nvmet_fc_tgtlock, flags);
-	list_del(&tgtport->tgt_list);
-	spin_unlock_irqrestore(&nvmet_fc_tgtlock, flags);
 
 	nvmet_fc_free_ls_iodlist(tgtport);
 
@@ -1624,6 +1609,11 @@ int
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
2.48.1


