Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F3A2C4345F
	for <linux-nvme@archiver.kernel.org>; Sat,  4 May 2024 08:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5jiKujhll46p6L0WMgGnkJQBx8sJE07sMXCU8gMvk+w=; b=db5VjWHN9zy33ZtRDf0tQS5WxD
	co5s61dheSq42Yr+nPe7fm9KKZbEkZwgxwbSUkbJ9d04TGAanEPMK/Xn9jcG3FEWQucMGcBkYof+r
	/FFMTiKpWftKhgdRXHZrkP/pMwovw2ZNnPWb+d2kf3oVLWAaVIBXM4Ora2tmkphXSFDGYkByy0xCI
	DFWSoC/Ezw1Acwh6zLSFhzb4adGjdb98wi2jMOyruAq/UOIwekDFx0eBBuaPZ8P1GcdDj75D5w76J
	KTGGkYY4nngUauxw/HMbWOsz4gYrpR3zSQyLvj9+l8QzLK95seFFpi/KdRbH+M/VsKKpNr4c0efmF
	448HZIyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3AZ2-00000001ZrJ-2QRo;
	Sat, 04 May 2024 08:16:12 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3AY1-00000001Yy7-2Xoq
	for linux-nvme@lists.infradead.org;
	Sat, 04 May 2024 08:15:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1714810509; x=1746346509;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EBxB2u8I9uSgVGqcMH+SW7wn7JCDKLBEg8W9tT3Kgug=;
  b=S/m6xBZQVbz9DHOOhgl9yUIMUaShje1+9/wZWrUzWUh8Wt5F4Fnd86LR
   BXhIo0UYeQoq5x7U4TzgAAIRyZxubSTmnARyZB3hERWBMANB02eY89/ev
   PV3iqk668Uojs1cgxWH0oRzJnO1Ci2MXq8KD6jJ6aU+IqyZYmX+dgCL3S
   o5J4mAoVSDIvH/0JrTWiQyf93Xk5aXWNN/OjI0aSmkDkGgdBOP0zujiD8
   hdIndX3DG7j38ieYmIcphpxUbGoHTikFD1PWwAlsFeccJHZVzctNPxoGy
   vpB/qGbX0l+rXMoFwkm2xP7j/nSOH/xbUW+akmT+5xMVoCO7wh0VilM2b
   w==;
X-CSE-ConnectionGUID: XsCiqAztQrCSxBaCnPdykQ==
X-CSE-MsgGUID: CLoVa9dhRDiF0bVR2BZlQQ==
X-IronPort-AV: E=Sophos;i="6.07,253,1708358400"; 
   d="scan'208";a="15540345"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 May 2024 16:15:08 +0800
IronPort-SDR: AUHDYqSvPy3InD+PjcF6mwucV1DMVJa/GpuUJdFq4KDExfvFIcE9hUWU7hW9XPK3/J2Imdb2oB
 8RNOES3vLqFGph2Jesn0h9QbV5SwPDJZbWMW3KWGsanlAPHmiR4IQxcqgYqkUUUBSReHjCAQ5l
 PF1Km6e2LpgbRu2rDaSbtLr6WKymwcWRBbUAWhmzhdASzQq4+7RXBRp6k8QRC41kOdZyke8e/j
 qV9lyLs8iJt86qq2jzjV2i9Tvxy670e1LUfbTL/Z/v4oFSN3BDTE/J2NS4xFDJEbxR7Fl94bsG
 Eek=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 May 2024 00:23:06 -0700
IronPort-SDR: ec7prmIlsYq5kcBekGgHVjgX3G/c/dEQ6xla3xleylc3RoKVfsmWDvEmc5tAZIbhV5/BoznX1z
 MExqYkSQxWioOiwXMGbdJiW5LGDthWF5EIc4Q9rfoGK+yaiJ50axtR3oodrueCsxqZDzLeeSvn
 pyTA4R8PacM/ncvSgfqOpL+bGMhgxFsE1CWyk1A3u1bGKJarvgL7IZkZ3Ekry9vJ5q+C7Vazc1
 JTZarzQmuXfKdic9ANImy1mttMot55OFCt3xR9OAFFmz/eadRJzwlkBOuIYbWyW/JEu4h8w0p9
 /u4=
WDCIronportException: Internal
Received: from unknown (HELO shinhome.flets-east.jp) ([10.225.163.38])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 May 2024 01:15:07 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v4 15/17] nvme/{rc,010,017,031,034,035}: rename nvme_img_size to NVME_IMG_SIZE
Date: Sat,  4 May 2024 17:14:46 +0900
Message-ID: <20240504081448.1107562-16-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240504081448.1107562-1-shinichiro.kawasaki@wdc.com>
References: <20240504081448.1107562-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240504_011509_873634_C66BD821 
X-CRM114-Status: GOOD (  14.88  )
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

To follow uppercase letter guide of environment variables, rename
nvme_img_size to NVME_IMG_SIZE.

Reviewed-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 Documentation/running-tests.md | 7 ++++---
 tests/nvme/010                 | 2 +-
 tests/nvme/017                 | 2 +-
 tests/nvme/031                 | 2 +-
 tests/nvme/034                 | 2 +-
 tests/nvme/035                 | 4 ++--
 tests/nvme/rc                  | 8 ++++----
 7 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/Documentation/running-tests.md b/Documentation/running-tests.md
index 64aff7c..736ab48 100644
--- a/Documentation/running-tests.md
+++ b/Documentation/running-tests.md
@@ -113,9 +113,10 @@ The NVMe tests can be additionally parameterized via environment variables.
   block device types can be listed with separating spaces. In this case, the
   tests are repeated to cover all of the block device types specified. Default
   value is "device file".
-- nvme_img_size: '1G' (default)
-  Run the tests with given image size in bytes. 'm', 'M', 'g'
-	and 'G' postfix are supported.
+- NVME_IMG_SIZE: '1G' (default)
+  Run the tests with given image size in bytes. 'm', 'M', 'g' and 'G' postfix
+  are supported. This parameter had an old name 'nvme_img_size'. The old name
+  is still usable, but not recommended.
 - nvme_num_iter: 1000 (default)
   The number of iterations a test should do.
 
diff --git a/tests/nvme/010 b/tests/nvme/010
index 524203d..a5ddf58 100755
--- a/tests/nvme/010
+++ b/tests/nvme/010
@@ -32,7 +32,7 @@ test() {
 
 	ns=$(_find_nvme_ns "${def_subsys_uuid}")
 
-	_run_fio_verify_io --size="${nvme_img_size}" \
+	_run_fio_verify_io --size="${NVME_IMG_SIZE}" \
 		--filename="/dev/${ns}"
 
 	_nvme_disconnect_subsys
diff --git a/tests/nvme/017 b/tests/nvme/017
index 9410cdc..4f14471 100755
--- a/tests/nvme/017
+++ b/tests/nvme/017
@@ -25,7 +25,7 @@ test() {
 	local port
 	local iterations="${nvme_num_iter}"
 
-	truncate -s "${nvme_img_size}" "$(_nvme_def_file_path)"
+	truncate -s "${NVME_IMG_SIZE}" "$(_nvme_def_file_path)"
 
 	local genctr=1
 
diff --git a/tests/nvme/031 b/tests/nvme/031
index b98630a..00d3d18 100755
--- a/tests/nvme/031
+++ b/tests/nvme/031
@@ -37,7 +37,7 @@ test() {
 	local loop_dev
 	local port
 
-	truncate -s "${nvme_img_size}" "$(_nvme_def_file_path)"
+	truncate -s "${NVME_IMG_SIZE}" "$(_nvme_def_file_path)"
 
 	loop_dev="$(losetup -f --show "$(_nvme_def_file_path)")"
 
diff --git a/tests/nvme/034 b/tests/nvme/034
index 522ffe3..239757c 100755
--- a/tests/nvme/034
+++ b/tests/nvme/034
@@ -29,7 +29,7 @@ test_device() {
 	_nvmet_passthru_target_setup
 	nsdev=$(_nvmet_passthru_target_connect)
 
-	_run_fio_verify_io --size="${nvme_img_size}" --filename="${nsdev}"
+	_run_fio_verify_io --size="${NVME_IMG_SIZE}" --filename="${nsdev}"
 
 	_nvme_disconnect_subsys
 	_nvmet_passthru_target_cleanup
diff --git a/tests/nvme/035 b/tests/nvme/035
index cfca5fd..8286178 100755
--- a/tests/nvme/035
+++ b/tests/nvme/035
@@ -17,7 +17,7 @@ requires() {
 }
 
 device_requires() {
-	_require_test_dev_size "${nvme_img_size}"
+	_require_test_dev_size "${NVME_IMG_SIZE}"
 }
 
 set_conditions() {
@@ -35,7 +35,7 @@ test_device() {
 	_nvmet_passthru_target_setup
 	nsdev=$(_nvmet_passthru_target_connect)
 
-	if ! _xfs_run_fio_verify_io "${nsdev}" "${nvme_img_size}"; then
+	if ! _xfs_run_fio_verify_io "${nsdev}" "${NVME_IMG_SIZE}"; then
 		echo "FAIL: fio verify failed"
 	fi
 
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 27d35e9..ef7b966 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -19,7 +19,7 @@ def_hostnqn="nqn.2014-08.org.nvmexpress:uuid:${def_hostid}"
 export def_subsysnqn="blktests-subsystem-1"
 export def_subsys_uuid="91fdba0d-f87b-4c25-b80f-db7be1418b9e"
 _check_conflict_and_set_default NVMET_TRTYPES nvme_trtype "loop"
-nvme_img_size=${nvme_img_size:-"1G"}
+_check_conflict_and_set_default NVME_IMG_SIZE nvme_img_size 1G
 nvme_num_iter=${nvme_num_iter:-"1000"}
 nvmet_blkdev_type=${nvmet_blkdev_type:-"device"}
 NVMET_BLKDEV_TYPES=${NVMET_BLKDEV_TYPES:-"device file"}
@@ -159,10 +159,10 @@ _require_nvme_test_img_size() {
 	local nvme_img_size_mb
 
 	require_sz_mb="$(convert_to_mb "$1")"
-	nvme_img_size_mb="$(convert_to_mb "${nvme_img_size}")"
+	nvme_img_size_mb="$(convert_to_mb "${NVME_IMG_SIZE}")"
 
 	if ((nvme_img_size_mb < require_sz_mb)); then
-		SKIP_REASONS+=("nvme_img_size must be at least ${require_sz_mb}m")
+		SKIP_REASONS+=("NVME_IMG_SIZE must be at least ${require_sz_mb}m")
 		return 1
 	fi
 	return 0
@@ -909,7 +909,7 @@ _nvmet_target_setup() {
 		esac
 	done
 
-	truncate -s "${nvme_img_size}" "$(_nvme_def_file_path)"
+	truncate -s "${NVME_IMG_SIZE}" "$(_nvme_def_file_path)"
 	if [[ "${blkdev_type}" == "device" ]]; then
 		blkdev="$(losetup -f --show "$(_nvme_def_file_path)")"
 	else
-- 
2.44.0


