Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DD4DC7EE24
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Jun 2023 12:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wb/zjNGR8vZ6lz2lsTJaQdU6G03xji6YZEjNm9p9xpM=; b=H9zLFWtcoWv/wTnirj50Zso52D
	vPCVucYiR/y4tUcHYMRcISl7NQGdnKSr0ggIhQHhY9qo1d/wO8nxgZkT0/GjW1zfmP6BPFRDyYGPB
	ZJCVXfnPADtzmoES50T7XUEf7hl11Q9pkuOd/IC/Gf7xnRUZGA45kiy4Ql9kOvpLh1sr/pdSmUzZ8
	2quPTgPDTXzjAulP4QVJXtyOdotWD7GCbjDJvB6LL6Iab7aNdlffXzfesOMgsPassjnHY4y5RVrLY
	HhkUSJjiH0ZBb1kdLB7NT5ROS5eQjq8n2BQKQS04dvwPe4MUeAuyL3GT/WrP2jcs33ZzfLyjh7UEc
	S+HpGavQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6Vji-001cfy-0e;
	Tue, 06 Jun 2023 12:24:30 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6Vjf-001cdX-19
	for linux-nvme@lists.infradead.org;
	Tue, 06 Jun 2023 12:24:28 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5A2321FD69;
	Tue,  6 Jun 2023 12:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1686054263; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wb/zjNGR8vZ6lz2lsTJaQdU6G03xji6YZEjNm9p9xpM=;
	b=XbRAzKIk+8BwZMJqCTkROBCnYCApL5tn3HVK3mLxE01nMJ13uoOtRVNt7R452KNNNUiXNz
	CP85SeKxXqHb1GIMAWU+Z+jF8oTf/FjHldEzmA42cnXvMU7brPyiAX8CgoWEwLy7uIHc8Z
	g8jX2KkCSzVJTw+ufERjCA4U8dZe84k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1686054263;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wb/zjNGR8vZ6lz2lsTJaQdU6G03xji6YZEjNm9p9xpM=;
	b=cqVAqDwKfn7FglB6pJlPli5dVhc49ugHt/54UYqQV+sO+PsyKWwb/p5I0iUShcsrNtIjaU
	iUVuONkOQcHmTWBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4CA9E13519;
	Tue,  6 Jun 2023 12:24:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id Rw6PEnclf2SDOAAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 06 Jun 2023 12:24:23 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v4 1/1] nvmet-fcloop: Do not wait on completion when unregister fails
Date: Tue,  6 Jun 2023 14:24:11 +0200
Message-Id: <20230606122411.7972-2-dwagner@suse.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230606122411.7972-1-dwagner@suse.de>
References: <20230606122411.7972-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230606_052427_534794_5D4C4954 
X-CRM114-Status: GOOD (  11.93  )
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

The nvme_fc_unregister_localport() returns an error code in case that
the locaport pointer is NULL or has already been unegisterd. localport is
is either in the ONLINE state (all resources allocated) or has already
been put into DELETED state.

In this case we will never receive an wakeup call and thus any caller
will hang, e.g. module unload.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/target/fcloop.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 1ab3d900f2bf..c65a73433c05 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -1166,7 +1166,8 @@ __wait_localport_unreg(struct fcloop_lport *lport)
 
 	ret = nvme_fc_unregister_localport(lport->localport);
 
-	wait_for_completion(&lport->unreg_done);
+	if (!ret)
+		wait_for_completion(&lport->unreg_done);
 
 	kfree(lport);
 
-- 
2.40.1


