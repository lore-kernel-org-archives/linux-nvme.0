Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0402ED0BB4A
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Oct 2024 01:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8wd8eKjFqzoicymWv8yTVbNtMyOXSfpPi7bzcRcV+Fc=; b=mNhKwHcBEVImhzAgjuvCmn4vKk
	JzFrGV0wdWVPuHrYSBzHUFCILOOOHGzGa3i5C6FiL0Ww4c4TADWBBw+lCl4kY4Qlm9raydxIm5YkL
	bvA/m/fyYmda1X6Uvq/gE55TFFVBRbl5+vzn6E6mHvj76g3H/DWfqKcU4pAY+lvrDKWwnOXFnCXAG
	5WuSRZd930bGZl+HViPLUuiJAAruisCG90GtUF3pWp0myR6y5mACtYggDqRVLCFkjrFZpW76OUuuX
	SPWLca1+cHNiW0NU8MoiDZVdnZuO+IMtjJoZ98jtMNYrlmP9CuvfYTKnCto6H8axwkFBHYcgyRcWE
	31Oco0pw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3mDQ-0000000GMdy-042W;
	Thu, 24 Oct 2024 01:00:40 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3mDJ-0000000GMWc-36fn
	for linux-nvme@lists.infradead.org;
	Thu, 24 Oct 2024 01:00:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1729731633; x=1761267633;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bAN0vmP7zi9ejcDiVX/60yub2WgLWd1MMuCgqfC4GCo=;
  b=g+IiS/kllE3sz+1mpUxNsmXWFuWop+yRg+La7iUaJm0iezofjhQXaAbh
   FVwb4MPdwtderVXTAaRarZUm9KKOVxwXJull1zovZIN8bLsQ1Y37jqMaH
   jiFktQH2QmoxIEX08ArgVgTRk/DvLehdowA2ja4q/utAagVQ1X63I33F0
   8GGQEFrQQYFyjyHgYv6q5bjEJEqIPNlIHqiVLviPtOb5KfYTwwxOx02ZJ
   TFFRx2421BI3Enu2nBgfzVmdY3z6jKi/2OQsHUwKUyRBSxwynUdhV0QEp
   8uXp1zBowiQV3Nlfky1DWtM0sjpYiVq+hrOzt/E4oDZUtWHDcVHN1SdHD
   A==;
X-CSE-ConnectionGUID: mzU7JJ3AT1qgxo+2Io3WBg==
X-CSE-MsgGUID: RYrKzJeTS9GUTRx0eCCCTg==
X-IronPort-AV: E=Sophos;i="6.11,227,1725292800"; 
   d="scan'208";a="30211087"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Oct 2024 09:00:29 +0800
IronPort-SDR: 67198f15_YcpYeYy9oq2xuO+0yeLJHppboIkQdV+rv9Xd5ygh/JXgUNT
 lV5EMs/T1s4NfvmstHOl3S08A7ImFjnlcUaHDZw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Oct 2024 17:04:38 -0700
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 Oct 2024 18:00:29 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 04/15] nvme: introduce wwnn/wwpn helper functions
Date: Thu, 24 Oct 2024 10:00:14 +0900
Message-ID: <20241024010025.2216242-5-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241024010025.2216242-1-shinichiro.kawasaki@wdc.com>
References: <20241024010025.2216242-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241023_180033_865079_48A12969 
X-CRM114-Status: GOOD (  10.90  )
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


