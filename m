Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE2A6C7EE22
	for <linux-nvme@archiver.kernel.org>; Wed,  3 May 2023 08:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1K7B1ulTvYgPG7Sie5nMsi4gf4h2tfGpVQJI7Dvefpg=; b=bBOWpp+3SphTDBIaK8t7Zxl2yJ
	xcr+/bPWtKWXk/SanCPlR3ayJwMx1RKFEFiQlsDz+vixMONRrWDNp5bzvMZ2+CQZooo6p7TFMKDjc
	IEfWlmqdy15vcIRQi007KqqdrK6VY1FuaiFoeNiHW/apNCMAufyGwAHHQ0TKn9wpH9P6eBDZXQQ8w
	jg8MqwJ7nyKf/9GpWF4P0lKVJY27wDYtEqf7ZLvR8rXLebNGIKM2wOf9DCdh3H6BsrLrkvQcEgK/J
	j2NYyIfCkRTnDAwmkOxH6v8E+QPvzR3vjz/XaAGRX9aHbIIS4igZfCw1dBuRUM0UjBT22KQycMci2
	8fHZfZXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pu80K-003tPB-33;
	Wed, 03 May 2023 08:38:28 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pu80H-003tKy-0Q
	for linux-nvme@lists.infradead.org;
	Wed, 03 May 2023 08:38:26 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 511E02246F;
	Wed,  3 May 2023 08:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1683103100; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1K7B1ulTvYgPG7Sie5nMsi4gf4h2tfGpVQJI7Dvefpg=;
	b=XIXDrIli9pt2V82t801AL6ofsvdrmgk5MOQRGziqjipJ6gsLBnzlXuQJ2RQGnFI1whska4
	dq0VPixIH5VqZY6Q+tnmkSufhSWthnDa9HQLat9Cc+YofgDlO0kF7Y1Wbaph1unYEWa8ds
	3NqmKYxfCqyzRtBXIf+2NtOqC4GDb6Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1683103100;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1K7B1ulTvYgPG7Sie5nMsi4gf4h2tfGpVQJI7Dvefpg=;
	b=QUr0MSESnCfRUDUbjDlYjtBOkz69rCIadklZK/oE4PQUcF5U2GWnexHAtz54vdgZTP/1ZA
	OJLkAExOz8XEGUBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 43908139F8;
	Wed,  3 May 2023 08:38:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id Uvp7EHwdUmS5dQAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 03 May 2023 08:38:20 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v3 2/2] nvme/rc: Cleanup fc resource before module unloading
Date: Wed,  3 May 2023 10:38:16 +0200
Message-Id: <20230503083816.18792-3-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230503083816.18792-1-dwagner@suse.de>
References: <20230503083816.18792-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230503_013825_311758_1D055499 
X-CRM114-Status: GOOD (  10.87  )
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

Cleanup all fc resources before unloading the module, so it the
operations are in reverse order how we setup them.

Also unload the nvme-fcloop after usage.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/rc | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index ec0cc2d8d8cc..24803afe8879 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -260,6 +260,11 @@ _cleanup_nvmet() {
 	shopt -u nullglob
 	trap SIGINT
 
+	if [[ "${nvme_trtype}" == "fc" ]]; then
+		_cleanup_fcloop "${def_local_wwnn}" "${def_local_wwpn}" \
+			        "${def_remote_wwnn}" "${def_remote_wwpn}"
+		modprobe -rq nvme-fcloop
+	fi
 	modprobe -rq nvme-"${nvme_trtype}" 2>/dev/null
 	if [[ "${nvme_trtype}" != "loop" ]]; then
 		modprobe -rq nvmet-"${nvme_trtype}" 2>/dev/null
@@ -268,10 +273,6 @@ _cleanup_nvmet() {
 	if [[ "${nvme_trtype}" == "rdma" ]]; then
 		stop_soft_rdma
 	fi
-	if [[ "${nvme_trtype}" == "fc" ]]; then
-		_cleanup_fcloop "${def_local_wwnn}" "${def_local_wwpn}" \
-			        "${def_remote_wwnn}" "${def_remote_wwpn}"
-	fi
 }
 
 _setup_nvmet() {
-- 
2.40.0


