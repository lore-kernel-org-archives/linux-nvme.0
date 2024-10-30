Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3257D7497A
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2024 06:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a4gk41uycnebZcV26LUgmvZtq5NVTTROU333aFx3HHE=; b=tfMmvhbCm530QKaNpzT9eanweZ
	o2P/V/lkpuxr2Ws6HKDmLHWWgQcQWqcNsZF/oYLpEcdKY/GARhzkXycABcWGM8d7nfjSkU4rPzh13
	/DNgs3lGrDAjYyh9SDX146Noottz4lVqJhCzppTncNSiGbWlh+OMXnT91MzDvA99S0PgDCDXf/Zg0
	VH/GbKShDgh5es2JT5zRWolBVSdeQxlorKd0WsnSLDP3yvB9SF/RfjNfxVg1Fk9P+LMxItM6xazBR
	ZOQT8OZDEH4vMBcKE7IF3bILtaHChlzCIsu1Y1fIdAwttQaLhQbwvL0YIvv1RXo1tV1mdoHmXT0DF
	jsYwaLUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t62Yw-0000000H2P5-1hlg;
	Wed, 30 Oct 2024 06:52:14 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t62Yg-0000000H2AZ-450G
	for linux-nvme@lists.infradead.org;
	Wed, 30 Oct 2024 06:52:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1730271118; x=1761807118;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3Aa1DY407rky4QY4yZx+8MBJO22V6VajHus4TVSVkCQ=;
  b=jN04+o310Ujy/imdLKvUOLckJFrs56czGfL+JJz5wurcowPKLds+ymC4
   t4WWa4L5TB/z0vxQJq5sKiDZpOQJvBf0vm73v6VGlHG7Mqg65jMiTwTQo
   oSTwhJBmYpq7ETNlLwpMtTfdByDyf/Ihjh3VtFrixoOoZYk06EY2U9VA6
   9iu65G1R6TLgO8CJ1GZYWblOzW+FPVtlbAkSKIEF2Fhfk9vlAZJk4tCzs
   gS/KJ/B7okIPE5Pn8nfSFM6lA2fl1YUciE1k+p/QOXxMYTCqJfHm69ut/
   Ur0ApbivIfTbr9oCqFv8X1HQ6/B6DjgSJtTvtEIUnEZQQ0+U7XrDUJfUz
   A==;
X-CSE-ConnectionGUID: LVndjtPVTWupmyuET9KyxA==
X-CSE-MsgGUID: 0I+P3wn/Rwi0zOMUVRVflg==
X-IronPort-AV: E=Sophos;i="6.11,244,1725292800"; 
   d="scan'208";a="31314346"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2024 14:51:58 +0800
IronPort-SDR: 6721ca60_mymIVDXVS6BEFYpMSzVZOgUjIYi7yMic6h3ezHKkxburCk3
 KE+UL8McPd1CwrNCMI+yIppxCQ68Af5U/fIWR/Q==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Oct 2024 22:55:44 -0700
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 Oct 2024 23:51:59 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v2 09/13] nvme: check for controller device in _nvme_connect_subsys()
Date: Wed, 30 Oct 2024 15:51:45 +0900
Message-ID: <20241030065149.2297405-10-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241030065149.2297405-1-shinichiro.kawasaki@wdc.com>
References: <20241030065149.2297405-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_235159_043631_23E80DDB 
X-CRM114-Status: GOOD (  13.28  )
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
Reviewed-by: Daniel Wagner <dwagner@suse.de>
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


