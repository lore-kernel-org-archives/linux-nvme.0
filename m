Return-Path: <SRS0=CGXy=BV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E31F0C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Aug 2020 21:01:24 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A135206DC
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Aug 2020 21:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bHLY/Jed"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A135206DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=AxCvRxBmCZcLCW42cj+wox1GyDrIRPqRVtn2UfhP0wU=; b=bHLY/JedVecLQn70VvAyishdo
	HkaQPkwJNnQb/JE6QEDk3jwNaOCVpKiS8zY6NE3w3xAvMAFGtt6B71F1Fg0VwBgO6DGiINXH6MNat
	qvf0TqvcZBiRPadw0OAB37Dg2bdQPaNcHiisY9WVXRD6AV3D1qecb+4eWFtSWZhlP1SlWNbh0HXNk
	VtAVQq4S7Aaq401bw6BQVgSUjlhKFS4fRUbYiBNGD9iAh2WfcyfzTjpS9U+rO+o93KWExHY3XO0Zk
	g+NstvGqtVuFrpKVFec6K6EgdvuuwNwnWK55oN0vVZiyUMAcn/hi7OPVbwHvlGL9gYW+E5TvxkNAA
	hWHd7J9Gg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5bOY-0005IY-Sq; Tue, 11 Aug 2020 21:01:18 +0000
Received: from mail-pf1-f196.google.com ([209.85.210.196])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5bOT-0005GA-OZ
 for linux-nvme@lists.infradead.org; Tue, 11 Aug 2020 21:01:15 +0000
Received: by mail-pf1-f196.google.com with SMTP id f193so8265257pfa.12
 for <linux-nvme@lists.infradead.org>; Tue, 11 Aug 2020 14:01:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2/vgxZaLBEo3X1GxcTNBOgwFD0GG283ZvcPViq0IECE=;
 b=RPCyemleyUC40zfyty3GfkNLr+gxriT9oW55ntg6JhiPKG4P9gYS/p5JS1zQxite7u
 vcMkMtoYSZNkFYHzRTVJNpYmJBvEGT+iTj4mp4bRaMO7O4E7RCQ9BxHxuHhxbRsVhl7n
 leohQwud0yj+Egasx+f7cFNs/8qH+JsgGRGOwBERFOvMwMsU0q45P/7oh3PDO/RUXuqq
 ANLD+JS/ftvJGOU8H7etMPqawwKU0yHWCrg5RHTMh5eT+AKRPsPr5YyIbT1FM7glBYR0
 2/Y4rOtyzpNPFYIakDVnM6eXBokPnDbVefByWyfM8oFnwp6S1o4+DLgBzl31MdxJNYKg
 zYFQ==
X-Gm-Message-State: AOAM531U9oZHHK+M3GDU6J1avbZLBICNhLi0wIl7oTnzqmW751yQ419K
 cvulgv/or7ztKQyX2PklQozZpWDivjA=
X-Google-Smtp-Source: ABdhPJxIPcqOmgBkAM7WKypDVOoyeCNQL7N7zS0MvWRL6vFswLFjArPKn9ogqAk6zaR6H5LJiIsK1Q==
X-Received: by 2002:a63:4a4c:: with SMTP id j12mr2319996pgl.115.1597179671876; 
 Tue, 11 Aug 2020 14:01:11 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:b58b:5460:6ed2:8ff9])
 by smtp.gmail.com with ESMTPSA id o17sm59370pgn.73.2020.08.11.14.01.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2020 14:01:10 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Omar Sandoval <osandov@osandov.com>
Subject: [PATCH v3 3/7] nvme: make tests transport type agnostic
Date: Tue, 11 Aug 2020 14:00:58 -0700
Message-Id: <20200811210102.194287-4-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200811210102.194287-1-sagi@grimberg.me>
References: <20200811210102.194287-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200811_170113_988714_FBFBDDC8 
X-CRM114-Status: GOOD (  13.61  )
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
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Bart Van Assche <bvanassche@acm.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Pass in nvme_trtype to common routines that can
support multiple transport types.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 tests/nvme/002 |  4 ++--
 tests/nvme/003 |  4 ++--
 tests/nvme/004 |  6 +++---
 tests/nvme/005 |  6 +++---
 tests/nvme/006 |  2 +-
 tests/nvme/007 |  2 +-
 tests/nvme/008 |  6 +++---
 tests/nvme/009 |  6 +++---
 tests/nvme/010 |  6 +++---
 tests/nvme/011 |  6 +++---
 tests/nvme/012 |  6 +++---
 tests/nvme/013 |  6 +++---
 tests/nvme/014 |  6 +++---
 tests/nvme/015 |  6 +++---
 tests/nvme/016 |  2 +-
 tests/nvme/017 |  2 +-
 tests/nvme/018 |  6 +++---
 tests/nvme/019 |  6 +++---
 tests/nvme/020 |  6 +++---
 tests/nvme/021 |  6 +++---
 tests/nvme/022 |  6 +++---
 tests/nvme/023 |  6 +++---
 tests/nvme/024 |  6 +++---
 tests/nvme/025 |  6 +++---
 tests/nvme/026 |  6 +++---
 tests/nvme/027 |  6 +++---
 tests/nvme/028 |  8 ++++----
 tests/nvme/029 |  6 +++---
 tests/nvme/030 |  2 +-
 tests/nvme/031 |  4 ++--
 tests/nvme/rc  | 39 ++++++++++++++++++++++++++++++++-------
 31 files changed, 110 insertions(+), 85 deletions(-)

diff --git a/tests/nvme/002 b/tests/nvme/002
index 999e222705bf..8540623497c7 100755
--- a/tests/nvme/002
+++ b/tests/nvme/002
@@ -21,7 +21,7 @@ test() {
 
 	local iterations=1000
 	local port
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port ${nvme_trtype})"
 
 	local loop_dev
 	loop_dev="$(losetup -f)"
@@ -31,7 +31,7 @@ test() {
 		_add_nvmet_subsys_to_port "${port}" "blktests-subsystem-$i"
 	done
 
-	_nvme_discover "loop" | _filter_discovery
+	_nvme_discover "${nvme_trtype}" | _filter_discovery
 
 	for ((i = iterations - 1; i >= 0; i--)); do
 		_remove_nvmet_subsystem_from_port "${port}" "blktests-subsystem-$i"
diff --git a/tests/nvme/003 b/tests/nvme/003
index 6ea6a23b7942..68f823011d7d 100755
--- a/tests/nvme/003
+++ b/tests/nvme/003
@@ -21,7 +21,7 @@ test() {
 	_setup_nvmet
 
 	local port
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port "${nvme_trtype}")"
 
 	local loop_dev
 	loop_dev="$(losetup -f)"
@@ -29,7 +29,7 @@ test() {
 	_create_nvmet_subsystem "blktests-subsystem-1" "${loop_dev}"
 	_add_nvmet_subsys_to_port "${port}" "blktests-subsystem-1"
 
-	_nvme_connect_subsys "loop" "nqn.2014-08.org.nvmexpress.discovery"
+	_nvme_connect_subsys "${nvme_trtype}" "nqn.2014-08.org.nvmexpress.discovery"
 
 	# This is ugly but checking for the absence of error messages is ...
 	sleep 10
diff --git a/tests/nvme/004 b/tests/nvme/004
index 7ea539fda55e..af434674beaa 100755
--- a/tests/nvme/004
+++ b/tests/nvme/004
@@ -22,7 +22,7 @@ test() {
 	_setup_nvmet
 
 	local port
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port ${nvme_trtype})"
 
 	truncate -s 1G "$TMPDIR/img"
 
@@ -33,10 +33,10 @@ test() {
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
 	_add_nvmet_subsys_to_port "${port}" "blktests-subsystem-1"
 
-	_nvme_connect_subsys "loop" "blktests-subsystem-1"
+	_nvme_connect_subsys ${nvme_trtype} "blktests-subsystem-1"
 
 	local nvmedev
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/005 b/tests/nvme/005
index d4ce6d703c1b..ff0975ce7c28 100755
--- a/tests/nvme/005
+++ b/tests/nvme/005
@@ -22,7 +22,7 @@ test() {
 	_setup_nvmet
 
 	local port
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port ${nvme_trtype})"
 
 	truncate -s 1G "$TMPDIR/img"
 
@@ -33,10 +33,10 @@ test() {
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
 	_add_nvmet_subsys_to_port "${port}" "blktests-subsystem-1"
 
-	_nvme_connect_subsys "loop" "blktests-subsystem-1"
+	_nvme_connect_subsys ${nvme_trtype} "blktests-subsystem-1"
 
 	local nvmedev
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 
 	udevadm settle
 
diff --git a/tests/nvme/006 b/tests/nvme/006
index 3f47613d52d2..3f161d08bc22 100755
--- a/tests/nvme/006
+++ b/tests/nvme/006
@@ -29,7 +29,7 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${loop_dev}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port ${nvme_trtype})"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
diff --git a/tests/nvme/007 b/tests/nvme/007
index 0902745a4ab2..b0e61186e886 100755
--- a/tests/nvme/007
+++ b/tests/nvme/007
@@ -28,7 +28,7 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port ${nvme_trtype})"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
diff --git a/tests/nvme/008 b/tests/nvme/008
index 5ab5c49b2039..7ffac945a58a 100755
--- a/tests/nvme/008
+++ b/tests/nvme/008
@@ -31,12 +31,12 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${loop_dev}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port ${nvme_trtype})"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys "loop" "${subsys_name}"
+	_nvme_connect_subsys ${nvme_trtype} "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/009 b/tests/nvme/009
index f6b999dea541..9ac5cb479983 100755
--- a/tests/nvme/009
+++ b/tests/nvme/009
@@ -27,12 +27,12 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port ${nvme_trtype})"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys "loop" "${subsys_name}"
+	_nvme_connect_subsys ${nvme_trtype} "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/010 b/tests/nvme/010
index 6caa2d0f813d..d90ca9d88053 100755
--- a/tests/nvme/010
+++ b/tests/nvme/010
@@ -31,12 +31,12 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${loop_dev}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port ${nvme_trtype})"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys "loop" "${subsys_name}"
+	_nvme_connect_subsys ${nvme_trtype} "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/011 b/tests/nvme/011
index 7a5535982a74..d8badbc00846 100755
--- a/tests/nvme/011
+++ b/tests/nvme/011
@@ -29,12 +29,12 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port ${nvme_trtype})"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys "loop" "${subsys_name}"
+	_nvme_connect_subsys ${nvme_trtype} "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/012 b/tests/nvme/012
index 5c3477a16af9..93b6cfaf4c77 100755
--- a/tests/nvme/012
+++ b/tests/nvme/012
@@ -35,12 +35,12 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${loop_dev}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port ${nvme_trtype})"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys "loop" "${subsys_name}"
+	_nvme_connect_subsys ${nvme_trtype} "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/013 b/tests/nvme/013
index 49784a0d46b5..3bae2f5edb3d 100755
--- a/tests/nvme/013
+++ b/tests/nvme/013
@@ -32,12 +32,12 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port ${nvme_trtype})"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys "loop" "${subsys_name}"
+	_nvme_connect_subsys ${nvme_trtype} "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/014 b/tests/nvme/014
index a33ff439fb3d..b61e7182af66 100755
--- a/tests/nvme/014
+++ b/tests/nvme/014
@@ -31,12 +31,12 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${loop_dev}" \
 		 "91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port ${nvme_trtype})"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys "loop" "${subsys_name}"
+	_nvme_connect_subsys ${nvme_trtype} "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/015 b/tests/nvme/015
index cb9792e13442..05195e3bc598 100755
--- a/tests/nvme/015
+++ b/tests/nvme/015
@@ -28,12 +28,12 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
 		 "91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port ${nvme_trtype})"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys "loop" "${subsys_name}"
+	_nvme_connect_subsys ${nvme_trtype} "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/016 b/tests/nvme/016
index 1ad744abb9b0..a5ad973dc246 100755
--- a/tests/nvme/016
+++ b/tests/nvme/016
@@ -30,7 +30,7 @@ test() {
 		_create_nvmet_ns "${subsys_nqn}" "${i}" "${loop_dev}"
 	done
 
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port ${nvme_trtype})"
 	_add_nvmet_subsys_to_port "$port" "${subsys_nqn}"
 
 	_nvme_discover "loop" | _filter_discovery
diff --git a/tests/nvme/017 b/tests/nvme/017
index 2507bcd606b7..67d7ffc72e93 100755
--- a/tests/nvme/017
+++ b/tests/nvme/017
@@ -33,7 +33,7 @@ test() {
 		_create_nvmet_ns "${subsys_name}" "${i}" "${file_path}"
 	done
 
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port ${nvme_trtype})"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
 	_nvme_discover "loop" | _filter_discovery
diff --git a/tests/nvme/018 b/tests/nvme/018
index 4863274cc525..43340d3c4d25 100755
--- a/tests/nvme/018
+++ b/tests/nvme/018
@@ -29,12 +29,12 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
 		 "91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port ${nvme_trtype})"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys "loop" "${subsys_name}"
+	_nvme_connect_subsys ${nvme_trtype} "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/019 b/tests/nvme/019
index 19c5b4755387..98d82ae21b42 100755
--- a/tests/nvme/019
+++ b/tests/nvme/019
@@ -33,12 +33,12 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${loop_dev}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port ${nvme_trtype})"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys "loop" "${subsys_name}"
+	_nvme_connect_subsys ${nvme_trtype} "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/020 b/tests/nvme/020
index 0a817004225a..2d4c0152bc55 100755
--- a/tests/nvme/020
+++ b/tests/nvme/020
@@ -29,12 +29,12 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port ${nvme_trtype})"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys "loop" "${subsys_name}"
+	_nvme_connect_subsys ${nvme_trtype} "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/021 b/tests/nvme/021
index ac3cbd17cd03..03b2ab749052 100755
--- a/tests/nvme/021
+++ b/tests/nvme/021
@@ -28,12 +28,12 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port ${nvme_trtype})"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys "loop" "${subsys_name}"
+	_nvme_connect_subsys ${nvme_trtype} "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/022 b/tests/nvme/022
index 4c91f98734fc..977b844ee117 100755
--- a/tests/nvme/022
+++ b/tests/nvme/022
@@ -28,12 +28,12 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port ${nvme_trtype})"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys "loop" "${subsys_name}"
+	_nvme_connect_subsys ${nvme_trtype} "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/023 b/tests/nvme/023
index dcbe821f2709..6c3b44174884 100755
--- a/tests/nvme/023
+++ b/tests/nvme/023
@@ -31,12 +31,12 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${loop_dev}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port ${nvme_trtype})"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys "loop" "${subsys_name}"
+	_nvme_connect_subsys ${nvme_trtype} "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/024 b/tests/nvme/024
index 0f4bddcb3142..9b5f6a44a916 100755
--- a/tests/nvme/024
+++ b/tests/nvme/024
@@ -28,12 +28,12 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port ${nvme_trtype})"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys "loop" "${subsys_name}"
+	_nvme_connect_subsys ${nvme_trtype} "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/025 b/tests/nvme/025
index 90896d327cff..9f0e9f722a02 100755
--- a/tests/nvme/025
+++ b/tests/nvme/025
@@ -28,12 +28,12 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port ${nvme_trtype})"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys "loop" "${subsys_name}"
+	_nvme_connect_subsys ${nvme_trtype} "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/026 b/tests/nvme/026
index 39cfe12a23c7..e60e73b2c26a 100755
--- a/tests/nvme/026
+++ b/tests/nvme/026
@@ -28,12 +28,12 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port ${nvme_trtype})"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys "loop" "${subsys_name}"
+	_nvme_connect_subsys ${nvme_trtype} "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/027 b/tests/nvme/027
index 5915c336a0cd..805a3c63eba2 100755
--- a/tests/nvme/027
+++ b/tests/nvme/027
@@ -28,12 +28,12 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port ${nvme_trtype})"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys "loop" "${subsys_name}"
+	_nvme_connect_subsys ${nvme_trtype} "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/028 b/tests/nvme/028
index cf44102b3957..c9bd3dde7f20 100755
--- a/tests/nvme/028
+++ b/tests/nvme/028
@@ -28,16 +28,16 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port ${nvme_trtype})"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys "loop" "${subsys_name}"
+	_nvme_connect_subsys ${nvme_trtype} "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
-	if ! nvme list-subsys 2>> "$FULL" | grep -q loop; then
+	if ! nvme list-subsys 2>> "$FULL" | grep -q ${nvme_trtype}; then
 		echo "ERROR: list-subsys"
 	fi
 	_nvme_disconnect_subsys "${subsys_name}" >> "$FULL" 2>&1
diff --git a/tests/nvme/029 b/tests/nvme/029
index 192b5c52168c..7bf904b16edc 100755
--- a/tests/nvme/029
+++ b/tests/nvme/029
@@ -64,12 +64,12 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${loop_dev}" \
 		 "91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port ${nvme_trtype})"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys "loop" "${subsys_name}"
+	_nvme_connect_subsys ${nvme_trtype} "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/030 b/tests/nvme/030
index 7156cad7b657..220b29f42962 100755
--- a/tests/nvme/030
+++ b/tests/nvme/030
@@ -37,7 +37,7 @@ test() {
 
     _setup_nvmet
 
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port ${nvme_trtype})"
 
 	_create_nvmet_subsystem "${subsys}1" "$(losetup -f)"
 	_add_nvmet_subsys_to_port "${port}" "${subsys}1"
diff --git a/tests/nvme/031 b/tests/nvme/031
index ab17633bc8fc..001f9d2b0b3a 100755
--- a/tests/nvme/031
+++ b/tests/nvme/031
@@ -36,12 +36,12 @@ test() {
 
 	loop_dev="$(losetup -f --show "$TMPDIR/img")"
 
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port ${nvme_trtype})"
 
 	for ((i = 0; i < iterations; i++)); do
 		_create_nvmet_subsystem "${subsys}$i" "${loop_dev}"
 		_add_nvmet_subsys_to_port "${port}" "${subsys}$i"
-		_nvme_connect_subsys "loop" "${subsys}$i"
+		_nvme_connect_subsys ${nvme_trtype} "${subsys}$i"
 		_nvme_disconnect_subsys "${subsys}$i" >> "${FULL}" 2>&1
 		_remove_nvmet_subsystem_from_port "${port}" "${subsys}$i"
 		_remove_nvmet_subsystem "${subsys}$i"
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 6d57cf591300..191f0497416a 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -6,6 +6,9 @@
 
 . common/rc
 
+def_traddr="127.0.0.1"
+def_adrfam="ipv4"
+def_trsvcid="4420"
 nvme_trtype=${nvme_trtype:-"loop"}
 
 _nvme_requires() {
@@ -62,8 +65,8 @@ _cleanup_nvmet() {
 	for dev in /sys/class/nvme/nvme*; do
 		dev="$(basename "$dev")"
 		transport="$(cat "/sys/class/nvme/${dev}/transport")"
-		if [[ "$transport" == "loop" ]]; then
-			echo "WARNING: Test did not clean up loop device: ${dev}"
+		if [[ "$transport" == "${nvme_trtype}" ]]; then
+			echo "WARNING: Test did not clean up ${nvme_trtype} device: ${dev}"
 			_nvme_disconnect_ctrl "${dev}"
 		fi
 	done
@@ -87,14 +90,20 @@ _cleanup_nvmet() {
 	shopt -u nullglob
 	trap SIGINT
 
-	modprobe -r nvme-loop 2>/dev/null
+	modprobe -r nvme-${nvme_trtype} 2>/dev/null
+	if [[ "${nvme_trtype}" != "loop" ]]; then
+		modprobe -r nvmet-${nvme_trtype} 2>/dev/null
+	fi
 	modprobe -r nvmet 2>/dev/null
 }
 
 _setup_nvmet() {
 	_register_test_cleanup _cleanup_nvmet
 	modprobe nvmet
-	modprobe nvme-loop
+	if [[ "${nvme_trtype}" != "loop" ]]; then
+		modprobe nvmet-${nvme_trtype}
+	fi
+	modprobe nvme-${nvme_trtype}
 }
 
 _nvme_disconnect_ctrl() {
@@ -112,20 +121,33 @@ _nvme_disconnect_subsys() {
 _nvme_connect_subsys() {
 	local trtype="$1"
 	local subsysnqn="$2"
+	local traddr="${3:-$def_traddr}"
+	local trsvcid="${4:-$def_trsvcid}"
 
 	cmd="nvme connect -t ${trtype} -n ${subsysnqn}"
+	if [[ "${trtype}" != "loop" ]]; then
+		cmd=$cmd" -a ${traddr} -s ${trsvcid}"
+	fi
 	eval $cmd
 }
 
 _nvme_discover() {
 	local trtype="$1"
+	local traddr="${2:-$def_traddr}"
+	local trsvcid="${3:-$def_trsvcid}"
 
 	cmd="nvme discover -t ${trtype}"
+	if [[ "${trtype}" != "loop" ]]; then
+		cmd=$cmd" -a ${traddr} -s ${trsvcid}"
+	fi
 	eval $cmd
 }
 
 _create_nvmet_port() {
 	local trtype="$1"
+	local traddr="${2:-$def_traddr}"
+	local adrfam="${3:-$def_adrfam}"
+	local trsvcid="${4:-$def_trsvcid}"
 
 	local port
 	for ((port = 0; ; port++)); do
@@ -136,6 +158,9 @@ _create_nvmet_port() {
 
 	mkdir "${NVMET_CFS}/ports/${port}"
 	echo "${trtype}" > "${NVMET_CFS}/ports/${port}/addr_trtype"
+	echo "${traddr}" > "${NVMET_CFS}/ports/${port}/addr_traddr"
+	echo "${adrfam}" > "${NVMET_CFS}/ports/${port}/addr_adrfam"
+	echo "${trsvcid}" > "${NVMET_CFS}/ports/${port}/addr_trsvcid"
 
 	echo "${port}"
 }
@@ -207,13 +232,13 @@ _remove_nvmet_subsystem_from_port() {
 	rm "${NVMET_CFS}/ports/${port}/subsystems/${nvmet_subsystem}"
 }
 
-_find_nvme_loop_dev() {
+_find_nvme_dev() {
 	local dev
 	local transport
 	for dev in /sys/class/nvme/nvme*; do
 		dev="$(basename "$dev")"
 		transport="$(cat "/sys/class/nvme/${dev}/transport")"
-		if [[ "$transport" == "loop" ]]; then
+		if [[ "$transport" == "${nvme_trtype}" ]]; then
 			echo "$dev"
 			for ((i = 0; i < 10; i++)); do
 				if [[ -e /sys/block/$dev/uuid &&
@@ -233,6 +258,6 @@ _filter_discovery() {
 }
 
 _discovery_genctr() {
-	_nvme_discover "loop" |
+	_nvme_discover "${nvme_trtype}" |
 		sed -n -e 's/^.*Generation counter \([0-9]\+\).*$/\1/p'
 }
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
