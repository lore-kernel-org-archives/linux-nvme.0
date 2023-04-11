Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 767B2C77B70
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Apr 2023 12:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AM9IzWlxFgnv2yBc55OQqOy6rxrdVVGUpc9W9P8C1kk=; b=wR1bSa95QVNIr93mh7EfNL+Dj7
	7N6NHvgLYZxC9d56GkqAFcUSkfJiydFG9Tke7aPmGh2kShYLGv0VfosTBTof+gnTZ8rJ6Flx9Owly
	DJDKE0/P9MCkZT4SB3rIMSFR0uu82gY3e+YHKBZkpEvi4V8+DzBjkXlzRRgjmW0OXRnSv48vtbCLs
	RQ3OqCsbPUq2LNHdFXY7540lO0gAVMm5H6AyfrJ+Y8N8FrpLeg8O8a+6L2pDsm3OwEmp8pZOsmRTV
	6WRG63DdxmA50HIbvZ3vyI2z1Jw4QEwaJgijs5sD7NV2EhtHn3Put4atub2FH7rcgZDqEHpKSHhoo
	zviXANSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pmCmg-00HVXl-2g;
	Tue, 11 Apr 2023 12:07:38 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pmCmZ-00HVSa-35
	for linux-nvme@lists.infradead.org;
	Tue, 11 Apr 2023 12:07:34 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8C0EC21A54;
	Tue, 11 Apr 2023 12:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1681214846; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AM9IzWlxFgnv2yBc55OQqOy6rxrdVVGUpc9W9P8C1kk=;
	b=RCcSRQDDXUpduzhYh4BPlWyt2F+66XGCyV33bTQxIFpZODzNCy5RlSDaFo7PE5VOZ2Knsf
	zLPFpb4k4+MGfuhnqiPljC4jrat9AgRi/52YhSf8ROdMaE1WJorJKlaq4XTqW9U4o6lKDm
	rXEysvyuuDD9bu/DYjwOxkoBI526Yy4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1681214846;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AM9IzWlxFgnv2yBc55OQqOy6rxrdVVGUpc9W9P8C1kk=;
	b=mst0K5lD3ygsXLl/DIWPSH8p8XbhhthNeMpFoPLhlYmkYOSrg3R3c3M+n+3FcZyzr3DkAH
	QdDmmvAcy/5I0OAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8053113638;
	Tue, 11 Apr 2023 12:07:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id L4knH35NNWR7BgAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 11 Apr 2023 12:07:26 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v2 2/4] nvmet-fcloop: Do not wait on completion when unregister fails
Date: Tue, 11 Apr 2023 14:07:16 +0200
Message-Id: <20230411120718.14477-3-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230411120718.14477-1-dwagner@suse.de>
References: <20230411120718.14477-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230411_050732_136131_A76F6846 
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
index 1e53c8fe4b95..6c3905498a94 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -1162,7 +1162,8 @@ __wait_localport_unreg(struct fcloop_lport *lport)
 
 	ret = nvme_fc_unregister_localport(lport->localport);
 
-	wait_for_completion(&lport->unreg_done);
+	if (!ret)
+		wait_for_completion(&lport->unreg_done);
 
 	kfree(lport);
 
-- 
2.40.0


