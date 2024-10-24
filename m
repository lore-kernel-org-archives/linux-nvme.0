Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 912D9D0BB4B
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Oct 2024 01:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xTQKcEBnMIdp5qpKly8qLlYLsFp5Z2AY88kZI6gAyoY=; b=EfervljaBPDsLpUWRSG0WFTxNJ
	kQBvOBi0BwFDRGvClv7BEZjSQhU6V3j1UE658KqVlcQc686DgM62/an2jSknk/YO1ykufcXOuAF0a
	DVWt3n+S39xl/K4pmWWLf1eegc5h/h/VmuLXWbMTrvKOXwfXuhSUCkfarlVB2S00+uU1btx/M2tyn
	+pF25LhABNi4dXiGCYCqe+3Y/A9cUv7+71BL5Y84EUt9wE0xrMb1vsuQEtOe/3AATYYa2M0HNi6pI
	CisUYADZTH3VePAeuOZVXt3vQjayBI0/d1CiTfbQOKOsxtc16kMA5hEBbtLzVGzcVCsBiXO86Ym3I
	eTzh4qyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3mDY-0000000GMkp-2Vb5;
	Thu, 24 Oct 2024 01:00:48 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3mDM-0000000GMX3-2Oqn
	for linux-nvme@lists.infradead.org;
	Thu, 24 Oct 2024 01:00:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1729731636; x=1761267636;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LYEsR40PlMLSt+lakabWDrXVHcPP5d87r8cRLBUeVFk=;
  b=qlwacR6wQteeS8FZdS5krc9QQzIA7w3zS2tQpkraX/0/tB/7F7MB6yYn
   kphhXdazO2sh2TDMLMYtPrNwHkPsF5JNqAWnBP7a333v6aWgqn6PN1mOX
   XjUqrwz754gu2EyHMn2lBfG7LSU46ghs6smWb7S7w68LKyyFBpBBa75JQ
   Jypo7A2J7H09gl6XhlMtNBqJI00jOvNdw2NvZUfR1Q9vhTOGRNWsiPKqo
   2pRsA0jQMG0sITZ9UpcwWQoqiXW0tpXmPjGtdDGmL1OYK0FusUB+1Ywgs
   ZsS3X6FvmpjKgNBrpBzCAFA84HWuXGZyRT3HShu6OOp7+lZQnhEH8e8Sk
   A==;
X-CSE-ConnectionGUID: 7ooUTpy4Q52ORAk2Fg3z9A==
X-CSE-MsgGUID: St/e0bm/Q8eKXxlPEpnD5w==
X-IronPort-AV: E=Sophos;i="6.11,227,1725292800"; 
   d="scan'208";a="30211135"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Oct 2024 09:00:34 +0800
IronPort-SDR: 67198f1a_wqbCoBPzQ4NxLkb6AjsFT35mob2a0vDs4e4Lmbiwtg8MEKV
 EuLTSUiXK5ioKwFcuMdfkmVJ/yrq8hFzeUNUZVA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Oct 2024 17:04:42 -0700
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 Oct 2024 18:00:34 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 09/15] nvme: check for controller device in _nvme_connect_subsys()
Date: Thu, 24 Oct 2024 10:00:19 +0900
Message-ID: <20241024010025.2216242-10-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241024010025.2216242-1-shinichiro.kawasaki@wdc.com>
References: <20241024010025.2216242-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241023_180036_738143_2CDC1D5F 
X-CRM114-Status: GOOD (  12.61  )
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

When calling 'nvme connect' we cannot assume that a namespace is
always present (eg if connecting to a discovery service), so better
check for the controller device to ensure that 'nvme connect' has
succeeded.

Signed-off-by: Hannes Reinecke <hare@suse.de>
[Shin'ichiro: fixed _nvme_connect_subsys() return for no_wait case]
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/nvme | 37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/common/nvme b/common/nvme
index 758df33..fa64ad4 100644
--- a/common/nvme
+++ b/common/nvme
@@ -373,17 +373,20 @@ _nvme_connect_subsys() {
 	if [[ -n "${ctrl_loss_tmo}" ]]; then
 		ARGS+=(--ctrl-loss-tmo="${ctrl_loss_tmo}")
 	fi
+	ARGS+=(-o json)
+	connect=$(nvme connect "${ARGS[@]}" 2> /dev/null)
 
-	nvme connect "${ARGS[@]}" 2> /dev/null | grep -v "connecting to device:"
-
-	# Wait until device file and uuid/wwid sysfs attributes get ready for
-	# all namespaces.
+	# Wait until device file and sysfs attributes get ready
 	if [[ ${no_wait} = false ]]; then
+		local ctrldev
+
+		ctrldev=$(echo "${connect}"  | sed -n 's/.*device.:.\(nvme[0-9]*\)./\1/p')
 		udevadm settle
 		for ((i = 0; i < 10; i++)); do
-			_nvme_ns_ready "${subsysnqn}" && return
+			_nvme_ctrl_ready "${ctrldev}" "${subsysnqn}" && return 0
 			sleep .1
 		done
+		return 1
 	fi
 }
 
@@ -408,21 +411,17 @@ _nvme_disconnect_subsys() {
 }
 
 
-_nvme_ns_ready() {
-	local subsysnqn="${1}"
-	local ns_path ns_id dev
-	local cfs_path="${NVMET_CFS}/subsystems/$subsysnqn"
+_nvme_ctrl_ready() {
+	local ctrldev="${1}"
+	local subsysnqn="${2:-$def_subsysnqn}"
+	local ctrlpath="/sys/class/nvme/${ctrldev}"
 
-	dev=$(_find_nvme_dev "$subsysnqn")
-	for ns_path in "${cfs_path}/namespaces/"*; do
-		ns_id=${ns_path##*/}
-		if [[ ! -b /dev/${dev}n${ns_id} ||
-			   ! -e /sys/block/${dev}n${ns_id}/uuid ||
-			   ! -e /sys/block/${dev}n${ns_id}/wwid ]]; then
-			return 1
-		fi
-	done
-	return 0
+	nqn=$(cat "${ctrlpath}/subsysnqn" 2> /dev/null)
+	if [[ "${nqn}" == "${subsysnqn}" &&
+		      -c /dev/${ctrldev} ]]; then
+		return 0
+	fi
+	return 1
 }
 
 _local_wwnn() {
-- 
2.45.2


