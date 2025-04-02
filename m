Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2493C36014
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Apr 2025 07:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K4WrlqnQO0EPe0P7KwaE6tYmrYpHNqryI+scTD1FGsg=; b=YdcUBhA7J9nEONtm3bzvxI4Cbb
	cJVH4+em7NeSXq4ZtLruoHpgBSdEW0SHG7lnfBF2hh4aECarK0pPpJCvC3yWAjkXDTCMv5hHHAYL1
	CnV5VHTNbRoB0JPPcrkYAYIFgWUxphcXTBNR99kOMiHX1lTvn6xFOHlH635475q8E+3eT4ed3J+h4
	50kYeWxGFljF/DhmQt6j1cwvM6RQ6NHq31xrMnJlDCjsO1vUNG9aqosTnL1bugfeAI8VvpJn8Yhar
	MbJcub0NgNkv3Vq1LW3+Pqr6pVwQwOEreWNY/x5XTl7zBHhh2oZPzQrjkToPTxpruxtra1Q6vKORG
	5rVdKiJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzsZ6-00000005NLH-2pEg;
	Wed, 02 Apr 2025 07:31:12 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzsDw-00000005JxC-1wax
	for linux-nvme@lists.infradead.org;
	Wed, 02 Apr 2025 07:09:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1743577760; x=1775113760;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MgPxIncYoIu1IyU0/pxsqdBGr5YKFoGwEiRiwr1vak4=;
  b=dKfnUlDijlC+4+P9lair4cTN2AfjeIe/BLHA+rQ9/pUNPRSYvhOk+Gr+
   QdeP6lOl8LLqdev4XiBK4pf4L8pqj+xyRPkCvuXp1HF/PcEkIPHG6ApXd
   wk5SwL5md0NqMCqGqFL0ge4PRXQMnsObFRTln9PGu2VNxKU0UcLU/AQzZ
   tI8RfsgASU1ixMLXQMunbeyI4GFxIjkGaYxE+6p1CD6ETOW/qKSRrpCvh
   V0xdS3PUY/NSJrcxYZeGq9JQcKXb26c54srkj5jZhOhASJS052dq22gLw
   STcEYVPMRomgDAplxzTjd1/kDO2HL2U4O8pi89cVOCAk7anB3j8n9PBjN
   A==;
X-CSE-ConnectionGUID: f/6axTsTSv2AgsjtD+vAYA==
X-CSE-MsgGUID: L6z94xRmRxKomy43x781vA==
X-IronPort-AV: E=Sophos;i="6.14,295,1736784000"; 
   d="scan'208";a="67793502"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Apr 2025 15:09:20 +0800
IronPort-SDR: 67ecd4a9_rib/kDRbbaMth1f+jvGUBZhL47wN7hkp7gp8CN04hEhaocs
 6JmuIA8babvhVgXqCh8/MCqZ9xQ3UXgAQ0ncBUQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Apr 2025 23:09:45 -0700
WDCIronportException: Internal
Received: from 5cg2075fn7.ad.shared (HELO shinmob.wdc.com) ([10.224.102.114])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 Apr 2025 00:09:20 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 10/10] nvme: add testcase for secure concatenation
Date: Wed,  2 Apr 2025 16:09:06 +0900
Message-ID: <20250402070906.393160-11-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250402070906.393160-1-shinichiro.kawasaki@wdc.com>
References: <20250402070906.393160-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250402_000920_508746_B7309C4C 
X-CRM114-Status: GOOD (  15.38  )
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

NVMe-TCP has a 'secure concatenation' mode, where the TLS PSK is
generated from the secret negotiated by the DH-HMAC-CHAP authentication,
and the TLS connection is started after authentication.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
[Shin'ichiro: added _have_systemd_tlshd_service, avoided "exit 1"]
[Shin'ichiro: used _systemctl_start and _systemctl_stop]
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/nvme/061     | 109 +++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/061.out |   7 +++
 2 files changed, 116 insertions(+)
 create mode 100755 tests/nvme/061
 create mode 100644 tests/nvme/061.out

diff --git a/tests/nvme/061 b/tests/nvme/061
new file mode 100755
index 0000000..7477078
--- /dev/null
+++ b/tests/nvme/061
@@ -0,0 +1,109 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2022 Hannes Reinecke, SUSE Labs
+#
+# Create secure concatenation for TCP connections
+
+. tests/nvme/rc
+
+DESCRIPTION="Create authenticated TCP connections with secure concatenation"
+QUICK=1
+
+requires() {
+	_nvme_requires
+	_have_loop
+	_have_kernel_option NVME_AUTH
+	_have_kernel_option NVME_TCP_TLS
+	_have_kernel_option NVME_TARGET_AUTH
+	_have_kernel_option NVME_TARGET_TCP_TLS
+	_require_kernel_nvme_fabrics_feature dhchap_ctrl_secret
+	_require_kernel_nvme_fabrics_feature concat
+	_require_nvme_trtype tcp
+	_require_nvme_cli_auth
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
+
+	_systemctl_start tlshd
+
+	hostkey=$(nvme gen-dhchap-key -m 1 -n "${def_hostnqn}" 2> /dev/null)
+	if [ -z "$hostkey" ] ; then
+		echo "nvme gen-dhchap-key failed"
+		_systemctl_stop
+		return 1
+	fi
+
+	_nvmet_target_setup --blkdev file --hostkey "${hostkey}" --tls
+	_set_nvmet_hash "${def_hostnqn}" "hmac(sha256)"
+	_set_nvmet_dhgroup "${def_hostnqn}" "ffdhe2048"
+
+	echo "Test secure concatenation with SHA256"
+	_nvme_connect_subsys --dhchap-secret "${hostkey}" --concat
+
+	ctrl=$(_find_nvme_dev "${def_subsysnqn}")
+	if [[ -z "$ctrl" ]]; then
+		echo "WARNING: connection failed"
+		_systemctl_stop
+		return 1
+	fi
+	tlskey=$(_nvme_ctrl_tls_key "$ctrl" || true)
+	if [[ -z "$tlskey" ]]; then
+		echo "WARNING: connection is not encrypted"
+		_systemctl_stop
+		return 1
+	fi
+
+	# Reset controller to force re-negotiation
+	echo "Reset controller"
+	if ! nvme reset "/dev/${ctrl}" ; then
+		echo "WARNING: failed to reset controller"
+	fi
+
+	new_tlskey=$(_nvme_ctrl_tls_key "$ctrl" || true)
+	if [[ -z "$new_tlskey" ]]; then
+		echo "WARNING: connection is not encrypted"
+	elif [[ "$new_tlskey" = "$tlskey" ]]; then
+		echo "WARNING: TLS key has not been renegotiated"
+	fi
+
+	_nvme_disconnect_subsys
+
+	hostkey=$(nvme gen-dhchap-key -m 2 -n "${def_hostnqn}" 2> /dev/null)
+	if [ -z "$hostkey" ] ; then
+		echo "nvme gen-dhchap-key failed"
+		_systemctl_stop
+		return 1
+	fi
+
+	_set_nvmet_hostkey "${def_hostnqn}" "${hostkey}"
+	_set_nvmet_hash "${def_hostnqn}" "hmac(sha384)"
+	_set_nvmet_dhgroup "${def_hostnqn}" "ffdhe3072"
+
+	echo "Test secure concatenation with SHA384"
+	_nvme_connect_subsys --dhchap-secret "${hostkey}" --concat
+
+	ctrl=$(_find_nvme_dev "${def_subsysnqn}")
+	if _nvme_ctrl_tls_key "$ctrl" > /dev/null ; then
+		echo "WARNING: connection is not encrypted"
+		_systemctl_stop
+		return 1
+	fi
+
+	_nvme_disconnect_subsys
+
+	_nvmet_target_cleanup
+
+	_systemctl_stop
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/061.out b/tests/nvme/061.out
new file mode 100644
index 0000000..97e8948
--- /dev/null
+++ b/tests/nvme/061.out
@@ -0,0 +1,7 @@
+Running nvme/061
+Test secure concatenation with SHA256
+Reset controller
+disconnected 1 controller(s)
+Test secure concatenation with SHA384
+disconnected 1 controller(s)
+Test complete
-- 
2.49.0


