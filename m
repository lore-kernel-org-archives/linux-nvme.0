Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CC2DC77B78
	for <linux-nvme@archiver.kernel.org>; Wed,  3 May 2023 08:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aAwZIxK8I8pPL4wc47pZHOduEchq/9jTkHlk6SsankQ=; b=DvyfaUwoL7XdzEYLBMgzUPgS+F
	K5Bw9ajMNIneGoLK9CZiY5qK1J16lFISoFIqsHZokIKl7c5V8gLjrSjfiV+j3ii0Dq1+zF0JUb+HI
	pqMs5/hAKOvWg8SJ4mjBdw/VLvYVp8OlQUNowK9apkFVYEAXb1R8daNpSo/eyilcoFcWpPGjz8nkO
	wdDdYZpCBr3ULRrOEz1VJR3LkT+Ej58dCuc/VboPXHDRcrDK/IQ7VsZce6+IJ/87ak9P7EyVawnO+
	g1JlSNWfx9DSZh9TVDHg1+cwWamjV+BTm869j32E/8u0k0LSe/PR2A5Jq8QSG1pgVGRvpEhkaeNsd
	+tUUVtgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pu7ST-003kQ3-0i;
	Wed, 03 May 2023 08:03:29 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pu7SH-003kCc-0H
	for linux-nvme@lists.infradead.org;
	Wed, 03 May 2023 08:03:18 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E1D7B200AC;
	Wed,  3 May 2023 08:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1683100995; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aAwZIxK8I8pPL4wc47pZHOduEchq/9jTkHlk6SsankQ=;
	b=oHTrdFgGWHdqnfD+LmHOQdC5XxD2Q22DtAONTOxgLJf/EWoUlRQLmuOOSPtFAJNKFUaW/g
	wDSyCILm9vuuMzjsDANBpaByMMOnj4PqJ+YfhZ/+gF9w/aP7S80cYagj41PsmMqN7Bt+9U
	GRLLeaX2nPhPwpje3o2sJYYsooSWp1U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1683100995;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aAwZIxK8I8pPL4wc47pZHOduEchq/9jTkHlk6SsankQ=;
	b=MxQz4XTPHtABvGW4lt/ezlfxVpkfpb+uBHpI520ezQrRzSHKhjJXADr8VqkOGIIhWXVhs9
	siDcr1VKAtzwA+Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D4BDC1331F;
	Wed,  3 May 2023 08:03:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id tjTuM0MVUmRFYgAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 03 May 2023 08:03:15 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v3 10/12] nvme/rc: Calculate IO size for random fio jobs
Date: Wed,  3 May 2023 10:02:56 +0200
Message-Id: <20230503080258.14525-11-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230503080258.14525-1-dwagner@suse.de>
References: <20230503080258.14525-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230503_010317_263736_14E5F0A6 
X-CRM114-Status: GOOD (  11.26  )
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
index 0b4d5f6570d6..268418e5b3e0 100644
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
+	io_size_kb="$(((img_size_mb * 1024) / $(OMP_THREAD_LIMIT=32 nproc)))"
+
+	echo "${io_size_kb}k"
+}
+
 _nvme_fcloop_add_rport() {
 	local local_wwnn="$1"
 	local local_wwpn="$2"
-- 
2.40.0


