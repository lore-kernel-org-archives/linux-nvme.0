Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 293E8C54E71
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Mar 2024 13:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CSsJBsXZohsiz4Leay09x15Z7rEEwNS8DbNiMejzmfc=; b=4LAjyyVwqkX2CZ7H2HtQfsV2c9
	DIQzvOJ4Hyyf9Y/L9tbHOj/WR1g3KKvZqwZp3Y976cLg147U7Fp6wOJrRF38NLqsflvEZmlx+IoFC
	mQaeN3iIUDoGUQzenNi6gIAwICDr37FJtioxL1oe/tpyZe6TFqxkSr+Pvaqg36whqBWTKJqW/g9Jj
	qskIMpFVcZDm/pZ8mFMab002kHJ2xMpk4d850R6xyAk0X5CG+TJ2zsMfPcvfVY+Q7Mcak5F4dSHjR
	kVQgcEvkZX5Ls0+ZwlnxIKqHt+6pUnOTzAwjEQT+nHG51oKirzTrdPZAwG6US+YdKrtndOYbEZnkk
	xEsmJDbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnfIO-00000007Q7g-0xpo;
	Fri, 22 Mar 2024 13:50:56 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnfIC-00000007Py9-05ci
	for linux-nvme@bombadil.infradead.org;
	Fri, 22 Mar 2024 13:50:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=CSsJBsXZohsiz4Leay09x15Z7rEEwNS8DbNiMejzmfc=; b=IMsZcMorjVpziir8vLUV0wgwEF
	r8/HGzp5Q++v+JNWpIwHVGLkNHwRu0qkfFJdFSlVcG2mjc7P8Bxc/vzW9JcZ7LczpkBXvDq8SdLXS
	dONZyHvtMf4KCxdhX08wJzPYGkUmv8uT9WINACydOvyg+Sor8tfHI1JeagBOBThH2fPnbRtJ+rMkA
	AjuOA0/iqURaLyklbbBSu7S3VlPuU+IZikduc7LbkTD25szl1ZKRr19Jm7ldcnioxTNMEpyhjkJ3h
	KzlfQO5W0yaZf4grYQ5Rni4QdaxebJ+wv0Ys5ZouJZ6luP6xbcvBoRuzFI+UL/o5J1fb5B014c6Uw
	EaSAhN4Q==;
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnfI8-0000000EoTq-0ISp
	for linux-nvme@lists.infradead.org;
	Fri, 22 Mar 2024 13:50:42 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C76CB3856A;
	Fri, 22 Mar 2024 13:50:29 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B4C7B136AD;
	Fri, 22 Mar 2024 13:50:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TTuyKqWM/WWsJAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 22 Mar 2024 13:50:29 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v2 17/18] nvme: don't assume namespace id
Date: Fri, 22 Mar 2024 14:50:14 +0100
Message-ID: <20240322135015.14712-18-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240322135015.14712-1-dwagner@suse.de>
References: <20240322135015.14712-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Queue-Id: C76CB3856A
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240322_135040_444174_644E54A4 
X-CRM114-Status: GOOD (  15.15  )
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

The tests assume that the namespace id is always 1. This might not be
correct in future (e.g. running real targets), thus harden the test by
using the uuid to lookup the correct namespace id.

The passthru test already do this, so it makes also sense to update the
other tests as well.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/010 |  7 +++----
 tests/nvme/011 |  7 +++----
 tests/nvme/012 |  7 +++----
 tests/nvme/013 |  7 +++----
 tests/nvme/014 | 13 ++++++-------
 tests/nvme/015 | 13 ++++++-------
 tests/nvme/018 | 15 +++++++--------
 tests/nvme/019 |  8 +++-----
 tests/nvme/020 |  7 +++----
 tests/nvme/021 |  7 +++----
 tests/nvme/023 |  8 +++-----
 tests/nvme/024 |  9 ++++-----
 tests/nvme/025 |  7 +++----
 tests/nvme/026 |  8 +++-----
 tests/nvme/029 |  7 ++-----
 tests/nvme/040 |  4 +++-
 tests/nvme/045 |  5 +++--
 tests/nvme/047 |  8 ++++----
 tests/nvme/rc  | 18 ++++++++++++++++++
 19 files changed, 83 insertions(+), 82 deletions(-)

diff --git a/tests/nvme/010 b/tests/nvme/010
index 7d875989a01c..6feb39153e99 100755
--- a/tests/nvme/010
+++ b/tests/nvme/010
@@ -20,17 +20,16 @@ test() {
 
 	_setup_nvmet
 
-	local nvmedev
+	local ns
 
 	_nvmet_target_setup
 
 	_nvme_connect_subsys
 
-	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
-	_check_uuid "${nvmedev}"
+	ns=$(_find_nvme_ns "${def_subsys_uuid}")
 
 	_run_fio_verify_io --size="${nvme_img_size}" \
-		--filename="/dev/${nvmedev}n1"
+		--filename="/dev/${ns}"
 
 	_nvme_disconnect_subsys
 
diff --git a/tests/nvme/011 b/tests/nvme/011
index 0acc8b1dbaed..eee044cbb4f8 100755
--- a/tests/nvme/011
+++ b/tests/nvme/011
@@ -20,17 +20,16 @@ test() {
 
 	_setup_nvmet
 
-	local nvmedev
+	local ns
 
 	_nvmet_target_setup --blkdev file
 
 	_nvme_connect_subsys
 
-	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
-	_check_uuid "${nvmedev}"
+	ns=$(_find_nvme_ns "${def_subsys_uuid}")
 
 	_run_fio_verify_io --size="${nvme_img_size}" \
-		--filename="/dev/${nvmedev}n1"
+		--filename="$/dev/{ns}"
 
 	_nvme_disconnect_subsys
 
diff --git a/tests/nvme/012 b/tests/nvme/012
index a0bff298ab29..64cb6ecf0191 100755
--- a/tests/nvme/012
+++ b/tests/nvme/012
@@ -24,16 +24,15 @@ test() {
 
 	_setup_nvmet
 
-	local nvmedev
+	local ns
 
 	_nvmet_target_setup
 
 	_nvme_connect_subsys
 
-	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
-	_check_uuid "${nvmedev}"
+	ns=$(_find_nvme_ns "${def_subsys_uuid}")
 
-	if ! _xfs_run_fio_verify_io "/dev/${nvmedev}n1"; then
+	if ! _xfs_run_fio_verify_io "/dev/${ns}"; then
 		echo "FAIL: fio verify failed"
 	fi
 
diff --git a/tests/nvme/013 b/tests/nvme/013
index 5e5026eabe17..68d07cbc4afa 100755
--- a/tests/nvme/013
+++ b/tests/nvme/013
@@ -23,16 +23,15 @@ test() {
 
 	_setup_nvmet
 
-	local nvmedev
+	local ns
 
 	_nvmet_target_setup --blkdev file
 
 	_nvme_connect_subsys
 
-	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
-	_check_uuid "${nvmedev}"
+	ns=$(_find_nvme_ns "${def_subsys_uuid}")
 
-	if ! _xfs_run_fio_verify_io "/dev/${nvmedev}n1"; then
+	if ! _xfs_run_fio_verify_io "$/dev/{ns}"; then
 		echo "FAIL: fio verify failed"
 	fi
 
diff --git a/tests/nvme/014 b/tests/nvme/014
index da4b4c13b347..e56e3212cf28 100755
--- a/tests/nvme/014
+++ b/tests/nvme/014
@@ -20,7 +20,7 @@ test() {
 
 	_setup_nvmet
 
-	local nvmedev
+	local ns
 	local size
 	local bs
 	local count
@@ -29,17 +29,16 @@ test() {
 
 	_nvme_connect_subsys
 
-	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
-	_check_uuid "${nvmedev}"
+	ns=$(_find_nvme_ns "${def_subsys_uuid}")
 
-	size="$(blockdev --getsize64 "/dev/${nvmedev}n1")"
-	bs="$(blockdev --getbsz "/dev/${nvmedev}n1")"
+	size="$(blockdev --getsize64 "/dev/${ns}")"
+	bs="$(blockdev --getbsz "/dev/${ns}")"
 	count=$((size / bs))
 
-	dd if=/dev/urandom of="/dev/${nvmedev}n1" \
+	dd if=/dev/urandom of="$/dev/{ns}" \
 		count="${count}" bs="${bs}" status=none
 
-	nvme flush "/dev/${nvmedev}" --namespace-id 1
+	nvme flush "/dev/${ns}"
 
 	_nvme_disconnect_subsys
 
diff --git a/tests/nvme/015 b/tests/nvme/015
index b82f2253c011..f0621dab681b 100755
--- a/tests/nvme/015
+++ b/tests/nvme/015
@@ -20,7 +20,7 @@ test() {
 
 	_setup_nvmet
 
-	local nvmedev
+	local ns
 	local size
 	local bs
 	local count
@@ -29,17 +29,16 @@ test() {
 
 	_nvme_connect_subsys
 
-	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
-	_check_uuid "${nvmedev}"
+	ns=$(_find_nvme_ns "${def_subsys_uuid}")
 
-	size="$(blockdev --getsize64 "/dev/${nvmedev}n1")"
-	bs="$(blockdev --getbsz "/dev/${nvmedev}n1")"
+	size="$(blockdev --getsize64 "/dev/${ns}")"
+	bs="$(blockdev --getbsz "/dev/${ns}")"
 	count=$((size / bs))
 
-	dd if=/dev/urandom of="/dev/${nvmedev}n1" \
+	dd if=/dev/urandom of="/dev/${ns}" \
 		count="${count}" bs="${bs}" status=none
 
-	nvme flush "/dev/${nvmedev}n1" --namespace-id 1
+	nvme flush "/dev/${ns}"
 
 	_nvme_disconnect_subsys
 
diff --git a/tests/nvme/018 b/tests/nvme/018
index bd6e5e930e35..b8c16354a01b 100755
--- a/tests/nvme/018
+++ b/tests/nvme/018
@@ -21,21 +21,20 @@ test() {
 
 	_setup_nvmet
 
-	local nvmedev
+	local ns
+	local sectors
+	local bs
 
 	_nvmet_target_setup --blkdev file
 
 	_nvme_connect_subsys
 
-	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
-	_check_uuid "${nvmedev}"
+	ns=$(_find_nvme_ns "${def_subsys_uuid}")
 
-	local sectors
-	local bs
-	sectors="$(blockdev --getsz "/dev/${nvmedev}n1")"
-	bs="$(blockdev --getbsz "/dev/${nvmedev}n1")"
+	sectors="$(blockdev --getsz "/dev/${ns}")"
+	bs="$(blockdev --getbsz "/dev/${ns}")"
 
-	nvme read "/dev/${nvmedev}n1" --start-block "$sectors" \
+	nvme read "/dev/${ns}" --start-block "$sectors" \
 		--block-count 0 --data-size "$bs" &>"$FULL" \
 		&& echo "ERROR: nvme read for out of range LBA was not rejected"
 
diff --git a/tests/nvme/019 b/tests/nvme/019
index 4d7de8191da7..1cd5378e9dd4 100755
--- a/tests/nvme/019
+++ b/tests/nvme/019
@@ -20,7 +20,7 @@ test() {
 
 	_setup_nvmet
 
-	local nvmedev
+	local ns
 	local nblk_range="10,10,10,10,10,10,10,10,10,10"
 	local sblk_range="100,200,300,400,500,600,700,800,900,1000"
 
@@ -28,10 +28,8 @@ test() {
 
 	_nvme_connect_subsys
 
-	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
-	_check_uuid "${nvmedev}"
-
-	nvme dsm "/dev/${nvmedev}" --namespace-id 1 --ad \
+	ns=$(_find_nvme_ns "${def_subsys_uuid}")
+	nvme dsm "/dev/${ns}" --ad \
 		--slbs "${sblk_range}" --blocks "${nblk_range}"
 
 	_nvme_disconnect_subsys
diff --git a/tests/nvme/020 b/tests/nvme/020
index c734210c5bd9..0364c4e0dd4f 100755
--- a/tests/nvme/020
+++ b/tests/nvme/020
@@ -19,7 +19,7 @@ test() {
 
 	_setup_nvmet
 
-	local nvmedev
+	local ns
 	local nblk_range="10,10,10,10,10,10,10,10,10,10"
 	local sblk_range="100,200,300,400,500,600,700,800,900,1000"
 
@@ -27,10 +27,9 @@ test() {
 
 	_nvme_connect_subsys
 
-	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
-	_check_uuid "${nvmedev}"
+	ns=$(_find_nvme_ns "${def_subsys_uuid}")
 
-	nvme dsm "/dev/${nvmedev}" --namespace-id 1 --ad \
+	nvme dsm "/dev/${ns}" --ad \
 		--slbs "${sblk_range}" --blocks "${nblk_range}"
 
 	_nvme_disconnect_subsys
diff --git a/tests/nvme/021 b/tests/nvme/021
index 358e209d0458..7ee1f078cd60 100755
--- a/tests/nvme/021
+++ b/tests/nvme/021
@@ -20,16 +20,15 @@ test() {
 
 	_setup_nvmet
 
-	local nvmedev
+	local ns
 
 	_nvmet_target_setup --blkdev file
 
 	_nvme_connect_subsys
 
-	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
-	_check_uuid "${nvmedev}"
+	ns=$(_find_nvme_ns "${def_subsys_uuid}")
 
-	if ! nvme list 2>> "$FULL" | grep -q "${nvmedev}n1"; then
+	if ! nvme list 2>> "$FULL" | grep -q "/dev/${ns}"; then
 		echo "ERROR: device not listed"
 	fi
 
diff --git a/tests/nvme/023 b/tests/nvme/023
index abbb35a0b580..d8f17ae7a8ea 100755
--- a/tests/nvme/023
+++ b/tests/nvme/023
@@ -20,17 +20,15 @@ test() {
 
 	_setup_nvmet
 
-	local nvmedev
+	local ns
 
 	_nvmet_target_setup
 
 	_nvme_connect_subsys
 
-	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
-	_check_uuid "${nvmedev}"
+	ns=$(_find_nvme_ns "${def_subsys_uuid}")
 
-	if ! nvme smart-log "/dev/${nvmedev}" --namespace-id 1 \
-		>> "$FULL" 2>&1; then
+	if ! nvme smart-log "/dev/${ns}" >> "$FULL" 2>&1; then
 		echo "ERROR: smart-log bdev-ns failed"
 	fi
 
diff --git a/tests/nvme/024 b/tests/nvme/024
index 3ee18822e26b..a5121940a543 100755
--- a/tests/nvme/024
+++ b/tests/nvme/024
@@ -20,19 +20,18 @@ test() {
 
 	_setup_nvmet
 
-	local nvmedev
+	local ns
 
 	_nvmet_target_setup --blkdev file
 
 	_nvme_connect_subsys
 
-	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
-	_check_uuid "${nvmedev}"
+	ns=$(_find_nvme_ns ${def_subsys_uuid})
 
-	if ! nvme smart-log "/dev/${nvmedev}" --namespace-id 1 \
-		>> "$FULL" 2>&1; then
+	if ! nvme smart-log "/dev/${ns}" >> "$FULL" 2>&1; then
 		echo "ERROR: smart-log file-ns failed"
 	fi
+
 	_nvme_disconnect_subsys >> "$FULL" 2>&1
 
 	_nvmet_target_cleanup
diff --git a/tests/nvme/025 b/tests/nvme/025
index 3cd62d0b4e5e..3f9a615e542e 100755
--- a/tests/nvme/025
+++ b/tests/nvme/025
@@ -20,16 +20,15 @@ test() {
 
 	_setup_nvmet
 
-	local nvmedev
+	local ns
 
 	_nvmet_target_setup --blkdev file
 
 	_nvme_connect_subsys
 
-	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
-	_check_uuid "${nvmedev}"
+	ns=$(_find_nvme_ns "${def_subsys_uuid}")
 
-	if ! nvme effects-log "/dev/${nvmedev}" >> "$FULL" 2>&1; then
+	if ! nvme effects-log "/dev/${ns}" >> "$FULL" 2>&1; then
 		echo "ERROR: effects-log failed"
 	fi
 
diff --git a/tests/nvme/026 b/tests/nvme/026
index 5d54b0ff3d28..28fd151d9a77 100755
--- a/tests/nvme/026
+++ b/tests/nvme/026
@@ -20,17 +20,15 @@ test() {
 
 	_setup_nvmet
 
-	local nvmedev
+	local ns
 
 	_nvmet_target_setup --blkdev file
 
 	_nvme_connect_subsys
 
-	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
-	_check_uuid "${nvmedev}"
+	ns=$(_find_nvme_ns "${def_subsys_uuid}")
 
-	if ! nvme ns-descs "/dev/${nvmedev}" --namespace-id 1 \
-		>> "$FULL" 2>&1; then
+	if ! nvme ns-descs "/dev/${ns}" >> "$FULL" 2>&1; then
 		echo "ERROR: ns-desc failed"
 	fi
 
diff --git a/tests/nvme/029 b/tests/nvme/029
index 8dbe49ba15cc..559c0b4feabe 100755
--- a/tests/nvme/029
+++ b/tests/nvme/029
@@ -53,16 +53,12 @@ test() {
 
 	_setup_nvmet
 
-	local nvmedev
 	local reset_nr_hugepages=false
 
 	_nvmet_target_setup
 
 	_nvme_connect_subsys
 
-	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
-	_check_uuid "${nvmedev}"
-
 	# nvme-cli may fail to allocate linear memory for rather large IO buffers.
 	# Increase nr_hugepages to allow nvme-cli to try the linear memory allocation
 	# from HugeTLB pool.
@@ -72,7 +68,8 @@ test() {
 		reset_nr_hugepages=true
 	fi
 
-	local dev="/dev/${nvmedev}n1"
+	local dev
+	dev="/dev/$(_find_nvme_ns "${def_subsys_uuid}")"
 	test_user_io "$dev" 1 512 > "$FULL" 2>&1 || echo FAIL
 	test_user_io "$dev" 1 511 > "$FULL" 2>&1 || echo FAIL
 	test_user_io "$dev" 1 513 > "$FULL" 2>&1 || echo FAIL
diff --git a/tests/nvme/040 b/tests/nvme/040
index f00fc16b643f..bb9ed5ef57e9 100755
--- a/tests/nvme/040
+++ b/tests/nvme/040
@@ -23,15 +23,17 @@ test() {
 
 	local nvmedev
 	local fio_pid
+	local ns
 
 	_nvmet_target_setup
 
 	_nvme_connect_subsys
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
+	ns=$(_find_nvme_ns "${def_subsys_uuid}")
 
 	# start fio job
 	echo "starting background fio"
-	_run_fio_rand_io --filename="/dev/${nvmedev}n1" \
+	_run_fio_rand_io --filename="/dev/${ns}" \
 		--group_reporting --ramp_time=5 \
 		--time_based --runtime=1d &> /dev/null &
 	fio_pid=$!
diff --git a/tests/nvme/045 b/tests/nvme/045
index 87ac3c019970..f387eadcbda3 100755
--- a/tests/nvme/045
+++ b/tests/nvme/045
@@ -33,6 +33,7 @@ test() {
 	local new_ctrlkey
 	local ctrldev
 	local rand_io_size
+	local ns
 
 	hostkey="$(nvme gen-dhchap-key -n ${def_subsysnqn} 2> /dev/null)"
 	if [ -z "$hostkey" ] ; then
@@ -100,10 +101,10 @@ test() {
 
 	echo "${new_hostkey}" > "${hostkey_file}"
 
-	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
+	ns=$(_find_nvme_ns "${def_subsys_uuid}")
 
 	rand_io_size="$(_nvme_calc_rand_io_size 4m)"
-	_run_fio_rand_io --size="${rand_io_size}" --filename="/dev/${nvmedev}n1"
+	_run_fio_rand_io --size="${rand_io_size}" --filename="/dev/${ns}"
 
 	_nvme_disconnect_subsys
 	_nvmet_target_cleanup
diff --git a/tests/nvme/047 b/tests/nvme/047
index 75aad7d06a36..9bbe84d4f145 100755
--- a/tests/nvme/047
+++ b/tests/nvme/047
@@ -22,7 +22,7 @@ test() {
 
 	_setup_nvmet
 
-	local nvmedev
+	local ns
 	local rand_io_size
 
 	_nvmet_target_setup
@@ -30,10 +30,10 @@ test() {
 	_nvme_connect_subsys \
 		--nr-write-queues 1 || echo FAIL
 
-	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
+	ns=$(_find_nvme_ns "${def_subsys_uuid}")
 
 	rand_io_size="$(_nvme_calc_rand_io_size 4M)"
-	_run_fio_rand_io --filename="/dev/${nvmedev}n1" --size="${rand_io_size}"
+	_run_fio_rand_io --filename="/dev/${ns}" --size="${rand_io_size}"
 
 	_nvme_disconnect_subsys >> "$FULL" 2>&1
 
@@ -41,7 +41,7 @@ test() {
 		--nr-write-queues 1 \
 		--nr-poll-queues 1 || echo FAIL
 
-	_run_fio_rand_io --filename="/dev/${nvmedev}n1" --size="${rand_io_size}"
+	_run_fio_rand_io --filename="/dev/${ns}" --size="${rand_io_size}"
 
 	_nvme_disconnect_subsys >> "$FULL" 2>&1
 
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 225314ea055c..29eabfb917e9 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -797,6 +797,24 @@ _find_nvme_dev() {
 	done
 }
 
+_find_nvme_ns() {
+	local subsys_uuid=$1
+	local uuid
+	local ns
+
+	for ns in "/sys/block/nvme"* ; do
+		# ignore nvme channel block devices
+		if ! [[ "${ns}" =~ nvme[0-9]+n[0-9]+ ]]; then
+			continue
+		fi
+		[ -e "${ns}/uuid" ] || continue
+		uuid=$(cat "${ns}/uuid")
+		if [[ "${subsys_uuid}" == "${uuid}" ]]; then
+			basename "${ns}"
+		fi
+	done
+}
+
 _find_nvme_passthru_loop_dev() {
 	local subsys=$1
 	local nsid
-- 
2.44.0


