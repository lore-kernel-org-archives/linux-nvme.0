Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF1EC04E69
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Aug 2023 11:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9RZ2Yzq36jl6W2j4gefEmERvFCX8trh+F8G0TYairgM=; b=2rb7wfDj1voXT72C3ReMP9ZFvT
	sXguWKbgXsZUL1d3RF+qhu3ui8/rpwQ9kd28gFLeTTpojYK/C29jeYf/wrxCRILtzbEdp9T3wIDiM
	/SX+vGtDiXwTJuLuITwtTtZvDvG2SNb3AKL9L9WPJQUs4yzyKnrZ2Oqxk9Jt0xE6OkdyL3sm8E5yK
	m5o4cX29+WG+hzaJLUkkyDnJyVU80LZXDNw6T65jDOBSkJRuBKsa95dtFAy0eYBVmuxh2vcLgsNq0
	Bhi3opD6GoPiq75jDWnysznlqwCcIV9+A7ZCUgrjrHP55Kgv/pN2LTfA5Ziqtx3hL1qtHp2aZMW41
	Bv0b9xUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qU3bf-007MDb-19;
	Thu, 10 Aug 2023 11:13:31 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qU3bb-007M7X-1h
	for linux-nvme@lists.infradead.org;
	Thu, 10 Aug 2023 11:13:29 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D09F41F45B;
	Thu, 10 Aug 2023 11:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691666002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9RZ2Yzq36jl6W2j4gefEmERvFCX8trh+F8G0TYairgM=;
	b=A2mn1HPzcuw3tZZBfLUW5seoHyYW9QW2Ryli+b0yyByjeiEP7ASfvebMwVxi1XxfmMxEJk
	qIrwkw/PllrAvxIpjaeyQmadAtJgFtxu5fRSMBT5maJBKWcpLNm1+46Tqp6mzi4NVvABEB
	T1ImTa6aHCUcr6ochRqzD+ofptNhyt4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691666002;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9RZ2Yzq36jl6W2j4gefEmERvFCX8trh+F8G0TYairgM=;
	b=Jc/IUxiJJWnoNNM60p3ovitCIonhd5gzoCUrb5mihaseaOdPbKS9WlXJwtVJjYMCq8bo87
	Qwgk1OG6qhHPQuBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C1862138E2;
	Thu, 10 Aug 2023 11:13:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id FdD1LlLG1GQ1LwAAMHmgww
	(envelope-from <dwagner@suse.de>); Thu, 10 Aug 2023 11:13:22 +0000
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
Subject: [PATCH blktests v2 01/12] nvme/{003,004,005,013,046,049}: Group all variables declarations
Date: Thu, 10 Aug 2023 13:13:06 +0200
Message-ID: <20230810111317.25273-2-dwagner@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230810111317.25273-1-dwagner@suse.de>
References: <20230810111317.25273-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230810_041327_741505_977AAE81 
X-CRM114-Status: GOOD (  12.27  )
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

Group all variable declarations together at the beginning of the
function. Many of the nvme tests do this but not all. Thus make these
tests use the same style. This allows to spot the odd balls in the
refactoring of the tests.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/003 | 3 ++-
 tests/nvme/004 | 3 ++-
 tests/nvme/005 | 5 +++--
 tests/nvme/013 | 1 -
 tests/nvme/046 | 1 +
 tests/nvme/049 | 1 +
 6 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/tests/nvme/003 b/tests/nvme/003
index 6604012d2068..aa26abf8d8b3 100755
--- a/tests/nvme/003
+++ b/tests/nvme/003
@@ -22,10 +22,11 @@ test() {
 
 	_setup_nvmet
 
+	local loop_dev
 	local port
+
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 
-	local loop_dev
 	loop_dev="$(losetup -f)"
 
 	_create_nvmet_subsystem "blktests-subsystem-1" "${loop_dev}"
diff --git a/tests/nvme/004 b/tests/nvme/004
index cab98ff44326..1e5c2b8b3e87 100755
--- a/tests/nvme/004
+++ b/tests/nvme/004
@@ -23,11 +23,12 @@ test() {
 	_setup_nvmet
 
 	local port
+	local loop_dev
+
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 
 	truncate -s "${nvme_img_size}" "$TMPDIR/img"
 
-	local loop_dev
 	loop_dev="$(losetup -f --show "$TMPDIR/img")"
 
 	_create_nvmet_subsystem "blktests-subsystem-1" "${loop_dev}" \
diff --git a/tests/nvme/005 b/tests/nvme/005
index 8e15a13f3794..836854086822 100755
--- a/tests/nvme/005
+++ b/tests/nvme/005
@@ -22,11 +22,13 @@ test() {
 	_setup_nvmet
 
 	local port
+	local loop_dev
+	local nvmedev
+
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 
 	truncate -s "${nvme_img_size}" "$TMPDIR/img"
 
-	local loop_dev
 	loop_dev="$(losetup -f --show "$TMPDIR/img")"
 
 	_create_nvmet_subsystem "blktests-subsystem-1" "${loop_dev}" \
@@ -35,7 +37,6 @@ test() {
 
 	_nvme_connect_subsys "${nvme_trtype}" blktests-subsystem-1
 
-	local nvmedev
 	nvmedev=$(_find_nvme_dev "blktests-subsystem-1")
 
 	udevadm settle
diff --git a/tests/nvme/013 b/tests/nvme/013
index 14e646a19c47..2be8681616d1 100755
--- a/tests/nvme/013
+++ b/tests/nvme/013
@@ -26,7 +26,6 @@ test() {
 	local port
 	local nvmedev
 	local file_path="${TMPDIR}/img"
-
 	local subsys_name="blktests-subsystem-1"
 
 	truncate -s "${nvme_img_size}" "${file_path}"
diff --git a/tests/nvme/046 b/tests/nvme/046
index b37b9e98a559..942f25206c17 100755
--- a/tests/nvme/046
+++ b/tests/nvme/046
@@ -16,6 +16,7 @@ requires() {
 
 test_device() {
 	echo "Running ${TEST_NAME}"
+
 	local ngdev=${TEST_DEV/nvme/ng}
 	local perm nsid
 
diff --git a/tests/nvme/049 b/tests/nvme/049
index f72862c6426d..599ab58d7a29 100755
--- a/tests/nvme/049
+++ b/tests/nvme/049
@@ -17,6 +17,7 @@ requires() {
 
 test_device() {
 	echo "Running ${TEST_NAME}"
+
 	local ngdev=${TEST_DEV/nvme/ng}
 	local common_args=(
 		--size=1M
-- 
2.41.0


