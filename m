Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D890CC76196
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Apr 2023 12:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NfxBQ+YwCQT4C500tsTvYDqFoF6jclwkqD6YJhX2o+Y=; b=TW1pxa6SXYCYMwB9ibpLLdTDu4
	bPSwrHpo7xsZvM2NsmrGm2u44JbxtTHKqNBW8+OIeVg82e1R4wMeZ4EpeU3Z+/YpGvHGLCzRMqBpA
	rGuwatUN0bIAuP+5LJedt8Sma38BFGj1Zt0U+1H1RTn7kIrFQVmPoVK2zokC3v0DUdpFN959mgBAD
	yWLSK59nB2Ji4RT7ddnmmrfq9fhRO3YSwcods9OAhQi4ysgMsmWacIzW+MMnrzPTa83sAwQ7gV5Qg
	GqtjdozrE1S813jbRZufnXHZhhwjL8/H3IOLNOb0ZyvbM/oFUbokEmfg5OeADDarCnTSxXJdK+XeI
	xAHuwRbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pmCmg-00HVX7-0U;
	Tue, 11 Apr 2023 12:07:38 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pmCmZ-00HVSW-35
	for linux-nvme@lists.infradead.org;
	Tue, 11 Apr 2023 12:07:33 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D467021A47;
	Tue, 11 Apr 2023 12:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1681214845; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NfxBQ+YwCQT4C500tsTvYDqFoF6jclwkqD6YJhX2o+Y=;
	b=K2o6RKqoXbIRqvLQ6ms4tAYt3tGPge1LW+XGpeyYNhhwqPzdArhN6/F3MnL6zVvfehSubm
	ND0+AMAxECFBLQzvPbOkFyhqM3OHkp+Aw2GdDTHe6JwYuEs7p4W7xfRN6wJG/5due289zq
	hKC1Ejf+zYVQ6qn7uU0zf5UVjjzMqbg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1681214845;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NfxBQ+YwCQT4C500tsTvYDqFoF6jclwkqD6YJhX2o+Y=;
	b=sY0Uc2g6d18FdMSnd04E+yW9xydSYI6kfSSY7gk/t2eOtbrnREBHE9ONU1Gh7M+InxjOtw
	2WITr9fAddjJzMAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C76A013638;
	Tue, 11 Apr 2023 12:07:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id NVmqMH1NNWR5BgAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 11 Apr 2023 12:07:25 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v2 1/4] nvmet-fcloop: Remove remote port from list when unlinking
Date: Tue, 11 Apr 2023 14:07:15 +0200
Message-Id: <20230411120718.14477-2-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230411120718.14477-1-dwagner@suse.de>
References: <20230411120718.14477-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230411_050732_138007_06FD6737 
X-CRM114-Status: GOOD (  11.70  )
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

The remote port is never removed from fcloop_nports list. During module
unloading it's possible to end up an busy loop in fcloop_exit, because
the remote port is found in the list and thus we will never progress.

The kernel log will be spammed with

  nvme_fcloop: fcloop_exit: Failed deleting remote port
  nvme_fcloop: fcloop_exit: Failed deleting target port

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/target/fcloop.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 5c16372f3b53..1e53c8fe4b95 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -1352,6 +1352,8 @@ __unlink_remote_port(struct fcloop_nport *nport)
 		nport->tport->remoteport = NULL;
 	nport->rport = NULL;
 
+	list_del(&nport->nport_list);
+
 	return rport;
 }
 
-- 
2.40.0


