Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B61AC35FFC
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Mar 2025 10:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wGnsF8+4GUaZ26xBkuVaNb+jheKkyYdI4Ksvk1nSWEA=; b=dadWxLKJFqCyEcnO6NeOhuLS6t
	73zlxazUD6YzDQ0rHa6c7YQliW7LW7mkjU4WJDw/fyXBIHOfB2Fr61qJrT/0mRh3SVGmttmCc3sgj
	Qoei6HnTp9bVOTCjEbvswQR8vmur4HTRYupldEf2X2GROBhDzqgjw46ty4n1HXq6cUNMcs3gSQe+r
	MKlqzCSWBe0N2iqbfg+NguK2IHHtkbXv8ilLw0TqHHuO0U4clzQVeENAL+mEXui+CuwLjDy7+QoYh
	+aON00jpNFhA6ISp8E0v3lWxD8SpkK9otFNfvofxarvxf5cyBUMoO7+oktU8J8P+5b5tGzQ2F17rh
	8jNxMEtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuUMu-00000005XqD-3KDg;
	Tue, 18 Mar 2025 10:40:20 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tuUMs-00000005Xng-2hmv
	for linux-nvme@lists.infradead.org;
	Tue, 18 Mar 2025 10:40:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 4F8A9A48F35;
	Tue, 18 Mar 2025 10:34:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A158C4CEF4;
	Tue, 18 Mar 2025 10:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742294417;
	bh=RpLuvQFkZ8DvcX0vAWLUD6hAcQKXufgx2o9rvMpsw7A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WdbMf4JvVkLm0K9jkxRzemTsQahyy22UPXJ4X+aFwp6tx/j3DmRAO7HVFcxqZMZ9J
	 rYVH19fybw09AiRU4rwDXerVizpdws3bF1v2KfUBXZ7dF3NvF42cdixJRQP7vJTM5V
	 BX7LOcgnvBugxib6VgSh+F0pqs58o8GepV6EVtzs9uP1nBG0535JahOcXaJAmbceiq
	 rtrfAafzBIHFNfCHBw/mnNgUngzbvvOf0yXYEY6Fup6ARggbpyQeBD9CGHJCoCEgV7
	 WubHktI9+DiR3m6Pt5Vv4RB5fymiToMlt4R/JW7mQs1zUg3MxJ7Z6VuNmPrJZ2SbJI
	 UTaOEblb3Aidw==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 18 Mar 2025 11:40:00 +0100
Subject: [PATCH v3 06/18] nvmet-fcloop: sync targetport removal
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-nvmet-fcloop-v3-6-05fec0fc02f6@kernel.org>
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
In-Reply-To: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250318_034018_756957_DFCBA3E6 
X-CRM114-Status: GOOD (  12.88  )
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

The nvmet-fc uses references on the targetport to ensure no UAFs
happens. The consequence is that when the targetport is unregistered,
not all resources are freed immediately. Ensure that all activities from
the unregister call have been submitted (deassocication) before
continuing with the shutdown sequence.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fcloop.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 69121a5f0f280936d1b720e9e994d6e5eb9186ff..cddaa424bb3ff62156cef14c787fdcb33c15d76e 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -239,6 +239,7 @@ struct fcloop_nport {
 	struct fcloop_rport *rport;
 	struct fcloop_tport *tport;
 	struct fcloop_lport *lport;
+	struct completion tport_unreg_done;
 	struct list_head nport_list;
 	refcount_t ref;
 	u64 node_name;
@@ -1078,6 +1079,8 @@ fcloop_targetport_delete(struct nvmet_fc_target_port *targetport)
 	tport->nport->tport = NULL;
 	spin_unlock_irqrestore(&fcloop_lock, flags);
 
+	complete(&tport->nport->tport_unreg_done);
+
 	/* nport ref put: tport */
 	fcloop_nport_put(tport->nport);
 }
@@ -1507,7 +1510,17 @@ __unlink_target_port(struct fcloop_nport *nport)
 static int
 __targetport_unreg(struct fcloop_nport *nport, struct fcloop_tport *tport)
 {
-	return nvmet_fc_unregister_targetport(tport->targetport);
+	int ret;
+
+	init_completion(&nport->tport_unreg_done);
+
+	ret = nvmet_fc_unregister_targetport(tport->targetport);
+	if (ret)
+		return ret;
+
+	wait_for_completion(&nport->tport_unreg_done);
+
+	return 0;
 }
 
 static ssize_t

-- 
2.48.1


