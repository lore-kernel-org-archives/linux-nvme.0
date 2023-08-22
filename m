Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43128EE49A3
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Aug 2023 08:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aFH7C3etxPrD96fDEvOOGPP4eu7f+nPrFbOOuzz2T7M=; b=QF8YBEPZRnbslPgzXzPlqzP3bM
	DPfQVW+ZTfBjp6zHaOwJj80PAw6lidi84cMmqFiwbxRHFs/9ttQChA0pW3uCbG3k3Wmz8wlkeQrh9
	47TBowMkRA3ZXSv8lrLPikyZrmwh6g/Nlm9DRDquyAopZOEFXKZD/V7QDhh5Q1xXqV5OFrSJh5S4R
	jXYb24A2+9nD8ei45+5nG08HMc/feOv1eBDKEMnZ9kDOEA+2d2sLR61Z1R8s0l676kW3jfikH3/Tk
	E3al2nIU2H9DvNo65wR5ShnZNQL5/S/mVEh0oEEka8Mf8ndEscpPobOpQtz7TTpyc0NPp8TzFiiYt
	BxDQIEZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qYMts-00FT3y-0I;
	Tue, 22 Aug 2023 08:38:08 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qYMto-00FT2c-1z
	for linux-nvme@lists.infradead.org;
	Tue, 22 Aug 2023 08:38:06 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0617C2296F;
	Tue, 22 Aug 2023 08:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1692693481; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aFH7C3etxPrD96fDEvOOGPP4eu7f+nPrFbOOuzz2T7M=;
	b=rL5PWOBTlKyQiVzga/fgpMvb4M6Wk1uEv7sldXH5TgiYUorqy2u7NB/vMJTozRBIgctaoB
	zW3IQfGwAajE0Hz9bhtZ3JXV4eLf2WWdCrjk4chls/pMVzUuGF8xFx/G3n4NzccWnErAiV
	S4V8Hcoma06nSnpBy400akpuj/bxfgQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1692693481;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aFH7C3etxPrD96fDEvOOGPP4eu7f+nPrFbOOuzz2T7M=;
	b=bOd+NzUzAiEmZK4SoHKW5MC54LLa/c9y32QfO4y8B2OFMJQudx2g+Ry4JdaFuiDwcUgqKl
	+COZ+mKvbwZBKEDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EED3B132B9;
	Tue, 22 Aug 2023 08:38:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id grVLOuhz5GQocAAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 22 Aug 2023 08:38:00 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v3 1/3] nvme/{033,034,035,036}: use default subsysnqn variable directly
Date: Tue, 22 Aug 2023 10:38:10 +0200
Message-ID: <20230822083812.24612-2-dwagner@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822083812.24612-1-dwagner@suse.de>
References: <20230822083812.24612-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230822_013804_821520_8AC5F928 
X-CRM114-Status: UNSURE (   9.92  )
X-CRM114-Notice: Please train this message.
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

There is no need to introduce an extra local variable when it
uses the default subsysnqn anyway.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/033 |  9 ++++-----
 tests/nvme/034 |  9 ++++-----
 tests/nvme/035 |  9 ++++-----
 tests/nvme/036 | 11 +++++------
 4 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/tests/nvme/033 b/tests/nvme/033
index 46a520ae01fa..d924883460c2 100755
--- a/tests/nvme/033
+++ b/tests/nvme/033
@@ -49,18 +49,17 @@ test_device() {
 
 	_setup_nvmet
 
-	local subsys="${def_subsysnqn}"
 	local nsdev
 	local port
 
-	port=$(_nvmet_passthru_target_setup "${subsys}")
+	port=$(_nvmet_passthru_target_setup "${def_subsysnqn}")
 
-	nsdev=$(_nvmet_passthru_target_connect "${nvme_trtype}" "${subsys}")
+	nsdev=$(_nvmet_passthru_target_connect "${nvme_trtype}" "${def_subsysnqn}")
 
 	compare_dev_info "${nsdev}"
 
-	_nvme_disconnect_subsys "${subsys}"
-	_nvmet_passthru_target_cleanup "${port}" "${subsys}"
+	_nvme_disconnect_subsys "${def_subsysnqn}"
+	_nvmet_passthru_target_cleanup "${port}" "${def_subsysnqn}"
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/034 b/tests/nvme/034
index 3c65d92cbaea..e79eef5e756d 100755
--- a/tests/nvme/034
+++ b/tests/nvme/034
@@ -19,18 +19,17 @@ test_device() {
 
 	_setup_nvmet
 
-	local subsys="${def_subsysnqn}"
 	local ctrldev
 	local nsdev
 	local port
 
-	port=$(_nvmet_passthru_target_setup "${subsys}")
-	nsdev=$(_nvmet_passthru_target_connect "${nvme_trtype}" "${subsys}")
+	port=$(_nvmet_passthru_target_setup "${def_subsysnqn}")
+	nsdev=$(_nvmet_passthru_target_connect "${nvme_trtype}" "${def_subsysnqn}")
 
 	_run_fio_verify_io --size="${nvme_img_size}" --filename="${nsdev}"
 
-	_nvme_disconnect_subsys "${subsys}"
-	_nvmet_passthru_target_cleanup "${port}" "${subsys}"
+	_nvme_disconnect_subsys "${def_subsysnqn}"
+	_nvmet_passthru_target_cleanup "${port}" "${def_subsysnqn}"
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/035 b/tests/nvme/035
index c705d9cf25a4..f0dfc92ceeea 100755
--- a/tests/nvme/035
+++ b/tests/nvme/035
@@ -25,18 +25,17 @@ test_device() {
 
 	_setup_nvmet
 
-	local subsys="${def_subsysnqn}"
 	local ctrldev
 	local nsdev
 	local port
 
-	port=$(_nvmet_passthru_target_setup "${subsys}")
-	nsdev=$(_nvmet_passthru_target_connect "${nvme_trtype}" "${subsys}")
+	port=$(_nvmet_passthru_target_setup "${def_subsysnqn}")
+	nsdev=$(_nvmet_passthru_target_connect "${nvme_trtype}" "${def_subsysnqn}")
 
 	_xfs_run_fio_verify_io "${nsdev}" "${nvme_img_size}"
 
-	_nvme_disconnect_subsys "${subsys}"
-	_nvmet_passthru_target_cleanup "${port}" "${subsys}"
+	_nvme_disconnect_subsys "${def_subsysnqn}"
+	_nvmet_passthru_target_cleanup "${port}" "${def_subsysnqn}"
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/036 b/tests/nvme/036
index 2e933cc41928..61b9e2309da7 100755
--- a/tests/nvme/036
+++ b/tests/nvme/036
@@ -18,21 +18,20 @@ test_device() {
 
 	_setup_nvmet
 
-	local subsys="${def_subsysnqn}"
 	local ctrldev
 	local port
 
-	port=$(_nvmet_passthru_target_setup "${subsys}")
-	nsdev=$(_nvmet_passthru_target_connect "${nvme_trtype}" "${subsys}")
+	port=$(_nvmet_passthru_target_setup "${def_subsysnqn}")
+	nsdev=$(_nvmet_passthru_target_connect "${nvme_trtype}" "${def_subsysnqn}")
 
-	ctrldev=$(_find_nvme_dev "${subsys}")
+	ctrldev=$(_find_nvme_dev "${def_subsysnqn}")
 
 	if ! nvme reset "/dev/${ctrldev}" >> "$FULL" 2>&1; then
 		echo "ERROR: reset failed"
 	fi
 
-	_nvme_disconnect_subsys "${subsys}"
-	_nvmet_passthru_target_cleanup "${port}" "${subsys}"
+	_nvme_disconnect_subsys "${def_subsysnqn}"
+	_nvmet_passthru_target_cleanup "${port}" "${def_subsysnqn}"
 
 	echo "Test complete"
 }
-- 
2.41.0


