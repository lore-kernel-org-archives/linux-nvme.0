Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FB25C77B7F
	for <linux-nvme@archiver.kernel.org>; Wed,  3 May 2023 08:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3QiWi7xEJCHdkqRRP7ZvqBGwdGpiUG8vH8kiotRokzk=; b=Ph/Gcp7fTxKPiU6yLa9eb0dkwd
	81k0A9knrqkrFT41dWZ39+WbHDXXRicl+/A4J+iOh4eEIdZhEs1XSoL/pVeYs/CxCphK4/QYk3npy
	rTh2tJadzXJhF/VT3Xi6rDmbjmjW7m5SHGxzNplq5nwCbglpci22gQxHTpBthbITv5i9Zc/PcIQDj
	tsCPEaDuQ/ovPJcHXvP3v/UkVig0CmwxVYzBH5IyiOEMLitOjiav4e+fkO3VRacQcntUl2xtpZE4l
	PrCxLZ5JJZ4WvG5qJHP3mYGd9RG3MzV4ZxELzC+3djI0R53+adEwF0PqSI3uBlNJ5IMoVJBvhq2Xb
	Gke6THgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pu80K-003tOb-0I;
	Wed, 03 May 2023 08:38:28 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pu80G-003tKo-0D
	for linux-nvme@lists.infradead.org;
	Wed, 03 May 2023 08:38:25 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AD94720103;
	Wed,  3 May 2023 08:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1683103099; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3QiWi7xEJCHdkqRRP7ZvqBGwdGpiUG8vH8kiotRokzk=;
	b=2Ab2FKdQ8fKvGmqEB0I/U2g45KK08soyZP8tOF5wMfe8PNz6K78uSs0i5apBW+etQ1Inxa
	ArwPC2DMu4vA8e6CSdctlFz3XfVblS/ze6a6TsINdMLPUAtm1Mb+kSl1pda1VqWPTYp/rs
	wiyefmKRpZThx3TPbcyzy7OPlAYGXrw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1683103099;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3QiWi7xEJCHdkqRRP7ZvqBGwdGpiUG8vH8kiotRokzk=;
	b=2SEKacaeG0CMWxmOXWQkVhmTf0ZZABRscFhVrhXTVExwYlmfgZTNCfQNrR1qDX38PChdIQ
	8KZeRytBUCP4bjDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9EAB4139F8;
	Wed,  3 May 2023 08:38:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 4py3JnsdUmS1dQAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 03 May 2023 08:38:19 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v3 1/2] nvme/rc: Cleanup fc ports in reverse order
Date: Wed,  3 May 2023 10:38:15 +0200
Message-Id: <20230503083816.18792-2-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230503083816.18792-1-dwagner@suse.de>
References: <20230503083816.18792-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230503_013824_250589_B58A13DF 
X-CRM114-Status: GOOD (  10.97  )
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

We need to free the resources in the opposite order as we allocate them.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/rc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index b44239446dcf..ec0cc2d8d8cc 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -204,10 +204,10 @@ _cleanup_fcloop() {
 	local remote_wwnn="${3:-$def_remote_wwnn}"
 	local remote_wwpn="${4:-$def_remote_wwpn}"
 
-	_nvme_fcloop_del_rport "${local_wwnn}" "${local_wwpn}" \
-			       "${remote_wwnn}" "${remote_wwpn}"
 	_nvme_fcloop_del_tport "${remote_wwnn}" "${remote_wwpn}"
 	_nvme_fcloop_del_lport "${local_wwnn}" "${local_wwpn}"
+	_nvme_fcloop_del_rport "${local_wwnn}" "${local_wwpn}" \
+			       "${remote_wwnn}" "${remote_wwpn}"
 }
 
 _cleanup_nvmet() {
-- 
2.40.0


