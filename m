Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4617ACC6B27
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Oct 2026 07:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Eqbwl8i4iagGFFSkVH0wQKx5RPaDdonVx8/YFLkVpmE=; b=kZFl3gah2hmTEqaS7OMdFAnosz
	oH1TIkKdzCJcBmnUAn8wOopTJtsTI2Z8x67/zn457WwkQo8KpO+C1nXj+d8KKgqXlbv3zE9tbm3Yu
	kuM82YVb/MFqhNohZZBQZW7V17ZEjHcS62txuFiCVGIL4Emszubc+Ddl6qEyX1rWdCd/w7PGHoYJW
	sNlZXrBgRJPjOSIudJCNfzJGeJuKWUL4KGGGffCkmbu1K7eN8hKKwy/zHVq2W4dgjwga8xrCmUeZP
	6SnUDJIbkOKFTfgoOqeWSy9aExtlceEP7bNtqHxZUh684tEpHfLqGU1hprQ/sMCb21HLjfe8ODDcb
	LzJAdkjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGtoL-0000000EpLA-3nvZ;
	Wed, 14 Oct 2026 07:54:05 +0000
Received: from m16.mail.163.com ([220.197.31.3])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGtoI-0000000EpKX-3bWF
	for linux-nvme@lists.infradead.org;
	Wed, 14 Oct 2026 07:54:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Eq
	bwl8i4iagGFFSkVH0wQKx5RPaDdonVx8/YFLkVpmE=; b=QrOnKpSkpEJAB/VLTy
	XNWRawMB8+A9bGPCXAjr3VSCNDaBxL1foEs4yFeiE1juHztbPibS2LfN1+7kBvLd
	kMXyHj3qkN1lTL15HVqMFuW2BKRO1b0VzO8CwtN9bJlueXzu4pTm78uDp6kqrTo3
	ecXJFKzOlV9nSDjJFgP8N77Bs=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgD3Xz_pNM9qjDEdEg--.38541S2;
	Wed, 14 Oct 2026 15:53:14 +0800 (CST)
From: kensanya@163.com
To: justin.tee@broadcom.com,
	nareshgottumukkala83@gmail.com,
	paul.ely@broadcom.com,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	TanZheng <tanzheng@kylinos.cn>
Subject: [PATCH] nvmet-fc: skip hostport ops when the LLDD has no host handle
Date: Wed, 14 Oct 2026 15:53:03 +0800
Message-Id: <20261014075303.277735-1-kensanya@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PygvCgD3Xz_pNM9qjDEdEg--.38541S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KryrJw4xAF1ktw17uw15Jwb_yoW8uw4kpF
	ZxtFnxKFy7GFWagwn5AFn5Jry2k3W8WFnrJrWfX398ZF1ft34rJrsxK3WvyrW5JF1fCa4U
	CF45XrZ5Jw15GaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jn5r7UUUUU=
X-CM-SenderInfo: 5nhq2txq1dqiywtou0bp/xtbC6QrVsWrPNOp08wAA37
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261014_005403_294157_9C957135 
X-CRM114-Status: GOOD (  10.42  )
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

From: TanZheng <tanzheng@kylinos.cn>

nvmet_fc_alloc_hostport() returns NULL when the LLDD passes a NULL
hosthandle. That is not an ERR_PTR, so nvmet_fc_alloc_target_assoc()
keeps the association and leaves assoc->hostport NULL.

Disconnect, association free and host invalidation then dereference
assoc->hostport. The disconnect comment already says an older LLDD
with no host handle should not send an LS.

Treat a missing hostport like a missing ls_req: do not send the
disconnect LS, do not put the hostport, and skip that association in
nvmet_fc_invalidate_host().

Assisted-by: Kimi:K3
Signed-off-by: TanZheng <tanzheng@kylinos.cn>
---
 drivers/nvme/target/fc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 1b557775e033..951be0bf7b54 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -483,7 +483,8 @@ nvmet_fc_xmt_disconnect_assoc(struct nvmet_fc_tgt_assoc *assoc)
 	 * message is normal. Otherwise, send unless the hostport has
 	 * already been invalidated by the lldd.
 	 */
-	if (!tgtport->ops->ls_req || assoc->hostport->invalid)
+	if (!tgtport->ops->ls_req || !assoc->hostport ||
+	    assoc->hostport->invalid)
 		return;
 
 	lsop = kzalloc((sizeof(*lsop) +
@@ -1176,7 +1177,8 @@ nvmet_fc_target_assoc_free(struct kref *ref)
 	/* Send Disconnect now that all i/o has completed */
 	nvmet_fc_xmt_disconnect_assoc(assoc);
 
-	nvmet_fc_hostport_put(assoc->hostport);
+	if (assoc->hostport)
+		nvmet_fc_hostport_put(assoc->hostport);
 	spin_lock_irqsave(&tgtport->lock, flags);
 	oldls = assoc->rcv_disconn;
 	spin_unlock_irqrestore(&tgtport->lock, flags);
@@ -1526,7 +1528,8 @@ nvmet_fc_invalidate_host(struct nvmet_fc_target_port *target_port,
 	spin_lock_irqsave(&tgtport->lock, flags);
 	list_for_each_entry_safe(assoc, next,
 				&tgtport->assoc_list, a_list) {
-		if (assoc->hostport->hosthandle != hosthandle)
+		if (!assoc->hostport ||
+		    assoc->hostport->hosthandle != hosthandle)
 			continue;
 		if (!nvmet_fc_tgt_a_get(assoc))
 			continue;


