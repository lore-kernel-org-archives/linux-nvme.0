Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE4BDD74978
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2024 06:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/BrxfpWF/TJdGVJKtDSTI9j4NR7aYw1Qx8HMw4XwrN4=; b=cD5YYRtc8FgUyUCPWx+8JgiTcD
	RVRDkuTPASBlHKFSdH4vWaN3Ib5NrgNAD10GLLf1uWGwc8LS8CkgdOYBqJS747GqFtKRId6eMUfJf
	0KuzVfhT7puNXdzMEKGFeBxpoxaHqu4Wh9HGwzNeAu0vN+xgLIea+++2lICGneP7xPGQhjMx91ONx
	toGDtT4n9I7L09Pn08b43pm9htxo9ZeE7TNTsl9MVtp+e5XJ4bMHOJB0XlpM3Egr00TAyxK7x6YjK
	F8st1lcjJVOuKBR53q6fAwMSwNyoQgQKmUzEUYZEic/NGjgbTqX8nJUaPGLI7txk8dLcNJIhq9yFL
	FAoSmXpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t62Yz-0000000H2Rh-2UOV;
	Wed, 30 Oct 2024 06:52:17 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t62Yh-0000000H2Dc-3Xc4
	for linux-nvme@lists.infradead.org;
	Wed, 30 Oct 2024 06:52:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1730271119; x=1761807119;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g/cSmU+b2W/XYDGg0C/m76qtdUdOwBlcbIvVs26CA/g=;
  b=TPmNnk7sWaH8l/3nbFqS9tTuLnnwtzs/xEbJVdyNGU/Lo2eFOtc6pl/p
   2EckvZYdbNFHNuOhegoqBsnnA8lwm703qFDKO2c0gMp+FPUqW1J5QlOBL
   zm9OYZo6lTTPEGznB9US9gMWtRceMbdF/gsTz2Gq5Cea4kp8PhqG/Er8r
   oQM/UNNS5MEO27P+mKk0DeAafYerZZPxnq/QViZvupiXjB+iPU3JHa9tB
   1efVGA8jG18rulcF8xQo5v2UCsW256no0nwG93KyFKII7FfqhllnFXgC7
   pBCqi+EjO25eLooJQItfFm8YMUHAiCSKbCLadqsbaMqw8L5jfDU26I+ZL
   w==;
X-CSE-ConnectionGUID: T1QRdFhySR2V0HFoOqsP+Q==
X-CSE-MsgGUID: 9fSgwUBqS5Cylk2+2EL6Dg==
X-IronPort-AV: E=Sophos;i="6.11,244,1725292800"; 
   d="scan'208";a="31314347"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2024 14:51:59 +0800
IronPort-SDR: 6721ca61_MAoOw062jdX9db5aogqw0xjHSGsVTE3IBHPdWrqSPRJTNA7
 zREC6jwoEFFKqh1uOwDEVTeEP0tmM06H/2Nkenw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Oct 2024 22:55:45 -0700
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 Oct 2024 23:52:00 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v2 10/13] nvme: pass in port parameter to _nvme_connect_subsys()
Date: Wed, 30 Oct 2024 15:51:46 +0900
Message-ID: <20241030065149.2297405-11-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241030065149.2297405-1-shinichiro.kawasaki@wdc.com>
References: <20241030065149.2297405-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_235159_947313_E9288F1A 
X-CRM114-Status: GOOD (  13.68  )
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
Reviewed-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/nvme | 46 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 36 insertions(+), 10 deletions(-)

diff --git a/common/nvme b/common/nvme
index fa64ad4..6513205 100644
--- a/common/nvme
+++ b/common/nvme
@@ -274,10 +274,16 @@ _nvme_connect_subsys() {
 	local reconnect_delay=""
 	local ctrl_loss_tmo=""
 	local no_wait=false
+	local port
 	local i
+	local -a ARGS
 
 	while [[ $# -gt 0 ]]; do
 		case $1 in
+			--port)
+				port="$2"
+				shift 2
+				;;
 			--subsysnqn)
 				subsysnqn="$2"
 				shift 2
@@ -333,20 +339,18 @@ _nvme_connect_subsys() {
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
+	_get_nvmet_port_params "${port}" ARGS
+	ARGS+=(--nqn "${subsysnqn}")
 	ARGS+=(--hostnqn="${hostnqn}")
 	ARGS+=(--hostid="${hostid}")
 	if [[ -n "${hostkey}" ]]; then
@@ -682,6 +686,28 @@ _get_nvmet_ports() {
 	done
 }
 
+_get_nvmet_port_params() {
+	local port="$1"
+	local -n args="$2"
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
+}
+
 _find_nvme_dev() {
 	local subsys=$1
 	local subsysnqn
-- 
2.45.2


