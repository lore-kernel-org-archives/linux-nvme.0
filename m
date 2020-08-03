Return-Path: <SRS0=Ae0q=BN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE4C5C433E1
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Aug 2020 06:48:55 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E1F5207FB
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Aug 2020 06:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gs2AXigF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E1F5207FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aCtUop/4aaolqrmeBSqTbEWXqJ4ybzbkm7Iqo86QY88=; b=gs2AXigFsm4n8COuSWJFpiCqSr
	SPur1f76u+HKuL49aZT5fRmqxLOYxOe+L9LklZP5GRGXlpMR0vftCPAu/l1mTX04ougA4D6ad25Bz
	drxzIxjn6FWtJlEnlRaWRiMhRW+w1ejKb9pQUf6S+ZTrJnsRppejx/JLGT1IMlGaIaGFeW7oBCXEZ
	tbkiHHkEm075YsaDcRrcAr9RoJBRoa5Nfv/SpEOkUZVAx64/SmD06EhAouYfwXPayFbBRefKj9Btc
	I4/CyEpxyV6AEpUMB64JjN4ODH8Mbs4bCPHXz0u+YDOb2ZbPFfZnq6UbHiMjL7TYKwWPwP/pabJVQ
	km4RSC5g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k2UHF-0002ll-Sz; Mon, 03 Aug 2020 06:48:53 +0000
Received: from mail-wm1-f65.google.com ([209.85.128.65])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k2UHC-0002kD-Ap
 for linux-nvme@lists.infradead.org; Mon, 03 Aug 2020 06:48:52 +0000
Received: by mail-wm1-f65.google.com with SMTP id k20so14366183wmi.5
 for <linux-nvme@lists.infradead.org>; Sun, 02 Aug 2020 23:48:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=v6FG2c3b08vexMeApuJKR8kLGxeV8IVT2DbjG+Bv4Dw=;
 b=NM9kyouqpOrqalzhITJAq0GH5ITvZDDgllshDoqeuob90C0alFx7euYn5yXXqjdI+0
 pJw2LkaJYtw+MBsVoi8nWPjtHZXcSzvjmf9dXEOf9fRDlYDl3ym36dijhtotvetX2EF2
 l2jRGkls9t5m63MXMDmRMtMe5HF6Iuh/6o8RpNh6Wxnc+wOHji7RLCi+6NPaAWiAboeJ
 vVR0mWOVw3uetwYacbhpgxkOVV+Ij5I8fxtSeid9dIMvMus5+KLvIdzMvLlBgCfB2LVt
 +G5ALDGUmfH0hzIwXmHnx8St4xy1yr/5IxRHQTRFZYMx454WxYviml1Xjr4VwYXOwOJw
 LlDQ==
X-Gm-Message-State: AOAM533AYpo8ImsBo4RCCPUjHaKwQuSEdG4HNeiMXEtn+XP977H8WU9W
 P/8UpRh0gCdvGd1nZQJKW5GMnmxG
X-Google-Smtp-Source: ABdhPJwhP/XSnIOgXrqnFWmL523limqlNPKfndy/uGwaqZbYXWKmAbxsPsdU/c72gQdqXFQ1/MoxRg==
X-Received: by 2002:a7b:c8cd:: with SMTP id f13mr13623214wml.29.1596437328434; 
 Sun, 02 Aug 2020 23:48:48 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:6dac:e394:c378:553e])
 by smtp.gmail.com with ESMTPSA id z6sm23740647wrs.36.2020.08.02.23.48.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Aug 2020 23:48:48 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Omar Sandoval <osandov@osandov.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Johannes Thumshirn <jthumshirn@suse.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH rfc 2/6] nvme: consolidate some nvme-cli utility functions
Date: Sun,  2 Aug 2020 23:48:31 -0700
Message-Id: <20200803064835.67927-3-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200803064835.67927-1-sagi@grimberg.me>
References: <20200803064835.67927-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200803_024850_536085_1721178D 
X-CRM114-Status: GOOD (  11.65  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 tests/nvme/002 |  2 +-
 tests/nvme/003 |  4 ++--
 tests/nvme/004 |  4 ++--
 tests/nvme/005 |  4 ++--
 tests/nvme/008 |  4 ++--
 tests/nvme/009 |  4 ++--
 tests/nvme/010 |  4 ++--
 tests/nvme/011 |  4 ++--
 tests/nvme/012 |  4 ++--
 tests/nvme/013 |  4 ++--
 tests/nvme/014 |  4 ++--
 tests/nvme/015 |  4 ++--
 tests/nvme/016 |  2 +-
 tests/nvme/017 |  2 +-
 tests/nvme/018 |  4 ++--
 tests/nvme/019 |  4 ++--
 tests/nvme/020 |  4 ++--
 tests/nvme/021 |  4 ++--
 tests/nvme/022 |  4 ++--
 tests/nvme/023 |  4 ++--
 tests/nvme/024 |  4 ++--
 tests/nvme/025 |  4 ++--
 tests/nvme/026 |  4 ++--
 tests/nvme/027 |  4 ++--
 tests/nvme/028 |  4 ++--
 tests/nvme/029 |  4 ++--
 tests/nvme/031 |  4 ++--
 tests/nvme/rc  | 50 ++++++++++++++++++++++++++++++++++++++++++++++++--
 28 files changed, 99 insertions(+), 53 deletions(-)

diff --git a/tests/nvme/002 b/tests/nvme/002
index aaa5ec4d729a..999e222705bf 100755
--- a/tests/nvme/002
+++ b/tests/nvme/002
@@ -31,7 +31,7 @@ test() {
 		_add_nvmet_subsys_to_port "${port}" "blktests-subsystem-$i"
 	done
 
-	nvme discover -t loop | _filter_discovery
+	_nvme_discover "loop" | _filter_discovery
 
 	for ((i = iterations - 1; i >= 0; i--)); do
 		_remove_nvmet_subsystem_from_port "${port}" "blktests-subsystem-$i"
diff --git a/tests/nvme/003 b/tests/nvme/003
index fd696d9efe2c..6ea6a23b7942 100755
--- a/tests/nvme/003
+++ b/tests/nvme/003
@@ -29,7 +29,7 @@ test() {
 	_create_nvmet_subsystem "blktests-subsystem-1" "${loop_dev}"
 	_add_nvmet_subsys_to_port "${port}" "blktests-subsystem-1"
 
-	nvme connect -t loop -n nqn.2014-08.org.nvmexpress.discovery
+	_nvme_connect_subsys "loop" "nqn.2014-08.org.nvmexpress.discovery"
 
 	# This is ugly but checking for the absence of error messages is ...
 	sleep 10
@@ -42,7 +42,7 @@ test() {
 		echo "Fail"
 	fi
 
-	nvme disconnect -n nqn.2014-08.org.nvmexpress.discovery
+	_nvme_disconnect_subsys "nqn.2014-08.org.nvmexpress.discovery"
 	_remove_nvmet_subsystem_from_port "${port}" "blktests-subsystem-1"
 	_remove_nvmet_subsystem "blktests-subsystem-1"
 	_remove_nvmet_port "${port}"
diff --git a/tests/nvme/004 b/tests/nvme/004
index b841a8d4cd87..7ea539fda55e 100755
--- a/tests/nvme/004
+++ b/tests/nvme/004
@@ -33,14 +33,14 @@ test() {
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
 	_add_nvmet_subsys_to_port "${port}" "blktests-subsystem-1"
 
-	nvme connect -t loop -n blktests-subsystem-1
+	_nvme_connect_subsys "loop" "blktests-subsystem-1"
 
 	local nvmedev
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
-	nvme disconnect -n "blktests-subsystem-1"
+	_nvme_disconnect_subsys "blktests-subsystem-1"
 	_remove_nvmet_subsystem_from_port "${port}" "blktests-subsystem-1"
 	_remove_nvmet_subsystem "blktests-subsystem-1"
 	_remove_nvmet_port "${port}"
diff --git a/tests/nvme/005 b/tests/nvme/005
index df0900b372be..d4ce6d703c1b 100755
--- a/tests/nvme/005
+++ b/tests/nvme/005
@@ -33,7 +33,7 @@ test() {
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
 	_add_nvmet_subsys_to_port "${port}" "blktests-subsystem-1"
 
-	nvme connect -t loop -n blktests-subsystem-1
+	_nvme_connect_subsys "loop" "blktests-subsystem-1"
 
 	local nvmedev
 	nvmedev="$(_find_nvme_loop_dev)"
@@ -42,7 +42,7 @@ test() {
 
 	echo 1 > "/sys/class/nvme/${nvmedev}/reset_controller"
 
-	nvme disconnect -d "${nvmedev}"
+	_nvme_disconnect_ctrl "${nvmedev}"
 	_remove_nvmet_subsystem_from_port "${port}" "blktests-subsystem-1"
 	_remove_nvmet_port "${port}"
 
diff --git a/tests/nvme/008 b/tests/nvme/008
index f19de17fefac..5ab5c49b2039 100755
--- a/tests/nvme/008
+++ b/tests/nvme/008
@@ -34,7 +34,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys "loop" "${subsys_name}"
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -42,7 +42,7 @@ test() {
 
 	udevadm settle
 
-	nvme disconnect -n "${subsys_name}"
+	_nvme_disconnect_subsys "${subsys_name}"
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/009 b/tests/nvme/009
index 4afbe62864f6..f6b999dea541 100755
--- a/tests/nvme/009
+++ b/tests/nvme/009
@@ -30,7 +30,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys "loop" "${subsys_name}"
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -38,7 +38,7 @@ test() {
 
 	udevadm settle
 
-	nvme disconnect -n "${subsys_name}"
+	_nvme_disconnect_subsys "${subsys_name}"
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/010 b/tests/nvme/010
index 53b97484615f..6caa2d0f813d 100755
--- a/tests/nvme/010
+++ b/tests/nvme/010
@@ -34,7 +34,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys "loop" "${subsys_name}"
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -42,7 +42,7 @@ test() {
 
 	_run_fio_verify_io --size=950m --filename="/dev/${nvmedev}n1"
 
-	nvme disconnect -n "${subsys_name}"
+	_nvme_disconnect_subsys "${subsys_name}"
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/011 b/tests/nvme/011
index a54583d5c582..7a5535982a74 100755
--- a/tests/nvme/011
+++ b/tests/nvme/011
@@ -32,7 +32,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys "loop" "${subsys_name}"
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -40,7 +40,7 @@ test() {
 
 	_run_fio_verify_io --size=950m --filename="/dev/${nvmedev}n1"
 
-	nvme disconnect -n "${subsys_name}"
+	_nvme_disconnect_subsys "${subsys_name}"
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/012 b/tests/nvme/012
index 0049c3d8ceb6..5c3477a16af9 100755
--- a/tests/nvme/012
+++ b/tests/nvme/012
@@ -38,7 +38,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys "loop" "${subsys_name}"
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -54,7 +54,7 @@ test() {
 
 	umount "${mount_dir}" > /dev/null 2>&1
 
-	nvme disconnect -n "${subsys_name}"
+	_nvme_disconnect_subsys "${subsys_name}"
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/013 b/tests/nvme/013
index 622706ec4088..49784a0d46b5 100755
--- a/tests/nvme/013
+++ b/tests/nvme/013
@@ -35,7 +35,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys "loop" "${subsys_name}"
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -51,7 +51,7 @@ test() {
 
 	umount "${mount_dir}" > /dev/null 2>&1
 
-	nvme disconnect -n "${subsys_name}"
+	_nvme_disconnect_subsys "${subsys_name}"
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/014 b/tests/nvme/014
index 9517230253ab..a33ff439fb3d 100755
--- a/tests/nvme/014
+++ b/tests/nvme/014
@@ -34,7 +34,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys "loop" "${subsys_name}"
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -44,7 +44,7 @@ test() {
 
 	nvme flush "/dev/${nvmedev}" -n 1
 
-	nvme disconnect -n "${subsys_name}"
+	_nvme_disconnect_subsys "${subsys_name}"
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/015 b/tests/nvme/015
index 40b850974b43..cb9792e13442 100755
--- a/tests/nvme/015
+++ b/tests/nvme/015
@@ -31,7 +31,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys "loop" "${subsys_name}"
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -41,7 +41,7 @@ test() {
 
 	nvme flush "/dev/${nvmedev}n1" -n 1
 
-	nvme disconnect -n "${subsys_name}"
+	_nvme_disconnect_subsys "${subsys_name}"
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/016 b/tests/nvme/016
index e1bad2f81461..1ad744abb9b0 100755
--- a/tests/nvme/016
+++ b/tests/nvme/016
@@ -33,7 +33,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "$port" "${subsys_nqn}"
 
-	nvme discover -t loop | _filter_discovery
+	_nvme_discover "loop" | _filter_discovery
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_nqn}"
 	_remove_nvmet_port "${port}"
 
diff --git a/tests/nvme/017 b/tests/nvme/017
index 2e6d649f9b65..2507bcd606b7 100755
--- a/tests/nvme/017
+++ b/tests/nvme/017
@@ -36,7 +36,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme discover -t loop | _filter_discovery
+	_nvme_discover "loop" | _filter_discovery
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_port "${port}"
 
diff --git a/tests/nvme/018 b/tests/nvme/018
index e39613709c90..4863274cc525 100755
--- a/tests/nvme/018
+++ b/tests/nvme/018
@@ -32,7 +32,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys "loop" "${subsys_name}"
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -46,7 +46,7 @@ test() {
 	nvme read "/dev/${nvmedev}n1" -s "$sectors" -c 0 -z "$bs" &>"$FULL" \
 		&& echo "ERROR: nvme read for out of range LBA was not rejected"
 
-	nvme disconnect -n "${subsys_name}"
+	_nvme_disconnect_subsys "${subsys_name}"
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/019 b/tests/nvme/019
index 86a2a2945b35..19c5b4755387 100755
--- a/tests/nvme/019
+++ b/tests/nvme/019
@@ -36,7 +36,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys "loop" "${subsys_name}"
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -44,7 +44,7 @@ test() {
 
 	nvme dsm "/dev/${nvmedev}" -n 1 -d -s "${sblk_range}" -b "${nblk_range}"
 
-	nvme disconnect -n "${subsys_name}"
+	_nvme_disconnect_subsys "${subsys_name}"
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/020 b/tests/nvme/020
index ccadec6a5822..0a817004225a 100755
--- a/tests/nvme/020
+++ b/tests/nvme/020
@@ -32,7 +32,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys "loop" "${subsys_name}"
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -40,7 +40,7 @@ test() {
 
 	nvme dsm "/dev/${nvmedev}" -n 1 -d -s "${sblk_range}" -b "${nblk_range}"
 
-	nvme disconnect -n "${subsys_name}"
+	_nvme_disconnect_subsys "${subsys_name}"
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/021 b/tests/nvme/021
index bbcb9d56a350..ac3cbd17cd03 100755
--- a/tests/nvme/021
+++ b/tests/nvme/021
@@ -31,7 +31,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys "loop" "${subsys_name}"
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -41,7 +41,7 @@ test() {
 		echo "ERROR: device not listed"
 	fi
 
-	nvme disconnect -n "${subsys_name}" >> "$FULL" 2>&1
+	_nvme_disconnect_subsys "${subsys_name}" >> "$FULL" 2>&1
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/022 b/tests/nvme/022
index 452e7b3d196c..4c91f98734fc 100755
--- a/tests/nvme/022
+++ b/tests/nvme/022
@@ -31,7 +31,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys "loop" "${subsys_name}"
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -41,7 +41,7 @@ test() {
 		echo "ERROR: reset failed"
 	fi
 
-	nvme disconnect -n "${subsys_name}" >> "$FULL" 2>&1
+	_nvme_disconnect_subsys "${subsys_name}" >> "$FULL" 2>&1
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/023 b/tests/nvme/023
index 2714571d16d9..dcbe821f2709 100755
--- a/tests/nvme/023
+++ b/tests/nvme/023
@@ -34,7 +34,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys "loop" "${subsys_name}"
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -44,7 +44,7 @@ test() {
 		echo "ERROR: smart-log bdev-ns failed"
 	fi
 
-	nvme disconnect -n "${subsys_name}" >> "$FULL" 2>&1
+	_nvme_disconnect_subsys "${subsys_name}" >> "$FULL" 2>&1
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/024 b/tests/nvme/024
index 1f87bd19ec69..0f4bddcb3142 100755
--- a/tests/nvme/024
+++ b/tests/nvme/024
@@ -31,7 +31,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys "loop" "${subsys_name}"
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -40,7 +40,7 @@ test() {
 	if ! nvme smart-log "/dev/${nvmedev}" -n 1 >> "$FULL" 2>&1; then
 		echo "ERROR: smart-log file-ns failed"
 	fi
-	nvme disconnect -n "${subsys_name}" >> "$FULL" 2>&1
+	_nvme_disconnect_subsys "${subsys_name}" >> "$FULL" 2>&1
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/025 b/tests/nvme/025
index 1b9e33351f61..90896d327cff 100755
--- a/tests/nvme/025
+++ b/tests/nvme/025
@@ -31,7 +31,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys "loop" "${subsys_name}"
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -41,7 +41,7 @@ test() {
 		echo "ERROR: effects-log failed"
 	fi
 
-	nvme disconnect -n "${subsys_name}" >> "$FULL" 2>&1
+	_nvme_disconnect_subsys "${subsys_name}" >> "$FULL" 2>&1
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/026 b/tests/nvme/026
index 21a265a630ba..39cfe12a23c7 100755
--- a/tests/nvme/026
+++ b/tests/nvme/026
@@ -31,7 +31,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys "loop" "${subsys_name}"
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -41,7 +41,7 @@ test() {
 		echo "ERROR: ns-desc failed"
 	fi
 
-	nvme disconnect -n "${subsys_name}" >> "$FULL" 2>&1
+	_nvme_disconnect_subsys "${subsys_name}" >> "$FULL" 2>&1
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/027 b/tests/nvme/027
index d7d33796e122..5915c336a0cd 100755
--- a/tests/nvme/027
+++ b/tests/nvme/027
@@ -31,7 +31,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys "loop" "${subsys_name}"
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -40,7 +40,7 @@ test() {
 	if ! nvme ns-rescan "/dev/${nvmedev}" >> "$FULL" 2>&1; then
 		echo "ERROR: ns-rescan failed"
 	fi
-	nvme disconnect -n "${subsys_name}" >> "$FULL" 2>&1
+	_nvme_disconnect_subsys "${subsys_name}" >> "$FULL" 2>&1
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/028 b/tests/nvme/028
index 1643857437e8..cf44102b3957 100755
--- a/tests/nvme/028
+++ b/tests/nvme/028
@@ -31,7 +31,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys "loop" "${subsys_name}"
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -40,7 +40,7 @@ test() {
 	if ! nvme list-subsys 2>> "$FULL" | grep -q loop; then
 		echo "ERROR: list-subsys"
 	fi
-	nvme disconnect -n "${subsys_name}" >> "$FULL" 2>&1
+	_nvme_disconnect_subsys "${subsys_name}" >> "$FULL" 2>&1
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/029 b/tests/nvme/029
index 9f437285d085..192b5c52168c 100755
--- a/tests/nvme/029
+++ b/tests/nvme/029
@@ -67,7 +67,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys "loop" "${subsys_name}"
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -81,7 +81,7 @@ test() {
 	test_user_io "$dev" 511 1023 > "$FULL" 2>&1 || echo FAIL
 	test_user_io "$dev" 511 1025 > "$FULL" 2>&1 || echo FAIL
 
-	nvme disconnect -n "${subsys_name}" >> "$FULL" 2>&1
+	_nvme_disconnect_subsys "${subsys_name}" >> "$FULL" 2>&1
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/031 b/tests/nvme/031
index 7e7ee7327e62..ab17633bc8fc 100755
--- a/tests/nvme/031
+++ b/tests/nvme/031
@@ -41,8 +41,8 @@ test() {
 	for ((i = 0; i < iterations; i++)); do
 		_create_nvmet_subsystem "${subsys}$i" "${loop_dev}"
 		_add_nvmet_subsys_to_port "${port}" "${subsys}$i"
-		nvme connect -t loop -n "${subsys}$i"
-		nvme disconnect -n "${subsys}$i" >> "${FULL}" 2>&1
+		_nvme_connect_subsys "loop" "${subsys}$i"
+		_nvme_disconnect_subsys "${subsys}$i" >> "${FULL}" 2>&1
 		_remove_nvmet_subsystem_from_port "${port}" "${subsys}$i"
 		_remove_nvmet_subsystem "${subsys}$i"
 	done
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 320aa4b2b475..3057b814c508 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -6,6 +6,9 @@
 
 . common/rc
 
+def_traddr="127.0.0.1"
+def_adrfam="ipv4"
+def_trsvcid="4420"
 nvme_trtype=${nvme_trtype:-"loop"}
 
 _nvme_requires() {
@@ -64,7 +67,7 @@ _cleanup_nvmet() {
 		transport="$(cat "/sys/class/nvme/${dev}/transport")"
 		if [[ "$transport" == "loop" ]]; then
 			echo "WARNING: Test did not clean up loop device: ${dev}"
-			nvme disconnect -d "${dev}"
+			_nvme_disconnect_ctrl "${dev}"
 		fi
 	done
 
@@ -97,8 +100,48 @@ _setup_nvmet() {
 	modprobe nvme-loop
 }
 
+_nvme_disconnect_ctrl() {
+	local ctrl="$1"
+
+	nvme disconnect -d ${ctrl}
+}
+
+_nvme_disconnect_subsys() {
+	local subsysnqn="$1"
+
+	nvme disconnect -n ${subsysnqn}
+}
+
+_nvme_connect_subsys() {
+	local trtype="$1"
+	local subsysnqn="$2"
+	local traddr="${3:-$def_traddr}"
+	local trsvcid="${4:-$def_trsvcid}"
+
+	cmd="nvme connect -t ${trtype} -n ${subsysnqn}"
+	if [[ "${trtype}" != "loop" ]]; then
+		cmd=$cmd" -a ${traddr} -s ${trsvcid}"
+	fi
+	eval $cmd
+}
+
+_nvme_discover() {
+	local trtype="$1"
+	local traddr="${2:-$def_traddr}"
+	local trsvcid="${3:-$def_trsvcid}"
+
+	cmd="nvme discover -t ${trtype}"
+	if [[ "${trtype}" != "loop" ]]; then
+		cmd=$cmd" -a ${traddr} -s ${trsvcid}"
+	fi
+	eval $cmd
+}
+
 _create_nvmet_port() {
 	local trtype="$1"
+	local traddr="${2:-$def_traddr}"
+	local adrfam="${3:-$def_adrfam}"
+	local trsvcid="${4:-$def_trsvcid}"
 
 	local port
 	for ((port = 0; ; port++)); do
@@ -109,6 +152,9 @@ _create_nvmet_port() {
 
 	mkdir "${NVMET_CFS}/ports/${port}"
 	echo "${trtype}" > "${NVMET_CFS}/ports/${port}/addr_trtype"
+	echo "${traddr}" > "${NVMET_CFS}/ports/${port}/addr_traddr"
+	echo "${adrfam}" > "${NVMET_CFS}/ports/${port}/addr_adrfam"
+	echo "${trsvcid}" > "${NVMET_CFS}/ports/${port}/addr_trsvcid"
 
 	echo "${port}"
 }
@@ -206,6 +252,6 @@ _filter_discovery() {
 }
 
 _discovery_genctr() {
-	nvme discover -t loop |
+	_nvme_discover "loop" |
 		sed -n -e 's/^.*Generation counter \([0-9]\+\).*$/\1/p'
 }
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
