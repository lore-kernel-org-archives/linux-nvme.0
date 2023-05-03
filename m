Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 941AFC7EE29
	for <linux-nvme@archiver.kernel.org>; Wed,  3 May 2023 08:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W7w0k+oXuT3ygMJBORCHbE7gJuAfade3I+Yj4aO2iQ4=; b=L05emuT5ZV+eIPmZB2KxXgR+03
	DjlCVxI156/m8stQ07C5vemhQP7gvm2WBg1+zkGQIHMHGkx/IuivL9TWaMyRmXkouxqxCzoWxMp1h
	1YFuFCFShXTGAYZbujKRdcNmMjv86d8iFaIcpQQzRlVMmNFzGw6Q2BlbGdYDtmFqbZFxeEJpQ1GYA
	WIsZ+t0vVDyWm+gcHQ9MYbGmlgUcnq/jVXQz9KGkpRw/q/6Q1TVsVtQWoYXAeOSBGxLue1lA4cV1F
	Zg3V3JCQrSTY7Tmrys2IL/k1aX8ll4O32S1WC0pIIAX8jczsWI6TsgKTXMWofx3zxTgWTi1pxFanM
	PZ6Oz/YQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pu7SL-003kHp-2A;
	Wed, 03 May 2023 08:03:21 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pu7SE-003k9j-0e
	for linux-nvme@lists.infradead.org;
	Wed, 03 May 2023 08:03:15 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C54632233D;
	Wed,  3 May 2023 08:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1683100992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W7w0k+oXuT3ygMJBORCHbE7gJuAfade3I+Yj4aO2iQ4=;
	b=QnWEZFn5QsXCkwyHBQsdL6x12IWRpfaU0FhE/tNMa0MHiWKsu2XILyr1gYWyAl9B1W2rG/
	3oxlsp92hqnyMInwoHxnico5eVjAci+JoDkgH0+Izt/YEV4ztfZsRachvVQAXo8KTVD84+
	bGFsNAJEJbUYNWVDL0u5p96VKsZe7PI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1683100992;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W7w0k+oXuT3ygMJBORCHbE7gJuAfade3I+Yj4aO2iQ4=;
	b=XQIMNtqZ8muZDol8RlsMpug/UOB/qwYif3FZgM1zc4yyBJsUtN04+nPYrB96tlHF/PC33z
	K2dG+UicqUyGAtCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B811B1331F;
	Wed,  3 May 2023 08:03:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id /kHuLEAVUmQ3YgAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 03 May 2023 08:03:12 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v3 05/12] nvme: Use runtime fio background jobs
Date: Wed,  3 May 2023 10:02:51 +0200
Message-Id: <20230503080258.14525-6-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230503080258.14525-1-dwagner@suse.de>
References: <20230503080258.14525-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230503_010314_386275_5666BC28 
X-CRM114-Status: UNSURE (   9.98  )
X-CRM114-Notice: Please train this message.
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

The fio jobs are supposed to run long in background during the test.
Instead relying on a job size use explicit runtime for this.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/032 | 4 ++--
 tests/nvme/040 | 9 +++++++--
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/tests/nvme/032 b/tests/nvme/032
index 017d4a339971..2e4b7f0760c7 100755
--- a/tests/nvme/032
+++ b/tests/nvme/032
@@ -38,8 +38,8 @@ test_device() {
 	sysfs="/sys/bus/pci/devices/${pdev}"
 
 	# start fio job
-	_run_fio_rand_io --filename="$TEST_DEV" --size=1g \
-		--group_reporting  &> /dev/null &
+	_run_fio_rand_io --filename="$TEST_DEV" \
+		--group_reporting --time_based --runtime=-1 &> /dev/null &
 
 	sleep 5
 
diff --git a/tests/nvme/040 b/tests/nvme/040
index 04bd726cd309..05b4f5472ef5 100755
--- a/tests/nvme/040
+++ b/tests/nvme/040
@@ -21,6 +21,7 @@ test() {
 	local port
 	local loop_dev
 	local nvmedev
+	local fio_pid
 
 	echo "Running ${TEST_NAME}"
 
@@ -37,8 +38,10 @@ test() {
 
 	# start fio job
 	echo "starting background fio"
-	_run_fio_rand_io --filename="/dev/${nvmedev}n1" --size=1g \
-		--group_reporting --ramp_time=5  &> /dev/null &
+	_run_fio_rand_io --filename="/dev/${nvmedev}n1" \
+		--group_reporting --ramp_time=5 \
+		--time_based --runtime=-1 &> /dev/null &
+	fio_pid=$!
 	sleep 5
 
 	# do reset/remove operation
@@ -48,6 +51,8 @@ test() {
 	echo "deleting controller"
 	_nvme_delete_ctrl "${nvmedev}"
 
+	{ kill "${fio_pid}"; wait; } &> /dev/null
+
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys}"
 	_remove_nvmet_subsystem "${subsys}"
 	_remove_nvmet_port "${port}"
-- 
2.40.0


