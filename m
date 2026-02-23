Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73388EF5861
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Feb 2026 03:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BZvCdGiVseIuNuU+yJBCK4XDWZ8m+f+W6QO5oWcAf1E=; b=n3xCclC/ApqS4shzWGQ4pSvG6b
	pXii8mnHKEfLxO3L35WFv5QzVwdaP1lWXiEELfJXLShGb0rG1WM9bUa1ydKLX5Jp1bNx4x/NWk/pQ
	sIySoOgXuIlEoJTL6M0HZxbZ70ToIOwTGqVpGeJxXEa/apheSAP7G2E8QN/XCF94bTttTJFav9CYk
	oWcpd9x2jZYyVTjD5djo/qLx9anXdjt3bkDAnLVrD6QVO8WFY8vd6yk6tUbB0HjyJEwALPVGAEnxL
	kGK3s77dwD4hFV+2k8h3dUCiRGABz3e86HRSb4/4OxJqqblXDn5rI3gzuMmkTx56S45Il0NQeBE2m
	/egrE4pA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuMxr-0000000HBdx-38c3;
	Mon, 23 Feb 2026 03:50:31 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuMxo-0000000HBcT-3tbm
	for linux-nvme@lists.infradead.org;
	Mon, 23 Feb 2026 03:50:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1771818628; x=1803354628;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p6o81+4nOXs9PCFt65NlCvkfcI5ag3wBP18ohrU9qdg=;
  b=avM2Ghg7YRMBuGznRs6YSO+MIiMg1GRs6ODTc92iLwKW8Sz/+KVB49ls
   MZE8vcgSzywlv5TzUwH08bHGJ8R+AesV4y9cWN4XHf+9ozOkWFh0ixKF6
   0qiIyzaSQ3kLLeyXAFmAIY7i/WglqmjWYIt8+EpBDYHMBWhnc9MKG3/5p
   hpVohNyFn+OFD5LD2LOsEzdfdBUJGrf8l8EcSXMwjj4xVLnGawUZ3mXRn
   CmHA0TH7aUAPhtB4/BJZfMj/SjOtWCLmZR4ZZ2YA0VpHsZ0kniWFBil8o
   gDJclSoPFvBPlP0RL1pzmq1yeuHSo+DdMWoa5jqmqWL/anrWlcGJh19mj
   Q==;
X-CSE-ConnectionGUID: L6TSqB4BSJew2L/VsvcgCg==
X-CSE-MsgGUID: udFEl2OBQbmpOOX094wUoA==
X-IronPort-AV: E=Sophos;i="6.21,305,1763395200"; 
   d="scan'208";a="140288649"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Feb 2026 11:50:26 +0800
IronPort-SDR: 699bce82_8jRrw0lTwxOYSfPmm/e3QDWtKeplTWZQWecJ3o7y8aL9Z6F
 PcGaAQn/Qdr22cnvbFj0ARrXfhZON9iIj7isREA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Feb 2026 19:50:27 -0800
WDCIronportException: Internal
Received: from 5cg217417w.ad.shared (HELO shinmob.wdc.com) ([10.224.109.142])
  by uls-op-cesaip01.wdc.com with ESMTP; 22 Feb 2026 19:50:26 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 1/3] check: call _unload_modules for each test run
Date: Mon, 23 Feb 2026 12:50:21 +0900
Message-ID: <20260223035023.21902-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260223035023.21902-1-shinichiro.kawasaki@wdc.com>
References: <20260223035023.21902-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260222_195029_023856_82D426B0 
X-CRM114-Status: GOOD (  13.03  )
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

Currently, the check script calls _unload_modules() once per test case.
However, when a test case has set_conditions(), the test case is
executed multiple times, once for each specified condition. Despite
these multiple execution, _unload_modules() is called only once after
all the runs for various conditions have been completed.

This behavior causes module unload problems. When a run leaves some
modules loaded, subsequent runs can be affected by the loaded modules.
To prevent such problems, call _unload_modules() for each test case run
for every condition.

Fixes: fb3ba926da7d ("check: support test case repeat by different conditions")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 check | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/check b/check
index a2c19a2..9622030 100755
--- a/check
+++ b/check
@@ -416,7 +416,7 @@ _cleanup() {
 	_exit_cgroup2
 }
 
-_call_test() {
+__call_test() {
 	local test_func="$1"
 	local seqres="${RESULTS_DIR}/${TEST_NAME}"
 	# shellcheck disable=SC2034
@@ -536,6 +536,17 @@ _call_test() {
 	fi
 }
 
+_call_test() {
+	local ret
+
+	__call_test "$@"
+	ret=$?
+
+	_unload_modules
+
+	return $ret
+}
+
 _test_dev_is_zoned() {
 	[[ -e "${TEST_DEV_SYSFS}/queue/zoned" &&
 	   $(cat "${TEST_DEV_SYSFS}/queue/zoned") != none ]]
@@ -887,8 +898,6 @@ _run_test() {
 		ret=$?
 	fi
 
-	_unload_modules
-
 	return $ret
 }
 
-- 
2.53.0


