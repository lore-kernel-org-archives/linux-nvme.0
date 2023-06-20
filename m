Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B94BC001DD
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jun 2023 13:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AoMZL1WwymTBvZ61qjY9sbo9USVmC0X8xg8UjUonl4A=; b=VueOY6nAC9upfm5CgjIiZ/Qji6
	7EC2j+ZkLBL9iumPJn3SI/DRfhGgwQ4fdeHbBHA8XeuOG/5Ygi2g/Y2vg/MLFaGxBs1dLP/+O09Xu
	hh6iIydW7HyhP5ZniFvMnYtaTgmPPtsnor9o37VgVqzF+XT2ryC2tEq09udFqbcqLOdbAO/WlHB5+
	Gx/GBxGx4VB00AXg+D6xx6qRq2ywHNA7hg23s5M33rX63GpJGM6DI0b7hh07V/aB/JhPORuamU7FF
	inGmLlQYfePLo0r6cz5H94IfszBF/j4clZjXP3QSWCHvJep8Y9BwWUP4x4XuJznx5OuIryOTGlbrP
	mKXliJEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qBbXx-00BPK3-1E;
	Tue, 20 Jun 2023 13:37:25 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qBbXt-00BPH8-2V
	for linux-nvme@lists.infradead.org;
	Tue, 20 Jun 2023 13:37:23 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 940AF2188D;
	Tue, 20 Jun 2023 13:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1687268240; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AoMZL1WwymTBvZ61qjY9sbo9USVmC0X8xg8UjUonl4A=;
	b=OWTGwb5PmWPvgTs4ihl8fxMWI///A36cKf5WeAbNCu601m4vN0ldARu/BQ//QLziAwcz8t
	h/N8W//yPtvTrgAdLpVGh6N2SPD4vHBl4Hd6LD2ZOuqme0BgGI5FVdiehP32Oz5yMoMUBU
	U0RdAAFFQoO4e8OTinYK57Khx1G0nHA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1687268240;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AoMZL1WwymTBvZ61qjY9sbo9USVmC0X8xg8UjUonl4A=;
	b=FRb75r7X5FkD0FMF6W6slG8sF33HBMQnQ8dRsLZWrfSlyAZERWF98Jx4wPvs8AR38PLwHG
	eDbZcwDtcWnmWTAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 853CF133A9;
	Tue, 20 Jun 2023 13:37:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id z4BIIJCrkWTCPQAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 20 Jun 2023 13:37:20 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	James Smart <jsmart2021@gmail.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v2 3/5] nvmet-fcloop: Remove remote port from list when unlinking
Date: Tue, 20 Jun 2023 15:37:09 +0200
Message-ID: <20230620133711.22840-4-dwagner@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230620133711.22840-1-dwagner@suse.de>
References: <20230620133711.22840-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230620_063721_955446_7B77278A 
X-CRM114-Status: GOOD (  13.41  )
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
index 4b35bdcac185..9f7530147893 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -995,11 +995,6 @@ fcloop_nport_free(struct kref *ref)
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
@@ -1357,6 +1352,8 @@ __unlink_remote_port(struct fcloop_nport *nport)
 		nport->tport->remoteport = NULL;
 	nport->rport = NULL;
 
+	list_del(&nport->nport_list);
+
 	return rport;
 }
 
-- 
2.41.0


