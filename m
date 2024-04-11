Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA23BCD1284
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Apr 2024 11:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+o28GyexQyEVOKcgmb1BAcfTc1j75A6wAPHLtyEnnmk=; b=5FIxiDwQSOGhNK8EZTIoro/0JL
	GEpUhvv2c+GKqLZneZdrFsKE5MZyMrJKZNjtOECkK0DKrUEVB7H9Y4XdncqplOD366fFIDiib7i8+
	qThAc6QVPAG0lgoFtOeZwmKSsLnpgPl9N+RlSkUKC/fpS+Afe1KogSum3yDrCO2g9BoVuoTYrjZ2A
	DCJV2b03rkpOhIxzCFSCA91smXvDSwvNNRI6pJ3aYDS7R8+nqcQAJBh1RaBB9mNFH9o+rKdPoH7yP
	TGoijddJwU6Tz0MPwr29CbZUhYCQFj33squO/yTPPkg0lYeniz0OdoSTbpHZz86Y2aud1JtCbgOfZ
	Qqfb+fWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rusMZ-0000000BftF-3Yjl;
	Thu, 11 Apr 2024 11:13:03 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rusMD-0000000BfV0-2HDj
	for linux-nvme@lists.infradead.org;
	Thu, 11 Apr 2024 11:12:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1712833961; x=1744369961;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a3mYw5dZYWpBYbWDrYxR2B8qW/L5n4xS8Y3bHI8WHVE=;
  b=k89c6OVOHhhggtk4ujSnuIceZg+K7yBC+kKrAyLtqUhEiuks0x6sEjV/
   YsEvexQ55ujFtnR75bQy9mTffVlfkgs6oIMdjYICJZ5RIkRUe/PPyPVy1
   MF3GSGP2y0PkDgzd0ri+KORz3yNo68T0oBImg2J4hOPUQgGQPoWv6Ct6x
   nXFPZM3l1PFum8zYVjULgfO4DpFI+GNUWYJhH5pxsYZKst0whw6S91oqq
   s/FZP3EsjFZEPxDjo77Z/Pj3hKsaB47jN8k506Km4soJ+1y/KH6E3Q+2z
   inxQnddixoQYlGHoQ7vlfDJoupQO8HvGIuBZ1O4OuwnIFlsBpWKEvnPq7
   g==;
X-CSE-ConnectionGUID: LeAi2rJaTD617RSuxKxfjA==
X-CSE-MsgGUID: Bu3hdLolRKWaU/RIgqNmQQ==
X-IronPort-AV: E=Sophos;i="6.07,193,1708358400"; 
   d="scan'208";a="13226496"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Apr 2024 19:12:38 +0800
IronPort-SDR: VzoJy4Oxc4rRPtstmpkQJ+HIsGIROc9bL2tmQ2aVXJQPLjDo3rSSBX0htUsjYICExdFs29H3kD
 1PXQBhX18IIw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Apr 2024 03:15:23 -0700
IronPort-SDR: sV749hVlOpjLYpNX1/Pd3VMuUlK0ngrRFfdB1j0RvYN0c6OTJqgZA4UrV6WBIMXt1WOl73hr3A
 RltqBp/MfExg==
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Apr 2024 04:12:38 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagern@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH blktests 09/11] nvme/{006,008,010,012,014,019,023}: support NVMET_BLKDEV_TYPES
Date: Thu, 11 Apr 2024 20:12:26 +0900
Message-ID: <20240411111228.2290407-10-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411111228.2290407-1-shinichiro.kawasaki@wdc.com>
References: <20240411111228.2290407-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240411_041241_907740_E03DE458 
X-CRM114-Status: GOOD (  11.55  )
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
NVMET_BLKDEV_TYPES and NVMET_TR_TYPES.

The default values of NVMET_BLKDEV_TYPES is (device file). With this
default set up, each of the listed test cases are run twice. The second
runs of the test cases for 'file' blkdev type do exact same test as
other test cases nvme/007, 009, 011, 013, 015, 020 and 024.

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
index a0c4096..0e1f142 100755
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


