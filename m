Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFA32C54E5D
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Mar 2024 09:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kQPsGRpz4CLonHUcOOyovUXi8TxY05mEmXJFZu2uhG8=; b=Cl/UkF+Lfsj/hffOAky9T1C4r8
	KPbjLRsrNz9ucSWfUEB8T7Stqym+54drI9S2OKcXkF2KdL5EmhTEjyl6eHFBP5T97+P+HBxRYPf7X
	60kMiQGEfKN2ojPYn2EeeZ+1zgxiMUsDcxK82pw3TR9gCy/Tz6Ng84AJb4NQlJlDw6JZWZCLhlG9q
	6TkKijrSJxjXJfUhiswfeehwWLcXBfg+B4wlrniu/X+fKGZ1+kezSv4U/EqKCUfILgg2LOEoavFDE
	+557oEeagJ6wWYxdpfeVSyVOprO1yY61YPH17HwVTdCqqrCTr2N5mK89cnHQ/C7nlSuwmjAnjjzAa
	R4YojasA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rm9Sz-00000007xU2-1zsc;
	Mon, 18 Mar 2024 09:39:37 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rm9SX-00000007xDd-2lKd
	for linux-nvme@lists.infradead.org;
	Mon, 18 Mar 2024 09:39:23 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EF9DC3487E;
	Mon, 18 Mar 2024 09:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710754747; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kQPsGRpz4CLonHUcOOyovUXi8TxY05mEmXJFZu2uhG8=;
	b=JsP2HI7yuCBMyUJmFm4s9yZYdcbd6mYHMz8WDyHqlCl2NECJHcW95X1XEp+u+N3hjLMWJa
	JrR+NdYn2UHzsYv1uePdFmT1gOdndSfBL6DgjY7fHcpjc31H6ZEaq41zqebdVSmRywP2tu
	iHwvApEVRIFvwdLrg1vvhIwT7cnVixA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710754747;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kQPsGRpz4CLonHUcOOyovUXi8TxY05mEmXJFZu2uhG8=;
	b=x7C4lZ/0zUnfUgjEAnnHbp7YU5DRFN/tjvJFuDRbXd+nTL72Hnwt0ln1AFbWHEiO1gJTVu
	PFmUVL1r2IKQXpAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710754746; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kQPsGRpz4CLonHUcOOyovUXi8TxY05mEmXJFZu2uhG8=;
	b=RW6fmR6vFctaVoeJXw80zI+a4IJb4I2Ljgua8ZG+NRnE8GpmXl9Sb81XiQgxzJKGVWiRBQ
	en+PMtz7eMpb7ac+mdhz+hhQsbk3QaH0VkvqvxHk+U40Ly1dphLhYKq7iLtqfb8PHQrQT3
	UAsS8B7RE337+bOHPCpRJw8ZQ7e6G1g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710754746;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kQPsGRpz4CLonHUcOOyovUXi8TxY05mEmXJFZu2uhG8=;
	b=E3REViix27YJyzzG/quVh115yw21jdSolvRR8mXdlWhXistkjuWYVBEAbzj9RPK5Rl7g1W
	m+2H81maHP80+NCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DD5621349D;
	Mon, 18 Mar 2024 09:39:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iNOLNLoL+GWvUAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 18 Mar 2024 09:39:06 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [RFC blktests v1 04/10]  nvme/{014,015,018,019,020,023,024,026,045,046}: use long command line option for nvme
Date: Mon, 18 Mar 2024 10:38:49 +0100
Message-ID: <20240318093856.22307-5-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240318093856.22307-1-dwagner@suse.de>
References: <20240318093856.22307-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-3.29 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 NEURAL_HAM_LONG(-1.00)[-0.998];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.980];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240318_023910_032883_36120BB5 
X-CRM114-Status: GOOD (  10.60  )
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

The long format of the command line option are more descriptive and more
likely to stay stable.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/014 | 2 +-
 tests/nvme/015 | 2 +-
 tests/nvme/018 | 3 ++-
 tests/nvme/019 | 3 ++-
 tests/nvme/020 | 3 ++-
 tests/nvme/023 | 3 ++-
 tests/nvme/024 | 3 ++-
 tests/nvme/026 | 3 ++-
 tests/nvme/045 | 6 +++---
 tests/nvme/046 | 7 ++++---
 10 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/tests/nvme/014 b/tests/nvme/014
index 31bfeb76d13d..c02167142cb3 100755
--- a/tests/nvme/014
+++ b/tests/nvme/014
@@ -39,7 +39,7 @@ test() {
 	dd if=/dev/urandom of="/dev/${nvmedev}n1" \
 		count="${count}" bs="${bs}" status=none
 
-	nvme flush "/dev/${nvmedev}" -n 1
+	nvme flush "/dev/${nvmedev}" --namespace-id 1
 
 	_nvme_disconnect_subsys "${def_subsysnqn}"
 
diff --git a/tests/nvme/015 b/tests/nvme/015
index 4315ffa57577..8ea90f10bda7 100755
--- a/tests/nvme/015
+++ b/tests/nvme/015
@@ -39,7 +39,7 @@ test() {
 	dd if=/dev/urandom of="/dev/${nvmedev}n1" \
 		count="${count}" bs="${bs}" status=none
 
-	nvme flush "/dev/${nvmedev}n1" -n 1
+	nvme flush "/dev/${nvmedev}n1" --namespace-id 1
 
 	_nvme_disconnect_subsys "${def_subsysnqn}"
 
diff --git a/tests/nvme/018 b/tests/nvme/018
index e90173098ec1..e631434d7bd6 100755
--- a/tests/nvme/018
+++ b/tests/nvme/018
@@ -35,7 +35,8 @@ test() {
 	sectors="$(blockdev --getsz "/dev/${nvmedev}n1")"
 	bs="$(blockdev --getbsz "/dev/${nvmedev}n1")"
 
-	nvme read "/dev/${nvmedev}n1" -s "$sectors" -c 0 -z "$bs" &>"$FULL" \
+	nvme read "/dev/${nvmedev}n1" --start-block "$sectors" \
+		--block-count 0 --data-size "$bs" &>"$FULL" \
 		&& echo "ERROR: nvme read for out of range LBA was not rejected"
 
 	_nvme_disconnect_subsys "${def_subsysnqn}"
diff --git a/tests/nvme/019 b/tests/nvme/019
index a1035ff8d8c7..3ab22e2cba01 100755
--- a/tests/nvme/019
+++ b/tests/nvme/019
@@ -31,7 +31,8 @@ test() {
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 	_check_uuid "${nvmedev}"
 
-	nvme dsm "/dev/${nvmedev}" -n 1 -d -s "${sblk_range}" -b "${nblk_range}"
+	nvme dsm "/dev/${nvmedev}" --namespace-id 1 --ad \
+		--slbs "${sblk_range}" --blocks "${nblk_range}"
 
 	_nvme_disconnect_subsys "${def_subsysnqn}"
 
diff --git a/tests/nvme/020 b/tests/nvme/020
index ba3f4c8a5b3d..10de114b83af 100755
--- a/tests/nvme/020
+++ b/tests/nvme/020
@@ -30,7 +30,8 @@ test() {
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 	_check_uuid "${nvmedev}"
 
-	nvme dsm "/dev/${nvmedev}" -n 1 -d -s "${sblk_range}" -b "${nblk_range}"
+	nvme dsm "/dev/${nvmedev}" --namespace-id 1 --ad \
+		--slbs "${sblk_range}" --blocks "${nblk_range}"
 
 	_nvme_disconnect_subsys "${def_subsysnqn}"
 
diff --git a/tests/nvme/023 b/tests/nvme/023
index 4e4d838ef6c9..58f03e8603a7 100755
--- a/tests/nvme/023
+++ b/tests/nvme/023
@@ -29,7 +29,8 @@ test() {
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 	_check_uuid "${nvmedev}"
 
-	if ! nvme smart-log "/dev/${nvmedev}" -n 1 >> "$FULL" 2>&1; then
+	if ! nvme smart-log "/dev/${nvmedev}" --namespace-id 1 \
+		>> "$FULL" 2>&1; then
 		echo "ERROR: smart-log bdev-ns failed"
 	fi
 
diff --git a/tests/nvme/024 b/tests/nvme/024
index 2535a9a78d23..4608f015c4c3 100755
--- a/tests/nvme/024
+++ b/tests/nvme/024
@@ -29,7 +29,8 @@ test() {
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 	_check_uuid "${nvmedev}"
 
-	if ! nvme smart-log "/dev/${nvmedev}" -n 1 >> "$FULL" 2>&1; then
+	if ! nvme smart-log "/dev/${nvmedev}" --namespace-id 1 \
+		>> "$FULL" 2>&1; then
 		echo "ERROR: smart-log file-ns failed"
 	fi
 	_nvme_disconnect_subsys "${def_subsysnqn}" >> "$FULL" 2>&1
diff --git a/tests/nvme/026 b/tests/nvme/026
index 5a7d9927b44b..d5e13db0a916 100755
--- a/tests/nvme/026
+++ b/tests/nvme/026
@@ -29,7 +29,8 @@ test() {
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 	_check_uuid "${nvmedev}"
 
-	if ! nvme ns-descs "/dev/${nvmedev}" -n 1 >> "$FULL" 2>&1; then
+	if ! nvme ns-descs "/dev/${nvmedev}" --namespace-id 1 \
+		>> "$FULL" 2>&1; then
 		echo "ERROR: ns-desc failed"
 	fi
 
diff --git a/tests/nvme/045 b/tests/nvme/045
index 30c45df8ed18..ceec59979928 100755
--- a/tests/nvme/045
+++ b/tests/nvme/045
@@ -90,7 +90,7 @@ test() {
 
 	echo "Renew host key on the controller"
 
-	new_hostkey="$(nvme gen-dhchap-key -n ${def_subsysnqn} 2> /dev/null)"
+	new_hostkey="$(nvme gen-dhchap-key --nqn ${def_subsysnqn} 2> /dev/null)"
 
 	_set_nvmet_hostkey "${def_hostnqn}" "${new_hostkey}"
 
@@ -100,7 +100,7 @@ test() {
 
 	echo "Renew ctrl key on the controller"
 
-	new_ctrlkey="$(nvme gen-dhchap-key -n ${def_subsysnqn} 2> /dev/null)"
+	new_ctrlkey="$(nvme gen-dhchap-key --nqn ${def_subsysnqn} 2> /dev/null)"
 
 	_set_nvmet_ctrlkey "${def_hostnqn}" "${new_ctrlkey}"
 
@@ -132,7 +132,7 @@ test() {
 
 	echo "Renew host key on the controller and force reconnect"
 
-	new_hostkey="$(nvme gen-dhchap-key -n ${def_subsysnqn} 2> /dev/null)"
+	new_hostkey="$(nvme gen-dhchap-key --nqn ${def_subsysnqn} 2> /dev/null)"
 
 	_set_nvmet_hostkey "${def_hostnqn}" "${new_hostkey}"
 
diff --git a/tests/nvme/046 b/tests/nvme/046
index 7576a24f234d..ea68d4079403 100755
--- a/tests/nvme/046
+++ b/tests/nvme/046
@@ -25,13 +25,14 @@ test_device() {
 
 	chmod g+r,o+r "$ngdev"
 
-	if ! _run_user "nvme io-passthru ${ngdev} --opcode 2 -l 4096 \
-		-n $nsid -r" >> "${FULL}" 2>&1; then
+	if ! _run_user "nvme io-passthru ${ngdev} --opcode 2 --data-len 4096 \
+		--namespace-id $nsid --read" >> "${FULL}" 2>&1; then
 		echo "Error: io-passthru read failed"
 	fi
 
 	if _run_user "echo hello | nvme io-passthru ${ngdev} --opcode 1 \
-		-l 4096 -n $nsid -r" >> "${FULL}" 2>&1; then
+		--data-len 4096 --namespace-id $nsid --read" \
+		>> "${FULL}" 2>&1; then
 		echo "Error: io-passthru write passed (unexpected)"
 	fi
 
-- 
2.44.0


