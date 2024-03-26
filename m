Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD43BCD1283
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Mar 2024 14:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=723k5d3gmSaI4BCZngPQmHXko0dX4CcPta9LDkIFzxM=; b=i6IhH7mbPlPSgCPlWMr+UtiQM+
	LhLmkzpzlx/oAUb9gtcl1TbAU7pebvfJo3rrOG1IRvrLp8T1vWrgUiGkiaVsvrzEgVaYVkzDKSZmB
	jGxN/Yoy0JHMXsgV8q/LMFOvMr49b3XnQ+UFTsTnVhbcPgwt9j4Kxq4jWrRbMnTyTGDJa3+FqW8hM
	PQzMjwdNbDxN/mkB5vCP6YoDsHEBFmHMR5gce3UKF019AyAv/7ZkESVE77DvhD8FvEwtRFCcfugMV
	x0XxG61SYdn9Q9R7TrwDwYI7c+czhfB+aXLFwomYdDrsHRRHdioIpTBsbfiaZYQZyUGqJ5HmO+GqZ
	mJQYdy1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp7bv-00000004s8J-2X4S;
	Tue, 26 Mar 2024 14:17:07 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp6dJ-00000004c45-32KK
	for linux-nvme@bombadil.infradead.org;
	Tue, 26 Mar 2024 13:14:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=723k5d3gmSaI4BCZngPQmHXko0dX4CcPta9LDkIFzxM=; b=SgODUPEXkMzu5clNoOGqKrTI7x
	o3lzcBDDuHXNlvCPh7pTS6wFko5zoLkCNdj7mmMAKRK+AeZFf5W0Gq1U+qlTKU1pexf1V+73HW1zV
	U7sgxyyw0WQ044KBT5DMom04+AlA4v5NwE782mj8J9s5yGF6ZUxpkHFrZZ9FAcKTl0AZBRkyKLUvl
	gCM2HqkE2csEYkvkqr3UpalHS6fNVCyyO7qAp8e44yDYGs6WH1UbW7Sm0q+dAegOq8hS2r53R+FKM
	bbCA86ME8Fjg+VHyx1cEhe9L/fpvjIr3icSwIUFoslOg0CoL6EQrqz0bomB4XX7g1V0499Cr/HDpA
	MNiQTNMQ==;
Received: from smtp-out1.suse.de ([195.135.223.130])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp6dF-0000000HAyx-19XJ
	for linux-nvme@lists.infradead.org;
	Tue, 26 Mar 2024 13:14:28 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 416F2373A9;
	Tue, 26 Mar 2024 13:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711458856; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=723k5d3gmSaI4BCZngPQmHXko0dX4CcPta9LDkIFzxM=;
	b=It/4g95Vvoubbl3G6fi5Aeb1NIl9GSbhIgR6hz1aHSLlXP9+sJz4XJa7D4GBARusvNx8Pg
	nu9kxjvR+MSmIqDnzdd0T9st+BhFUp5p6Yv7FwbJU1y9DJljfWn/hBqRRHe9qB2b6xf+4b
	/haYd7e6DSBHTyRwLvJpMjyXLtBMo9A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711458856;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=723k5d3gmSaI4BCZngPQmHXko0dX4CcPta9LDkIFzxM=;
	b=Uojd8yiZsJOK/BwH8IVgJG+a7bUTw/5C0asFegihug2IVx8bWjUu+OpBvelD2JUkcbqDOk
	ZlwpETwR3VKQx0Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711458856; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=723k5d3gmSaI4BCZngPQmHXko0dX4CcPta9LDkIFzxM=;
	b=It/4g95Vvoubbl3G6fi5Aeb1NIl9GSbhIgR6hz1aHSLlXP9+sJz4XJa7D4GBARusvNx8Pg
	nu9kxjvR+MSmIqDnzdd0T9st+BhFUp5p6Yv7FwbJU1y9DJljfWn/hBqRRHe9qB2b6xf+4b
	/haYd7e6DSBHTyRwLvJpMjyXLtBMo9A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711458856;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=723k5d3gmSaI4BCZngPQmHXko0dX4CcPta9LDkIFzxM=;
	b=Uojd8yiZsJOK/BwH8IVgJG+a7bUTw/5C0asFegihug2IVx8bWjUu+OpBvelD2JUkcbqDOk
	ZlwpETwR3VKQx0Cw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 2FAD713587;
	Tue, 26 Mar 2024 13:14:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id NjOeCijKAmYjNwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Tue, 26 Mar 2024 13:14:16 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v3 17/20] nvme: drop default subsysnqn argument from _nvmet_passthru_target_connect
Date: Tue, 26 Mar 2024 14:13:59 +0100
Message-ID: <20240326131402.5092-18-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240326131402.5092-1-dwagner@suse.de>
References: <20240326131402.5092-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.998];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
Authentication-Results: smtp-out1.suse.de;
	none
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240326_131425_503131_A239BEC0 
X-CRM114-Status: GOOD (  12.32  )
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

Remove the last positional argument for _nvmet_passthru_target_connect
which most test pass in the default subsysnqn anyway. There is little
point in cluttering all the test textual noise.

While at it, also use subsysnqn as variable name everywhere, instead of
subsys_name.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/033 |  2 +-
 tests/nvme/034 |  2 +-
 tests/nvme/035 |  2 +-
 tests/nvme/036 |  2 +-
 tests/nvme/037 |  3 ++-
 tests/nvme/rc  | 19 ++++++++++++++++---
 6 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/tests/nvme/033 b/tests/nvme/033
index f7d9f04450a8..70a73b8c7b6a 100755
--- a/tests/nvme/033
+++ b/tests/nvme/033
@@ -53,7 +53,7 @@ test_device() {
 
 	_nvmet_passthru_target_setup
 
-	nsdev=$(_nvmet_passthru_target_connect "${def_subsysnqn}")
+	nsdev=$(_nvmet_passthru_target_connect)
 
 	compare_dev_info "${nsdev}"
 
diff --git a/tests/nvme/034 b/tests/nvme/034
index e5518d497377..409324aafb39 100755
--- a/tests/nvme/034
+++ b/tests/nvme/034
@@ -23,7 +23,7 @@ test_device() {
 	local nsdev
 
 	_nvmet_passthru_target_setup
-	nsdev=$(_nvmet_passthru_target_connect "${def_subsysnqn}")
+	nsdev=$(_nvmet_passthru_target_connect)
 
 	_run_fio_verify_io --size="${nvme_img_size}" --filename="${nsdev}"
 
diff --git a/tests/nvme/035 b/tests/nvme/035
index 8a66c2c15218..ecf6b7285ee5 100755
--- a/tests/nvme/035
+++ b/tests/nvme/035
@@ -29,7 +29,7 @@ test_device() {
 	local nsdev
 
 	_nvmet_passthru_target_setup
-	nsdev=$(_nvmet_passthru_target_connect "${def_subsysnqn}")
+	nsdev=$(_nvmet_passthru_target_connect)
 
 	if ! _xfs_run_fio_verify_io "${nsdev}" "${nvme_img_size}"; then
 		echo "FAIL: fio verify failed"
diff --git a/tests/nvme/036 b/tests/nvme/036
index 20cd3af7081a..36ea792e3d40 100755
--- a/tests/nvme/036
+++ b/tests/nvme/036
@@ -21,7 +21,7 @@ test_device() {
 	local ctrldev
 
 	_nvmet_passthru_target_setup
-	nsdev=$(_nvmet_passthru_target_connect "${def_subsysnqn}")
+	nsdev=$(_nvmet_passthru_target_connect)
 
 	ctrldev=$(_find_nvme_dev "${def_subsysnqn}")
 
diff --git a/tests/nvme/037 b/tests/nvme/037
index 2fe37a7a7340..3e733d201d6a 100755
--- a/tests/nvme/037
+++ b/tests/nvme/037
@@ -23,7 +23,8 @@ test_device() {
 
 	for ((i = 0; i < iterations; i++)); do
 		_nvmet_passthru_target_setup --subsysnqn "${subsys}${i}"
-		nsdev=$(_nvmet_passthru_target_connect "${subsys}${i}")
+		nsdev=$(_nvmet_passthru_target_connect \
+				--subsysnqn "${subsys}${i}")
 
 		_nvme_disconnect_subsys \
 			--subsysnqn "${subsys}${i}" >>"${FULL}" 2>&1
diff --git a/tests/nvme/rc b/tests/nvme/rc
index fca7408062ee..fb7a5fa864e8 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -922,10 +922,23 @@ _nvmet_passthru_target_setup() {
 }
 
 _nvmet_passthru_target_connect() {
-	local subsys_name=$1
+	local subsysnqn="$def_subsysnqn"
+
+	while [[ $# -gt 0 ]]; do
+		case $1 in
+			--subsysnqn)
+				subsysnqn="$2"
+				shift 2
+				;;
+			*)
+				echo "WARNING: unknown argument: $1"
+				shift
+				;;
+		esac
+	done
 
-	_nvme_connect_subsys --subsysnqn "${subsys_name}" --no-wait || return
-	nsdev=$(_find_nvme_passthru_loop_dev "${subsys_name}")
+	_nvme_connect_subsys --subsysnqn "${subsysnqn}" --no-wait || return
+	nsdev=$(_find_nvme_passthru_loop_dev "${subsysnqn}")
 
 	# The following tests can race with the creation
 	# of the device so ensure the block device exists
-- 
2.44.0


