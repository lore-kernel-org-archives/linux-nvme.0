Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB66D4334B
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Nov 2024 11:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=de5l2VfZ1HLjLXiJ93/XyTOjYNR9c1AK4r4DoM5NW4w=; b=n3mlVGdv7Jt1fF2rFl6dqHt5y/
	GBUHHqLnGacYKxyu8fTbbgnvj24pTcP5peH2FS/4noel5a3YdnTa9JY1TObPmra9nseJva8YLon2G
	j28J7/MSbS4GGMnxtjD3NAg4tXQgw7Oa9khS/c3EhQvf/G8IkOgGzsdBZQCYDA8lapr2ILz0I1AQg
	nwfV5266vLLi4z2yjFdv2Xi7Aa9PmrAeQYohY2838FyLrqbhE2vsVNhBAE9tveE0z0f0VV6XHPiaf
	vyJxjzVnAAIQFP5Cp5l1qzDM/Ea7Rf4eBFetkWWRpaQktGtWNEVULd/TqxF1sPZLUsOdcTvc1lc+a
	cGkv7O0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t90Sj-00000006dxF-09X4;
	Thu, 07 Nov 2024 11:14:05 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t90Sd-00000006dtE-3tZo
	for linux-nvme@lists.infradead.org;
	Thu, 07 Nov 2024 11:14:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1730978039; x=1762514039;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2OgwaLLqTT9GNxGcabOj59NNed2K9Cd0HXaz2+9tfB8=;
  b=LCkf9noeF3mxANSpiIPyCJ2l+fNu6cFHvY9dnfnqFob/ET9ZVh4G3fAs
   s0A9PaEe6v51YNB9HwQehX6NGiffwwTSz6orVoAiUu/1rfd3mTTKb0sZP
   KkettruKFG6d1m9va6IOAWKNnq/cTsPYxYz65K6/tMvPsXERRq1fXMLu2
   tLReR5DVa+uasAieqLaDWzOUCWbWgm49aB/4NOAWYaElPapTc17SeMyMS
   UGE4ZQOm2Y78d9KI0dXweT+FYWjwK4iRVoJQQfwkVuKCH+0+ESy1vZFaj
   hUWDFTycnPToQ0k4pkP6AEoebmkWrjZOCpJDc9ytY+44VcAVoSHa6CLC5
   Q==;
X-CSE-ConnectionGUID: 32fwnNC6SUKzZ3tpBIilGg==
X-CSE-MsgGUID: Fa8uceYhSIuXlKQ9DxM6qQ==
X-IronPort-AV: E=Sophos;i="6.11,265,1725292800"; 
   d="scan'208";a="30851678"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Nov 2024 19:13:57 +0800
IronPort-SDR: 672c93bc_3yEN25/LhR4J1P6QbmyQ6GsknHTj5BlsiTgwZ3cnUaNCcjQ
 PxIoGFPFr6AheZASgcqLUaWY491TDl8cf4uKBQg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Nov 2024 02:17:33 -0800
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Nov 2024 03:13:57 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 2/8] nvme: move _nvmet_target_setup() to common/nvme
Date: Thu,  7 Nov 2024 20:13:48 +0900
Message-ID: <20241107111354.80606-3-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241107111354.80606-1-shinichiro.kawasaki@wdc.com>
References: <20241107111354.80606-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241107_031400_064560_1BF3805B 
X-CRM114-Status: GOOD (  13.06  )
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

_nvmet_target_setup() is in tests/nvme/rc, but _nvmet_target_cleanup()
is in common/nvme. So move the former into common/nvme to have both
functions in the same place.

Signed-off-by: Hannes Reinecke <hare@suse.de>
[Shin'ichiro: rebased on the commit e3fe06e and resolved conflicts]
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/nvme   | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/rc | 71 ---------------------------------------------------
 2 files changed, 70 insertions(+), 71 deletions(-)

diff --git a/common/nvme b/common/nvme
index 84b6ac3..832e879 100644
--- a/common/nvme
+++ b/common/nvme
@@ -784,6 +784,76 @@ _find_nvme_ns() {
 	return 1
 }
 
+_nvmet_target_setup() {
+	local blkdev_type="${nvmet_blkdev_type}"
+	local blkdev
+	local ctrlkey=""
+	local hostkey=""
+	local subsysnqn="${def_subsysnqn}"
+	local subsys_uuid
+	local port
+	local -a ARGS
+
+	while [[ $# -gt 0 ]]; do
+		case $1 in
+			--blkdev)
+				blkdev_type="$2"
+				shift 2
+				;;
+			--ctrlkey)
+				ctrlkey="$2"
+				shift 2
+				;;
+			--hostkey)
+				hostkey="$2"
+				shift 2
+				;;
+			--subsysnqn)
+				subsysnqn="$2"
+				shift 2
+				;;
+			--subsys-uuid)
+				subsys_uuid="$2"
+				shift 2
+				;;
+			--resv_enable)
+				resv_enable="--resv_enable"
+				shift 1
+				;;
+			*)
+				echo "WARNING: unknown argument: $1"
+				shift
+				;;
+		esac
+	done
+
+	if [[ "${blkdev_type}" != "none" ]]; then
+		truncate -s "${NVME_IMG_SIZE}" "$(_nvme_def_file_path)"
+		if [[ "${blkdev_type}" == "device" ]]; then
+			blkdev="$(losetup -f --show "$(_nvme_def_file_path)")"
+		else
+			blkdev="$(_nvme_def_file_path)"
+		fi
+	fi
+
+	ARGS=(--subsysnqn "${subsysnqn}")
+	if [[ -n "${blkdev}" ]]; then
+		ARGS+=(--blkdev "${blkdev}")
+	fi
+	if [[ -n "${subsys_uuid}" ]]; then
+		ARGS+=(--uuid "${subsys_uuid}")
+	fi
+	if [[ -n "${resv_enable}" ]]; then
+		ARGS+=("${resv_enable}")
+	fi
+	_create_nvmet_subsystem "${ARGS[@]}"
+
+	port="$(_create_nvmet_port)"
+	_add_nvmet_subsys_to_port "${port}" "${subsysnqn}"
+	_create_nvmet_host "${subsysnqn}" "${def_hostnqn}" \
+			"${hostkey}" "${ctrlkey}"
+}
+
 _nvmet_target_cleanup() {
 	local ports
 	local port
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 05f9192..d63afd1 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -317,77 +317,6 @@ _find_nvme_passthru_loop_dev() {
 	echo "/dev/${dev}n${nsid}"
 }
 
-_nvmet_target_setup() {
-	local blkdev_type="${nvmet_blkdev_type}"
-	local blkdev
-	local ctrlkey=""
-	local hostkey=""
-	local subsysnqn="${def_subsysnqn}"
-	local subsys_uuid
-	local port
-	local resv_enable=""
-	local -a ARGS
-
-	while [[ $# -gt 0 ]]; do
-		case $1 in
-			--blkdev)
-				blkdev_type="$2"
-				shift 2
-				;;
-			--ctrlkey)
-				ctrlkey="$2"
-				shift 2
-				;;
-			--hostkey)
-				hostkey="$2"
-				shift 2
-				;;
-			--subsysnqn)
-				subsysnqn="$2"
-				shift 2
-				;;
-			--subsys-uuid)
-				subsys_uuid="$2"
-				shift 2
-				;;
-			--resv_enable)
-				resv_enable="--resv_enable"
-				shift 1
-				;;
-			*)
-				echo "WARNING: unknown argument: $1"
-				shift
-				;;
-		esac
-	done
-
-	if [[ "${blkdev_type}" != "none" ]]; then
-		truncate -s "${NVME_IMG_SIZE}" "$(_nvme_def_file_path)"
-		if [[ "${blkdev_type}" == "device" ]]; then
-			blkdev="$(losetup -f --show "$(_nvme_def_file_path)")"
-		else
-			blkdev="$(_nvme_def_file_path)"
-		fi
-	fi
-
-	ARGS=(--subsysnqn "${subsysnqn}")
-	if [[ -n "${blkdev}" ]]; then
-		ARGS+=(--blkdev "${blkdev}")
-	fi
-	if [[ -n "${subsys_uuid}" ]]; then
-		ARGS+=(--uuid "${subsys_uuid}")
-	fi
-	if [[ -n "${resv_enable}" ]]; then
-		ARGS+=("${resv_enable}")
-	fi
-	_create_nvmet_subsystem "${ARGS[@]}"
-
-	port="$(_create_nvmet_port)"
-	_add_nvmet_subsys_to_port "${port}" "${subsysnqn}"
-	_create_nvmet_host "${subsysnqn}" "${def_hostnqn}" \
-			"${hostkey}" "${ctrlkey}"
-}
-
 _nvmet_passthru_target_setup() {
 	local subsysnqn="$def_subsysnqn"
 	local port
-- 
2.47.0


