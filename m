Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F23EBC4345F
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Apr 2024 08:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5ErNdDiBWMRpGdrCKorm3vOR+dcWM6pqzclO+gHCUsc=; b=jUzDdjocOrDzbbwt8NnLS9Z4G+
	GDkCHl2u+g/K86GIKUsTjYprW+Dy9AZIJ2UXSzt1xzx8pFj3tj2ZTIZczcX0oNrHINv86wC5E5AAL
	jOEmvqBIfjCUXmGrd1EtrksjeHaGMo5j9x4zpyDC4lCFu3sNZgt9QvCtxwbtvcb50RDAvfZvl1UoJ
	zzSqwR3dplvbEer+jmXKBssTNOOcvJd1Fz0exBWw321q/grbzYW7ZagiNk7sdHNva4nNRwqKc03jZ
	mox1DCddYlz3FExLX8L9xXkkHJALWICuXrtoNZcCIK0Ebu+GMEmxXCz4ZI+LcBU94IHbxy+TSXgTu
	s9OcQZ9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzXZG-00000003Cwf-2ghi;
	Wed, 24 Apr 2024 08:01:26 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzXY9-00000003ByV-0EsE
	for linux-nvme@lists.infradead.org;
	Wed, 24 Apr 2024 08:00:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713945617; x=1745481617;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sSC9duX72FifCTm3ELiWm9Q8X/xeNDFYZA8WyilwbPA=;
  b=LJCS1Fs22TOAfADpZ3mpQZ3xq/F/vDqqQcu9jCjndtr8GALlinZjTtXh
   naxpMzIijzSshxcQYmmRu2kBR8hmqdKVd+fZqFdBToFcfzk4nuNfRZDnz
   198CmrnDW13JXYmsEF4i9/vwidSKVAeUUevcIfceprrG5e92B04KoSKkR
   H/rDH03jJHYc3xX40HN+VNHxBj0P7wkFI0JARng/qWGzytdc7aE808Ins
   XjrkDdHunbjOadsX6PCBqYJq//TFsYvJ5RVigh0bquQRTrSr8V7I1W5sJ
   BE62uyfwbN0DMv0//nUkZYwiNu5JGX+CRBEAvuCEfGtAyjgGEdMJ/LaLS
   Q==;
X-CSE-ConnectionGUID: N5/SpxwFTNOCVD0KiIjufg==
X-CSE-MsgGUID: 9x0OtKc9R5y8YGL/+FYsNA==
X-IronPort-AV: E=Sophos;i="6.07,225,1708358400"; 
   d="scan'208";a="14140811"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Apr 2024 16:00:12 +0800
IronPort-SDR: 9RxMynFc9yqG8nNNVWHJ/I/Yn13I0XDytHUiBz/hiz3iFaW1dl9Ix7Sfh8PCjOLRPWhKt/EVU3
 sWfjeOn0T3vOeXbEu0BlkA7xGYXkBMi6r+YC+E5+OhI9QJGj3ommaH38BI6ViXEI7WDCScP6ZY
 0JGYOtllsIj48hDqkZsFaD3HCnA0bD4D3QyUlOkrkdcVebI2BOg32D99+I+niFW54fpDe5g/Fr
 KblakK9tLW8HDJOkMnBYQqBe/lVcPLTHPCYewI6/OIKWmclf4sYc7kxrW2k1Eiba3HtiUuTYUu
 s6o=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Apr 2024 00:02:42 -0700
IronPort-SDR: MlOKba1Lp9hfmyqNfUobT2+/JTJBQNiAdMH4tJM+WV86fNGZqX2T0vMBObHYNN46iS1ZdaTs0t
 9lAM/msyFXlje5E8D1IWkgHXjhyFUEs3fZIeWtoxuBJeEnLZqu/RMC8ij8YThpUz/Lm60cn+st
 dJUcb3ZdaKSF0+Gv2cYyVXovUJLK+EuKHR8sr0wOdy0vSE+u8iJ1NZH0Obv8ClXv5CxEVl7mfw
 GsIHV/OnCpQRyR6IUi97M9i8VwYDvNK+3Povc/hBPOildynX6Tx/TUGebQRigDIi3PfFGiQKsw
 zEk=
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Apr 2024 01:00:12 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagern@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH blktests v3 15/15] nvme/rc,srp/rc,common/multipath-over-rdma: rename use_rxe to USE_RXE
Date: Wed, 24 Apr 2024 16:59:55 +0900
Message-ID: <20240424075955.3604997-16-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240424075955.3604997-1-shinichiro.kawasaki@wdc.com>
References: <20240424075955.3604997-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240424_010017_308826_B1FC4E98 
X-CRM114-Status: GOOD (  12.54  )
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
index 8762a56..24eafd2 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -103,7 +103,7 @@ _nvme_requires() {
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


