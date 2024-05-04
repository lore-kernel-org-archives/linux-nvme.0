Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA4BC4345F
	for <linux-nvme@archiver.kernel.org>; Sat,  4 May 2024 08:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q4roxKQeoWQdWmXz3vCFGxCW5rN4RDoCgn8/Bg+FUv0=; b=ydAQWN+ZklCTmIK2rAyjb0GaDT
	E7GX/4d/IAkIgBMRRLw1wv2DHpyOYbls2Fq3hQK8jVxNLkcSUt7L/V7UXGx7y/9scQ88VsordxOCz
	iV/bxIBHkNxvlTbFXbB/0hFbdw3FlDaLv7bDslBL1j/xYi2v8yhCRSxxYV7gVnDmfhWBrg4QahQDm
	GwCMU1tU10g9PmO/ZjrcfJ3JAqUlMT0zT4Zc2aBieek8wlXQ5NsughqelAotb614swmZg7u/tHu6q
	SRdPC3kI7S09qfN4AleYVBm4/BNsjDqNFkkoWZlz/lw1vSj4Q/OHnfnkQXtoJ443JJHjwel0yxDX3
	6ZiHEs6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3AZ7-00000001ZvP-2ueh;
	Sat, 04 May 2024 08:16:17 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3AY6-00000001YnF-0GZ8
	for linux-nvme@lists.infradead.org;
	Sat, 04 May 2024 08:15:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1714810513; x=1746346513;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t7G2Ho5WPgwkt3ZFuraW47O0HRzd+FaFO+yo28FOtDU=;
  b=FLZ/XmCS+RjSZPwV+r6k0zt7kXylDWzzkIYOmn2T/hcM143XdwNZY7Y0
   Dsf9/g7ecr6SDrxX6erOAAD2FV7U/6dDr+rLvmHvFyEPC0Yw6mmdZum5G
   iYMwqpgDoRNKIOBBpKenejWwZCOy77uBaY7MktwR/lKToRTbGO/oW2nCY
   QA/uqgfn+qkhqnIArswrxKbr/9Qvb7O7ibFrNtMsqMcYYpmg8Lj/XVaVB
   qRVFAw4m+aB5BquZWtVLvHNT/p0p4WaaNNVa3nAUr7DURiUjEuSOgGmyw
   HDWkBBBIMtx7dIC2JeZDg9IMR1PFxRWOSqt+9Lz+OBQBcO3d4lJaA/cGG
   Q==;
X-CSE-ConnectionGUID: jLmEII+pR4G9iQlsSu32+Q==
X-CSE-MsgGUID: lRAq1WLnRCqiROBQxgY9rw==
X-IronPort-AV: E=Sophos;i="6.07,253,1708358400"; 
   d="scan'208";a="15540359"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 May 2024 16:15:12 +0800
IronPort-SDR: 7ZNEZjezUW6pOFwFJ0sKVEv5b3RcSJdyu+Us6Bc3lkZJ9p1Bt3BLq13/54tSYjPYdwMKcrKfLy
 jIbJgppHQglnyIUbPjVILDQ+rA1TSUxtVp/T6IWs/3W+a4unYNw/uvkSjrbY62Dg5E7s7rLqB/
 04w81yf9eRrF7TM30JoavlofK1vd39J4hkvMZjAB0RxIlzGxqC3dx0pZxO3ybzujrVPoP5RtN/
 nQNgcsOmrnUG27zgFj9mXDrMERMKKLEWB1yGegVYkzsKYcfQYxTfKd9FIZVPEes7FvbEwaTmws
 qqM=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 May 2024 00:23:10 -0700
IronPort-SDR: +VsxZNyaEtyXC2FUTDXm5TSjW5TLuz8wCYTv7CUL+KZNduTEprAmYkX/VO7HR2rylv44ElWF0Z
 eBxqn5/2yhb+ahLhY4we4IulCddX0WCaA/UASNwKJhxrZBaKU9IKpPvW5a1p8AAcXC1I+QLzJg
 J5I4grPWLBdmuzJ8GQcqQCEslrZ+jfdPa2breAqXcY4UYPbKMonUq3LMJCGPLsB6wpDCmZPiQF
 WKp0RdGXoMUYjzj6IBdxL0Fg0OOcNg2MIPOersX0mbTt4jIaogmc75RIi6MTUaCwXFEuJPtKmC
 wyw=
WDCIronportException: Internal
Received: from unknown (HELO shinhome.flets-east.jp) ([10.225.163.38])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 May 2024 01:15:10 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v4 17/17] nvme/rc,srp/rc,common/multipath-over-rdma: rename use_rxe to USE_RXE
Date: Sat,  4 May 2024 17:14:48 +0900
Message-ID: <20240504081448.1107562-18-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240504081448.1107562-1-shinichiro.kawasaki@wdc.com>
References: <20240504081448.1107562-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240504_011514_458051_C7C57313 
X-CRM114-Status: GOOD (  13.96  )
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
use_rxe to USE_RXE.

Reviewed-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 Documentation/running-tests.md | 6 ++++--
 common/multipath-over-rdma     | 5 +++--
 tests/nvme/rc                  | 2 +-
 tests/srp/rc                   | 2 +-
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/Documentation/running-tests.md b/Documentation/running-tests.md
index 7bd0885..968702e 100644
--- a/Documentation/running-tests.md
+++ b/Documentation/running-tests.md
@@ -132,9 +132,11 @@ NVMET_TRTYPES=rdma ./check nvme/
 ./check srp/
 
 To use the rdma_rxe driver:
-use_rxe=1 NVMET_TRTYPES=rdma ./check nvme/
-use_rxe=1 ./check srp/
+USE_RXE=1 NVMET_TRTYPES=rdma ./check nvme/
+USE_RXE=1 ./check srp/
 ```
+'USE_RXE' had the old name 'use_rxe'. The old name is still usable but not
+recommended.
 
 ### Normal user
 
diff --git a/common/multipath-over-rdma b/common/multipath-over-rdma
index ee05100..d0f4d26 100644
--- a/common/multipath-over-rdma
+++ b/common/multipath-over-rdma
@@ -12,12 +12,13 @@ filesystem_type=ext4
 fio_aux_path=/tmp/fio-state-files
 memtotal=$(sed -n 's/^MemTotal:[[:blank:]]*\([0-9]*\)[[:blank:]]*kB$/\1/p' /proc/meminfo)
 max_ramdisk_size=$((1<<25))
-use_rxe=${use_rxe:-""}
 ramdisk_size=$((memtotal*(1024/16)))  # in bytes
 if [ $ramdisk_size -gt $max_ramdisk_size ]; then
 	ramdisk_size=$max_ramdisk_size
 fi
 
+_check_conflict_and_set_default USE_RXE use_rxe ""
+
 _have_legacy_dm() {
 	_have_kernel_config_file || return
 	if ! _check_kernel_option DM_MQ_DEFAULT; then
@@ -396,7 +397,7 @@ start_soft_rdma() {
 	local type
 
 	{
-	if [ -z "$use_rxe" ]; then
+	if [ -z "$USE_RXE" ]; then
 		modprobe siw || return $?
 		type=siw
 	else
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 6fc0020..c1ddf41 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -97,7 +97,7 @@ _nvme_requires() {
 		_have_driver nvmet-rdma
 		_have_configfs
 		_have_program rdma
-		if [ -n "$use_rxe" ]; then
+		if [ -n "$USE_RXE" ]; then
 			_have_driver rdma_rxe
 		else
 			_have_driver siw
diff --git a/tests/srp/rc b/tests/srp/rc
index c77ef6c..85bd1dd 100755
--- a/tests/srp/rc
+++ b/tests/srp/rc
@@ -51,7 +51,7 @@ group_requires() {
 	_have_module ib_uverbs
 	_have_module null_blk
 	_have_module rdma_cm
-	if [ -n "$use_rxe" ]; then
+	if [ -n "$USE_RXE" ]; then
 		_have_module rdma_rxe
 	else
 		_have_module siw
-- 
2.44.0


