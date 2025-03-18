Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98F32C28B28
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Mar 2025 10:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OJwyb+TfU7mV0CiNq8BsKihXmqlx3FO3Qy6jNlQvfOY=; b=xuRkSzmOXgqnAQBwSAuLElvPE+
	X6R3CuToA0iKJvXVRoOoTAWFHnUbaWLkRGpibf2ufR93LBY7SlynqEKDlAkI2oFo/hCgGOPvrraIS
	Dr++09Tigg+PvSFdFVD52XGcIIvUvC5fr0VDmZilJuPzvmZ3axW4EM5aoHGVkWbsw8VZS+QBvazim
	sMZv/o6defbBQSHjhJSA+lLXmz0aeUsoaBMbYMNi28gAJ/sorbv+6I6z9gzu18/bKj6PJ05N1CH5x
	65Tu306/xXTNza+Pfeq3UqDf9aZteX7jJqghTsDDPK48Y8AoGeUm4noBTI4OdxEJEXZbLeXs7a9d2
	JtOXx8wQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuUMn-00000005XjY-37kc;
	Tue, 18 Mar 2025 10:40:13 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tuUMg-00000005Xgv-0AGh
	for linux-nvme@lists.infradead.org;
	Tue, 18 Mar 2025 10:40:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 92BE65C58A2;
	Tue, 18 Mar 2025 10:37:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACEC0C4CEDD;
	Tue, 18 Mar 2025 10:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742294405;
	bh=MWm8eqM6Uuk9iRoCyRSd03Uok+xmCB8TLkbHS2USEkw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=T+Wxssv1ktILToEPxp0tOGXSSNJ5BxgwAzRuiNw98ibxuMAycNI6FdRmPLWoNVw5Y
	 +zeVd9+Z/dzdWAkU2XfRDbs4KupVE+TGcgMMliWNyS67G9Sl40fhRXkskYNe8Zg+qJ
	 RNju43IlP6EcgB16p8WdMcpBF2xGrhuRGW7U49SUrFINpY+sxQ9asuYcD3XHqtTcf8
	 NO5Pb66yAO2jzrZ2wxHpyKeJ6fXNd1LrRK3swJu/X3yHLt728bv2eA/cJEkkyvJEzd
	 86FgohH+DoSQb5s8Sjd6j2aFQuRVWJEOPsCfMbMXcIGi2TXCo0pXD73FrhTPLQMe7j
	 /GG0hWuYVhRGg==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 18 Mar 2025 11:39:55 +0100
Subject: [PATCH v3 01/18] nvmet-fcloop: remove nport from list on last user
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-nvmet-fcloop-v3-1-05fec0fc02f6@kernel.org>
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
In-Reply-To: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250318_034006_126645_B533E3FA 
X-CRM114-Status: GOOD (  11.61  )
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

The nport object has an association with the rport and lport object,
that means we can only remove an nport object from the global nport_list
after the last user of an rport or lport is gone.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fcloop.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 3390215b1c1f040001985a0d33741e57f1f80cb3..09546c3161fd9828234e58641de3e53519e27824 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -1004,6 +1004,11 @@ fcloop_nport_free(struct kref *ref)
 {
 	struct fcloop_nport *nport =
 		container_of(ref, struct fcloop_nport, ref);
+	unsigned long flags;
+
+	spin_lock_irqsave(&fcloop_lock, flags);
+	list_del(&nport->nport_list);
+	spin_unlock_irqrestore(&fcloop_lock, flags);
 
 	kfree(nport);
 }
@@ -1362,8 +1367,6 @@ __unlink_remote_port(struct fcloop_nport *nport)
 		nport->tport->remoteport = NULL;
 	nport->rport = NULL;
 
-	list_del(&nport->nport_list);
-
 	return rport;
 }
 

-- 
2.48.1


