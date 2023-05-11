Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB677C7EE23
	for <linux-nvme@archiver.kernel.org>; Thu, 11 May 2023 14:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XyPFar/uvfmEGWaW5dhDFdsSTXhNfuavOtAPrf32kM8=; b=Mjb/ESJopDt4SLOoN72o08yWt3
	hAraMeqT7vvxYFYR/H2qvrNqo+o39YBRLahA1owAoWhkHmDn7s/d7++iKGHoqJhY9NSyDhL1IT2Wl
	Rfy9g7tW6zB2eg+0gp/M40DyhSCAQ2QFC8Kp3nuShATiAu4QUkMItAnrU5YQodsSZ+FpHmiLICh1q
	GNm2y+wLfcRWke67+ObwcS48viCh3alf6ru+XoOt/t0xxq0bQPd9N3yndtvr/D6etHOGT5Z9Dlvq6
	unriYJSB9ielpISJGQRppC/VsJACBXEk0FPtZ1G0Xaqc0atuQDoYJ6SpOGMS3T3ytOwm8ieVUMUik
	CJ1IWHDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1px6zu-008yoA-2s;
	Thu, 11 May 2023 14:10:22 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1px6zs-008ylF-1o
	for linux-nvme@lists.infradead.org;
	Thu, 11 May 2023 14:10:22 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6062321D10;
	Thu, 11 May 2023 14:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1683814219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XyPFar/uvfmEGWaW5dhDFdsSTXhNfuavOtAPrf32kM8=;
	b=fx4k0iVNDQci11fhJAwyPC367DlyGxLzPEZSJCi0ihVsho1O9Ww9JL8KiE+hS1CAg0yEC1
	n/2M/fRJiL7cAxqwPA8z4ewVSYQlOW9og7ahDeDtLExwCSHvxlpVgCqD/dRtm6S3ILQeFF
	0UZ0+e7y2CPr3slgEOnKYKD6YxNXJB0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1683814219;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XyPFar/uvfmEGWaW5dhDFdsSTXhNfuavOtAPrf32kM8=;
	b=0VXSr0M+hQU6s1D5q4XAbKURbYmU6bLUJJjN5Zq3+LFybJLFdweQ9A/P+ZaolqDpPtUT7B
	CeD7cq5TDrVJxmDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0FDC4134B2;
	Thu, 11 May 2023 14:10:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id uJ6+Nkr3XGSKPwAAMHmgww
	(envelope-from <dwagner@suse.de>); Thu, 11 May 2023 14:10:18 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v4 09/11] nvme{045,047}: Calculate IO size for random fio jobs
Date: Thu, 11 May 2023 16:09:51 +0200
Message-Id: <20230511140953.17609-10-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230511140953.17609-1-dwagner@suse.de>
References: <20230511140953.17609-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230511_071020_745003_A4E4593B 
X-CRM114-Status: GOOD (  12.30  )
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

_nvme_calc_run_io_size() returns the jobs size for _run_fio_rand_io()
function. The jobs size is the size per job, thus we have to divide
through the number of CPUs.

_xfs_run_fio_verify_io() is replaced with _run_fio_rand_io() because the
former has a minimum nvme_img_size of 350M. Both tests nvme/{045,047}
just want some IO to verify that the path is working. Thus reduce the
min nmve_img_size requirement switch to _run_fio_rand_io()

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/045 |  4 +++-
 tests/nvme/047 |  6 ++++--
 tests/nvme/rc  | 10 ++++++++++
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/tests/nvme/045 b/tests/nvme/045
index 99012f6bed8f..f50087cccb6a 100755
--- a/tests/nvme/045
+++ b/tests/nvme/045
@@ -31,6 +31,7 @@ test() {
 	local ctrlkey
 	local new_ctrlkey
 	local ctrldev
+	local rand_io_size
 
 	echo "Running ${TEST_NAME}"
 
@@ -120,7 +121,8 @@ test() {
 
 	nvmedev=$(_find_nvme_dev "${subsys_name}")
 
-	_run_fio_rand_io --size=4m --filename="/dev/${nvmedev}n1"
+	rand_io_size="$(_nvme_calc_rand_io_size 4m)"
+	_run_fio_rand_io --size="${rand_io_size}" --filename="/dev/${nvmedev}n1"
 
 	_nvme_disconnect_subsys "${subsys_name}"
 
diff --git a/tests/nvme/047 b/tests/nvme/047
index b5a8d469a983..6a7599bc2e91 100755
--- a/tests/nvme/047
+++ b/tests/nvme/047
@@ -25,6 +25,7 @@ test() {
 	local port
 	local nvmedev
 	local loop_dev
+	local rand_io_size
 	local file_path="$TMPDIR/img"
 	local subsys_name="blktests-subsystem-1"
 
@@ -42,7 +43,8 @@ test() {
 
 	nvmedev=$(_find_nvme_dev "${subsys_name}")
 
-	_xfs_run_fio_verify_io /dev/"${nvmedev}n1" "1m" || echo FAIL
+	rand_io_size="$(_nvme_calc_rand_io_size 4M)"
+	_run_fio_rand_io --filename="/dev/${nvmedev}n1" --size="${rand_io_size}"
 
 	_nvme_disconnect_subsys "${subsys_name}" >> "$FULL" 2>&1
 
@@ -50,7 +52,7 @@ test() {
 		--nr-write-queues 1 \
 		--nr-poll-queues 1 || echo FAIL
 
-	_xfs_run_fio_verify_io /dev/"${nvmedev}n1" "1m" || echo FAIL
+	_run_fio_rand_io --filename="/dev/${nvmedev}n1" --size="${rand_io_size}"
 
 	_nvme_disconnect_subsys "${subsys_name}" >> "$FULL" 2>&1
 
diff --git a/tests/nvme/rc b/tests/nvme/rc
index c951339fad7d..277057eef7c5 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -150,6 +150,16 @@ _test_dev_nvme_nsid() {
 	cat "${TEST_DEV_SYSFS}/nsid"
 }
 
+_nvme_calc_rand_io_size() {
+	local img_size_mb
+	local io_size_kb
+
+	img_size_mb="$(convert_to_mb "$1")"
+	io_size_kb="$(((img_size_mb * 1024) / $(nproc)))"
+
+	echo "${io_size_kb}k"
+}
+
 _nvme_fcloop_add_rport() {
 	local local_wwnn="$1"
 	local local_wwpn="$2"
-- 
2.40.0


