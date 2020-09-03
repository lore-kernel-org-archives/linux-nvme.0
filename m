Return-Path: <SRS0=8iPx=CM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD516C433E2
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Sep 2020 21:26:54 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D099206CA
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Sep 2020 21:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="w60M9ud9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D099206CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ST7i3AelGjTbOFThZ5qB81DI+Dg/63PN20LnOrVDvsQ=; b=w60M9ud9HRpeZY1ap9wZlWwjd
	mySIhZcwXq+GiSbGthTZLn+33P9ktj2l2zh3Lbd1D2JfWaiPnVECf+1crDgWG4oav3blGXlMM03+9
	d/Y5zzw9IP0gzljsX6OBSJjzunXDlmoWRtzGuiR41G5w2cdh8MEFRYf2GKbQLVfDnbpYVmeO4LOoW
	rvhSizDH5vSEYDL1fJA6AtHAAQVCyhv6u/lajeGkvNtCuxbEsDR34h0Rpb2YtUYDjrDUUWDwYrwgq
	k9jMSLurItRt0cor7gSa4B2DaNDpb1qYFuh+u3lUbzhuasAiX2hOKu7vVP5Qu6D5lnXoGircjchxq
	fcOL4vcPQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kDwku-0007g6-1c; Thu, 03 Sep 2020 21:26:52 +0000
Received: from mail-wm1-f66.google.com ([209.85.128.66])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kDwkq-0007er-DM
 for linux-nvme@lists.infradead.org; Thu, 03 Sep 2020 21:26:50 +0000
Received: by mail-wm1-f66.google.com with SMTP id v4so4232237wmj.5
 for <linux-nvme@lists.infradead.org>; Thu, 03 Sep 2020 14:26:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RjLxVU9bJSYIr8RJXBleNXvEadigpiXjtlRIegUl5q4=;
 b=B0qQVsJn+2q7z+zR0Fu+AWi4Od/UIdnI6atIYBHLXU9xfKIv25V39MHjcu+EealrjB
 L2U2yzSuD4CT0iz8j04pTHHX64B1zgqlIu4NkAXnus+EPF169mfmtEWOqY40kxxFw34u
 nLd8mTRGmGXGqImVcDkNuuzktRf7h9OkaXCjGp6paa8zo84s2JkDbdNr5mcv15aCo2Dk
 ArSBLmlb2yxIHN421CE+lzQ/YKr/o+fXlqfQR7uugRkcFJ74k+klN2FaUOeLBMLZK5Gb
 CKuIdkD2yBm91vk/KCJXM4v2abC63SD/xl8Zum3YJDmHnRRen2AehQLpebtLYseaCVpO
 PM1A==
X-Gm-Message-State: AOAM531gx/hoXHjevbwSUpbwMusOjC2jF1db3Zom4qQiq58XTAbSlsc/
 Ug3tsptBJDCnVbdxcgQogew=
X-Google-Smtp-Source: ABdhPJylIsrhFqz2/wU7QAPu3xJ7GAUxd14TM5fr7NrnLDjlNkx1cevJjCSjihWRoJOpdNEZFXZehA==
X-Received: by 2002:a1c:cc0d:: with SMTP id h13mr4252925wmb.44.1599168407455; 
 Thu, 03 Sep 2020 14:26:47 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:79a5:e112:bd7c:4b29])
 by smtp.gmail.com with ESMTPSA id v204sm6659896wmg.20.2020.09.03.14.26.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 14:26:47 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-block@vger.kernel.org,
	Omar Sandoval <osandov@osandov.com>
Subject: [PATCH v6 2/7] nvme: consolidate some nvme-cli utility functions
Date: Thu,  3 Sep 2020 14:26:29 -0700
Message-Id: <20200903212634.503227-3-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200903212634.503227-1-sagi@grimberg.me>
References: <20200903212634.503227-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200903_172648_558108_3596ABCC 
X-CRM114-Status: GOOD (  12.71  )
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
Cc: Keith Busch <kbusch@kernel.org>, Logan Gunthorpe <logang@deltatee.com>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
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
 tests/nvme/rc  | 31 +++++++++++++++++++++++++++++--
 28 files changed, 80 insertions(+), 53 deletions(-)

diff --git a/tests/nvme/002 b/tests/nvme/002
index aaa5ec4d729a..92779e8d28ca 100755
--- a/tests/nvme/002
+++ b/tests/nvme/002
@@ -31,7 +31,7 @@ test() {
 		_add_nvmet_subsys_to_port "${port}" "blktests-subsystem-$i"
 	done
 
-	nvme discover -t loop | _filter_discovery
+	_nvme_discover loop | _filter_discovery
 
 	for ((i = iterations - 1; i >= 0; i--)); do
 		_remove_nvmet_subsystem_from_port "${port}" "blktests-subsystem-$i"
diff --git a/tests/nvme/003 b/tests/nvme/003
index fd696d9efe2c..83d1b2ff9cb0 100755
--- a/tests/nvme/003
+++ b/tests/nvme/003
@@ -29,7 +29,7 @@ test() {
 	_create_nvmet_subsystem "blktests-subsystem-1" "${loop_dev}"
 	_add_nvmet_subsys_to_port "${port}" "blktests-subsystem-1"
 
-	nvme connect -t loop -n nqn.2014-08.org.nvmexpress.discovery
+	_nvme_connect_subsys loop nqn.2014-08.org.nvmexpress.discovery
 
 	# This is ugly but checking for the absence of error messages is ...
 	sleep 10
@@ -42,7 +42,7 @@ test() {
 		echo "Fail"
 	fi
 
-	nvme disconnect -n nqn.2014-08.org.nvmexpress.discovery
+	_nvme_disconnect_subsys nqn.2014-08.org.nvmexpress.discovery
 	_remove_nvmet_subsystem_from_port "${port}" "blktests-subsystem-1"
 	_remove_nvmet_subsystem "blktests-subsystem-1"
 	_remove_nvmet_port "${port}"
diff --git a/tests/nvme/004 b/tests/nvme/004
index b841a8d4cd87..1a3eedd634cf 100755
--- a/tests/nvme/004
+++ b/tests/nvme/004
@@ -33,14 +33,14 @@ test() {
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
 	_add_nvmet_subsys_to_port "${port}" "blktests-subsystem-1"
 
-	nvme connect -t loop -n blktests-subsystem-1
+	_nvme_connect_subsys loop blktests-subsystem-1
 
 	local nvmedev
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
-	nvme disconnect -n "blktests-subsystem-1"
+	_nvme_disconnect_subsys blktests-subsystem-1
 	_remove_nvmet_subsystem_from_port "${port}" "blktests-subsystem-1"
 	_remove_nvmet_subsystem "blktests-subsystem-1"
 	_remove_nvmet_port "${port}"
diff --git a/tests/nvme/005 b/tests/nvme/005
index df0900b372be..708e37766e0e 100755
--- a/tests/nvme/005
+++ b/tests/nvme/005
@@ -33,7 +33,7 @@ test() {
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
 	_add_nvmet_subsys_to_port "${port}" "blktests-subsystem-1"
 
-	nvme connect -t loop -n blktests-subsystem-1
+	_nvme_connect_subsys loop blktests-subsystem-1
 
 	local nvmedev
 	nvmedev="$(_find_nvme_loop_dev)"
@@ -42,7 +42,7 @@ test() {
 
 	echo 1 > "/sys/class/nvme/${nvmedev}/reset_controller"
 
-	nvme disconnect -d "${nvmedev}"
+	_nvme_disconnect_ctrl ${nvmedev}
 	_remove_nvmet_subsystem_from_port "${port}" "blktests-subsystem-1"
 	_remove_nvmet_port "${port}"
 
diff --git a/tests/nvme/008 b/tests/nvme/008
index f19de17fefac..177a1f27dcd6 100755
--- a/tests/nvme/008
+++ b/tests/nvme/008
@@ -34,7 +34,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys loop ${subsys_name}
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -42,7 +42,7 @@ test() {
 
 	udevadm settle
 
-	nvme disconnect -n "${subsys_name}"
+	_nvme_disconnect_subsys ${subsys_name}
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/009 b/tests/nvme/009
index 4afbe62864f6..621eec668926 100755
--- a/tests/nvme/009
+++ b/tests/nvme/009
@@ -30,7 +30,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys loop ${subsys_name}
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -38,7 +38,7 @@ test() {
 
 	udevadm settle
 
-	nvme disconnect -n "${subsys_name}"
+	_nvme_disconnect_subsys ${subsys_name}
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/010 b/tests/nvme/010
index 53b97484615f..3a629469014f 100755
--- a/tests/nvme/010
+++ b/tests/nvme/010
@@ -34,7 +34,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys loop ${subsys_name}
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -42,7 +42,7 @@ test() {
 
 	_run_fio_verify_io --size=950m --filename="/dev/${nvmedev}n1"
 
-	nvme disconnect -n "${subsys_name}"
+	_nvme_disconnect_subsys ${subsys_name}
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/011 b/tests/nvme/011
index a54583d5c582..068090a0f42d 100755
--- a/tests/nvme/011
+++ b/tests/nvme/011
@@ -32,7 +32,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys loop ${subsys_name}
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -40,7 +40,7 @@ test() {
 
 	_run_fio_verify_io --size=950m --filename="/dev/${nvmedev}n1"
 
-	nvme disconnect -n "${subsys_name}"
+	_nvme_disconnect_subsys ${subsys_name}
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/012 b/tests/nvme/012
index 0049c3d8ceb6..4cab4c1891a9 100755
--- a/tests/nvme/012
+++ b/tests/nvme/012
@@ -38,7 +38,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys loop ${subsys_name}
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -54,7 +54,7 @@ test() {
 
 	umount "${mount_dir}" > /dev/null 2>&1
 
-	nvme disconnect -n "${subsys_name}"
+	_nvme_disconnect_subsys ${subsys_name}
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/013 b/tests/nvme/013
index 622706ec4088..b646f08be26a 100755
--- a/tests/nvme/013
+++ b/tests/nvme/013
@@ -35,7 +35,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys loop ${subsys_name}
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -51,7 +51,7 @@ test() {
 
 	umount "${mount_dir}" > /dev/null 2>&1
 
-	nvme disconnect -n "${subsys_name}"
+	_nvme_disconnect_subsys ${subsys_name}
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/014 b/tests/nvme/014
index 9517230253ab..979f77009209 100755
--- a/tests/nvme/014
+++ b/tests/nvme/014
@@ -34,7 +34,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys loop ${subsys_name}
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -44,7 +44,7 @@ test() {
 
 	nvme flush "/dev/${nvmedev}" -n 1
 
-	nvme disconnect -n "${subsys_name}"
+	_nvme_disconnect_subsys ${subsys_name}
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/015 b/tests/nvme/015
index 40b850974b43..ecd23b206e25 100755
--- a/tests/nvme/015
+++ b/tests/nvme/015
@@ -31,7 +31,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys loop ${subsys_name}
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -41,7 +41,7 @@ test() {
 
 	nvme flush "/dev/${nvmedev}n1" -n 1
 
-	nvme disconnect -n "${subsys_name}"
+	_nvme_disconnect_subsys ${subsys_name}
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/016 b/tests/nvme/016
index e1bad2f81461..a2b22adfc6b9 100755
--- a/tests/nvme/016
+++ b/tests/nvme/016
@@ -33,7 +33,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "$port" "${subsys_nqn}"
 
-	nvme discover -t loop | _filter_discovery
+	_nvme_discover loop | _filter_discovery
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_nqn}"
 	_remove_nvmet_port "${port}"
 
diff --git a/tests/nvme/017 b/tests/nvme/017
index 2e6d649f9b65..7ec146ec7414 100755
--- a/tests/nvme/017
+++ b/tests/nvme/017
@@ -36,7 +36,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme discover -t loop | _filter_discovery
+	_nvme_discover loop | _filter_discovery
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_port "${port}"
 
diff --git a/tests/nvme/018 b/tests/nvme/018
index e39613709c90..9b5abefd39d2 100755
--- a/tests/nvme/018
+++ b/tests/nvme/018
@@ -32,7 +32,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys loop ${subsys_name}
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -46,7 +46,7 @@ test() {
 	nvme read "/dev/${nvmedev}n1" -s "$sectors" -c 0 -z "$bs" &>"$FULL" \
 		&& echo "ERROR: nvme read for out of range LBA was not rejected"
 
-	nvme disconnect -n "${subsys_name}"
+	_nvme_disconnect_subsys ${subsys_name}
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/019 b/tests/nvme/019
index 86a2a2945b35..5bc68e4514f9 100755
--- a/tests/nvme/019
+++ b/tests/nvme/019
@@ -36,7 +36,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys loop ${subsys_name}
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -44,7 +44,7 @@ test() {
 
 	nvme dsm "/dev/${nvmedev}" -n 1 -d -s "${sblk_range}" -b "${nblk_range}"
 
-	nvme disconnect -n "${subsys_name}"
+	_nvme_disconnect_subsys ${subsys_name}
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/020 b/tests/nvme/020
index ccadec6a5822..32f7490b0796 100755
--- a/tests/nvme/020
+++ b/tests/nvme/020
@@ -32,7 +32,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys loop ${subsys_name}
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -40,7 +40,7 @@ test() {
 
 	nvme dsm "/dev/${nvmedev}" -n 1 -d -s "${sblk_range}" -b "${nblk_range}"
 
-	nvme disconnect -n "${subsys_name}"
+	_nvme_disconnect_subsys ${subsys_name}
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/021 b/tests/nvme/021
index bbcb9d56a350..c10c09277cff 100755
--- a/tests/nvme/021
+++ b/tests/nvme/021
@@ -31,7 +31,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys loop ${subsys_name}
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -41,7 +41,7 @@ test() {
 		echo "ERROR: device not listed"
 	fi
 
-	nvme disconnect -n "${subsys_name}" >> "$FULL" 2>&1
+	_nvme_disconnect_subsys ${subsys_name} >> "$FULL" 2>&1
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/022 b/tests/nvme/022
index 452e7b3d196c..f7286ef008e0 100755
--- a/tests/nvme/022
+++ b/tests/nvme/022
@@ -31,7 +31,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys loop ${subsys_name}
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -41,7 +41,7 @@ test() {
 		echo "ERROR: reset failed"
 	fi
 
-	nvme disconnect -n "${subsys_name}" >> "$FULL" 2>&1
+	_nvme_disconnect_subsys ${subsys_name} >> "$FULL" 2>&1
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/023 b/tests/nvme/023
index 2714571d16d9..0b93fe95954b 100755
--- a/tests/nvme/023
+++ b/tests/nvme/023
@@ -34,7 +34,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys loop ${subsys_name}
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -44,7 +44,7 @@ test() {
 		echo "ERROR: smart-log bdev-ns failed"
 	fi
 
-	nvme disconnect -n "${subsys_name}" >> "$FULL" 2>&1
+	_nvme_disconnect_subsys ${subsys_name} >> "$FULL" 2>&1
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/024 b/tests/nvme/024
index 1f87bd19ec69..174fdc74a4e1 100755
--- a/tests/nvme/024
+++ b/tests/nvme/024
@@ -31,7 +31,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys loop ${subsys_name}
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -40,7 +40,7 @@ test() {
 	if ! nvme smart-log "/dev/${nvmedev}" -n 1 >> "$FULL" 2>&1; then
 		echo "ERROR: smart-log file-ns failed"
 	fi
-	nvme disconnect -n "${subsys_name}" >> "$FULL" 2>&1
+	_nvme_disconnect_subsys ${subsys_name} >> "$FULL" 2>&1
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/025 b/tests/nvme/025
index 1b9e33351f61..7f90a57861bd 100755
--- a/tests/nvme/025
+++ b/tests/nvme/025
@@ -31,7 +31,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys loop ${subsys_name}
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -41,7 +41,7 @@ test() {
 		echo "ERROR: effects-log failed"
 	fi
 
-	nvme disconnect -n "${subsys_name}" >> "$FULL" 2>&1
+	_nvme_disconnect_subsys ${subsys_name} >> "$FULL" 2>&1
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/026 b/tests/nvme/026
index 21a265a630ba..5af08b753fe9 100755
--- a/tests/nvme/026
+++ b/tests/nvme/026
@@ -31,7 +31,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys loop ${subsys_name}
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -41,7 +41,7 @@ test() {
 		echo "ERROR: ns-desc failed"
 	fi
 
-	nvme disconnect -n "${subsys_name}" >> "$FULL" 2>&1
+	_nvme_disconnect_subsys ${subsys_name} >> "$FULL" 2>&1
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/027 b/tests/nvme/027
index d7d33796e122..445f4fc65306 100755
--- a/tests/nvme/027
+++ b/tests/nvme/027
@@ -31,7 +31,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys loop ${subsys_name}
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -40,7 +40,7 @@ test() {
 	if ! nvme ns-rescan "/dev/${nvmedev}" >> "$FULL" 2>&1; then
 		echo "ERROR: ns-rescan failed"
 	fi
-	nvme disconnect -n "${subsys_name}" >> "$FULL" 2>&1
+	_nvme_disconnect_subsys ${subsys_name} >> "$FULL" 2>&1
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/028 b/tests/nvme/028
index 1643857437e8..70f6462bb9f3 100755
--- a/tests/nvme/028
+++ b/tests/nvme/028
@@ -31,7 +31,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys loop ${subsys_name}
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -40,7 +40,7 @@ test() {
 	if ! nvme list-subsys 2>> "$FULL" | grep -q loop; then
 		echo "ERROR: list-subsys"
 	fi
-	nvme disconnect -n "${subsys_name}" >> "$FULL" 2>&1
+	_nvme_disconnect_subsys ${subsys_name} >> "$FULL" 2>&1
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/029 b/tests/nvme/029
index 9f437285d085..873e54e7e43a 100755
--- a/tests/nvme/029
+++ b/tests/nvme/029
@@ -67,7 +67,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys loop ${subsys_name}
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -81,7 +81,7 @@ test() {
 	test_user_io "$dev" 511 1023 > "$FULL" 2>&1 || echo FAIL
 	test_user_io "$dev" 511 1025 > "$FULL" 2>&1 || echo FAIL
 
-	nvme disconnect -n "${subsys_name}" >> "$FULL" 2>&1
+	_nvme_disconnect_subsys ${subsys_name} >> "$FULL" 2>&1
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/031 b/tests/nvme/031
index 7e7ee7327e62..7053553cb837 100755
--- a/tests/nvme/031
+++ b/tests/nvme/031
@@ -41,8 +41,8 @@ test() {
 	for ((i = 0; i < iterations; i++)); do
 		_create_nvmet_subsystem "${subsys}$i" "${loop_dev}"
 		_add_nvmet_subsys_to_port "${port}" "${subsys}$i"
-		nvme connect -t loop -n "${subsys}$i"
-		nvme disconnect -n "${subsys}$i" >> "${FULL}" 2>&1
+		_nvme_connect_subsys loop "${subsys}$i"
+		_nvme_disconnect_subsys "${subsys}$i" >> "${FULL}" 2>&1
 		_remove_nvmet_subsystem_from_port "${port}" "${subsys}$i"
 		_remove_nvmet_subsystem "${subsys}$i"
 	done
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 320aa4b2b475..db19d50131e9 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -64,7 +64,7 @@ _cleanup_nvmet() {
 		transport="$(cat "/sys/class/nvme/${dev}/transport")"
 		if [[ "$transport" == "loop" ]]; then
 			echo "WARNING: Test did not clean up loop device: ${dev}"
-			nvme disconnect -d "${dev}"
+			_nvme_disconnect_ctrl "${dev}"
 		fi
 	done
 
@@ -97,6 +97,33 @@ _setup_nvmet() {
 	modprobe nvme-loop
 }
 
+_nvme_disconnect_ctrl() {
+	local ctrl="$1"
+
+	nvme disconnect -d "${ctrl}"
+}
+
+_nvme_disconnect_subsys() {
+	local subsysnqn="$1"
+
+	nvme disconnect -n "${subsysnqn}"
+}
+
+_nvme_connect_subsys() {
+	local trtype="$1"
+	local subsysnqn="$2"
+
+	ARGS=(-t "${trtype}" -n "${subsysnqn}")
+	nvme connect "${ARGS[@]}"
+}
+
+_nvme_discover() {
+	local trtype="$1"
+
+	ARGS=(-t "${trtype}" -n "${subsysnqn}")
+	nvme discover "${ARGS[@]}"
+}
+
 _create_nvmet_port() {
 	local trtype="$1"
 
@@ -206,6 +233,6 @@ _filter_discovery() {
 }
 
 _discovery_genctr() {
-	nvme discover -t loop |
+	_nvme_discover loop |
 		sed -n -e 's/^.*Generation counter \([0-9]\+\).*$/\1/p'
 }
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
