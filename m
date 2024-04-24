Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78C0DC4345F
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Apr 2024 08:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BRux5xzWtj837XWCB6iZmyUFB+pDyjM27kvuwkEiOew=; b=XqF1kNoA70Q5WIf4YtAPnPaKr2
	quh9FZ9URxqSyWbtPhw6s/1CfiyNi9jWYW3ddFJBpIUAao7zGXg0lg3xnODeZgLG/HPFb+oYloyyr
	HL0sRkuuAYVS5lHejpsrzArJU9RwvBXJaJAj+1phC3Jg05VBqvsyXBLFs8HdNVwWvqFcHqfZvE+YL
	6Ave0mFLkXTqnPDeIRtrbYDiL6h/ZGXMVtFjzHEaCPrPCHoYW0QbW0MzURHpcLWeB3iCcELS/urOe
	dxs+bbJZ5BmsapbzBT3Yt5snzdEr+QBRF1Rkri2S1v8hcAtO49yRtZKYAzDXjWR4drymuGkCv2giD
	ydpUbeJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzXYa-00000003CNs-3Sg5;
	Wed, 24 Apr 2024 08:00:44 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzXXz-00000003Bnw-38BG
	for linux-nvme@lists.infradead.org;
	Wed, 24 Apr 2024 08:00:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713945607; x=1745481607;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e3O80rkK1CVAuLxzt039J7MwxeMHq2ELp8O6/iaSTkw=;
  b=CQ0k5O8zOkVXPhieDDRfZtm6M8I41yDA9Y6wOi0nZYTxRKwu1bzisGoo
   8b9AbXYP62xO1ON6VjZ8Z7P8+r12oiERdudKakV2QSjvIMfWqi31SfjFx
   4hS1YGSs8XT/3jziRjzWhHRoIWi7tyWSUulu6vF/WVr3TOwKF2SxgameQ
   tkW/vmpWwWHUwWlgESwrx9zBYeht7taL6rLI/ZJ+pDtSAZC+Lef0qpV/c
   7f0cdFpmLa/5i1/MUiM1Unp9C7hjzNrxB1J8ZNqoW3n9aA1lFKm05/I0s
   u2pT8lXj/oMRx/M6+h61caXNBWMxPQxZeqiS0MZ1Mea7XoIqitVD7M62u
   A==;
X-CSE-ConnectionGUID: wBxfhpD0StSCrkY7QcJjTA==
X-CSE-MsgGUID: gMHXssoHQf28Hj/9IyQWCg==
X-IronPort-AV: E=Sophos;i="6.07,225,1708358400"; 
   d="scan'208";a="14738274"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Apr 2024 16:00:07 +0800
IronPort-SDR: K/x8lzIUU6LnIeYZV2MLtfmzVHR20BwlA4BFv8vDP5v+uQcs041dOkMPMqlFuU02LghpdPos4W
 ZorNT7ln1Yjrc/6Jo9eNFyIr4lBUZE1OZqk7UJhE+214nmMpm30cG2rABXBbfiREtWVAeRK33p
 bc0E2bWp9XTks5zq+HUmYAicPIf0GUy/QFrGBNpmniQPyCJUThZ0ubEDE8BLkJeAJfd7rZrCGn
 /j0ebq5cjUe+LpiSY6+WrSURpnIsb+pPW1AjxhFLE8JPVge7BfxgBbNF9k6TbJqqrc6njcT8zc
 cOo=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Apr 2024 00:08:17 -0700
IronPort-SDR: n8nDbOR+7WshaDgN5fl6gZMoqhKTX8niSXw6hoGP1JzWJBPdcyY8d7JT1hf00uuEWQ6UryubBh
 snv3ADs/QkbXTmRfNkW/YiG9I2mq8BdB9KtpoNKWJz8jzLU1e1hnSJjz8zqqauF7RLSqXfgk5J
 SlzlaW2zNzzNQg5lXcvu5WqQ8BTIVMDoYKRZ3nyO8BT4HIuDz93hFhcAD65dQqA5vmHud3xjSQ
 1NpZ5aI1VflViAqDVBm/fc6Ptq0LJcx/XizUPS8XJsW5R/Qthg7XExjYPJKeugE5WiO25yXXXW
 SpM=
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Apr 2024 01:00:06 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagern@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH blktests v3 10/15] nvme/{006,008,010,012,014,019,023}: support NVMET_BLKDEV_TYPES
Date: Wed, 24 Apr 2024 16:59:50 +0900
Message-ID: <20240424075955.3604997-11-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240424075955.3604997-1-shinichiro.kawasaki@wdc.com>
References: <20240424075955.3604997-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240424_010008_054931_A57D08AD 
X-CRM114-Status: GOOD (  11.82  )
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
NVMET_BLKDEV_TYPES. Modify the set_conditions() hooks to call
_set_nvme_trtype_and_nvmet_blkdev_type() instead of _set_nvmet_trtype()
so that the test cases are repeated for listed conditions in
NVMET_BLKDEV_TYPES and NVMET_TRTYPES.

The default values of NVMET_BLKDEV_TYPES is (device file). With this
default set up, each of the listed test cases are run twice. The second
runs of the test cases for 'file' blkdev type do exact same test as
other test cases nvme/007, 009, 011, 013, 015, 020 and 024.

Reviewed-by: Daniel Wagner <dwagner@suse.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Acked-by: Nitesh Shetty <nj.shetty@samsung.com>
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
index ff0a9eb..c543b40 100755
--- a/tests/nvme/006
+++ b/tests/nvme/006
@@ -16,7 +16,7 @@ requires() {
 }
 
 set_conditions() {
-	_set_nvme_trtype "$@"
+	_set_nvme_trtype_and_nvmet_blkdev_type "$@"
 }
 
 test() {
diff --git a/tests/nvme/008 b/tests/nvme/008
index 1877d8a..b53ecdb 100755
--- a/tests/nvme/008
+++ b/tests/nvme/008
@@ -16,7 +16,7 @@ requires() {
 }
 
 set_conditions() {
-	_set_nvme_trtype "$@"
+	_set_nvme_trtype_and_nvmet_blkdev_type "$@"
 }
 
 test() {
diff --git a/tests/nvme/010 b/tests/nvme/010
index 34914a7..0417daf 100755
--- a/tests/nvme/010
+++ b/tests/nvme/010
@@ -16,7 +16,7 @@ requires() {
 }
 
 set_conditions() {
-	_set_nvme_trtype "$@"
+	_set_nvme_trtype_and_nvmet_blkdev_type "$@"
 }
 
 test() {
diff --git a/tests/nvme/012 b/tests/nvme/012
index e06bf8d..37b9056 100755
--- a/tests/nvme/012
+++ b/tests/nvme/012
@@ -20,7 +20,7 @@ requires() {
 }
 
 set_conditions() {
-	_set_nvme_trtype "$@"
+	_set_nvme_trtype_and_nvmet_blkdev_type "$@"
 }
 
 test() {
diff --git a/tests/nvme/014 b/tests/nvme/014
index ff0ebfb..bcfbc87 100755
--- a/tests/nvme/014
+++ b/tests/nvme/014
@@ -16,7 +16,7 @@ requires() {
 }
 
 set_conditions() {
-	_set_nvme_trtype "$@"
+	_set_nvme_trtype_and_nvmet_blkdev_type "$@"
 }
 
 test() {
diff --git a/tests/nvme/019 b/tests/nvme/019
index 31020d9..fb11d41 100755
--- a/tests/nvme/019
+++ b/tests/nvme/019
@@ -16,7 +16,7 @@ requires() {
 }
 
 set_conditions() {
-	_set_nvme_trtype "$@"
+	_set_nvme_trtype_and_nvmet_blkdev_type "$@"
 }
 
 test() {
diff --git a/tests/nvme/023 b/tests/nvme/023
index da99406..a723b73 100755
--- a/tests/nvme/023
+++ b/tests/nvme/023
@@ -16,7 +16,7 @@ requires() {
 }
 
 set_conditions() {
-	_set_nvme_trtype "$@"
+	_set_nvme_trtype_and_nvmet_blkdev_type "$@"
 }
 
 test() {
-- 
2.44.0


