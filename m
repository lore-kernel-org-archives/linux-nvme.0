Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8E82C4345F
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Apr 2024 10:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z0L1GM4EPcxY28T9q8f1uvfboGK3AeOXXD5yrjwxN9k=; b=ItbJgT/zNYpR8SLsqnu1UKm3Qq
	W6N35E/zk8Kp8YfQRwqgJw9GqewFyvbh9UtqnJzH09LM2AM0ciGR8nmnLvcQxtWcQREjyH0co8ydy
	QftSin2IbVxDb+hccPBVSndAYVZAhktUxUtgysin5DJ5HSqf7nFE198mDadwre2xQWjJr4xSR3W55
	U6fJ0ceH9yKPollzo45R5+AZ/k8Gzb0B6TyYlNqgZ9x3zi2mjupYVROqRYoDQ1Hk7M4MIkAJLOLEv
	FJ0VCj1lLuJr+VLLV3+1Jhc/c/sMHBpxW+pY5peeVSQ+18boyVsfi1P21Mkf582ZI8MHQjjogkA9c
	TQxJahmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwg7L-0000000Bo11-2Jhc;
	Tue, 16 Apr 2024 10:32:47 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwg6r-0000000BnZ7-2Al9
	for linux-nvme@lists.infradead.org;
	Tue, 16 Apr 2024 10:32:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713263537; x=1744799537;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wKrzhkD2vg/WvRStbcCDepGHYo8qCYqridvUcZHyY20=;
  b=qZt+LTXhoed1mm5QaItyoi6qrOtVfMINcNBN9QWwc3AGCXRUbZA8sI37
   Qzsj8y0RIFfktF0opod7YvRD62anTI4PzN7t9j5m6NHNkLnCFjfo1DDMh
   mahDNrl1SmaCOpmonBRSveLL8BAIYJfGGVYrC5wEyupK78E4kPd7808vt
   9dmdCiNIaKeq0bVz1ufqp3jwFxRrVIuDq6x/3TA5OzlktITJn5ctA+wMe
   rUBeFGj6oU9cklmHDPI6gK5TCGi0JlTXfowwcG6V2KArRir2Lyqv5F5px
   niNnPUQ/xniF8wKGq5x9qlUhHb/8ZiAxBNuV+NFmAS1qImBiot1EHM5/+
   g==;
X-CSE-ConnectionGUID: YCoJqwdBThqLsLhWSFIyjw==
X-CSE-MsgGUID: dJzQLX01SH6W5LBmcRNShw==
X-IronPort-AV: E=Sophos;i="6.07,205,1708358400"; 
   d="scan'208";a="14796911"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2024 18:32:17 +0800
IronPort-SDR: CNt1ATgbo6TLsK7wmHj8ufAYkLoHoi35i1kbhdJ8VZyOwku5YAFZU6cR0YXImuasyapuK0LSwY
 PHBC1mxOY7cA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Apr 2024 02:34:56 -0700
IronPort-SDR: OCYt+4IGiSmW3wki+5ltkt26okeUcFju6kRV0lM8/gun52l2xgB/5S0VtpWoq84xfNS1zYnHn3
 fwvvXV7mFrzGwr9qi/vJX62Rgk8ZgcDaB/H+/F9Q3KhjPhb4M9Z5BC0ekm6sjNOzwyQx2BHO6A
 n2/3O5y7BvZoBGOCz5wyE1rOFyG6uhvEPea+1d8MmNu6aeWqN4J9vYTfGUdTnzoj6gs6HahRKu
 PDWKryHhNyvMeij4W0LynrXUobiLl9OfJ20wzxuLkTN/q2WTuXouhdGSE1dWgNAwjVE0VygclC
 Ats=
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Apr 2024 03:32:16 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagern@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH blktests v2 09/11] nvme/{006,008,010,012,014,019,023}: support NVMET_BLKDEV_TYPES
Date: Tue, 16 Apr 2024 19:32:05 +0900
Message-ID: <20240416103207.2754778-10-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240416103207.2754778-1-shinichiro.kawasaki@wdc.com>
References: <20240416103207.2754778-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240416_033217_787403_1452D38A 
X-CRM114-Status: GOOD (  11.51  )
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


