Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEEC1C54E71
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Mar 2024 15:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AnFAh6yCTmKI/Y+oikSQG++m293PK8pS6qKLAj5RedU=; b=czciIqu5jTddWvXbuMggppBpfl
	FTlDORV4X528wkWuEhOO7PBC6OaniMaUCG0qg5HpFx55lEGno20s3RuSzZ3i2i1GUE/7ScBHGPGH3
	nimRRMXZnQuqS7dvaGuZ9tyHctE90tSC4htSLmofwdi2RxDKiLg8RYsc61JV1rf2CveSSiiqkzis1
	uhFbxH5SYsmoosnI8IoIEHwCL3uHp7W0UF1oySTbG0d8Jk8RlVRG25yNl5sCOjUAH4vbmbswCrcsV
	MRRQx1DFW/iLarlWRJoy48jkNYuCErtjwDWBgoEd8QmTWc9TSjwPc3k/IgPqA6dI2rvu7SmSfunRo
	V5kqFSag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rngPq-00000007fBL-3MU9;
	Fri, 22 Mar 2024 15:02:42 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnfHx-00000007PsF-0Ur2
	for linux-nvme@lists.infradead.org;
	Fri, 22 Mar 2024 13:50:45 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D387E3855D;
	Fri, 22 Mar 2024 13:50:27 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C271C136AD;
	Fri, 22 Mar 2024 13:50:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KzAILqOM/WWcJAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 22 Mar 2024 13:50:27 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v2 14/18] nvme: drop default trtype argument for _nvmet_passthru_target_connect
Date: Fri, 22 Mar 2024 14:50:11 +0100
Message-ID: <20240322135015.14712-15-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240322135015.14712-1-dwagner@suse.de>
References: <20240322135015.14712-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
Authentication-Results: smtp-out1.suse.de;
	none
X-Rspamd-Queue-Id: D387E3855D
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240322_065029_512401_9553C4DA 
X-CRM114-Status: GOOD (  11.31  )
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

Every invocation of _nvmet_passthru_target_connect passes in the default
nvme_trtype argument. The argument is not evaluated anymore, thus just
remove it.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/033 | 2 +-
 tests/nvme/034 | 2 +-
 tests/nvme/035 | 2 +-
 tests/nvme/036 | 2 +-
 tests/nvme/037 | 3 +--
 tests/nvme/rc  | 3 +--
 6 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/tests/nvme/033 b/tests/nvme/033
index 6cc4f57e6d60..cb120e20b573 100755
--- a/tests/nvme/033
+++ b/tests/nvme/033
@@ -53,7 +53,7 @@ test_device() {
 
 	_nvmet_passthru_target_setup "${def_subsysnqn}"
 
-	nsdev=$(_nvmet_passthru_target_connect "${nvme_trtype}" "${def_subsysnqn}")
+	nsdev=$(_nvmet_passthru_target_connect "${def_subsysnqn}")
 
 	compare_dev_info "${nsdev}"
 
diff --git a/tests/nvme/034 b/tests/nvme/034
index 3bd1c3ad2f61..98a7db859b36 100755
--- a/tests/nvme/034
+++ b/tests/nvme/034
@@ -23,7 +23,7 @@ test_device() {
 	local nsdev
 
 	_nvmet_passthru_target_setup "${def_subsysnqn}"
-	nsdev=$(_nvmet_passthru_target_connect "${nvme_trtype}" "${def_subsysnqn}")
+	nsdev=$(_nvmet_passthru_target_connect "${def_subsysnqn}")
 
 	_run_fio_verify_io --size="${nvme_img_size}" --filename="${nsdev}"
 
diff --git a/tests/nvme/035 b/tests/nvme/035
index 01aa09077d6a..c17e8be6ce46 100755
--- a/tests/nvme/035
+++ b/tests/nvme/035
@@ -29,7 +29,7 @@ test_device() {
 	local nsdev
 
 	_nvmet_passthru_target_setup "${def_subsysnqn}"
-	nsdev=$(_nvmet_passthru_target_connect "${nvme_trtype}" "${def_subsysnqn}")
+	nsdev=$(_nvmet_passthru_target_connect "${def_subsysnqn}")
 
 	if ! _xfs_run_fio_verify_io "${nsdev}" "${nvme_img_size}"; then
 		echo "FAIL: fio verify failed"
diff --git a/tests/nvme/036 b/tests/nvme/036
index 89ccd256a67c..a1ae74fa95ea 100755
--- a/tests/nvme/036
+++ b/tests/nvme/036
@@ -21,7 +21,7 @@ test_device() {
 	local ctrldev
 
 	_nvmet_passthru_target_setup "${def_subsysnqn}"
-	nsdev=$(_nvmet_passthru_target_connect "${nvme_trtype}" "${def_subsysnqn}")
+	nsdev=$(_nvmet_passthru_target_connect "${def_subsysnqn}")
 
 	ctrldev=$(_find_nvme_dev "${def_subsysnqn}")
 
diff --git a/tests/nvme/037 b/tests/nvme/037
index a2815b3ff2d7..eb47839a4289 100755
--- a/tests/nvme/037
+++ b/tests/nvme/037
@@ -23,8 +23,7 @@ test_device() {
 
 	for ((i = 0; i < iterations; i++)); do
 		_nvmet_passthru_target_setup "${subsys}${i}"
-		nsdev=$(_nvmet_passthru_target_connect "${nvme_trtype}" \
-				"${subsys}${i}")
+		nsdev=$(_nvmet_passthru_target_connect "${subsys}${i}")
 
 		_nvme_disconnect_subsys "${subsys}${i}" >>"${FULL}" 2>&1
 		_nvmet_passthru_target_cleanup "${subsys}${i}"
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 9ce2fd787f8d..1dd1072f9ffb 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -897,8 +897,7 @@ _nvmet_passthru_target_setup() {
 }
 
 _nvmet_passthru_target_connect() {
-	local trtype=$1
-	local subsys_name=$2
+	local subsys_name=$1
 
 	_nvme_connect_subsys "${subsys_name}" --no-wait || return
 	nsdev=$(_find_nvme_passthru_loop_dev "${subsys_name}")
-- 
2.44.0


