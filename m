Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F6A4C77B76
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Apr 2023 13:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xHvZovTrRuZrCOEGfusLwQUaUkaDOrzb+7eR8e2Rvs8=; b=29xdD9qxpixix8vHmhzhd1jKjH
	rMbrN3FFC89ZJHlzYlJXxbwlH0PgA8ABhPKt5Y6mswus2yV5/cGl8sKwF+98Jrl/vraDPUSOXaXYY
	T0sP3bwqCBlWg2rrsNBJLGUHDttNoWPw42YYNo+DN/JM8JO0DQKeCGX7ViO9cJacXL5Y8GTqyWugE
	M6pCKuwOgsozYWJLgAZG9CBYajhjob7cmhKk9SyHnkqY2apSN4BlqGpZtrbJO7S7lhaHxN46BK0Ge
	3RdA77mW9owTfhe5XgabtEJIaCPFb6z3SNOIIx2MHuxpsIb6TbrNLTTpQOJtQ96V9ugk8rJNzzMsP
	zhsyeAVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pokyQ-002DKQ-2E;
	Tue, 18 Apr 2023 13:02:18 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pokyM-002DHU-0c
	for linux-nvme@lists.infradead.org;
	Tue, 18 Apr 2023 13:02:16 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6FA4921986;
	Tue, 18 Apr 2023 13:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1681822930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xHvZovTrRuZrCOEGfusLwQUaUkaDOrzb+7eR8e2Rvs8=;
	b=Pth/OjEIF+iAJtaKL48n4fYL7h2eaUVtFj+NqwQjQABxLdzHi4AMN84J4k1Ucqv+7QPnJ1
	KiZjqvyrCW9vTEjkytguqTtifeMvKCkMXTzfWwAfz9daooI29T84piBkqb98osw6U69AMr
	hnU+VGdJ/nxJoDihIPExvvQ/m1uGHbc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1681822930;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xHvZovTrRuZrCOEGfusLwQUaUkaDOrzb+7eR8e2Rvs8=;
	b=+t33Z/TwSQlmtp9hskJC+ufgtV99df5LInSy+WaZ7NPA+LBpG13Y3GcfrfXUKOC2Moh7UM
	amIqVMbPnzMBSxDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5EEBB139CC;
	Tue, 18 Apr 2023 13:02:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id ATI7F9KUPmSEJwAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 18 Apr 2023 13:02:10 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v3 1/4] nvmet-fcloop: Remove remote port from list when unlinking
Date: Tue, 18 Apr 2023 15:01:56 +0200
Message-Id: <20230418130159.11075-2-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230418130159.11075-1-dwagner@suse.de>
References: <20230418130159.11075-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230418_060214_377466_95B751B5 
X-CRM114-Status: GOOD (  13.60  )
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

The remote port is removed too late from fcloop_nports list. Remove it
when port is unregistered.

This prevents a busy loop in fcloop_exit, because it is possible the
remote port is found in the list and thus we will never progress.

The kernel log will be spammed with

  nvme_fcloop: fcloop_exit: Failed deleting remote port
  nvme_fcloop: fcloop_exit: Failed deleting target port

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/target/fcloop.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index c780af36c1d4..629a90fe4306 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -997,11 +997,6 @@ fcloop_nport_free(struct kref *ref)
 {
 	struct fcloop_nport *nport =
 		container_of(ref, struct fcloop_nport, ref);
-	unsigned long flags;
-
-	spin_lock_irqsave(&fcloop_lock, flags);
-	list_del(&nport->nport_list);
-	spin_unlock_irqrestore(&fcloop_lock, flags);
 
 	kfree(nport);
 }
@@ -1358,6 +1353,8 @@ __unlink_remote_port(struct fcloop_nport *nport)
 		nport->tport->remoteport = NULL;
 	nport->rport = NULL;
 
+	list_del(&nport->nport_list);
+
 	return rport;
 }
 
-- 
2.40.0


