Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60A47C04FDF
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Aug 2023 11:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/qhpDrnyJ7ZYfbrDMR7+SmW/nd2jhoSM4735T51Dzt4=; b=SFIsShSIqgbVf8BT7bZP4f0mpd
	92WfNMF1oe0tB6C3HlmXQDOJG+6ymklp3c87hQoHM5Jd2kHZ9uepMLA3ChqxdjiVUyEvE2DvcWA2G
	eDkmWBgqvQQQyRIaAyk9aBGRkFpCCYC2ZBn/HSQrIsfUvKuM6CzWGShc1R48JMfaKzZE5Fszteb6g
	4+FTW4rlFy8hxaqBLy3v50uWNT3Oles73OeKBVFw6hm/poMAKvZPHLN5B/FhHT3+qWhRf/JWech3i
	iuaPYQ4bC6eWuyLWG1S44DeN7FdM/aOYXS9j/ieRoYosl5OZh4nObydF3QRLpvFq+BesJ/5fvfwj1
	tkGW5ldg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qU3bs-007MR8-1E;
	Thu, 10 Aug 2023 11:13:44 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qU3bc-007M8e-17
	for linux-nvme@lists.infradead.org;
	Thu, 10 Aug 2023 11:13:33 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2C0FE21872;
	Thu, 10 Aug 2023 11:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691666007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/qhpDrnyJ7ZYfbrDMR7+SmW/nd2jhoSM4735T51Dzt4=;
	b=d3PuPv22fKAzdkerCTR2aU6h2Tfd+FwmRzr8uA0VIfhVc/nwREJfYo0vtwINa8sKX7jwVw
	uT5FJ7yi71Gc82eUWmXekg67W58hVWcGzhejph6yoGOo4zzlWfqbxK6/1BWT4R6z5x7XE6
	swp4AMECrilJLjcl+3118kr5UTID1fc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691666007;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/qhpDrnyJ7ZYfbrDMR7+SmW/nd2jhoSM4735T51Dzt4=;
	b=lfvEvn/HQiME80KbUIG/nn67BT5CMIOjPAsSLJp5DYTPdFC71kczJQTrTeYmtiyZ7zR/hC
	OgPJYKSGkdX7GWDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1DCC0138E2;
	Thu, 10 Aug 2023 11:13:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id T04wB1fG1GRHLwAAMHmgww
	(envelope-from <dwagner@suse.de>); Thu, 10 Aug 2023 11:13:27 +0000
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
Subject: [PATCH blktests v2 09/12] nvme: Use def_subsys_uuid variable
Date: Thu, 10 Aug 2023 13:13:14 +0200
Message-ID: <20230810111317.25273-10-dwagner@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230810111317.25273-1-dwagner@suse.de>
References: <20230810111317.25273-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230810_041328_664691_B56DDD07 
X-CRM114-Status: GOOD (  10.65  )
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

As all tests are using the same subsys uuid name anyway, use
the def_subsys_uuid variable.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/004 | 2 +-
 tests/nvme/005 | 2 +-
 tests/nvme/006 | 2 +-
 tests/nvme/007 | 2 +-
 tests/nvme/008 | 2 +-
 tests/nvme/009 | 2 +-
 tests/nvme/010 | 2 +-
 tests/nvme/011 | 2 +-
 tests/nvme/012 | 2 +-
 tests/nvme/013 | 2 +-
 tests/nvme/014 | 2 +-
 tests/nvme/015 | 2 +-
 tests/nvme/017 | 2 +-
 tests/nvme/018 | 2 +-
 tests/nvme/019 | 2 +-
 tests/nvme/020 | 2 +-
 tests/nvme/021 | 2 +-
 tests/nvme/022 | 2 +-
 tests/nvme/023 | 2 +-
 tests/nvme/024 | 2 +-
 tests/nvme/025 | 2 +-
 tests/nvme/026 | 2 +-
 tests/nvme/027 | 2 +-
 tests/nvme/028 | 2 +-
 tests/nvme/029 | 2 +-
 tests/nvme/041 | 2 +-
 tests/nvme/047 | 2 +-
 tests/nvme/048 | 2 +-
 28 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/tests/nvme/004 b/tests/nvme/004
index 78b11c7b84c5..54d74b61f689 100755
--- a/tests/nvme/004
+++ b/tests/nvme/004
@@ -32,7 +32,7 @@ test() {
 	loop_dev="$(losetup -f --show "${def_file_path}")"
 
 	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}" \
-		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
+		"${def_subsys_uuid}"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
diff --git a/tests/nvme/005 b/tests/nvme/005
index 211b8affc32a..8e3ddfe75e2f 100755
--- a/tests/nvme/005
+++ b/tests/nvme/005
@@ -32,7 +32,7 @@ test() {
 	loop_dev="$(losetup -f --show "${def_file_path}")"
 
 	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}" \
-		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
+		"${def_subsys_uuid}"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
diff --git a/tests/nvme/006 b/tests/nvme/006
index f31633825a70..910204aaeb90 100755
--- a/tests/nvme/006
+++ b/tests/nvme/006
@@ -28,7 +28,7 @@ test() {
 	loop_dev="$(losetup -f --show "${def_file_path}")"
 
 	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}" \
-		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
+		"${def_subsys_uuid}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
diff --git a/tests/nvme/007 b/tests/nvme/007
index b6a4bc437103..db00bdcc2d08 100755
--- a/tests/nvme/007
+++ b/tests/nvme/007
@@ -24,7 +24,7 @@ test() {
 	truncate -s "${nvme_img_size}" "${def_file_path}"
 
 	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
-		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
+		"${def_subsys_uuid}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
diff --git a/tests/nvme/008 b/tests/nvme/008
index a38926ef0051..752ab30a756b 100755
--- a/tests/nvme/008
+++ b/tests/nvme/008
@@ -29,7 +29,7 @@ test() {
 	loop_dev="$(losetup -f --show "${def_file_path}")"
 
 	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}" \
-		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
+		"${def_subsys_uuid}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
diff --git a/tests/nvme/009 b/tests/nvme/009
index 2c8ea7ead9b8..7debd837cc76 100755
--- a/tests/nvme/009
+++ b/tests/nvme/009
@@ -25,7 +25,7 @@ test() {
 	truncate -s "${nvme_img_size}" "${def_file_path}"
 
 	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
-		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
+		"${def_subsys_uuid}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
diff --git a/tests/nvme/010 b/tests/nvme/010
index 81f7d2024ee6..cba711b29af8 100755
--- a/tests/nvme/010
+++ b/tests/nvme/010
@@ -29,7 +29,7 @@ test() {
 	loop_dev="$(losetup -f --show "${def_file_path}")"
 
 	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}" \
-		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
+		"${def_subsys_uuid}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
diff --git a/tests/nvme/011 b/tests/nvme/011
index e6f78867e283..ba2718d81bd9 100755
--- a/tests/nvme/011
+++ b/tests/nvme/011
@@ -26,7 +26,7 @@ test() {
 	truncate -s "${nvme_img_size}" "${def_file_path}"
 
 	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
-		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
+		"${def_subsys_uuid}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
diff --git a/tests/nvme/012 b/tests/nvme/012
index 85549c25a1c6..629b5194435e 100755
--- a/tests/nvme/012
+++ b/tests/nvme/012
@@ -33,7 +33,7 @@ test() {
 	loop_dev="$(losetup -f --show "${def_file_path}")"
 
 	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}" \
-		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
+		"${def_subsys_uuid}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
diff --git a/tests/nvme/013 b/tests/nvme/013
index 355bc2e03557..ca51544b82d1 100755
--- a/tests/nvme/013
+++ b/tests/nvme/013
@@ -29,7 +29,7 @@ test() {
 	truncate -s "${nvme_img_size}" "${def_file_path}"
 
 	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
-		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
+		"${def_subsys_uuid}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
diff --git a/tests/nvme/014 b/tests/nvme/014
index 44ae91e2210f..6d27300cfb30 100755
--- a/tests/nvme/014
+++ b/tests/nvme/014
@@ -32,7 +32,7 @@ test() {
 	loop_dev="$(losetup -f --show "${def_file_path}")"
 
 	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}" \
-		 "91fdba0d-f87b-4c25-b80f-db7be1418b9e"
+		 "${def_subsys_uuid}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
diff --git a/tests/nvme/015 b/tests/nvme/015
index 16e41ee65d42..1b3aa4aa36c2 100755
--- a/tests/nvme/015
+++ b/tests/nvme/015
@@ -29,7 +29,7 @@ test() {
 	truncate -s "${nvme_img_size}" "${def_file_path}"
 
 	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
-		 "91fdba0d-f87b-4c25-b80f-db7be1418b9e"
+		 "${def_subsys_uuid}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
diff --git a/tests/nvme/017 b/tests/nvme/017
index 7cbf274c13b0..aa0a3fefae90 100755
--- a/tests/nvme/017
+++ b/tests/nvme/017
@@ -26,7 +26,7 @@ test() {
 	local genctr=1
 
 	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
-		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
+		"${def_subsys_uuid}"
 
 	for ((i = 2; i <= iterations; i++)); do
 		_create_nvmet_ns "${def_subsysnqn}" "${i}" "${def_file_path}"
diff --git a/tests/nvme/018 b/tests/nvme/018
index d1d2082e62ac..b66056d43041 100755
--- a/tests/nvme/018
+++ b/tests/nvme/018
@@ -27,7 +27,7 @@ test() {
 	truncate -s "${nvme_img_size}" "${def_file_path}"
 
 	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
-		 "91fdba0d-f87b-4c25-b80f-db7be1418b9e"
+		 "${def_subsys_uuid}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
diff --git a/tests/nvme/019 b/tests/nvme/019
index 2628dea55ac8..b456b38d038e 100755
--- a/tests/nvme/019
+++ b/tests/nvme/019
@@ -31,7 +31,7 @@ test() {
 	loop_dev="$(losetup -f --show "${def_file_path}")"
 
 	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}" \
-		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
+		"${def_subsys_uuid}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
diff --git a/tests/nvme/020 b/tests/nvme/020
index 4a4f3c12da30..ba88921d75af 100755
--- a/tests/nvme/020
+++ b/tests/nvme/020
@@ -27,7 +27,7 @@ test() {
 	truncate -s "${nvme_img_size}" "${def_file_path}"
 
 	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
-		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
+		"${def_subsys_uuid}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
diff --git a/tests/nvme/021 b/tests/nvme/021
index 11f82d64f378..02ef9727ee59 100755
--- a/tests/nvme/021
+++ b/tests/nvme/021
@@ -26,7 +26,7 @@ test() {
 	truncate -s "${nvme_img_size}" "${def_file_path}"
 
 	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
-		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
+		"${def_subsys_uuid}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
diff --git a/tests/nvme/022 b/tests/nvme/022
index 586f6cdd3448..74c12c3e0ba9 100755
--- a/tests/nvme/022
+++ b/tests/nvme/022
@@ -26,7 +26,7 @@ test() {
 	truncate -s "${nvme_img_size}" "${def_file_path}"
 
 	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
-		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
+		"${def_subsys_uuid}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
diff --git a/tests/nvme/023 b/tests/nvme/023
index b13426cf5615..413b6afa6d14 100755
--- a/tests/nvme/023
+++ b/tests/nvme/023
@@ -29,7 +29,7 @@ test() {
 	loop_dev="$(losetup -f --show "${def_file_path}")"
 
 	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}" \
-		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
+		"${def_subsys_uuid}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
diff --git a/tests/nvme/024 b/tests/nvme/024
index b7c7b3f64321..1baf5487ae64 100755
--- a/tests/nvme/024
+++ b/tests/nvme/024
@@ -26,7 +26,7 @@ test() {
 	truncate -s "${nvme_img_size}" "${def_file_path}"
 
 	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
-		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
+		"${def_subsys_uuid}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
diff --git a/tests/nvme/025 b/tests/nvme/025
index 04ceace5840b..9eecd4d4a604 100755
--- a/tests/nvme/025
+++ b/tests/nvme/025
@@ -26,7 +26,7 @@ test() {
 	truncate -s "${nvme_img_size}" "${def_file_path}"
 
 	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
-		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
+		"${def_subsys_uuid}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
diff --git a/tests/nvme/026 b/tests/nvme/026
index a9dc7bc15db5..8a8bc58170e2 100755
--- a/tests/nvme/026
+++ b/tests/nvme/026
@@ -26,7 +26,7 @@ test() {
 	truncate -s "${nvme_img_size}" "${def_file_path}"
 
 	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
-		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
+		"${def_subsys_uuid}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
diff --git a/tests/nvme/027 b/tests/nvme/027
index fda8c61405a5..723e721202be 100755
--- a/tests/nvme/027
+++ b/tests/nvme/027
@@ -26,7 +26,7 @@ test() {
 	truncate -s "${nvme_img_size}" "${def_file_path}"
 
 	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
-		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
+		"${def_subsys_uuid}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
diff --git a/tests/nvme/028 b/tests/nvme/028
index 8e42ea37a634..d4e62e8cae1c 100755
--- a/tests/nvme/028
+++ b/tests/nvme/028
@@ -26,7 +26,7 @@ test() {
 	truncate -s "${nvme_img_size}" "${def_file_path}"
 
 	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
-		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
+		"${def_subsys_uuid}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
diff --git a/tests/nvme/029 b/tests/nvme/029
index 7988faf5dd03..b113e387f1fa 100755
--- a/tests/nvme/029
+++ b/tests/nvme/029
@@ -62,7 +62,7 @@ test() {
 	loop_dev="$(losetup -f --show "${def_file_path}")"
 
 	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}" \
-		 "91fdba0d-f87b-4c25-b80f-db7be1418b9e"
+		 "${def_subsys_uuid}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
diff --git a/tests/nvme/041 b/tests/nvme/041
index 0a0700533b7b..cb2766619b0e 100755
--- a/tests/nvme/041
+++ b/tests/nvme/041
@@ -37,7 +37,7 @@ test() {
 	truncate -s "${nvme_img_size}" "${def_file_path}"
 
 	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
-		"b92842df-a394-44b1-84a4-92ae7d112861"
+		"${def_subsys_uuid}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}" "${hostkey}"
diff --git a/tests/nvme/047 b/tests/nvme/047
index 66032f679ae2..2b81f7ea9ffd 100755
--- a/tests/nvme/047
+++ b/tests/nvme/047
@@ -32,7 +32,7 @@ test() {
 	loop_dev="$(losetup -f --show "${def_file_path}")"
 
 	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}" \
-		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
+		"${def_subsys_uuid}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
diff --git a/tests/nvme/048 b/tests/nvme/048
index 6a05feae9b82..19234a5b3791 100755
--- a/tests/nvme/048
+++ b/tests/nvme/048
@@ -92,7 +92,7 @@ test() {
 	truncate -s "${nvme_img_size}" "${def_file_path}"
 
 	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
-		"b92842df-a394-44b1-84a4-92ae7d112861"
+		"${def_subsys_uuid}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
-- 
2.41.0


