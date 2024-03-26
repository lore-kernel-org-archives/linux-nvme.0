Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A9CAC6FD1F
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Mar 2024 14:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=spm9GVdaOI8UR8nt1GPJV7b8HcAmOe2bSVnBngDjipw=; b=LtAj7O0T9UB0zTj3b8IrlDf22q
	YhjrXfGbv6cmO1N2yB2MJGtF1taNYoXZ3vSHF8M0VB+gSe43F9XFULMsPjUFfdxtRMwdF8b7aQSXH
	+Vp86V0utH3ZHsspEKhzRdkCYfyyrKL8zJLfMcFWLHmK+TVOT4cbF4kx9W6pC9cOg/5gNSY5snupA
	X7/GpnPs5312xKbzOVEgjjhgsWShkh9g1JaJl0OERSuWIATBk7Nz9yWhQS/b8qzrAbYjHk4UFY4c0
	QGWBI94w9GBx9orWQf2nScqvyugIIhMtFoGiBNJgV/2euVvmscd23AP5qOaRg6rAmO07jRdtaGmNO
	2eYvpP4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp7bt-00000004s6k-1Lmk;
	Tue, 26 Mar 2024 14:17:05 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp6dJ-00000004c46-34Ha
	for linux-nvme@bombadil.infradead.org;
	Tue, 26 Mar 2024 13:14:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=spm9GVdaOI8UR8nt1GPJV7b8HcAmOe2bSVnBngDjipw=; b=rcHkpfsFMAjTGO/2v7T8t8bpvT
	k7seomkp7vxnwQuT5Ues9AL86S1ymH7NzTfMq3jXGqZ/tkLoLuQpR5pYTlxN04syF7FgF4+JKvZaG
	Y8JkFc/4LW31b3oCVSj7IfGt2Vjw3oBKQNtqBzx12x9n647C6a++7DHqM+MVqBiu7qtbCjmIMh36m
	sqqkfUrEs/RRVmxjMXdw7i3YAjSz08emY0M4dK4BMAh73MmE912AiDzIuO9fLBbwyER4p8RhHQk+k
	3vo5TUQ8wWInnbFUJSWPlNfiLu+KHZ7ske2SPeyO5uH4nITHpdf391fhLMx1GJwVnPGKzC/ZjuHfC
	BbJ5nL7g==;
Received: from smtp-out1.suse.de ([195.135.223.130])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp6dF-0000000HAym-0rvH
	for linux-nvme@lists.infradead.org;
	Tue, 26 Mar 2024 13:14:28 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B4A2037C4F;
	Tue, 26 Mar 2024 13:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711458853; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=spm9GVdaOI8UR8nt1GPJV7b8HcAmOe2bSVnBngDjipw=;
	b=J2pFNSkq0ijIW2HOodt0qp6RWTL4dqqmxFIpYvMvKKdNyLThCx0c8X51744U6OMGWilpKr
	k9orVyycNOOa5GjIQhO9ZEnwEDjznsCG2ZeSExrT96EbTC96yMyPfpZJXT9Z4WcjcfLYiq
	tkr6Rb3qKvBlJDOlRk2aXhJppqETDhk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711458853;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=spm9GVdaOI8UR8nt1GPJV7b8HcAmOe2bSVnBngDjipw=;
	b=mQ4s+ccytILhZ2ufHMiXzo/UzD30gnKI2VuZ026JdqOGT53tDvB5plYjDTY9uaovwmQFLc
	xN7xQSAjap2q+XBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711458853; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=spm9GVdaOI8UR8nt1GPJV7b8HcAmOe2bSVnBngDjipw=;
	b=J2pFNSkq0ijIW2HOodt0qp6RWTL4dqqmxFIpYvMvKKdNyLThCx0c8X51744U6OMGWilpKr
	k9orVyycNOOa5GjIQhO9ZEnwEDjznsCG2ZeSExrT96EbTC96yMyPfpZJXT9Z4WcjcfLYiq
	tkr6Rb3qKvBlJDOlRk2aXhJppqETDhk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711458853;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=spm9GVdaOI8UR8nt1GPJV7b8HcAmOe2bSVnBngDjipw=;
	b=mQ4s+ccytILhZ2ufHMiXzo/UzD30gnKI2VuZ026JdqOGT53tDvB5plYjDTY9uaovwmQFLc
	xN7xQSAjap2q+XBg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A309313587;
	Tue, 26 Mar 2024 13:14:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id UB3qJiXKAmYbNwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Tue, 26 Mar 2024 13:14:13 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v3 13/20] nvme: drop default trtype argument for _nvmet_connect_subsys
Date: Tue, 26 Mar 2024 14:13:55 +0100
Message-ID: <20240326131402.5092-14-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240326131402.5092-1-dwagner@suse.de>
References: <20240326131402.5092-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_HI(-3.50)[suse.de:dkim];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=J2pFNSkq;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=mQ4s+ccy
X-Rspamd-Queue-Id: B4A2037C4F
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240326_131425_483936_F26577E7 
X-CRM114-Status: GOOD (  11.77  )
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

Every invocation of _nvmet_connect_subsys passes in the default
nvme_trtype argument. nvme/rc also assumes the test is always using
nvme_trtype for trtype (e.g. cleanup code paths), thus just drop
this argument.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/003 |  2 +-
 tests/nvme/004 |  3 +--
 tests/nvme/005 |  2 +-
 tests/nvme/008 |  2 +-
 tests/nvme/009 |  2 +-
 tests/nvme/010 |  2 +-
 tests/nvme/011 |  2 +-
 tests/nvme/012 |  2 +-
 tests/nvme/013 |  2 +-
 tests/nvme/014 |  2 +-
 tests/nvme/015 |  2 +-
 tests/nvme/018 |  2 +-
 tests/nvme/019 |  2 +-
 tests/nvme/020 |  2 +-
 tests/nvme/021 |  2 +-
 tests/nvme/022 |  2 +-
 tests/nvme/023 |  2 +-
 tests/nvme/024 |  2 +-
 tests/nvme/025 |  2 +-
 tests/nvme/026 |  2 +-
 tests/nvme/027 |  2 +-
 tests/nvme/028 |  2 +-
 tests/nvme/029 |  2 +-
 tests/nvme/031 |  2 +-
 tests/nvme/040 |  2 +-
 tests/nvme/041 |  4 ++--
 tests/nvme/042 |  4 ++--
 tests/nvme/043 |  4 ++--
 tests/nvme/044 |  8 ++++----
 tests/nvme/045 |  2 +-
 tests/nvme/047 |  4 ++--
 tests/nvme/048 |  2 +-
 tests/nvme/rc  | 12 +++++-------
 33 files changed, 44 insertions(+), 47 deletions(-)

diff --git a/tests/nvme/003 b/tests/nvme/003
index b5ea2720100e..9a7c41f0856b 100755
--- a/tests/nvme/003
+++ b/tests/nvme/003
@@ -25,7 +25,7 @@ test() {
 
 	_nvmet_target_setup
 
-	_nvme_connect_subsys "${nvme_trtype}" nqn.2014-08.org.nvmexpress.discovery
+	_nvme_connect_subsys nqn.2014-08.org.nvmexpress.discovery
 
 	# This is ugly but checking for the absence of error messages is ...
 	sleep 10
diff --git a/tests/nvme/004 b/tests/nvme/004
index cc5310e78e0b..024ac986e5c1 100755
--- a/tests/nvme/004
+++ b/tests/nvme/004
@@ -22,10 +22,9 @@ test() {
 
 	_setup_nvmet
 
-
 	_nvmet_target_setup
 
-	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
+	_nvme_connect_subsys "${def_subsysnqn}"
 
 	local nvmedev
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
diff --git a/tests/nvme/005 b/tests/nvme/005
index f9956e960a56..80a5359e862e 100755
--- a/tests/nvme/005
+++ b/tests/nvme/005
@@ -25,7 +25,7 @@ test() {
 
 	_nvmet_target_setup
 
-	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
+	_nvme_connect_subsys "${def_subsysnqn}"
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 
diff --git a/tests/nvme/008 b/tests/nvme/008
index 6ff3362e9c9b..fb1726723d43 100755
--- a/tests/nvme/008
+++ b/tests/nvme/008
@@ -24,7 +24,7 @@ test() {
 
 	_nvmet_target_setup
 
-	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
+	_nvme_connect_subsys "${def_subsysnqn}"
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 	_check_uuid "${nvmedev}"
diff --git a/tests/nvme/009 b/tests/nvme/009
index 4ea00636e5dd..a9d83b675ba2 100755
--- a/tests/nvme/009
+++ b/tests/nvme/009
@@ -23,7 +23,7 @@ test() {
 
 	_nvmet_target_setup --blkdev file
 
-	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
+	_nvme_connect_subsys "${def_subsysnqn}"
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 	_check_uuid "${nvmedev}"
diff --git a/tests/nvme/010 b/tests/nvme/010
index 5ed6cb5c0374..496f6e5c6a52 100755
--- a/tests/nvme/010
+++ b/tests/nvme/010
@@ -24,7 +24,7 @@ test() {
 
 	_nvmet_target_setup
 
-	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
+	_nvme_connect_subsys "${def_subsysnqn}"
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 	_check_uuid "${nvmedev}"
diff --git a/tests/nvme/011 b/tests/nvme/011
index f9150e06434e..14a17a774d5f 100755
--- a/tests/nvme/011
+++ b/tests/nvme/011
@@ -24,7 +24,7 @@ test() {
 
 	_nvmet_target_setup --blkdev file
 
-	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
+	_nvme_connect_subsys "${def_subsysnqn}"
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 	_check_uuid "${nvmedev}"
diff --git a/tests/nvme/012 b/tests/nvme/012
index f0914ce3206b..8dbf8eb1a9f0 100755
--- a/tests/nvme/012
+++ b/tests/nvme/012
@@ -28,7 +28,7 @@ test() {
 
 	_nvmet_target_setup
 
-	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
+	_nvme_connect_subsys "${def_subsysnqn}"
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 	_check_uuid "${nvmedev}"
diff --git a/tests/nvme/013 b/tests/nvme/013
index 3cef009cb9f4..eb22933fdec6 100755
--- a/tests/nvme/013
+++ b/tests/nvme/013
@@ -27,7 +27,7 @@ test() {
 
 	_nvmet_target_setup --blkdev file
 
-	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
+	_nvme_connect_subsys "${def_subsysnqn}"
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 	_check_uuid "${nvmedev}"
diff --git a/tests/nvme/014 b/tests/nvme/014
index c02167142cb3..20ff69176231 100755
--- a/tests/nvme/014
+++ b/tests/nvme/014
@@ -27,7 +27,7 @@ test() {
 
 	_nvmet_target_setup
 
-	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
+	_nvme_connect_subsys "${def_subsysnqn}"
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 	_check_uuid "${nvmedev}"
diff --git a/tests/nvme/015 b/tests/nvme/015
index 8ea90f10bda7..634c42c07a86 100755
--- a/tests/nvme/015
+++ b/tests/nvme/015
@@ -27,7 +27,7 @@ test() {
 
 	_nvmet_target_setup --blkdev file
 
-	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
+	_nvme_connect_subsys "${def_subsysnqn}"
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 	_check_uuid "${nvmedev}"
diff --git a/tests/nvme/018 b/tests/nvme/018
index e631434d7bd6..9225f7d58377 100755
--- a/tests/nvme/018
+++ b/tests/nvme/018
@@ -25,7 +25,7 @@ test() {
 
 	_nvmet_target_setup --blkdev file
 
-	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
+	_nvme_connect_subsys "${def_subsysnqn}"
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 	_check_uuid "${nvmedev}"
diff --git a/tests/nvme/019 b/tests/nvme/019
index 3ab22e2cba01..9cf9f5299305 100755
--- a/tests/nvme/019
+++ b/tests/nvme/019
@@ -26,7 +26,7 @@ test() {
 
 	_nvmet_target_setup
 
-	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
+	_nvme_connect_subsys "${def_subsysnqn}"
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 	_check_uuid "${nvmedev}"
diff --git a/tests/nvme/020 b/tests/nvme/020
index 10de114b83af..f6a204e6e417 100755
--- a/tests/nvme/020
+++ b/tests/nvme/020
@@ -25,7 +25,7 @@ test() {
 
 	_nvmet_target_setup --blkdev file
 
-	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
+	_nvme_connect_subsys "${def_subsysnqn}"
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 	_check_uuid "${nvmedev}"
diff --git a/tests/nvme/021 b/tests/nvme/021
index 7dc6a41b9f7b..73e414e9db47 100755
--- a/tests/nvme/021
+++ b/tests/nvme/021
@@ -24,7 +24,7 @@ test() {
 
 	_nvmet_target_setup --blkdev file
 
-	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
+	_nvme_connect_subsys "${def_subsysnqn}"
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 	_check_uuid "${nvmedev}"
diff --git a/tests/nvme/022 b/tests/nvme/022
index c70fbbae822e..31435cd2e9c7 100755
--- a/tests/nvme/022
+++ b/tests/nvme/022
@@ -24,7 +24,7 @@ test() {
 
 	_nvmet_target_setup --blkdev file
 
-	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
+	_nvme_connect_subsys "${def_subsysnqn}"
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 	_check_uuid "${nvmedev}"
diff --git a/tests/nvme/023 b/tests/nvme/023
index 58f03e8603a7..c4c292899f32 100755
--- a/tests/nvme/023
+++ b/tests/nvme/023
@@ -24,7 +24,7 @@ test() {
 
 	_nvmet_target_setup
 
-	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
+	_nvme_connect_subsys "${def_subsysnqn}"
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 	_check_uuid "${nvmedev}"
diff --git a/tests/nvme/024 b/tests/nvme/024
index 4608f015c4c3..b0d6f5a3c0b9 100755
--- a/tests/nvme/024
+++ b/tests/nvme/024
@@ -24,7 +24,7 @@ test() {
 
 	_nvmet_target_setup --blkdev file
 
-	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
+	_nvme_connect_subsys "${def_subsysnqn}"
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 	_check_uuid "${nvmedev}"
diff --git a/tests/nvme/025 b/tests/nvme/025
index 46f6197cdfed..107eb38ba787 100755
--- a/tests/nvme/025
+++ b/tests/nvme/025
@@ -24,7 +24,7 @@ test() {
 
 	_nvmet_target_setup --blkdev file
 
-	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
+	_nvme_connect_subsys "${def_subsysnqn}"
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 	_check_uuid "${nvmedev}"
diff --git a/tests/nvme/026 b/tests/nvme/026
index d5e13db0a916..ff4ff91d5d4f 100755
--- a/tests/nvme/026
+++ b/tests/nvme/026
@@ -24,7 +24,7 @@ test() {
 
 	_nvmet_target_setup --blkdev file
 
-	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
+	_nvme_connect_subsys "${def_subsysnqn}"
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 	_check_uuid "${nvmedev}"
diff --git a/tests/nvme/027 b/tests/nvme/027
index 82b77a963623..a15e6d6e92d0 100755
--- a/tests/nvme/027
+++ b/tests/nvme/027
@@ -24,7 +24,7 @@ test() {
 
 	_nvmet_target_setup --blkdev file
 
-	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
+	_nvme_connect_subsys "${def_subsysnqn}"
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 	_check_uuid "${nvmedev}"
diff --git a/tests/nvme/028 b/tests/nvme/028
index 0b49e2016d30..41dcb6ef7a4f 100755
--- a/tests/nvme/028
+++ b/tests/nvme/028
@@ -24,7 +24,7 @@ test() {
 
 	_nvmet_target_setup --blkdev file
 
-	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
+	_nvme_connect_subsys "${def_subsysnqn}"
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 	_check_uuid "${nvmedev}"
diff --git a/tests/nvme/029 b/tests/nvme/029
index a4f0cb1402b1..7bde5565b020 100755
--- a/tests/nvme/029
+++ b/tests/nvme/029
@@ -58,7 +58,7 @@ test() {
 
 	_nvmet_target_setup
 
-	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
+	_nvme_connect_subsys "${def_subsysnqn}"
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 	_check_uuid "${nvmedev}"
diff --git a/tests/nvme/031 b/tests/nvme/031
index 204ba7d2892f..19854ccb903f 100755
--- a/tests/nvme/031
+++ b/tests/nvme/031
@@ -43,7 +43,7 @@ test() {
 		_nvmet_target_setup --subsysnqn "${subsys}$i" \
 			--blkdev "${loop_dev}"
 
-		_nvme_connect_subsys "${nvme_trtype}" "${subsys}$i"
+		_nvme_connect_subsys "${subsys}$i"
 		_nvme_disconnect_subsys "${subsys}$i" >> "${FULL}" 2>&1
 
 		_nvmet_target_cleanup --subsysnqn "${subsys}$i" \
diff --git a/tests/nvme/040 b/tests/nvme/040
index 7759bac9b43c..06d0d0d47368 100755
--- a/tests/nvme/040
+++ b/tests/nvme/040
@@ -26,7 +26,7 @@ test() {
 
 	_nvmet_target_setup
 
-	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
+	_nvme_connect_subsys "${def_subsysnqn}"
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 
 	# start fio job
diff --git a/tests/nvme/041 b/tests/nvme/041
index c4588d7058ac..02452fd52628 100755
--- a/tests/nvme/041
+++ b/tests/nvme/041
@@ -38,7 +38,7 @@ test() {
 
 	# Test unauthenticated connection (should fail)
 	echo "Test unauthenticated connection (should fail)"
-	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}" \
+	_nvme_connect_subsys "${def_subsysnqn}" \
 			     --hostnqn "${def_hostnqn}" \
 			     --hostid "${def_hostid}"
 
@@ -46,7 +46,7 @@ test() {
 
 	# Test authenticated connection
 	echo "Test authenticated connection"
-	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}" \
+	_nvme_connect_subsys "${def_subsysnqn}" \
 			     --hostnqn "${def_hostnqn}" \
 			     --hostid "${def_hostid}" \
 			     --dhchap-secret "${hostkey}"
diff --git a/tests/nvme/042 b/tests/nvme/042
index 815d65e7c610..961301ff6993 100755
--- a/tests/nvme/042
+++ b/tests/nvme/042
@@ -41,7 +41,7 @@ test() {
 		fi
 		_set_nvmet_hostkey "${def_hostnqn}" "${hostkey}"
 
-		_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}" \
+		_nvme_connect_subsys "${def_subsysnqn}" \
 				     --hostnqn "${def_hostnqn}" \
 				     --hostid "${def_hostid}" \
 				     --dhchap-secret "${hostkey}"
@@ -58,7 +58,7 @@ test() {
 		fi
 		_set_nvmet_hostkey "${def_hostnqn}" "${hostkey}"
 
-		_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}" \
+		_nvme_connect_subsys "${def_subsysnqn}" \
 				     --hostnqn "${def_hostnqn}" \
 				     --hostid "${def_hostid}" \
 				     --dhchap-secret "${hostkey}"
diff --git a/tests/nvme/043 b/tests/nvme/043
index e65abb09fe7c..ed18869a5977 100755
--- a/tests/nvme/043
+++ b/tests/nvme/043
@@ -45,7 +45,7 @@ test() {
 
 		_set_nvmet_hash "${def_hostnqn}" "${hash}"
 
-		_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}" \
+		_nvme_connect_subsys "${def_subsysnqn}" \
 				     --hostnqn "${def_hostnqn}" \
 				     --hostid "${def_hostid}" \
 				     --dhchap-secret "${hostkey}"
@@ -59,7 +59,7 @@ test() {
 
 		_set_nvmet_dhgroup "${def_hostnqn}" "${dhgroup}"
 
-		_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}" \
+		_nvme_connect_subsys "${def_subsysnqn}" \
 				      --hostnqn "${def_hostnqn}" \
 				      --hostid "${def_hostid}" \
 				      --dhchap-secret "${hostkey}"
diff --git a/tests/nvme/044 b/tests/nvme/044
index 9ee07475e738..8e2b4131b969 100755
--- a/tests/nvme/044
+++ b/tests/nvme/044
@@ -49,7 +49,7 @@ test() {
 
 	# Step 1: Connect with host authentication only
 	echo "Test host authentication"
-	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}" \
+	_nvme_connect_subsys "${def_subsysnqn}" \
 			     --hostnqn "${def_hostnqn}" \
 			     --hostid "${def_hostid}" \
 			     --dhchap-secret "${hostkey}"
@@ -59,7 +59,7 @@ test() {
 	# Step 2: Connect with host authentication
 	# and invalid ctrl authentication
 	echo "Test invalid ctrl authentication (should fail)"
-	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}" \
+	_nvme_connect_subsys "${def_subsysnqn}" \
 			     --hostnqn "${def_hostnqn}" \
 			     --hostid "${def_hostid}" \
 			     --dhchap-secret "${hostkey}" \
@@ -70,7 +70,7 @@ test() {
 	# Step 3: Connect with host authentication
 	# and valid ctrl authentication
 	echo "Test valid ctrl authentication"
-	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}" \
+	_nvme_connect_subsys "${def_subsysnqn}" \
 			     --hostnqn "${def_hostnqn}" \
 			     --hostid "${def_hostid}" \
 			     --dhchap-secret "${hostkey}" \
@@ -82,7 +82,7 @@ test() {
 	# and invalid ctrl key
 	echo "Test invalid ctrl key (should fail)"
 	invkey="DHHC-1:00:Jc/My1o0qtLCWRp+sHhAVafdfaS7YQOMYhk9zSmlatobqB8C:"
-	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}" \
+	_nvme_connect_subsys "${def_subsysnqn}" \
 			     --hostnqn "${def_hostnqn}" \
 			     --hostid "${def_hostid}" \
 			     --dhchap-secret "${hostkey}" \
diff --git a/tests/nvme/045 b/tests/nvme/045
index 9e5cb54e9533..f89378836e67 100755
--- a/tests/nvme/045
+++ b/tests/nvme/045
@@ -51,7 +51,7 @@ test() {
 
 	_set_nvmet_dhgroup "${def_hostnqn}" "ffdhe2048"
 
-	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}" \
+	_nvme_connect_subsys "${def_subsysnqn}" \
 			     --hostnqn "${def_hostnqn}" \
 			     --hostid "${def_hostid}" \
 			     --dhchap-secret "${hostkey}" \
diff --git a/tests/nvme/047 b/tests/nvme/047
index 94d7d50f9f98..162bd3bf70fa 100755
--- a/tests/nvme/047
+++ b/tests/nvme/047
@@ -27,7 +27,7 @@ test() {
 
 	_nvmet_target_setup
 
-	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}" \
+	_nvme_connect_subsys \
 		--nr-write-queues 1 || echo FAIL
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
@@ -37,7 +37,7 @@ test() {
 
 	_nvme_disconnect_subsys "${def_subsysnqn}" >> "$FULL" 2>&1
 
-	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}" \
+	_nvme_connect_subsys "${def_subsysnqn}" \
 		--nr-write-queues 1 \
 		--nr-poll-queues 1 || echo FAIL
 
diff --git a/tests/nvme/048 b/tests/nvme/048
index f76cfedf8b03..44fdffe287c8 100755
--- a/tests/nvme/048
+++ b/tests/nvme/048
@@ -99,7 +99,7 @@ test() {
 	_nvmet_target_setup --blkdev file
 
 	if [[ -f "${cfs_path}/attr_qid_max" ]] ; then
-		_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}" \
+		_nvme_connect_subsys "${def_subsysnqn}" \
 					--hostnqn "${def_hostnqn}" \
 					--hostid "${def_hostid}" \
 					--keep-alive-tmo 1 \
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 9d47c737f9b0..9ce2fd787f8d 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -408,7 +408,6 @@ _nvme_disconnect_subsys() {
 
 _nvme_connect_subsys() {
 	local positional_args=()
-	local trtype=""
 	local subsysnqn=""
 	local hostnqn="$def_hostnqn"
 	local hostid="$def_hostid"
@@ -478,13 +477,12 @@ _nvme_connect_subsys() {
 
 	set -- "${positional_args[@]}"
 
-	trtype="$1"
-	subsysnqn="$2"
+	subsysnqn="$1"
 
-	ARGS=(--transport "${trtype}" --nqn "${subsysnqn}")
-	if [[ "${trtype}" == "fc" ]] ; then
+	ARGS=(--transport "${nvme_trtype}" --nqn "${subsysnqn}")
+	if [[ "${nvme_trtype}" == "fc" ]] ; then
 		ARGS+=(--traddr "${def_traddr}" --host-traddr "${def_host_traddr}")
-	elif [[ "${trtype}" != "loop" ]]; then
+	elif [[ "${nvme_trtype}" != "loop" ]]; then
 		ARGS+=(--traddr "${def_traddr}" --trsvcid "${def_trsvcid}")
 	fi
 	ARGS+=(--hostnqn="${hostnqn}")
@@ -902,7 +900,7 @@ _nvmet_passthru_target_connect() {
 	local trtype=$1
 	local subsys_name=$2
 
-	_nvme_connect_subsys "${trtype}" "${subsys_name}" --no-wait || return
+	_nvme_connect_subsys "${subsys_name}" --no-wait || return
 	nsdev=$(_find_nvme_passthru_loop_dev "${subsys_name}")
 
 	# The following tests can race with the creation
-- 
2.44.0


