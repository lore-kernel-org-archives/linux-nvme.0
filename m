Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF501C369A9
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Apr 2025 11:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SEvzmKXxpa8ksOQYylXMo2JMjDuOUiTCCxYTgwkIu84=; b=qyo8olrEmKA764d9UPilvZWdxS
	yMvC4NHbdyunLLTJd/2kdITjKIUxmAUZ6UcqIV0gsYub6OZ56crT0bo9N/Fx6n7YVlRIzXg8onRN4
	gn1PJHhRqnB9D5121Izlu8cUjlAUMlZsG/Dzjs9jo9g+H/H1KFbQUpreAcgLih5s+Opi4cAUbM+Mb
	aeUJwvRUORDLeKH9Gdw54YBhe94SRO5PORXUSNCaGWw4304lsPLx5C6Oc/mV/ar4wV/87SbFinX4T
	FXvBZ3W3BHvPh4S9zjt0VsH3xeJcNvdIueiyVdDhuDh/0Ulu4p3Zf9dfSqhfXeeD6pAKVWsoHGQM+
	fdqOwLSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2qN0-0000000AM0t-10xt;
	Thu, 10 Apr 2025 11:46:58 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2qHU-0000000AKor-3fod
	for linux-nvme@lists.infradead.org;
	Thu, 10 Apr 2025 11:41:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 413725C1043;
	Thu, 10 Apr 2025 11:38:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A27F9C4CEE9;
	Thu, 10 Apr 2025 11:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744285276;
	bh=Tey/jPpQIblgm+n0ERiQKMTVIjHrNonHGj1c23bE1TI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mqIjYDlLXig4f1bLZyKqHY6vo2hLsJSz7sogICU/asF+8rnxjO5aTpy1lw9I8wYH5
	 Ux41jY72blOsdUitvFUB4nnIL6/I/gkuVrloxalfSuMqOkZVaiTb6T6Kvc6829mOPz
	 aPXt95JlG0SxrucOnVbPJb/RExa53TmCz+paac1S7T9CSIlPuFI/d1UKqEKvwpb1SW
	 PJMJK6j1mhgqvgxCElQ9P+sART/8M14gZ+nOBqp3oXL/dnE85QeogSA5bvE8OC5G6A
	 CoJyA+VkIUwHCAU7NOPFvOiqu/gwy5qmL42zhPiyraWTPO67aIVskseLDDLs4VmZ9C
	 xaw+G2JsywR+w==
From: Daniel Wagner <wagi@kernel.org>
Date: Thu, 10 Apr 2025 13:41:05 +0200
Subject: [PATCH v4 02/14] nvmet-fcloop: remove nport from list on last user
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250410-nvmet-fcloop-v4-2-7e5c42b7b2cb@kernel.org>
References: <20250410-nvmet-fcloop-v4-0-7e5c42b7b2cb@kernel.org>
In-Reply-To: <20250410-nvmet-fcloop-v4-0-7e5c42b7b2cb@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250410_044116_960445_6801B94C 
X-CRM114-Status: GOOD (  11.50  )
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


