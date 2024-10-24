Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D1F9D0BB4C
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Oct 2024 01:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+QRg8qD8al6SVsIR3aZmwQCHESS8KKlWPxybBwo6hwE=; b=Ji7bPNO+VVb5FPL1K018U4XrII
	ta3eqg6bS+p8sOd7nwleaplh4dPxNPfw0ehcrBMLILWqzNePzZx1JK6PY0l54R3wViAmLDwXVQaEW
	/uQFR7mXd47wfu7/3dKt7M4w48lbvugxfz9zBnvMN4B3SS3EcivZ5Xzl1m46NEB2dV3Er51qJdWy3
	+E38CqDxL9bxfUVMNA3xPGb4EPrSmFJcErXi4n8PeroXolUqlULiB5Ni4wtimcLXemAY33F4N5vDf
	JHs1aJz44vJTizqDAMEXS4UGnaapip/RLiyIEj+YDPn7V+rmgv4OEDshDRxcd5YIu5p5iZJbOIDAs
	cw/grm0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3mDZ-0000000GMlw-3LPa;
	Thu, 24 Oct 2024 01:00:49 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3mDN-0000000GMWc-1CEe
	for linux-nvme@lists.infradead.org;
	Thu, 24 Oct 2024 01:00:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1729731637; x=1761267637;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=00n2glHCRGXoGi+0ffsVOHmkWbnjqIr1/wYajYc7fzE=;
  b=Fl812jNCw9PluzgzYMU0tNcfdSwb0ZP2hNmkeVTSsd7SVBDlM9OxCWgJ
   dOkqS/zS2IpCydE0F1skW47L7/GzHE+uTyoFdcaICyoodZtKEVCFdHfuc
   sHU34D66iv3YHQl0qtYVo1lVjJSzPEYw+aHqPHbLbkFIxuY+F9qQCvH5a
   AE37cdRCz6fj9YReaoZMyh/e4zgPD96FfsLlpNSdf+feKANkZQbiWDUkn
   tCeuf/Aqx0lAGr4PtdEZHvJjHUkoL9irJPoeLFKpiS/ycrOo3z0BmDu9m
   1JD/PM3uxb1zqlmH8P/fOtKsID/oyv6/OBCRnE/uBxjqcc1X1RunT+a3R
   g==;
X-CSE-ConnectionGUID: vH6FhPmRTwW5LZI304/Arw==
X-CSE-MsgGUID: sutztSYAQ96Nbg8OFjgTew==
X-IronPort-AV: E=Sophos;i="6.11,227,1725292800"; 
   d="scan'208";a="30211144"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Oct 2024 09:00:35 +0800
IronPort-SDR: 67198f1a_ajXS4+Fj7G0/KnvIGyGXokcxZaVb3uVZ1jA34H3Tz11jIs6
 knrDK0p2cx7+Y93d4t2cm1DpFUE/VpM72suCNBw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Oct 2024 17:04:43 -0700
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 Oct 2024 18:00:34 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 10/15] nvme: pass in port parameter to _nvme_connect_subsys()
Date: Thu, 24 Oct 2024 10:00:20 +0900
Message-ID: <20241024010025.2216242-11-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241024010025.2216242-1-shinichiro.kawasaki@wdc.com>
References: <20241024010025.2216242-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241023_180037_432557_3099B158 
X-CRM114-Status: GOOD (  13.10  )
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

A subsystem might have more than one port, and that port might be
configured differently from the default settings. So rather than
to rely on the default settings we should extract the parameters
from the passed in ports on that subsystem and issue 'nvme connect'
with the extracted parameters.

Signed-off-by: Hannes Reinecke <hare@suse.de>
[Shin'ichiro: fixed conflicts for fc transport]
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/nvme | 47 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 37 insertions(+), 10 deletions(-)

diff --git a/common/nvme b/common/nvme
index fa64ad4..95a05de 100644
--- a/common/nvme
+++ b/common/nvme
@@ -274,10 +274,15 @@ _nvme_connect_subsys() {
 	local reconnect_delay=""
 	local ctrl_loss_tmo=""
 	local no_wait=false
+	local port
 	local i
 
 	while [[ $# -gt 0 ]]; do
 		case $1 in
+			--port)
+				port="$2"
+				shift 2
+				;;
 			--subsysnqn)
 				subsysnqn="$2"
 				shift 2
@@ -333,20 +338,18 @@ _nvme_connect_subsys() {
 		esac
 	done
 
-	ARGS=(--transport "${nvme_trtype}" --nqn "${subsysnqn}")
-	if [[ "${nvme_trtype}" == "fc" ]] ; then
+	if [[ -z "${port}" ]]; then
 		local ports
+
 		_get_nvmet_ports "${subsysnqn}" ports
-		if ((${#ports[@]} != 1)); then
-			echo only one port is supported at this moment...
-			exit 1
+		port="${ports[0]##*/}"
+		if [[ -z "${port}" ]]; then
+			echo "WARNING: no port found"
+			return 1
 		fi
-		local port=${ports[0]}
-		ARGS+=(--traddr "$(_fc_traddr "$port")")
-		ARGS+=(--host-traddr "$(_fc_host_traddr "$port")")
-	elif [[ "${nvme_trtype}" != "loop" ]]; then
-		ARGS+=(--traddr "${def_traddr}" --trsvcid "${def_trsvcid}")
 	fi
+	read -ra ARGS < <(_get_nvmet_port_params "${port}")
+	ARGS+=(--nqn "${subsysnqn}")
 	ARGS+=(--hostnqn="${hostnqn}")
 	ARGS+=(--hostid="${hostid}")
 	if [[ -n "${hostkey}" ]]; then
@@ -682,6 +685,30 @@ _get_nvmet_ports() {
 	done
 }
 
+_get_nvmet_port_params() {
+	local port="$1"
+	local -a args=()
+	local cfs_path="${NVMET_CFS}/ports/${port}"
+	local trtype
+	local traddr
+	local trsvcid
+
+	[[ -d "${cfs_path}" ]] || exit 1
+	trtype=$(cat "${cfs_path}/addr_trtype")
+	args+=(--transport "${trtype}")
+	traddr=$(cat "${cfs_path}/addr_traddr")
+	args+=(--traddr "${traddr}")
+	if [[ "${trtype}" == "tcp" ]] || [[ "${trtype}" == "rdma" ]]; then
+		trsvcid=$(cat "${cfs_path}/addr_trsvcid")
+		args+=(--trsvcid "${trsvcid}")
+	elif [[ "${trtype}" == "fc" ]]; then
+		args+=(--traddr "$(_fc_traddr "$port")")
+		args+=(--host-traddr "$(_fc_host_traddr "$port")")
+	fi
+
+	echo "${args[@]}"
+}
+
 _find_nvme_dev() {
 	local subsys=$1
 	local subsysnqn
-- 
2.45.2


