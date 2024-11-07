Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A573D43349
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Nov 2024 11:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=No+d3OnOnLKoAjKJQvZusp8YK519SNgznle8DCDx95g=; b=pPz5+LRVx1bLTxgBxJMpR/D76O
	EkKcjDGmToe2P4IGuOjQmZwX7+PsDEK57Y2ombs0y/55xKRw7kgN2GuhZUqN5EwlDsr3iHHCP4I1U
	NH3v4bhDyJwaBIdpBwaK2dZmib1Q4sbkmI6KcfMhecq5QZH5Z2RKjFtsdDUeCxJPzZydCtcLOlHTf
	nQwXFeJBUumGzbY6VxZuuV4AdtWe5PptPb0lcQdyFRlTXWz4fPp5stgpu7Ma/NWew9371vRGQAx/m
	VoH7C0JvQwkvohh/w6i2UGzGakPquIr+5s9HlQZgsQJMxL9yUOpQUO0SgiwOTWfOoeScdIiWMAVZ0
	M050WMjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t90Ss-00000006e59-1sLe;
	Thu, 07 Nov 2024 11:14:14 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t90Sg-00000006drt-2FlO
	for linux-nvme@lists.infradead.org;
	Thu, 07 Nov 2024 11:14:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1730978042; x=1762514042;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KIGEgp+msM/oSXBxbuP8M7uCM8Vy7lithC5VYltVTPE=;
  b=VgwHs20OJ8SB4UQ+UfRlVt/eOtXSOSm8gai9O+hiSpfRVI+cLDO5iysd
   Yu7AZ9Qg1gdsCvOPCwCShpwcesHWyuNWiQaERncbwEwC6J4GSJYAC3sYL
   EQH2flDIjgkPh/7KRJiHFTCNHPbMptSCG6WK8zxUifc7Xepy4Hqe956lI
   3W+KL8o4s8IjgERAEf+3Vo9HxnAqiPRMud9nCzwflaIEelKYXDD4Tj+sI
   J4lw1HSZTgaipYoRBkvvILnXGTOmlbyhazvF0WipD+PdoTvQxWopaj2kA
   pMZDXmZI2YnzAlkffKAEsVXp0YL7AMd8WSM8lY6nKDXJZ26Qxei3bk6if
   A==;
X-CSE-ConnectionGUID: yFLZAFDXQaSmT9vMbCIeaA==
X-CSE-MsgGUID: jw9a4RgNRE2w6wtEN3USbw==
X-IronPort-AV: E=Sophos;i="6.11,265,1725292800"; 
   d="scan'208";a="30851685"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Nov 2024 19:14:01 +0800
IronPort-SDR: 672c93c1_yp/BcM1/P9lvJju78fIO2XqKGzGh+enYMAeV7KKJghfJMUa
 lzXmapT+7SRkwQ6HHeDRO8BJoeize7ZykkuHTfA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Nov 2024 02:17:37 -0800
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Nov 2024 03:14:01 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 7/8] nvme: rework fcloop
Date: Thu,  7 Nov 2024 20:13:53 +0900
Message-ID: <20241107111354.80606-8-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241107111354.80606-1-shinichiro.kawasaki@wdc.com>
References: <20241107111354.80606-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241107_031402_723626_CF75513C 
X-CRM114-Status: GOOD (  12.63  )
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

Rework fcloop handling to create only one local port but several
remote ports. That way we can keep the global setting for local port
addresses and don't need to worry about passing the correct local
port address when calling 'nvme connect'.

Signed-off-by: Hannes Reinecke <hare@suse.de>
[Shin'ichiro: used wwnn/wwpn helper functions]
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/nvme | 66 +++++++++++++++--------------------------------------
 1 file changed, 19 insertions(+), 47 deletions(-)

diff --git a/common/nvme b/common/nvme
index 832e879..1190de7 100644
--- a/common/nvme
+++ b/common/nvme
@@ -83,18 +83,6 @@ _nvme_fcloop_add_tport() {
 	echo "wwnn=${wwnn},wwpn=${wwpn}" > ${loopctl}/add_target_port
 }
 
-_setup_fcloop() {
-	local local_wwnn="${1:-$def_local_wwnn}"
-	local local_wwpn="${2:-$def_local_wwpn}"
-	local remote_wwnn="${3:-$def_remote_wwnn}"
-	local remote_wwpn="${4:-$def_remote_wwpn}"
-
-	_nvme_fcloop_add_tport "${remote_wwnn}" "${remote_wwpn}"
-	_nvme_fcloop_add_lport "${local_wwnn}" "${local_wwpn}"
-	_nvme_fcloop_add_rport "${local_wwnn}" "${local_wwpn}" \
-		               "${remote_wwnn}" "${remote_wwpn}"
-}
-
 _nvme_fcloop_del_rport() {
 	local local_wwnn="$1"
 	local local_wwpn="$2"
@@ -130,18 +118,6 @@ _nvme_fcloop_del_tport() {
 	echo "wwnn=${wwnn},wwpn=${wwpn}" > "${loopctl}/del_target_port"
 }
 
-_cleanup_fcloop() {
-	local local_wwnn="${1:-$def_local_wwnn}"
-	local local_wwpn="${2:-$def_local_wwpn}"
-	local remote_wwnn="${3:-$def_remote_wwnn}"
-	local remote_wwpn="${4:-$def_remote_wwpn}"
-
-	_nvme_fcloop_del_tport "${remote_wwnn}" "${remote_wwpn}"
-	_nvme_fcloop_del_lport "${local_wwnn}" "${local_wwpn}"
-	_nvme_fcloop_del_rport "${local_wwnn}" "${local_wwpn}" \
-			       "${remote_wwnn}" "${remote_wwpn}"
-}
-
 _cleanup_blkdev() {
 	local blkdev
 	local dev
@@ -185,10 +161,12 @@ _cleanup_nvmet() {
 		name=$(basename "${port}")
 		echo "WARNING: Test did not clean up port: ${name}"
 		if [[ "${nvme_trtype}" == "fc" ]]; then
-			_cleanup_fcloop "$(_local_wwnn "$port")" \
-					"$(_local_wwpn "$port")" \
-					"$(_remote_wwnn "$port")" \
-					"$(_remote_wwpn "$port")"
+			_nvme_fcloop_del_rport "$(_local_wwnn "$name")" \
+					       "$(_local_wwpn "$name")" \
+					       "$(_remote_wwnn "$name")" \
+					       "$(_remote_wwpn "$name")"
+			_nvme_fcloop_del_tport "$(_remote_wwnn "$name")" \
+					       "$(_remote_wwpn "$name")"
 		fi
 		rm -f "${port}"/subsystems/*
 		rmdir "${port}"
@@ -213,6 +191,7 @@ _cleanup_nvmet() {
 	trap SIGINT
 
 	if [[ "${nvme_trtype}" == "fc" ]]; then
+		_nvme_fcloop_del_lport "${def_local_wwnn}" "${def_local_wwpn}"
 		modprobe -rq nvme-fcloop 2>/dev/null
 	fi
 	modprobe -rq nvme-"${nvme_trtype}" 2>/dev/null
@@ -253,6 +232,7 @@ _setup_nvmet() {
 	fi
 	if [[ "${nvme_trtype}" = "fc" ]]; then
 		modprobe -q nvme-fcloop
+		_nvme_fcloop_add_lport "${def_local_wwnn}" "${def_local_wwpn}"
 	fi
 }
 
@@ -429,18 +409,6 @@ _nvme_ctrl_ready() {
 	return 1
 }
 
-_local_wwnn() {
-	local -i port=${1}
-
-	printf "0x%08x" $(( def_local_wwnn + port ))
-}
-
-_local_wwpn() {
-	local -i port=${1}
-
-	printf "0x%08x" $(( def_local_wwpn + port ))
-}
-
 _remote_wwnn() {
 	local -i port=${1}
 
@@ -458,7 +426,7 @@ _fc_traddr() {
 }
 
 _fc_host_traddr() {
-	printf "nn-%s:pn-%s" "$(_local_wwnn "$1")" "$(_local_wwpn "$1")"
+	printf "nn-%s:pn-%s" "$def_local_wwnn" "$def_local_wwpn"
 }
 
 _create_nvmet_port() {
@@ -483,8 +451,11 @@ _create_nvmet_port() {
 		traddr="${port}"
 		adrfam="loop"
 	elif [[ "${trtype}" == "fc" ]]; then
-		_setup_fcloop "$(_local_wwnn $port)" "$(_local_wwpn $port)" \
-			      "$(_remote_wwnn $port)" "$(_remote_wwpn $port)"
+		_nvme_fcloop_add_tport "$(_remote_wwnn $port)" \
+				       "$(_remote_wwpn $port)"
+		_nvme_fcloop_add_rport "$def_local_wwnn" "$def_local_wwpn" \
+				       "$(_remote_wwnn $port)" \
+				       "$(_remote_wwpn $port)"
 		traddr=$(_fc_traddr $port)
 		adrfam="fc"
 	fi
@@ -503,10 +474,11 @@ _remove_nvmet_port() {
 	local port="$1"
 
 	if [[ "${nvme_trtype}" == "fc" ]]; then
-		_cleanup_fcloop "$(_local_wwnn "$port")" \
-				"$(_local_wwpn "$port")" \
-				"$(_remote_wwnn "$port")" \
-				"$(_remote_wwpn "$port")"
+		_nvme_fcloop_del_tport "$(_remote_wwnn "$port")" \
+				       "$(_remote_wwpn "$port")"
+		_nvme_fcloop_del_rport "$def_local_wwnn" "$def_local_wwpn" \
+				       "$(_remote_wwnn "$port")" \
+				       "$(_remote_wwpn "$port")"
 	fi
 	rmdir "${NVMET_CFS}/ports/${port}"
 }
-- 
2.47.0


