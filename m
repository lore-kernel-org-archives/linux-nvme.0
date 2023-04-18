Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA5E4C77B75
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Apr 2023 13:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5g2m9cdhDFuckoCqEKdoJuXLXK61genfhZXKo2FvJPM=; b=L1KGYQAeNI0o9lNbnpnOEuuz4U
	82lLponxwRVpIlnw5K8+zzO8kYPOYwi7vRLdbIBKD/NZHPA96kh9OSs9mSzgsNYTicCLljCKI/oR0
	ARNqFknxmRJXuR1LC7QBT3ufPNnm0CgvLDOqJyGWwh+WFBJf1WmoFAjPKflJInFD4At2zAQs9h33P
	P7JnDld+Ls0o7d7eKeORdBPHBx6fKbPwHdqwU0Soc3smLpnARiE3d/+c7S2+wWJ0NYMZEksG5Xaj8
	2ey26hey4MALo5yjmsCiy2+HKXBFCtTv9GN13Wl0+81hHDc9qCH1SxI4NTP7e8c4d2qORErFExYsa
	vYIzKTDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pokyO-002DJF-0j;
	Tue, 18 Apr 2023 13:02:16 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pokyL-002DHW-1R
	for linux-nvme@lists.infradead.org;
	Tue, 18 Apr 2023 13:02:14 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 23EB71F8D5;
	Tue, 18 Apr 2023 13:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1681822931; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5g2m9cdhDFuckoCqEKdoJuXLXK61genfhZXKo2FvJPM=;
	b=lc1/ke99ZqNTootV2UfmpxNzV5L/dqCzxEu2E/KslbltKBcQqpu/J+JzXvDKdUDRFEfXFO
	9NRMvGzSWM4nwIEyFA2cwsqLEhb+voC45PGEk8K+PhFpZteYuImCpYLQrS4fESQ7cTacRE
	I6jW3JTVYwDiENs+OgbFXOZqPaD8fqk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1681822931;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5g2m9cdhDFuckoCqEKdoJuXLXK61genfhZXKo2FvJPM=;
	b=YZYmCE5dO+lD/Uw9acR0E8Bgo4py4Uli0L+em/DUjLlbgdz/RTVlZsjRTCWfmRwZwtuf12
	6h0mBsmUdG4ce6Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 14A99139CC;
	Tue, 18 Apr 2023 13:02:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id oC4HBdOUPmSKJwAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 18 Apr 2023 13:02:11 +0000
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
Subject: [PATCH v3 2/4] nvmet-fcloop: Do not wait on completion when unregister fails
Date: Tue, 18 Apr 2023 15:01:57 +0200
Message-Id: <20230418130159.11075-3-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230418130159.11075-1-dwagner@suse.de>
References: <20230418130159.11075-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230418_060213_635303_25BCF521 
X-CRM114-Status: GOOD (  12.01  )
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
index 629a90fe4306..57b2d47cf640 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -1163,7 +1163,8 @@ __wait_localport_unreg(struct fcloop_lport *lport)
 
 	ret = nvme_fc_unregister_localport(lport->localport);
 
-	wait_for_completion(&lport->unreg_done);
+	if (!ret)
+		wait_for_completion(&lport->unreg_done);
 
 	kfree(lport);
 
-- 
2.40.0


