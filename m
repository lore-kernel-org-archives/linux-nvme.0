Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D9E8C4345F
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Apr 2024 08:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6unWcEo/ZqNf5w6t5XESHfwGAMYKw89pg0SFsS3GR6A=; b=LeKeCWtRdDCMyvbXkwCmbMRq7z
	YAKXQ8Yn18Sktt2eE15PtuSJbwy56HY3pOh1peB+e6od56wjmExFUSCzMRngoF72euHoCAjNxCqkk
	rYYWqt25QKGgv9ldS+PoHBawjTceztb9QrKSBnsbUAbexrgbkgoMn1HJmuQcD9LREM7YXQvVxplaq
	q2i2TmLPMc03IU6mjKpYfs0tk5tRHEs6zwMjfTiS7UD6Q9heuo71zpAtzw9j00i46U6B5cWnET/eh
	Gc0YcmjNwDaQIERr+vJYFFR8t0/vvTqD8eX2fj0jYAxjUPOb2iyq177qBnm7zkFxfqfruD1i+t+zN
	pjOVeMWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzXZ7-00000003CoP-2HN3;
	Wed, 24 Apr 2024 08:01:17 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzXY4-00000003Bnw-105Z
	for linux-nvme@lists.infradead.org;
	Wed, 24 Apr 2024 08:00:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713945612; x=1745481612;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IIzLHZ0xDcoXvdTGBnbL9BdlXaLVUODqXivyreG6OI8=;
  b=mihci5OPeyyDJKt7WoKDOfcjHqb1FzLVBDGAm8nfKz9PrZ1Vtab+KsnJ
   Dp0RDF0vyKtZ3xJjAhxJ09CazgFLceiCscB5smBzIwwmmAsWTRamEqiVf
   4V7YcElSWi88m9QlNWUFQnrNK/uxM8TFFRTtZBCbtKESoDqB53fQ1x4X8
   c5AlHQ7t29cRgJKBd08xA3nFcz9VCYmo6PJsDoyaJrQJAt3bHL4qulM2e
   P083baD+JKSqHb2TpKVyYslA1q66Yv6JmTbqAMQAEpkFIVARQFVgprsNE
   NENAVNEl92dBvVx2SwhqTqs3IfoONOrIf/MpICgCv78jtorwlEsW8UF/a
   w==;
X-CSE-ConnectionGUID: AJWo7IqETFC8yAN1Nk5BsA==
X-CSE-MsgGUID: dCH2UnAMREKgW5pJxIncyQ==
X-IronPort-AV: E=Sophos;i="6.07,225,1708358400"; 
   d="scan'208";a="14738279"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Apr 2024 16:00:12 +0800
IronPort-SDR: OxC1W69uWLSXlh2Xgduu7G+SO6/QyDUPTZHi46LpuKk2sPhtfKVX0JNSpi8lb79tzxfjo+ZkJv
 XbnZI1+jzuoeETx8G/tB885z/8x7zUvIrOJPY4sbJrmNkvuQjQk2uL4wDMmz6Ye9F8XwTgWWY5
 KtmJnqQSOP+C5gV4Khs5FC6VyJ9SZEnFhFpHCV8PTBeignBF+noaeq+HEcVv1rzt8qxXwAa7vO
 wvsNVKqXHdarei7Y6Ri/G41oaQS91FYm3t2R2ewEwLvZw5oSwG8gqQtOnMcOWHrzIua6ikw3ET
 1YA=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Apr 2024 00:08:21 -0700
IronPort-SDR: drLCxtdu3hJwEHv0XteFNIZlY1I6rN2e2b597kyjjIysvolujINHLNprofLK3WAJldGVKsP0BY
 ggrlJZWswyoMZwJNaySMCUxCHqDJygx7st0JWIZfzeLzoF5I9mqX4D/f7f5B/qYOG846fGd/5h
 wmIyJkgvmxXuL6ox8gpKnZzhHLd30N88bhB2i6fsH5NDb9EljUAOz+lJdtu8EPH/Z6BC5DHCd+
 zPBK6l7xX6dfU+iDYBvwI4MQsR+lAGVv/QXeU1xIezc8jrIDtlJJuuAwajVnjru+ZYq7ukcp/M
 DAQ=
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Apr 2024 01:00:09 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagern@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH blktests v3 13/15] nvme/{rc,010,017,031,034,035}: rename nvme_img_size to NVME_IMG_SIZE
Date: Wed, 24 Apr 2024 16:59:53 +0900
Message-ID: <20240424075955.3604997-14-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240424075955.3604997-1-shinichiro.kawasaki@wdc.com>
References: <20240424075955.3604997-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240424_010013_004003_802987B6 
X-CRM114-Status: GOOD (  13.66  )
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
index 9ea2561..d99067a 100755
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
index a31690d..c018f7f 100644
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
@@ -165,10 +165,10 @@ _require_nvme_test_img_size() {
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
@@ -915,7 +915,7 @@ _nvmet_target_setup() {
 		esac
 	done
 
-	truncate -s "${nvme_img_size}" "$(_nvme_def_file_path)"
+	truncate -s "${NVME_IMG_SIZE}" "$(_nvme_def_file_path)"
 	if [[ "${blkdev_type}" == "device" ]]; then
 		blkdev="$(losetup -f --show "$(_nvme_def_file_path)")"
 	else
-- 
2.44.0


