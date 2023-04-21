Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2CD3C77B7E
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Apr 2023 06:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=64UivdY+JtKHHGrkt+vaul9Etj91J7nvEO+ZQNudNu8=; b=NBW8RMuDzXkXOS5Zbl9Keth4pX
	CmoQO4bLqcQJOYIrixeWF47BHNdLbEG7MyANASw1XtHNLkCE2s/X41XkUYWkxktaulTU/v4k29TUZ
	eYfu2sbUr/o4TxlA8hwE0Wm6ZswblZbeNmqQa2hHSY6iFpiI7dSo4a3J8wXfuAuBE/Lgfpu1Qzaa4
	TCsYtJC3ZTiQoxqrUYIRJH/FLlfgXELgsFJW4wvEYNVYCrVpnVyfFPzrkVIQM9z+RVK4PIcbDyTXm
	SBt8eTsgmPyxZ0B/U+cgcieRPGFUaA1J1NRGxPLE+7/7P1h0GM1wD01cRMweO6wn1SdlCA+bAEWwR
	US76Mibg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ppjth-009kl1-27;
	Fri, 21 Apr 2023 06:05:29 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ppjtb-009kfQ-08
	for linux-nvme@lists.infradead.org;
	Fri, 21 Apr 2023 06:05:24 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9EEA81FDE2;
	Fri, 21 Apr 2023 06:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1682057121; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=64UivdY+JtKHHGrkt+vaul9Etj91J7nvEO+ZQNudNu8=;
	b=EoDlVx7FPNaOzfpIOSof4jUY/6TuLVkrAyfprfZJfhy51GvMUM+n3ATkasGkLnJs+C5dIO
	Fyq7gr10RKobM0kDmJs+7SnK1o4KX/w6yFyaD46VkRmYMlY7DT3oYzbLPb0sCTY5l72lbK
	6SUu6B8aGNy+riILvgXic0sEaMv6Rpk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1682057121;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=64UivdY+JtKHHGrkt+vaul9Etj91J7nvEO+ZQNudNu8=;
	b=ZoTN2WdrMBxSwpS2IqkFOu5Yqa1VIXEp6PiWZwtMiPNUAwRRCg+aBF/tgnYjlop0XjvaQb
	GQcRmDXfFpwu00Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 914831390E;
	Fri, 21 Apr 2023 06:05:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 46mJI6EnQmSAZgAAMHmgww
	(envelope-from <dwagner@suse.de>); Fri, 21 Apr 2023 06:05:21 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH REPOST blktests v2 9/9] nvme: Make the number iterations configurable
Date: Fri, 21 Apr 2023 08:05:05 +0200
Message-Id: <20230421060505.10132-10-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230421060505.10132-1-dwagner@suse.de>
References: <20230421060505.10132-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230420_230523_253576_99BAB1EE 
X-CRM114-Status: GOOD (  11.23  )
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

Some tests hard code high values of iterations. This makes them run
relatively long compared to the other tests. Introduce a new environment
variable nvme_num_iter to allow tune the runtime.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/002 | 2 +-
 tests/nvme/016 | 2 +-
 tests/nvme/017 | 2 +-
 tests/nvme/rc  | 1 +
 4 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/tests/nvme/002 b/tests/nvme/002
index 6b8484844b4d..c28035483514 100755
--- a/tests/nvme/002
+++ b/tests/nvme/002
@@ -20,7 +20,7 @@ test() {
 
 	_setup_nvmet
 
-	local iterations=1000
+	local iterations="${nvme_num_iter}"
 	local port
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 
diff --git a/tests/nvme/016 b/tests/nvme/016
index 4eba30223a08..c0c31a55b190 100755
--- a/tests/nvme/016
+++ b/tests/nvme/016
@@ -17,7 +17,7 @@ test() {
 	echo "Running ${TEST_NAME}"
 
 	local port
-	local iterations=1000
+	local iterations="${nvme_num_iter}"
 	local loop_dev
 	local subsys_nqn="blktests-subsystem-1"
 
diff --git a/tests/nvme/017 b/tests/nvme/017
index 0248aee9bc41..e1674508f654 100755
--- a/tests/nvme/017
+++ b/tests/nvme/017
@@ -18,7 +18,7 @@ test() {
 
 	local port
 	local file_path
-	local iterations=1000
+	local iterations="${nvme_num_iter}"
 	local subsys_name="blktests-subsystem-1"
 
 	_setup_nvmet
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 2aa34fb0c9b8..bb135502220a 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -18,6 +18,7 @@ def_hostnqn="$(cat /etc/nvme/hostnqn 2> /dev/null)"
 def_hostid="$(cat /etc/nvme/hostid 2> /dev/null)"
 nvme_trtype=${nvme_trtype:-"loop"}
 nvme_img_size=${nvme_img_size:-"350M"}
+nvme_num_iter=${nvme_num_iter:-"100"}
 
 _nvme_requires() {
 	_have_program nvme
-- 
2.40.0


