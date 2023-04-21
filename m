Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A1F1C77B78
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Apr 2023 06:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jCDEW/smOmwBvOMJJJdt4SnrQCWrrDZuVuIkT4i7jsI=; b=Jw/LEXjEfb+QHg+uL/J3LP+O3P
	eeh59pb5ZCYKX2ZAd4fEgn5wGxYMJUYcYoIwu6YXMQ+TS+BEcn1ATaz47jfW4VO0o2TX6LUDSGv2Y
	PSi/4vK3QzUoinxghbCvNnvswjU057sjqPiBEFA3JF8d3V9oL/U/x9WbSDAgQf4gcsIP76+QGmvW9
	UNng4JVHZcklpOHwXLLDxrcu+gf++10jxD7j6DQwzbk8wsHD1t2kkLPh1Rl+Bz5IeJSigIy+GpQeQ
	gPnia1BMlao06Wvb5CydtcuxMznBHT5yghdVrVeQT3WkfXelmmA9+T1MTl9QJ2OnxGz3YNzg49BNE
	jFHzJ4Hg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ppjtb-009kgu-2r;
	Fri, 21 Apr 2023 06:05:23 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ppjtY-009kcX-0j
	for linux-nvme@lists.infradead.org;
	Fri, 21 Apr 2023 06:05:21 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 655AB1FDDB;
	Fri, 21 Apr 2023 06:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1682057116; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jCDEW/smOmwBvOMJJJdt4SnrQCWrrDZuVuIkT4i7jsI=;
	b=RLm5wzmMTMIk5hQhJgWZ5aafAt1lCgSmxu0OQ4GjIuytkJNNz2/7dJu28AACIL1bYK7Ccd
	pyjHLV2H7K6RNydqkWfjFRqvGvKD1XDoxK87rxzKtrWTqb7SWnNL5Crewkvmn2sS17U/O2
	KCfzhl1byXivbkcYSgAuDEJ4wGfzKHE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1682057116;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jCDEW/smOmwBvOMJJJdt4SnrQCWrrDZuVuIkT4i7jsI=;
	b=31+NDckKwxc41+DKq0w44zYD/iV3XFvBiFIBlqh0nGlgRQAvdLYFVf3bNnUAQ8ROLcM4B9
	NAKevrwTpl/MrADg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 580B21390E;
	Fri, 21 Apr 2023 06:05:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id ME1nFZwnQmRqZgAAMHmgww
	(envelope-from <dwagner@suse.de>); Fri, 21 Apr 2023 06:05:16 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH REPOST blktests v2 1/9] nvme-rc: Auto convert test device size info
Date: Fri, 21 Apr 2023 08:04:57 +0200
Message-Id: <20230421060505.10132-2-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230421060505.10132-1-dwagner@suse.de>
References: <20230421060505.10132-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230420_230520_420456_4DF047F5 
X-CRM114-Status: GOOD (  12.28  )
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

Introduce a convert_to_mb() helper which converts the size argument
to MBytes and use in test device require function. This makes it
possible to use user input strings in future.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 common/rc      | 30 +++++++++++++++++++++++++++---
 tests/nvme/035 |  2 +-
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/common/rc b/common/rc
index af4c0b1cab22..dd0afda3d821 100644
--- a/common/rc
+++ b/common/rc
@@ -324,9 +324,12 @@ _get_pci_parent_from_blkdev() {
 		tail -2 | head -1
 }
 
-_require_test_dev_size_mb() {
-	local require_sz_mb=$1
-	local test_dev_sz_mb=$(($(blockdev --getsize64 "$TEST_DEV")/1024/1024))
+_require_test_dev_size() {
+	local require_sz_mb
+	local test_dev_sz_mb
+
+	require_sz_mb="$(convert_to_mb "$1")"
+	test_dev_sz_mb="$(($(blockdev --getsize64 "$TEST_DEV")/1024/1024))"
 
 	if (( "$test_dev_sz_mb" < "$require_sz_mb" )); then
 		SKIP_REASONS+=("${TEST_DEV} required at least ${require_sz_mb}m")
@@ -422,3 +425,24 @@ _have_writeable_kmsg() {
 _run_user() {
 	su "$NORMAL_USER" -c "$1"
 }
+
+convert_to_mb()
+{
+    local str=$1
+    local res
+
+    res=$(echo "${str}" | sed -n 's/^\([0-9]\+\)$/\1/p')
+    if [[ -n "${res}" ]]; then
+        echo "$((res / 1024 / 1024))"
+    fi
+
+    res=$(echo "${str}" | sed -n 's/^\([0-9]\+\)[mM]$/\1/p')
+    if [[ -n "${res}" ]]; then
+        echo "$((res))"
+    fi
+
+    res=$(echo "${str}" | sed -n 's/^\([0-9]\+\)[gG]$/\1/p')
+    if [[ -n "${res}" ]]; then
+        echo "$((res * 1024))"
+    fi
+}
diff --git a/tests/nvme/035 b/tests/nvme/035
index d169e351e3d0..eb1024edddbf 100755
--- a/tests/nvme/035
+++ b/tests/nvme/035
@@ -17,7 +17,7 @@ requires() {
 }
 
 device_requires() {
-	_require_test_dev_size_mb 1024
+	_require_test_dev_size 1024m
 }
 
 test_device() {
-- 
2.40.0


