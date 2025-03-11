Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B97EBC28B2E
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Mar 2025 10:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=caImqFKY1OWhG0J2lguQx7P3mXyXUPzEcDJDZUxh2YE=; b=e6L2l8hCZXGIorXxPD1hFFz5PW
	e+3GCV0daONmRDW4UQZKmLbFFC+/Lh+M/uWX7gTIOF+4a5rwwm/x0JJP38A3A3cUGlfyXDX36pzdM
	ld7wwKRlpqqHXq7pTCWgECQZHyCDtl/dHRRKmvltDiSQS/dFt0KwC9nciHOQr7isD5QgfsUPWtE4P
	hyUWy+pXDVlys7vSsGjL2wiitjhp6q5t4kwK7RqX78tZcs/KdYWA1hHxhCY8iZBVmGldZfKAW70L7
	Nt76tO/T9PHRdifFalSMauvKxEt66UVdGg78Z8HpTWZ6A1dh7r7BOrwVY+ZsRaY3TYxMB2yLKSR7K
	0K0geUNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1trwaR-00000005G1S-1alt;
	Tue, 11 Mar 2025 10:11:47 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1trwaO-00000005G0b-3GDL
	for linux-nvme@lists.infradead.org;
	Tue, 11 Mar 2025 10:11:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 7B5105C5D75;
	Tue, 11 Mar 2025 10:09:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F1BC4CEED;
	Tue, 11 Mar 2025 10:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741687904;
	bh=MDYxwyBzQKrmV0tTE4ueZcBadH+sNzw7R8Ql8WpB9yo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ND1IwkIIk0V5C/IPLyWxnqM0wIamp0hbqGWdNmMU/zWC3XXyfZCSr//3pPxmzeWw2
	 6o+NjpxmU33U1QKtqskkwgAMslmL8ABuJ2qtIWYctIkSB9HM+BzV55PiVqjEGUk4Vm
	 fx5Nlq2YPXSOcqENUp0voS5j9fAdqGxFbRcmsAPIIafr1whAoHQKXYHJwFxPbPtQ3K
	 ROS+sv+luyfTaT0QnFB110O0qcglTZNeLiG1f5wy4D1lfLcCD32jOuS8ZfWELF8a6m
	 sAj5oIJUrbaZpY4RPQBxwlAteFZcSnaNGecYciSFp6VkAzy1OYf+/PP7P3fMsbGC2S
	 p5Lvo8jc2Gg+Q==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 11 Mar 2025 11:11:27 +0100
Subject: [PATCH v2 01/15] nvmet-fcloop: remove nport from list on last user
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-nvmet-fcloop-v2-1-fc40cb64edea@kernel.org>
References: <20250311-nvmet-fcloop-v2-0-fc40cb64edea@kernel.org>
In-Reply-To: <20250311-nvmet-fcloop-v2-0-fc40cb64edea@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250311_031144_860571_0A777380 
X-CRM114-Status: GOOD (  11.48  )
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


