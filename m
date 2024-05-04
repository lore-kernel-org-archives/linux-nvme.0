Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B284C4345F
	for <linux-nvme@archiver.kernel.org>; Sat,  4 May 2024 08:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q3TVFEUqUeglHuJcEMYvs882pASm+AO69NYW+42KqNg=; b=JXIbpCCjCLhSCQuP4d3lgPt3BX
	itkkjgUB5PU3FwInIaC75jeemwRx07O4XvUK6flZ0ZCXYkSXTk5EsUXbF4zmlZE/zM8VNr1+KTF7u
	lgsKpy94rKHX7g8iT7L0+hBuzrT/YEcsR7qDCd8Z0fVrFwRg1GXK0CsiDYeTPHOGIYtiOVK3IYMPo
	o81IcmyrnqF9YHVsYHBL3slepZcv5a5drdzBRdEBrbFJ+rRpl0LqscctSf5OmIR0XWTVDKXbcp7/E
	jmH6ouIp177FHtrI19URl8mz3M3hkgV8VcAaD76ywhh+c1nwZHlLAs5StBfUgQpaAZrxDVdxYCHaE
	niPcgV1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3AYW-00000001ZR1-1jrs;
	Sat, 04 May 2024 08:15:40 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3AXx-00000001YnF-1eRq
	for linux-nvme@lists.infradead.org;
	Sat, 04 May 2024 08:15:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1714810505; x=1746346505;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BFfaOX5p2iOl7nNSAnVbtqrbQDtOYPAQ2VME6QGOMfk=;
  b=Pk74viunu7SQtE2ypOmyfSpmorZ2Udz/fr+tcvsFs8wjmFPqZby41Vcn
   SmQUdxT3URqSLQ7pntDPZS+uq3L7uV1AeQeHAmfvO8RCAvKT4deNDd/VI
   s3WTjJ6WaCo52Gdu9LuJWX7/FNvWCif/e0c3mpa/Zi9fk2nlvodnR6emR
   2/U1TNBXvXaZQQDHdi2nBoegg77PO6q5qSU7wThGNtq6AjzWcwv2OYStN
   FHnRNRJNv3ehijLFD3qFd64uEk9dwKyMzSXaFAZakIhmQcEb+NFCCdfI3
   VOkyMVt81rYrEp1VpfWwk8iBx4FIoU+U9fUB7sLchgX2P3OkAfuruDSDN
   g==;
X-CSE-ConnectionGUID: qyAWMb6RSPmV8EjW76jRzQ==
X-CSE-MsgGUID: l1XjITNsQ6GCKEZtTv7fPA==
X-IronPort-AV: E=Sophos;i="6.07,253,1708358400"; 
   d="scan'208";a="15540330"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 May 2024 16:15:04 +0800
IronPort-SDR: zt/XOiIUYfno5ZMkM7I1EHsD7C9NyXMbcV9cpg9oePSIsxWnAii3eeRPiZ57FIEzyWiMDtaQZN
 +doqjlPy58Fz/bK5E0teuLkdChR+Eg/7TN74p47wqOuVRcT6hIgjT68QCfFOe4FWX3Fa2uoL4k
 DCx64LEnbGgrrKA/iSwsBqZyu3hDjsy08kWQCd7DVsJ/5NG7f2G8pasGdZapbay1HJqdUR2mIp
 Rt8W1TqZPe+hbMNiP/OYjEBnkC6VPvtixhu0H4VszuZS9QjUrVLze/Ubqp3zAJerpp6EQ531Dm
 G+s=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 May 2024 00:23:02 -0700
IronPort-SDR: SystkBEVl0eprf0RMbP5jdCF2A0SuSsHlQSZlZUlGyfT7qUPEwXMOxzF9ZZr2a6u+hB6k4YHt6
 BBvdtXp+84Wuzi4dg7IQ6QR8QiRqk/s3OjU5VIfbfozbMRFd3LlX1Qc9q1BQtVmJwwOMUXTZlD
 +Lv4ePv2Mj8Oc+NCH+T6xhtmnU5mhExcZMmLqTu7ARzKzPSXE8fwSmPetQQHUCaL6raV17XFBY
 NcZSK31Id8Wqo7KfOXXDJ+KuQcBQc3oowNBNKCREM8iXlQ872EXmSNJ7H4E1dAPRmpS9P+RqCE
 B+w=
WDCIronportException: Internal
Received: from unknown (HELO shinhome.flets-east.jp) ([10.225.163.38])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 May 2024 01:15:04 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v4 12/17] nvme/{006,008,010,012,014,019,023}: support NVMET_BLKDEV_TYPES
Date: Sat,  4 May 2024 17:14:43 +0900
Message-ID: <20240504081448.1107562-13-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240504081448.1107562-1-shinichiro.kawasaki@wdc.com>
References: <20240504081448.1107562-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240504_011505_546428_97AC2F25 
X-CRM114-Status: GOOD (  13.44  )
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

Enable repeated test runs for the listed test cases for
NVMET_BLKDEV_TYPES. The default values of NVMET_BLKDEV_TYPES is
"device file". With this default set up, each of the listed test cases
are run twice. The second runs of the test cases for 'file' blkdev type
do exact same test as other test cases nvme/007, 009, 011, 013, 015, 020
and 024.

The test cases already support the repetition for NVMET_TRTYPES. Modify
the set_conditions() hooks to call both NVMET_BLKDEV_TYPES and
NVMET_TRTYPES using _set_combined_conditions(). When NVMET_BLKDEV_TYPES
and NVMET_TRTYPES are set as follows, the test cases are repeated
2 x 3 = 6 times each.

      NVMET_BLKDEV_TYPES="device file"
      NVMET_TRTYPES="loop rdma tcp"

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/nvme/006 | 2 +-
 tests/nvme/008 | 2 +-
 tests/nvme/010 | 2 +-
 tests/nvme/012 | 2 +-
 tests/nvme/014 | 2 +-
 tests/nvme/019 | 2 +-
 tests/nvme/023 | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tests/nvme/006 b/tests/nvme/006
index ff0a9eb..3f9d209 100755
--- a/tests/nvme/006
+++ b/tests/nvme/006
@@ -16,7 +16,7 @@ requires() {
 }
 
 set_conditions() {
-	_set_nvme_trtype "$@"
+	_set_combined_conditions _set_nvme_trtype _set_nvmet_blkdev_type "$@"
 }
 
 test() {
diff --git a/tests/nvme/008 b/tests/nvme/008
index 1877d8a..247850c 100755
--- a/tests/nvme/008
+++ b/tests/nvme/008
@@ -16,7 +16,7 @@ requires() {
 }
 
 set_conditions() {
-	_set_nvme_trtype "$@"
+	_set_combined_conditions _set_nvme_trtype _set_nvmet_blkdev_type "$@"
 }
 
 test() {
diff --git a/tests/nvme/010 b/tests/nvme/010
index 34914a7..c16587f 100755
--- a/tests/nvme/010
+++ b/tests/nvme/010
@@ -16,7 +16,7 @@ requires() {
 }
 
 set_conditions() {
-	_set_nvme_trtype "$@"
+	_set_combined_conditions _set_nvme_trtype _set_nvmet_blkdev_type "$@"
 }
 
 test() {
diff --git a/tests/nvme/012 b/tests/nvme/012
index e06bf8d..e6674e2 100755
--- a/tests/nvme/012
+++ b/tests/nvme/012
@@ -20,7 +20,7 @@ requires() {
 }
 
 set_conditions() {
-	_set_nvme_trtype "$@"
+	_set_combined_conditions _set_nvme_trtype _set_nvmet_blkdev_type "$@"
 }
 
 test() {
diff --git a/tests/nvme/014 b/tests/nvme/014
index ff0ebfb..571c6f4 100755
--- a/tests/nvme/014
+++ b/tests/nvme/014
@@ -16,7 +16,7 @@ requires() {
 }
 
 set_conditions() {
-	_set_nvme_trtype "$@"
+	_set_combined_conditions _set_nvme_trtype _set_nvmet_blkdev_type "$@"
 }
 
 test() {
diff --git a/tests/nvme/019 b/tests/nvme/019
index 31020d9..501256c 100755
--- a/tests/nvme/019
+++ b/tests/nvme/019
@@ -16,7 +16,7 @@ requires() {
 }
 
 set_conditions() {
-	_set_nvme_trtype "$@"
+	_set_combined_conditions _set_nvme_trtype _set_nvmet_blkdev_type "$@"
 }
 
 test() {
diff --git a/tests/nvme/023 b/tests/nvme/023
index da99406..3c43c55 100755
--- a/tests/nvme/023
+++ b/tests/nvme/023
@@ -16,7 +16,7 @@ requires() {
 }
 
 set_conditions() {
-	_set_nvme_trtype "$@"
+	_set_combined_conditions _set_nvme_trtype _set_nvmet_blkdev_type "$@"
 }
 
 test() {
-- 
2.44.0


