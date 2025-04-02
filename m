Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D190C3601C
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Apr 2025 07:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cIZDkWb3gAkEUSs4vFgtdOFHOVFWhlbXFTRL8kTClQQ=; b=neAlzJbyfaRDVtf3WUft2MLlGj
	7M+2QqOnqTzeiR14jiP2ikooBb3pZHK3g+FppYiEjaFRIyrhXkLXIpvvOuH4O0G9Roiw49iRbQFP+
	+1DyX2T3VuHatIoS/GwR2mXz5pMU9n7W0Qm3ycrf90ygIG4Up7rUfWDjm1WdbI5hM8nM5AHQwdcVo
	YF4UStHXU5+YhfaGUXoddZLc/CuHnXbI9Iazjlakik4r2oKiNS0OOwLt/vPHZ8cj5RPpZjEjwEonU
	JiGMc6Ve7meSQt/tV3ku1VBv3PvZA+MMDbx+z4XsMRO1ynIEtqq/Ey9ZHV72oAEYZiNe1VwSKYeDb
	TUEsstnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzsZ5-00000005NJd-2VX2;
	Wed, 02 Apr 2025 07:31:11 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzsDv-00000005Jwm-0oVT
	for linux-nvme@lists.infradead.org;
	Wed, 02 Apr 2025 07:09:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1743577759; x=1775113759;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZUg4vWIrhMybKloELmU+beOmG39uzWztwz1klnfDxho=;
  b=f++gpbxgC3w/q9iCU4964/InqVPBXMeHMQ1O/KJjOFaBjQnxa9M9rFlE
   z4aOVrjueiFrwi0qAx0Vu6SSw8AbsiRv5P/Y5jKyAl/UfroVXbXCjvxXB
   C1UlF6OHNgqYDFcOS7PZS0Qhel5+MZwscosQx6UyJ030813qCc8VQzew5
   ydWOgwk36ykjikeEDGu4239RQYeWjdGVXZveK3IXC/8UUDp0Ng7IdtC4x
   As3EVH8rkt3FQFU5OAOW4TuI85E8mzcDRwNWmPGt4HmDZ1nTQ3qACqmI0
   KwGuvx6rUioRhR4CayRWlJcl4r5S0sJeDgnHgZ1pQwvrHmcjc6dad16qe
   A==;
X-CSE-ConnectionGUID: 4jXllP1wTqC4llB4sbnutg==
X-CSE-MsgGUID: zjZhENR/THCFRB87DNndjg==
X-IronPort-AV: E=Sophos;i="6.14,295,1736784000"; 
   d="scan'208";a="67793501"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Apr 2025 15:09:19 +0800
IronPort-SDR: 67ecd4a7_CT/pz0PKx2WguZKPryhvNqMMrylukI5wSDD62Y+uKjgXUKl
 E1bPv01XseTaPTRu1IDvRX387dIREJwP3nAp3Kw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Apr 2025 23:09:44 -0700
WDCIronportException: Internal
Received: from 5cg2075fn7.ad.shared (HELO shinmob.wdc.com) ([10.224.102.114])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 Apr 2025 00:09:19 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 09/10] nvme: add testcase for TLS-encrypted connections
Date: Wed,  2 Apr 2025 16:09:05 +0900
Message-ID: <20250402070906.393160-10-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250402070906.393160-1-shinichiro.kawasaki@wdc.com>
References: <20250402070906.393160-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250402_000919_351325_AD9D68BA 
X-CRM114-Status: GOOD (  16.93  )
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

From: Hannes Reinecke <hare@suse.de>

TCP connections can be encrypted using in-kernel TLS, so add a
testcase to exercise the various combinations.

Signed-off-by: Hannes Reinecke <hare@suse.de>
[Shin'ichiro: added _have_libnvme_ver and _have_systemd_tlshd_service]
[Shin'ichiro: used _systemctl_start and _systemctl_stop]
[Shin'ichiro: fixed file mode]
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/nvme/060     | 95 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/060.out | 10 +++++
 tests/nvme/rc      | 14 +++++++
 3 files changed, 119 insertions(+)
 create mode 100755 tests/nvme/060
 create mode 100644 tests/nvme/060.out

diff --git a/tests/nvme/060 b/tests/nvme/060
new file mode 100755
index 0000000..d7424ac
--- /dev/null
+++ b/tests/nvme/060
@@ -0,0 +1,95 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2024 Hannes Reinecke, SUSE Labs
+#
+# Create TLS-encrypted connections
+
+. tests/nvme/rc
+
+DESCRIPTION="Create TLS-encrypted connections"
+QUICK=1
+
+requires() {
+	_nvme_requires
+	_have_loop
+	_have_kernel_option NVME_TCP_TLS
+	_have_kernel_option NVME_TARGET_TCP_TLS
+	_require_kernel_nvme_fabrics_feature tls
+	_require_nvme_trtype tcp
+	_require_nvme_cli_tls
+	_have_libnvme_ver 1 11
+	_have_systemd_tlshd_service
+}
+
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+
+	local hostkey
+	local ctrl
+
+	hostkey=$(nvme gen-tls-key -n "${def_hostnqn}" -c "${def_subsysnqn}" -m 1 -I 1 -i 2> /dev/null)
+	if [ -z "$hostkey" ] ; then
+		echo "nvme gen-tls-key failed"
+		return 1
+	fi
+
+	_systemctl_start tlshd
+
+	_nvmet_target_setup --blkdev file --tls
+
+	# Test unencrypted connection
+	echo "Test unencrypted connection w/ tls not required"
+	_nvme_connect_subsys
+
+	ctrl=$(_find_nvme_dev "${def_subsysnqn}")
+	if _nvme_ctrl_tls_key "$ctrl" > /dev/null; then
+		echo "WARNING: connection is encrypted"
+	fi
+
+	_nvme_disconnect_subsys
+
+	# Test encrypted connection
+	echo "Test encrypted connection w/ tls not required"
+	_nvme_connect_subsys --tls
+
+	ctrl=$(_find_nvme_dev "${def_subsysnqn}")
+	if ! _nvme_ctrl_tls_key "$ctrl" > /dev/null ; then
+                echo "WARNING: connection is not encrypted"
+        fi
+
+	_nvme_disconnect_subsys
+
+	# Reset target configuration
+	_nvmet_target_cleanup
+
+	_nvmet_target_setup --blkdev file --force-tls
+
+	# Test unencrypted connection
+	echo "Test unencrypted connection w/ tls required (should fail)"
+	_nvme_connect_subsys
+
+	_nvme_disconnect_subsys
+
+	# Test encrypted connection
+	echo "Test encrypted connection w/ tls required"
+	_nvme_connect_subsys --tls
+
+	ctrl=$(_find_nvme_dev "${def_subsysnqn}")
+	if ! _nvme_ctrl_tls_key "$ctrl" > /dev/null; then
+                echo "WARNING: connection is not encrypted"
+        fi
+
+	_nvme_disconnect_subsys
+
+	_nvmet_target_cleanup
+
+	_systemctl_stop
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/060.out b/tests/nvme/060.out
new file mode 100644
index 0000000..b2975bb
--- /dev/null
+++ b/tests/nvme/060.out
@@ -0,0 +1,10 @@
+Running nvme/060
+Test unencrypted connection w/ tls not required
+disconnected 1 controller(s)
+Test encrypted connection w/ tls not required
+disconnected 1 controller(s)
+Test unencrypted connection w/ tls required (should fail)
+disconnected 0 controller(s)
+Test encrypted connection w/ tls required
+disconnected 1 controller(s)
+Test complete
diff --git a/tests/nvme/rc b/tests/nvme/rc
index e52437f..ac3949a 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -175,6 +175,14 @@ _require_nvme_cli_auth() {
 	return 0
 }
 
+_require_nvme_cli_tls() {
+	if ! nvme gen-tls-key --subsysnqn nvmf-test-subsys > /dev/null 2>&1; then
+		SKIP_REASON+=("nvme gen-tls-key command missing")
+		return 1
+	fi
+	return 0
+}
+
 _require_kernel_nvme_fabrics_feature() {
 	local feature="$1"
 
@@ -630,3 +638,9 @@ _have_libnvme_ver() {
 	fi
 	return 0
 }
+
+_nvme_ctrl_tls_key() {
+	local ctrl="$1"
+
+	cat /sys/class/nvme/"$ctrl"/tls_key 2>/dev/null
+}
-- 
2.49.0


