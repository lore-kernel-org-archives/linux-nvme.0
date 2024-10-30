Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 489BCD7497B
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2024 06:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SrENtZy8Q0VcC5xFYq0YGaHZ4cCX5929VuDsSnAO6Q0=; b=CTKFn3vqBZ8RHIyiVGZU1Qf7xh
	aE1K4l/ZG/BayqmCBkMLDuJiqRzyEs/nthOJWFZL5iAyRbZWpmkDbwd8h2vzIy2sG6d7Fd65Rs+6q
	cndReo2pzogualbdD4qBHqS6UT7hNQ6xcGoXIiAy6D9oIa6vyRvwxmZZkt/P/WXn7Fs5RJpXnR1y7
	7nPaPbwqob6dSuEGfLLHwfeX+0E3qKB6/bCD7jx/7fIiGHMQDzN7fN9FcVclnPv84Z12MLaDP5tGX
	1py/PAonLvZLBtNLkgdpUUHho0BVAiE6f+49aGZ8vfCGWxFOJ5Q46oCJW4DedwVsVMXFsnpkAD6Ng
	3NhYEcyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t62Yj-0000000H2G7-1qkf;
	Wed, 30 Oct 2024 06:52:01 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t62Yd-0000000H2AZ-3Uh7
	for linux-nvme@lists.infradead.org;
	Wed, 30 Oct 2024 06:51:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1730271115; x=1761807115;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Lzh4LLwPTlyn088hxc+I//c5LvrVPAKNPxvI+aIP+dk=;
  b=rKa7UIn8M5P7Y5nz0c/EKu3Rfcl520QXiD/xYuLD1UUudDC7GPMu035C
   6E9r99YeN/Hfqr5vmpQZ3omCf8JuxksdQK5+725ClHxyLSTG3zmT0CfQP
   emG4QCB8/C7ecyWtY8x6lqWIu4QLwDTG8ucMnDtylQHe9IqxUq9FjBCw1
   KNfNrU26wi7mMOjrQs/mZML2mCmDd7W+GpqA5NR2bwbRC/qO3lvNpJOmf
   roo9QSYYeC2gtbaqVTk3LwCQ/o3pxEyHOFwW6pu1cYLF0IUQ+bua+h6Co
   dZZqcAU0mzmp0J1oh//BZ6ymWThw3sBm3QoZpe81LQ8PtJZNoFluW49e3
   A==;
X-CSE-ConnectionGUID: C8WX10IeTe2ZsvRHteuAUA==
X-CSE-MsgGUID: UpMa+QUpSRCdHWBA8wJkhA==
X-IronPort-AV: E=Sophos;i="6.11,244,1725292800"; 
   d="scan'208";a="31314337"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2024 14:51:54 +0800
IronPort-SDR: 6721ca5c_Qr5/uzU0iWlaK7hmKQmjVXbW3CLGvVFT4jH5mE/LBfghJIK
 YCBygUTUfa7aj9k2VDcisZ6bw38QElLSste91qg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Oct 2024 22:55:40 -0700
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 Oct 2024 23:51:54 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v2 04/13] nvme: introduce wwnn/wwpn helper functions
Date: Wed, 30 Oct 2024 15:51:40 +0900
Message-ID: <20241030065149.2297405-5-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241030065149.2297405-1-shinichiro.kawasaki@wdc.com>
References: <20241030065149.2297405-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_235155_900727_6740994E 
X-CRM114-Status: GOOD (  11.51  )
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

Commit "nvme: sanitize transport parameter in _create_nvmet_port()"
modified the wwnn and wwpn names for fc transport to calculate from the
port ID. It also moved the timing to set the global variable
def_host_traddr based on the wwnn and wwpn from _setup_nvmet() to
_create_nvmet_port(). This move made _nvme_connect_subsys() fail
to refer to the def_host_traddr variable, and caused nvme/003 test case
failure.

To avoid the failure, do the wwnn and wwpn calculations both in
_create_nvmet_port() and _nvme_connect_subsys(). Introduce helper
functions to calculate wwnn and wwpn.

Reviewed-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/nvme | 63 +++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 44 insertions(+), 19 deletions(-)

diff --git a/common/nvme b/common/nvme
index 46dfb51..3e388c2 100644
--- a/common/nvme
+++ b/common/nvme
@@ -331,7 +331,15 @@ _nvme_connect_subsys() {
 
 	ARGS=(--transport "${nvme_trtype}" --nqn "${subsysnqn}")
 	if [[ "${nvme_trtype}" == "fc" ]] ; then
-		ARGS+=(--traddr "${def_traddr}" --host-traddr "${def_host_traddr}")
+		local ports
+		_get_nvmet_ports "${subsysnqn}" ports
+		if ((${#ports[@]} != 1)); then
+			echo only one port is supported at this moment...
+			exit 1
+		fi
+		local port=${ports[0]}
+		ARGS+=(--traddr "$(_fc_traddr "$port")")
+		ARGS+=(--host-traddr "$(_fc_host_traddr "$port")")
 	elif [[ "${nvme_trtype}" != "loop" ]]; then
 		ARGS+=(--traddr "${def_traddr}" --trsvcid "${def_trsvcid}")
 	fi
@@ -413,6 +421,38 @@ _nvme_ns_ready() {
 	return 0
 }
 
+_local_wwnn() {
+	local -i port=${1}
+
+	printf "0x%08x" $(( def_local_wwnn + port ))
+}
+
+_local_wwpn() {
+	local -i port=${1}
+
+	printf "0x%08x" $(( def_local_wwpn + port ))
+}
+
+_remote_wwnn() {
+	local -i port=${1}
+
+	printf "0x%08x" $(( def_remote_wwnn + port ))
+}
+
+_remote_wwpn() {
+	local -i port=${1}
+
+	printf "0x%08x" $(( def_remote_wwpn + port ))
+}
+
+_fc_traddr() {
+	printf "nn-%s:pn-%s" "$(_remote_wwnn "$1")" "$(_remote_wwpn "$1")"
+}
+
+_fc_host_traddr() {
+	printf "nn-%s:pn-%s" "$(_local_wwnn "$1")" "$(_local_wwpn "$1")"
+}
+
 _create_nvmet_port() {
 	local trtype="${1:-$nvme_trtype}"
 	local traddr="${2:-$def_traddr}"
@@ -435,24 +475,9 @@ _create_nvmet_port() {
 		traddr="${port}"
 		adrfam="loop"
 	elif [[ "${trtype}" == "fc" ]]; then
-		local local_wwnn
-		local local_wwpn
-		local remote_wwnn
-		local remote_wwpn
-
-		local_wwnn=$(printf "0x%08x" $(( def_local_wwnn + port )) )
-		local_wwpn=$(printf "0x%08x" $(( def_local_wwpn + port )) )
-		remote_wwnn=$(printf "0x%08x" $(( def_remote_wwnn + port )) )
-		remote_wwpn=$(printf "0x%08x" $(( def_remote_wwpn + port )) )
-		_setup_fcloop "${local_wwnn}" "${local_wwpn}" \
-			      "${remote_wwnn}" "${remote_wwpn}"
-
-		traddr=$(printf "nn-%s:pn-%s" \
-				"${remote_wwnn}" \
-				"${remote_wwpn}")
-		def_host_traddr=$(printf "nn-%s:pn-%s" \
-					 "${local_wwnn}" \
-					 "${local_wwpn}")
+		_setup_fcloop "$(_local_wwnn $port)" "$(_local_wwpn $port)" \
+			      "$(_remote_wwnn $port)" "$(_remote_wwpn $port)"
+		traddr=$(_fc_traddr $port)
 		adrfam="fc"
 	fi
 	echo "${trtype}" > "${portcfs}/addr_trtype"
-- 
2.45.2


