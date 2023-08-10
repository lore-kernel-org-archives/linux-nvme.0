Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80A9EC05051
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Aug 2023 11:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ySX0bPj+OlMTvPO100mpK3C4LxGQ/kzWWhKoP04YVHk=; b=H6mIIIhJjvoJVSb2v+nyCoKNFo
	b6Ea9Xaqvr9u64diRYLp6amsAS/4c1FtJNe/xCBmNJlSzb9ntXPkLCSpt72EyZpyhgwo24vdvIxmE
	COsV9psIVluz/o+syeGDDV/p7bYcr4dAyC74lCWE0C03jvK/LGJi3lY1jFIzlzjLw/CkiTgmlLhgw
	omaI4kqnWX6G041YuydhYeb4O9gltBY4dw3UDKuhzUcI2dk/dJlsJLA9d9+sqpMGstiKAqbkAJ0qD
	TYzQlbwkKjXwlTjJFy8fRTc48WxWMQC98zoE7giUfuRjXVCxBY3UcrZNLPPCZnVGvh9zaCpFEf9PS
	NapApvCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qU3bl-007MIR-16;
	Thu, 10 Aug 2023 11:13:37 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qU3bc-007M7e-0F
	for linux-nvme@lists.infradead.org;
	Thu, 10 Aug 2023 11:13:31 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6F61A21867;
	Thu, 10 Aug 2023 11:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691666003; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ySX0bPj+OlMTvPO100mpK3C4LxGQ/kzWWhKoP04YVHk=;
	b=1KJzQHtd2yEoQ9RANk+oHFA5qS3HkdIzzmFgXLjh8dAw9eWFuFVi/jDftrH9KAOYZXbLn+
	NKKH9sFtiPB+PCtZsFSBmf9MQ3pp1cR8IJT+/I8qFhNOF5qYCKas2aeFuCbYG5vVJfYt3u
	dRldxAeOEY37B2Zy7G/c7y8YjoWhKUM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691666003;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ySX0bPj+OlMTvPO100mpK3C4LxGQ/kzWWhKoP04YVHk=;
	b=DSx1hN/81uIOJzcpJh2ArzA9ZSPo1MDRm9DAVGFwzTkIB+j6sLiaKGSnmXWmUg5uhwPHJN
	obE+g3Fjp/uL/qDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 54187138E2;
	Thu, 10 Aug 2023 11:13:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id P/iDFFPG1GQ3LwAAMHmgww
	(envelope-from <dwagner@suse.de>); Thu, 10 Aug 2023 11:13:23 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <jsmart2021@gmail.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v2 02/12] nvme: Reorganize test preamble code section
Date: Thu, 10 Aug 2023 13:13:07 +0200
Message-ID: <20230810111317.25273-3-dwagner@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230810111317.25273-1-dwagner@suse.de>
References: <20230810111317.25273-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230810_041328_415771_C3CD07BB 
X-CRM114-Status: GOOD (  12.40  )
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

This unifies all the tests preamble code section.

Reorganize all tests to start with printing the test name, then
the setting nvmet and finally followed by the variable declarations.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/006 | 4 ++--
 tests/nvme/007 | 4 ++--
 tests/nvme/016 | 4 ++--
 tests/nvme/017 | 4 ++--
 tests/nvme/030 | 8 ++++----
 tests/nvme/031 | 8 ++++----
 tests/nvme/033 | 7 ++++---
 tests/nvme/034 | 7 ++++---
 tests/nvme/035 | 7 ++++---
 tests/nvme/036 | 7 ++++---
 tests/nvme/037 | 8 ++++----
 tests/nvme/038 | 6 +++---
 tests/nvme/039 | 4 ++--
 tests/nvme/040 | 7 ++++---
 tests/nvme/041 | 8 ++++----
 tests/nvme/042 | 8 ++++----
 tests/nvme/043 | 8 ++++----
 tests/nvme/044 | 8 ++++----
 tests/nvme/045 | 8 ++++----
 tests/nvme/048 | 8 ++++----
 20 files changed, 69 insertions(+), 64 deletions(-)

diff --git a/tests/nvme/006 b/tests/nvme/006
index ea0db93791a7..b44c56b6a25d 100755
--- a/tests/nvme/006
+++ b/tests/nvme/006
@@ -18,12 +18,12 @@ requires() {
 test() {
 	echo "Running ${TEST_NAME}"
 
+	_setup_nvmet
+
 	local port
 	local loop_dev
 	local subsys_name="blktests-subsystem-1"
 
-	_setup_nvmet
-
 	truncate -s "${nvme_img_size}" "$TMPDIR/img"
 
 	loop_dev="$(losetup -f --show "$TMPDIR/img")"
diff --git a/tests/nvme/007 b/tests/nvme/007
index 243a79f5a254..112432df7a9d 100755
--- a/tests/nvme/007
+++ b/tests/nvme/007
@@ -17,12 +17,12 @@ requires() {
 test() {
 	echo "Running ${TEST_NAME}"
 
+	_setup_nvmet
+
 	local port
 	local file_path
 	local subsys_name="blktests-subsystem-1"
 
-	_setup_nvmet
-
 	file_path="${TMPDIR}/img"
 
 	truncate -s "${nvme_img_size}" "${file_path}"
diff --git a/tests/nvme/016 b/tests/nvme/016
index f617cf103900..cac0c0509aca 100755
--- a/tests/nvme/016
+++ b/tests/nvme/016
@@ -16,13 +16,13 @@ requires() {
 test() {
 	echo "Running ${TEST_NAME}"
 
+	_setup_nvmet
+
 	local port
 	local iterations="${nvme_num_iter}"
 	local loop_dev
 	local subsys_nqn="blktests-subsystem-1"
 
-	_setup_nvmet
-
 	loop_dev="$(losetup -f)"
 	local genctr=1
 
diff --git a/tests/nvme/017 b/tests/nvme/017
index 3dbb7c174b56..429a25e8e011 100755
--- a/tests/nvme/017
+++ b/tests/nvme/017
@@ -16,13 +16,13 @@ requires() {
 test() {
 	echo "Running ${TEST_NAME}"
 
+	_setup_nvmet
+
 	local port
 	local file_path
 	local iterations="${nvme_num_iter}"
 	local subsys_name="blktests-subsystem-1"
 
-	_setup_nvmet
-
 	file_path="${TMPDIR}/img"
 
 	truncate -s "${nvme_img_size}" "${file_path}"
diff --git a/tests/nvme/030 b/tests/nvme/030
index cfcdcbe6be23..a0b999cace94 100755
--- a/tests/nvme/030
+++ b/tests/nvme/030
@@ -16,14 +16,14 @@ requires() {
 }
 
 test() {
-	local port
-	local genctr
-	local subsys="blktests-subsystem-"
-
 	echo "Running ${TEST_NAME}"
 
 	_setup_nvmet
 
+	local port
+	local genctr
+	local subsys="blktests-subsystem-"
+
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 
 	_create_nvmet_subsystem "${subsys}1" "$(losetup -f)"
diff --git a/tests/nvme/031 b/tests/nvme/031
index e70898819a86..27b08e96dd0b 100755
--- a/tests/nvme/031
+++ b/tests/nvme/031
@@ -24,15 +24,15 @@ requires() {
 }
 
 test() {
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+
 	local subsys="blktests-subsystem-"
 	local iterations=10
 	local loop_dev
 	local port
 
-	echo "Running ${TEST_NAME}"
-
-	_setup_nvmet
-
 	truncate -s "${nvme_img_size}" "$TMPDIR/img"
 
 	loop_dev="$(losetup -f --show "$TMPDIR/img")"
diff --git a/tests/nvme/033 b/tests/nvme/033
index 90aee817de5d..5a4fac03bea0 100755
--- a/tests/nvme/033
+++ b/tests/nvme/033
@@ -45,13 +45,14 @@ compare_dev_info() {
 }
 
 test_device() {
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+
 	local subsys="blktests-subsystem-1"
 	local nsdev
 	local port
 
-	echo "Running ${TEST_NAME}"
-
-	_setup_nvmet
 	port=$(_nvmet_passthru_target_setup "${subsys}")
 
 	nsdev=$(_nvmet_passthru_target_connect "${nvme_trtype}" "${subsys}")
diff --git a/tests/nvme/034 b/tests/nvme/034
index e0ede717c373..334b2525d1b6 100755
--- a/tests/nvme/034
+++ b/tests/nvme/034
@@ -15,14 +15,15 @@ requires() {
 }
 
 test_device() {
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+
 	local subsys="blktests-subsystem-1"
 	local ctrldev
 	local nsdev
 	local port
 
-	echo "Running ${TEST_NAME}"
-
-	_setup_nvmet
 	port=$(_nvmet_passthru_target_setup "${subsys}")
 	nsdev=$(_nvmet_passthru_target_connect "${nvme_trtype}" "${subsys}")
 
diff --git a/tests/nvme/035 b/tests/nvme/035
index 0896f7bb578d..68a9b608920e 100755
--- a/tests/nvme/035
+++ b/tests/nvme/035
@@ -21,14 +21,15 @@ device_requires() {
 }
 
 test_device() {
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+
 	local subsys="blktests-subsystem-1"
 	local ctrldev
 	local nsdev
 	local port
 
-	echo "Running ${TEST_NAME}"
-
-	_setup_nvmet
 	port=$(_nvmet_passthru_target_setup "${subsys}")
 	nsdev=$(_nvmet_passthru_target_connect "${nvme_trtype}" "${subsys}")
 
diff --git a/tests/nvme/036 b/tests/nvme/036
index 8218c6538dfd..c3fc5d4a948d 100755
--- a/tests/nvme/036
+++ b/tests/nvme/036
@@ -14,13 +14,14 @@ requires() {
 }
 
 test_device() {
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+
 	local subsys="blktests-subsystem-1"
 	local ctrldev
 	local port
 
-	echo "Running ${TEST_NAME}"
-
-	_setup_nvmet
 	port=$(_nvmet_passthru_target_setup "${subsys}")
 	nsdev=$(_nvmet_passthru_target_connect "${nvme_trtype}" "${subsys}")
 
diff --git a/tests/nvme/037 b/tests/nvme/037
index fc6c21343652..5a78444b7e78 100755
--- a/tests/nvme/037
+++ b/tests/nvme/037
@@ -13,15 +13,15 @@ requires() {
 }
 
 test_device() {
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+
 	local subsys="blktests-subsystem-"
 	local iterations=10
 	local ctrldev
 	local port
 
-	echo "Running ${TEST_NAME}"
-
-	_setup_nvmet
-
 	for ((i = 0; i < iterations; i++)); do
 		port=$(_nvmet_passthru_target_setup "${subsys}${i}")
 		nsdev=$(_nvmet_passthru_target_connect "${nvme_trtype}" \
diff --git a/tests/nvme/038 b/tests/nvme/038
index 24f02d4ad4d1..5af28da03c36 100755
--- a/tests/nvme/038
+++ b/tests/nvme/038
@@ -19,13 +19,13 @@ requires() {
 }
 
 test() {
-	local subsys_path="${NVMET_CFS}/subsystems/blktests-subsystem-1"
-	local port
-
 	echo "Running ${TEST_NAME}"
 
 	_setup_nvmet
 
+	local subsys_path="${NVMET_CFS}/subsystems/blktests-subsystem-1"
+	local port
+
 	mkdir -p "${subsys_path}"
 	rmdir "${subsys_path}"
 
diff --git a/tests/nvme/039 b/tests/nvme/039
index f327b54a8d00..73b53d0b949c 100755
--- a/tests/nvme/039
+++ b/tests/nvme/039
@@ -131,12 +131,12 @@ inject_invalid_admin_cmd()
 }
 
 test_device() {
+	echo "Running ${TEST_NAME}"
+
 	local nvme_verbose_errors
 	local ns_dev
 	local ctrl_dev
 
-	echo "Running ${TEST_NAME}"
-
 	if _check_kernel_option NVME_VERBOSE_ERRORS; then
 		nvme_verbose_errors=true
 	else
diff --git a/tests/nvme/040 b/tests/nvme/040
index 688a0939a376..3b76753132f3 100755
--- a/tests/nvme/040
+++ b/tests/nvme/040
@@ -17,6 +17,10 @@ requires() {
 }
 
 test() {
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+
 	local subsys="blktests-subsystem-1"
 	local file_path="${TMPDIR}/img"
 	local port
@@ -24,9 +28,6 @@ test() {
 	local nvmedev
 	local fio_pid
 
-	echo "Running ${TEST_NAME}"
-
-	_setup_nvmet
 	truncate -s "${nvme_img_size}" "${file_path}"
 	loop_dev="$(losetup -f --show "${file_path}")"
 
diff --git a/tests/nvme/041 b/tests/nvme/041
index 5b04b99b128e..d8937915d622 100755
--- a/tests/nvme/041
+++ b/tests/nvme/041
@@ -20,6 +20,10 @@ requires() {
 
 
 test() {
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+
 	local port
 	local subsys_name="blktests-subsystem-1"
 	local hostid
@@ -28,8 +32,6 @@ test() {
 	local hostkey
 	local ctrldev
 
-	echo "Running ${TEST_NAME}"
-
 	hostid="${def_hostid}"
 	hostnqn="${def_hostnqn}"
 	hostkey="$(nvme gen-dhchap-key -n ${subsys_name} 2> /dev/null)"
@@ -38,8 +40,6 @@ test() {
 		return 1
 	fi
 
-	_setup_nvmet
-
 	truncate -s "${nvme_img_size}" "${file_path}"
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
diff --git a/tests/nvme/042 b/tests/nvme/042
index 8df5ed37aacc..af291cb33a04 100755
--- a/tests/nvme/042
+++ b/tests/nvme/042
@@ -20,6 +20,10 @@ requires() {
 
 
 test() {
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+
 	local port
 	local subsys_name="blktests-subsystem-1"
 	local hostid
@@ -30,13 +34,9 @@ test() {
 	local hostkey
 	local ctrldev
 
-	echo "Running ${TEST_NAME}"
-
 	hostid="${def_hostid}"
 	hostnqn="${def_hostnqn}"
 
-	_setup_nvmet
-
 	truncate -s "${nvme_img_size}" "${file_path}"
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}"
diff --git a/tests/nvme/043 b/tests/nvme/043
index 8f4b783a02ff..4a37f91e50c3 100755
--- a/tests/nvme/043
+++ b/tests/nvme/043
@@ -21,6 +21,10 @@ requires() {
 
 
 test() {
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+
 	local port
 	local subsys_name="blktests-subsystem-1"
 	local hostid
@@ -31,8 +35,6 @@ test() {
 	local hostkey
 	local ctrldev
 
-	echo "Running ${TEST_NAME}"
-
 	hostid="${def_hostid}"
 	hostnqn="${def_hostnqn}"
 	hostkey="$(nvme gen-dhchap-key -n ${subsys_name} 2> /dev/null)"
@@ -41,8 +43,6 @@ test() {
 		return 1
 	fi
 
-	_setup_nvmet
-
 	truncate -s "${nvme_img_size}" "${file_path}"
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}"
diff --git a/tests/nvme/044 b/tests/nvme/044
index fca0897af27b..27cb343f5ea7 100755
--- a/tests/nvme/044
+++ b/tests/nvme/044
@@ -21,6 +21,10 @@ requires() {
 
 
 test() {
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+
 	local port
 	local subsys_name="blktests-subsystem-1"
 	local hostid
@@ -30,8 +34,6 @@ test() {
 	local ctrlkey
 	local ctrldev
 
-	echo "Running ${TEST_NAME}"
-
 	hostid="${def_hostid}"
 	hostnqn="${def_hostnqn}"
 
@@ -47,8 +49,6 @@ test() {
 		return 1
 	fi
 
-	_setup_nvmet
-
 	truncate -s "${nvme_img_size}" "${file_path}"
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}"
diff --git a/tests/nvme/045 b/tests/nvme/045
index eca629a18691..005d62d4f886 100755
--- a/tests/nvme/045
+++ b/tests/nvme/045
@@ -22,6 +22,10 @@ requires() {
 
 
 test() {
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+
 	local port
 	local subsys_name="blktests-subsystem-1"
 	local hostid
@@ -34,8 +38,6 @@ test() {
 	local ctrldev
 	local rand_io_size
 
-	echo "Running ${TEST_NAME}"
-
 	hostid="${def_hostid}"
 	hostnqn="${def_hostnqn}"
 
@@ -51,8 +53,6 @@ test() {
 		return 1
 	fi
 
-	_setup_nvmet
-
 	truncate -s "${nvme_img_size}" "${file_path}"
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}"
diff --git a/tests/nvme/048 b/tests/nvme/048
index a6ebb8927865..6efcd7d6ab03 100755
--- a/tests/nvme/048
+++ b/tests/nvme/048
@@ -81,6 +81,10 @@ set_qid_max() {
 }
 
 test() {
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+
 	local subsys_name="blktests-subsystem-1"
 	local cfs_path="${NVMET_CFS}/subsystems/${subsys_name}"
 	local file_path="${TMPDIR}/img"
@@ -89,10 +93,6 @@ test() {
 	local hostid
 	local port
 
-	echo "Running ${TEST_NAME}"
-
-	_setup_nvmet
-
 	hostid="${def_hostid}"
 	hostnqn="${def_hostnqn}"
 
-- 
2.41.0


