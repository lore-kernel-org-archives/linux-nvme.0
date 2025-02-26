Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F5ABC19776
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2025 18:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=96EZn/HgA9E97gIimGJgnY/7VcVWYf8bHQlbjPiXLVY=; b=u6Y2li/l8pbvV3esw/WQbe+4NZ
	nJFYn6FRpxdavFZyRrkJ0MYi4BNCXUSau/Vjc0NlbKPpj0m6ZaiXLOqWeXYQ5oJ+xez5T9Sgzo34p
	ix0BEg0S3RDqcPxYQDdpe0nDlPYZxm4QuRU+O21DBl8+/oW5HE5EbFVpDS0Xl7lA+nE4KB74bYyFO
	t9mT+RNdDivTLxNouHuu7tgTs9fs3nluSpaPh5X95u37ZHUrVKQcriuzGYAUNXMA+j4A7bi1SI65B
	mGeJFB9l9k/ygVVINKRkbE1p2eSlu9juXbHX/RF0a39zKagnIZsudj/rTwXuJsw4eMuxQ9hzcQNq6
	2MgWcyeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnMPx-0000000506C-2hvC;
	Wed, 26 Feb 2025 18:46:01 +0000
Received: from tor.source.kernel.org ([2600:3c04::f03c:95ff:fe5e:7468])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnMPw-0000000505P-1JEu
	for linux-nvme@lists.infradead.org;
	Wed, 26 Feb 2025 18:46:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id D038D61548;
	Wed, 26 Feb 2025 18:45:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13BA2C4CEE9;
	Wed, 26 Feb 2025 18:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740595559;
	bh=Kc4e83KgunYQeubPAAe08urkDG6fAFT7j2kclg3zHWg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eGEMDyIZtQQ7R0NoksWK/rVAa1ueZlaZXWjk0D2OqfnYfobPXyWares5WRQs0LwaP
	 xbwFkJE0B/8UHMx7/nrtOfBQCfXRm/klF66DlNKAH3z4m6gUbN/0X/yyAQsc0YTsOP
	 8hQO/9uQoHDVrohmqojwC25EwO6LR2e0Rm0AI7Aiw6BQ4EOq60iPAM4Y9zUryZ9Swi
	 1E2i+Piv6aWPqL/Kcy9UJ+tcqGrOg76vYxCTyJgILNhHjfae55vwdXotsq8bm1JBsF
	 D0b9z1vDeA/YMDW7M9nJl2thHuQvY4mglFnnQzdpPdvZyALGblOL01cYlPdcjBbRoY
	 BuQQaMKmJLwVg==
From: Daniel Wagner <wagi@kernel.org>
Date: Wed, 26 Feb 2025 19:45:53 +0100
Subject: [PATCH 01/11] nvmet-fcloop: remove nport from list on last user
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-nvmet-fcloop-v1-1-c0bd83d43e6a@kernel.org>
References: <20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org>
In-Reply-To: <20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
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

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fcloop.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index e1abb27927ff74c9c55ddefd9581aab18bf3b00f..5493677a948d34391c7c08055dfefd91cc3ff33f 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -1005,6 +1005,11 @@ fcloop_nport_free(struct kref *ref)
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
@@ -1363,8 +1368,6 @@ __unlink_remote_port(struct fcloop_nport *nport)
 		nport->tport->remoteport = NULL;
 	nport->rport = NULL;
 
-	list_del(&nport->nport_list);
-
 	return rport;
 }
 

-- 
2.48.1


