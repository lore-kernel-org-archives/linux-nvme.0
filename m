Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F37B5C4345F
	for <linux-nvme@archiver.kernel.org>; Sat,  4 May 2024 08:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O9fdBQcIVjzQ5YK4digUGoFLVlZEn8pOPvIRdPde1FA=; b=Vvu8bue14sSt+NYBO1TRlrYqQm
	2SHT+dpg/4k3bxzZyphabyfy0grnKKnouo1Af3BX4zwM+M8psF3/AxogVv6PcEwK0wr3msb0Sx+Sb
	Xer9JlXxkJaS3x2nfupBbQwLedtqk6b8tC/BA4iz5fbl5pxLaas2VYjcfZk2nLTdA7OX9T2xmo29X
	iSkBushsha/I4IYzdToihL/dJCfp2nFXM97OrzES7gJvz+Wigh6KafpJszZ+wrjMHl4Q+xpnEKULe
	tt86sLKXlQJ6gupmAPtrmXPQpMkZ8001uvvO3do8FjHm7R2GjbDZm5aLnv52UXz+xz+hZdHidONA/
	WYSaV5nQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3AXz-00000001Yvr-0xAo;
	Sat, 04 May 2024 08:15:07 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3AXr-00000001YnR-1aOY
	for linux-nvme@lists.infradead.org;
	Sat, 04 May 2024 08:15:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1714810499; x=1746346499;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=scNjPLcz5U6Sk7MLBNiJnev4lHFJRKq4VGZH2fiaUaE=;
  b=WQQZfCb2ZMq1XjbnlphA4ilw4y13lu5XJPPQhfdxGa1u3kGpkrFbqXYf
   WREzQ3x5bC3dDp8AldljtH0kcK3l66PWx3RhVW2TB9+avdxpiQk7REIke
   FvTyGhcF/btdpwbGIsHAluVuJ8dS+aopWCWpyqbgQt6nQ8X/dAov9N2C7
   uCOMPGIkcNKQFMuLTU+kpgNnhm/TLH+iQPgi1J8x+iWF1IHc8Ny63Dqky
   aIifeBYuUdmqzxEocf2IwM++Ra9nigiUfaJ3nr3YJiokKsIHcKrYDu5dS
   y/0mF1PFFt4vM+IuKOId7KdVMmm78S1Ny9dw76Nbz9rXo+7svZL3IU2T9
   A==;
X-CSE-ConnectionGUID: K1W/+jp4TlSNme1EkyKf1w==
X-CSE-MsgGUID: LrruYp6zSPi9Tvn2+w7v+w==
X-IronPort-AV: E=Sophos;i="6.07,253,1708358400"; 
   d="scan'208";a="15540310"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 May 2024 16:14:57 +0800
IronPort-SDR: nvLfPWuuh+UtoU5shBkSfJxqnkExHUp4sG+AKTOoO4f6kmVg4k42jH1NqdWu7g4RwQK4L+Cgz7
 sWW4nL0u3B4vRaNEuV8E4pnTroBYPwI0oCL4TCrN/syRCaMfx9OBHkpPNg3vtulv2VqMbDq29h
 ZhSZSi+vHO1ZPZ4ZL+jkNBm9zMCL7ht56sfMIMeQUDrJOCl4HUKhivAW7hix3aP9v5A7xPs2q9
 PqyfeoJzdFhXOEzKK/7ktLImDZS/UHoHlDgdoDAR9eOvvvA80SNyJx+B1UZVUF0/vCJB/TjTn1
 53o=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 May 2024 00:22:55 -0700
IronPort-SDR: SzDKZTS73O5IilMQMl5Z5uonEhDgwVnsGdwYRVSSmYGpF6PSLg0zS2t+Z3W1bUlGyFFeDlSGyi
 ITiww7CqspRfSKPebtDuYtjpjgjL6oAml7ZIpj2uEqa7lxjTY/vy8XfWfTcYRQidVJEIL7Cg2W
 8fHptq7jwd4pLX6aQUHA1UveKLEP7cWIBQ8E9ueKhy9J01YnY/RZBSIq7hjZklpkZNEXIw89zZ
 2uIx1LlE/tx2ClKSZdco/+0tP4OJatBA2PCmXZT267eYC/QShJpXKoiIY6Ppv+dj0OeI+WtHtS
 P/U=
WDCIronportException: Internal
Received: from unknown (HELO shinhome.flets-east.jp) ([10.225.163.38])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 May 2024 01:14:56 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v4 06/17] meta/{018,019}: add test cases to check _set_combined_conditions
Date: Sat,  4 May 2024 17:14:37 +0900
Message-ID: <20240504081448.1107562-7-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240504081448.1107562-1-shinichiro.kawasaki@wdc.com>
References: <20240504081448.1107562-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240504_011459_548872_3A9BBAE1 
X-CRM114-Status: GOOD (  16.50  )
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

Add test cases to confirm that the helper _set_combined_conditions is
working. meta/018 combines two hooks, and meta/019 combines three hooks.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/meta/018     | 43 ++++++++++++++++++++++++++++++++++++
 tests/meta/018.out |  2 ++
 tests/meta/019     | 55 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/meta/019.out |  2 ++
 tests/meta/rc      |  5 +++++
 5 files changed, 107 insertions(+)
 create mode 100755 tests/meta/018
 create mode 100644 tests/meta/018.out
 create mode 100755 tests/meta/019
 create mode 100644 tests/meta/019.out

diff --git a/tests/meta/018 b/tests/meta/018
new file mode 100755
index 0000000..4b62d82
--- /dev/null
+++ b/tests/meta/018
@@ -0,0 +1,43 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2024 Western Digital Corporation or its affiliates.
+#
+# Test _set_combined_conditions() helper
+
+. tests/meta/rc
+
+DESCRIPTION="combine two set_conditions() hooks"
+
+conditions_x() {
+	local index=$1
+
+	if [[ -z $index ]]; then
+		echo 2
+		return
+	fi
+
+	meta_x_index=$index
+	COND_DESC="x=$index"
+}
+
+conditions_y() {
+	local index=$1
+
+	if [[ -z $index ]]; then
+		echo 2
+		return
+	fi
+
+	meta_y_index=$index
+	COND_DESC="y=$index"
+}
+
+set_conditions() {
+	_set_combined_conditions conditions_x conditions_y "$@"
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+	echo "(x,y)=(${meta_x_index},${meta_y_index})" >> "$FULL"
+	echo "Test complete"
+}
diff --git a/tests/meta/018.out b/tests/meta/018.out
new file mode 100644
index 0000000..e1af26b
--- /dev/null
+++ b/tests/meta/018.out
@@ -0,0 +1,2 @@
+Running meta/018
+Test complete
diff --git a/tests/meta/019 b/tests/meta/019
new file mode 100755
index 0000000..2ec1ed9
--- /dev/null
+++ b/tests/meta/019
@@ -0,0 +1,55 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2024 Western Digital Corporation or its affiliates.
+#
+# Test _set_combined_conditions() helper
+
+. tests/meta/rc
+
+DESCRIPTION="combine three set_conditions() hooks"
+
+conditions_x() {
+	local index=$1
+
+	if [[ -z $index ]]; then
+		echo 2
+		return
+	fi
+
+	meta_x_index=$index
+	COND_DESC="x=$index"
+}
+
+conditions_y() {
+	local index=$1
+
+	if [[ -z $index ]]; then
+		echo 2
+		return
+	fi
+
+	meta_y_index=$index
+	COND_DESC="y=$index"
+}
+
+conditions_z() {
+	local index=$1
+
+	if [[ -z $index ]]; then
+		echo 2
+		return
+	fi
+
+	meta_z_index=$index
+	COND_DESC="z=$index"
+}
+
+set_conditions() {
+	_set_combined_conditions conditions_x conditions_y conditions_z "$@"
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+	echo "(x,y,z)=(${meta_x_index},${meta_y_index},${meta_z_index})" >> "$FULL"
+	echo "Test complete"
+}
diff --git a/tests/meta/019.out b/tests/meta/019.out
new file mode 100644
index 0000000..d8828ab
--- /dev/null
+++ b/tests/meta/019.out
@@ -0,0 +1,2 @@
+Running meta/019
+Test complete
diff --git a/tests/meta/rc b/tests/meta/rc
index 3a472be..a2f556e 100644
--- a/tests/meta/rc
+++ b/tests/meta/rc
@@ -57,3 +57,8 @@ EOF
 		echo "$line" >> /dev/kmsg
 	done < "$TMPDIR/dmesg"
 }
+
+# Global variables shared between set_conditions() and test()
+export meta_x_index=
+export meta_y_index=
+export meta_z_index=
-- 
2.44.0


