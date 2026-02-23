Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33DC4E98DF3
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Feb 2026 07:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t/RPFZ/IF706l5nYuqQIBPJb+q6oFRg6Rr+OVwT6T+I=; b=ZLrT+R9wsX21ePLt4Wc4onW2mo
	tSu/X9hfdoEGytxAMwET3r7fge2uTjXZrKk08sWsU8sfvBAwlYCPm6BKeMzO8IsJvE83g2R2N0u4U
	hcnEuXIKgoHZIbybqocJ+8QHjgMwXonPcQ6UyfGDuUFDtiHP727aXr4SuenyVToNbiA9pk/4Lo+3Z
	qDtn9fWJpPV59R+PGub8Zx/EuPF9q6at0iFmxGNUlkTghzvTOvo0p1BaaqsKpUUZ4iMPD45uvSyJ/
	KNxkrAI9hS7pJx51Rb/N41L1S2TV65mvQVQWFOYy8BHI4XsASU2QE7ksdek+a5syYDhJAqblOiNy/
	ozDfPbsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuQZB-0000000HOOI-29Tp;
	Mon, 23 Feb 2026 07:41:17 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuQZ9-0000000HONH-0qoV
	for linux-nvme@lists.infradead.org;
	Mon, 23 Feb 2026 07:41:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1771832475; x=1803368475;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KpQwsZX6wPSc8P/twa9sW5j21j/xglKX+fmhHVd/5UI=;
  b=hJAnCT99rZdg7TNIMaSklKEJS1cfB6EyudZmtqbSlny/sGglCY00oxAy
   ZATDz4LL0mRAHwUkYCWhPOqRHGhfXXOaRIxLO9UWMo5Hz/RPiILq6rlUu
   8tzwVy0l3bbJA+vXYtp8TcGk15P5RqUoSHstD00pKpnkYwsO3KvLsT+Qm
   PN8S7wm9j197fbZYI6mxCvxsxox354LsE7qlHedZ14xT1dvzuyHnPvWJS
   qFPzkLg+7fh1irBbHpuJ4mBMtc52+s7osg+uFc1GmiqvVAWhP2YiJ9Nn9
   VwBCMxN7F8+nJMEMsui7Jm+e1uI7fp4ZxqdODpHA6N9ZdsKJHETJCFRAN
   Q==;
X-CSE-ConnectionGUID: nDLvAlcITU6nSflblQdG5A==
X-CSE-MsgGUID: UlGBHa9LTVWtTMxwrKih+g==
X-IronPort-AV: E=Sophos;i="6.21,306,1763395200"; 
   d="scan'208";a="141214630"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Feb 2026 15:41:13 +0800
IronPort-SDR: 699c0499_U0fYgHoWhIq4Tm81ChkaQdKbciwd9l5sfT8mHvJFDeQe8hQ
 k7GRq8lmX3yZCDWN77fdLRRmPTIgWS7B2zigbCQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Feb 2026 23:41:13 -0800
WDCIronportException: Internal
Received: from 5cg217417w.ad.shared (HELO shinmob.wdc.com) ([10.224.109.142])
  by uls-op-cesaip01.wdc.com with ESMTP; 22 Feb 2026 23:41:13 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 1/3] common/nvme: do not call 'nvme id-ns' to non-nvme devices
Date: Mon, 23 Feb 2026 16:41:08 +0900
Message-ID: <20260223074110.144758-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260223074110.144758-1-shinichiro.kawasaki@wdc.com>
References: <20260223074110.144758-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260222_234115_303211_8CEB08B9 
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

The test case block/041 tests PI metadata capability in the block layer.
At this moment, nvme is the only one block device that supports the
capability. To check that the test target nvme devices fulfills the
requirement, the test case calls 'nvme ns-id' command via
_test_dev_disable_extended_lba(). However, since the test case is in
the block group, TEST_DEVS can specify non-nvme devices. Even though the
test case is skipped by _require_test_dev_is_nvme() check, the
'nvme ns-id' is called for the non-nvme device and fails. It spits out
unnecessary error messages.

To avoid the error message, check if the test device is nvme before
calling 'nvme ns-id'. For the check, factor out a helper function
_test_dev_is_nvme(). While at it, replace short command options -q and
-f with long options --quiet and --canonicalize for readability.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/nvme | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/common/nvme b/common/nvme
index a419cd3..bb4896a 100644
--- a/common/nvme
+++ b/common/nvme
@@ -1121,8 +1121,12 @@ _nvmet_target_cleanup() {
 	fi
 }
 
+_test_dev_is_nvme() {
+	readlink --canonicalize "$TEST_DEV_SYSFS/device" | grep --quiet nvme
+}
+
 _require_test_dev_is_nvme() {
-	if ! readlink -f "$TEST_DEV_SYSFS/device" | grep -q nvme; then
+	if ! _test_dev_is_nvme; then
 		SKIP_REASONS+=("$TEST_DEV is not a NVMe device")
 		return 1
 	fi
@@ -1150,8 +1154,8 @@ _test_dev_has_no_metadata() {
 _test_dev_disables_extended_lba() {
 	local flbas
 
-	if ! flbas=$(nvme id-ns "$TEST_DEV" | grep flbas | \
-			     sed --quiet 's/.*: \(.*\)/\1/p'); then
+	if ! _test_dev_is_nvme || ! flbas=$(nvme id-ns "$TEST_DEV" | \
+	   grep flbas | sed --quiet 's/.*: \(.*\)/\1/p'); then
 		SKIP_REASONS+=("$TEST_DEV does not have namespace flbas field")
 		return 1
 	fi
-- 
2.53.0


