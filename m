Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 903FDC3ABBF
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 12:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SEvzmKXxpa8ksOQYylXMo2JMjDuOUiTCCxYTgwkIu84=; b=0DaD03uU1pR4rz/xd0rT4JZ+n6
	FNq/lob56bQwc84a+lXbqz6rgq68/oHTiuURmmpppmVQCh0xRSfkSE0aZUu3N54Q1nAWguAoqcNU2
	HxbvW7d5BoOcjK64MazJeOYJtv3IvgWR05OUgfgf8PRRJ8NSweT4hvJCEVagikHAA9o5BHZVMCj9l
	SFOndEwXz0NZZbwt6foaUQ5MOfWf9xAT+U1i8Xm3Sr7r3a5P/ds9zoB4Whhm7Flfnhw+y8XhK6gP9
	doAPzaD61xcZGJyola40Exjzqvx4qen+lsRdSTsQARAb/MQAOiK860FvIRvGATK0INyRGNVQ6G826
	vSZSgz3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCdnr-0000000FMoT-0Rzi;
	Wed, 07 May 2025 12:23:11 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCdno-0000000FMn2-2hxz
	for linux-nvme@lists.infradead.org;
	Wed, 07 May 2025 12:23:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 636AE4A9C3;
	Wed,  7 May 2025 12:23:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D5EC4CEEB;
	Wed,  7 May 2025 12:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746620588;
	bh=Tey/jPpQIblgm+n0ERiQKMTVIjHrNonHGj1c23bE1TI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gZiN0O1lCHy/mbuM0dwpSBUZV366vh7C3QMSeCid5/l28x5EpygWDgVdbG9WCTsY1
	 xi0S8B12L/xNE/bdCWA2cHua9KO+61ursME2NNOhOAfJw848NjFiHix0vhlrhnLBWS
	 388KCJ9hMFuB3VKeG5OkjA7IzYzYx7LuUWCKs3E8YWkhDnrr1NJxq3Yivcg0cYxBSE
	 86HLHDoIoRJ/LXDXaaE637c8h70SgFp+gzuMYGrA+poU4nKCY5u1gRT/QfQ3PkrzZc
	 xV0UaQ29ie4KzUs+EDkKpojhrdF9I3WhKyP1zZ3GD3oSDoJ1RO/C1QrkhP0Mr9EMQS
	 0fUgPx93LYguw==
From: Daniel Wagner <wagi@kernel.org>
Date: Wed, 07 May 2025 14:22:58 +0200
Subject: [PATCH v6 02/14] nvmet-fcloop: remove nport from list on last user
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250507-nvmet-fcloop-v6-2-ca02e16fb018@kernel.org>
References: <20250507-nvmet-fcloop-v6-0-ca02e16fb018@kernel.org>
In-Reply-To: <20250507-nvmet-fcloop-v6-0-ca02e16fb018@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_052308_718753_03D90AD5 
X-CRM114-Status: GOOD (  11.68  )
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
 drivers/nvme/target/fcloop.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 2b23e43ef4403fa4d70c66263f7750165d2ddc72..2cce7649af276528360395b6d58f03183c11da20 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -1019,9 +1019,15 @@ fcloop_lport_get(struct fcloop_lport *lport)
 static void
 fcloop_nport_put(struct fcloop_nport *nport)
 {
+	unsigned long flags;
+
 	if (!refcount_dec_and_test(&nport->ref))
 		return;
 
+	spin_lock_irqsave(&fcloop_lock, flags);
+	list_del(&nport->nport_list);
+	spin_unlock_irqrestore(&fcloop_lock, flags);
+
 	kfree(nport);
 }
 
@@ -1414,8 +1420,6 @@ __unlink_remote_port(struct fcloop_nport *nport)
 		nport->tport->remoteport = NULL;
 	nport->rport = NULL;
 
-	list_del(&nport->nport_list);
-
 	return rport;
 }
 

-- 
2.49.0


