Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F58D74978
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2024 06:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3u16hbSU/UY/VQBZo7FJGOhNZX/zvU4T6cTsVq3QfGU=; b=3hArsa+W7/GEQyU085giaDu0RF
	KsB5yUw4Onbgh+EqMLLYOt5bibiRnoJcK4iDDu29VBy8uA1LpbNA4DiAJbiMPc/tU1kO0NYWYZhJr
	tauRcwq1SQ+V861jFslUDvvAo/rkfatQscdnf8qIZSA18Jp+Y0LszMvn2XDp+yht5ip7P8ZwJ0y+R
	JrtFaQINsinypmQAtIp9nBPrekjzR1+gEfRrglr9O6UdKSphiNQI5pJYAYVmxn+5WUFv6nRzUx5LR
	J5L/oMH01y8r03hhEZXHRhoxtaZq5M8/vTw4520tUN3ldXDUnN5Q99GK9w0oL8bYj8EYm75EzcKjR
	GZ51yAnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t62Yi-0000000H2FP-2NcD;
	Wed, 30 Oct 2024 06:52:00 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t62Yc-0000000H2Ac-45tt
	for linux-nvme@lists.infradead.org;
	Wed, 30 Oct 2024 06:51:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1730271114; x=1761807114;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3t4FqDEaWPdUuIqRv977bSksEwnOu2xajGtjd4UNHu4=;
  b=DjiuUBbWNz6xN9clX51rfTCzrMz/6VJ5vGfFc9pVBcnSChft7VAykkJg
   dABGCzV8zEuKTnTiI0wCjaU90BUMGYF+3WgBXyWtserrOdOFzgBE/5v3b
   0qFe8Wk+C66y/bE7LMrkU5xRVJGPELkSch56JHtL49Z06H4OpoNn3oBr4
   tJxO2el8SQkkweDamFJ8CxmpcE+PRB4FUXAYFIRFe7D9Qv8dYNyxO85J+
   EoIIsHnWXPGH919wR/IDunuh2MbRXe8WM2ZwXtrTBwnxZxLlZ/s4LGjop
   i5eYHrVrsOPJ56t9E0Y/DE6KnKHVurKof5rE7RUq9izGDCooT396lRSs6
   A==;
X-CSE-ConnectionGUID: sGJFWshwS8GZc8E7iI3KTQ==
X-CSE-MsgGUID: poAu+3ppQ0mvhZOVC/bPMw==
X-IronPort-AV: E=Sophos;i="6.11,244,1725292800"; 
   d="scan'208";a="31314335"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2024 14:51:54 +0800
IronPort-SDR: 6721ca5b_plXLIkQQwg3aIJ1Hjoic4HcbTdUPUWHALHEoUM6eUsA/Q49
 kcplroXgrBHvXerce3lZnHQLDoiSsgpNCQBbv+g==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Oct 2024 22:55:39 -0700
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 Oct 2024 23:51:53 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v2 03/13] nvme: sanitize transport parameter in _create_nvmet_port()
Date: Wed, 30 Oct 2024 15:51:39 +0900
Message-ID: <20241030065149.2297405-4-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241030065149.2297405-1-shinichiro.kawasaki@wdc.com>
References: <20241030065149.2297405-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_235155_068391_98C327B2 
X-CRM114-Status: GOOD (  11.11  )
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

We need to sanitize the transport parameters in _create_nvmet_port()
to avoid having invalid transport values when selecting a transport
type. This change allows the function support more than one port.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/nvme | 43 ++++++++++++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 13 deletions(-)

diff --git a/common/nvme b/common/nvme
index 99ff959..46dfb51 100644
--- a/common/nvme
+++ b/common/nvme
@@ -8,10 +8,10 @@
 def_traddr="127.0.0.1"
 def_adrfam="ipv4"
 def_trsvcid="4420"
-def_remote_wwnn="0x10001100aa000001"
-def_remote_wwpn="0x20001100aa000001"
-def_local_wwnn="0x10001100aa000002"
-def_local_wwpn="0x20001100aa000002"
+def_remote_wwnn="0x10001100ab000001"
+def_remote_wwpn="0x20001100ab000001"
+def_local_wwnn="0x10001100aa000001"
+def_local_wwpn="0x20001100aa000001"
 def_hostid="0f01fb42-9f7f-4856-b0b3-51e60b8de349"
 def_hostnqn="nqn.2014-08.org.nvmexpress:uuid:${def_hostid}"
 export def_subsysnqn="blktests-subsystem-1"
@@ -248,15 +248,6 @@ _setup_nvmet() {
 	fi
 	if [[ "${nvme_trtype}" = "fc" ]]; then
 		modprobe -q nvme-fcloop
-		_setup_fcloop "${def_local_wwnn}" "${def_local_wwpn}" \
-			      "${def_remote_wwnn}" "${def_remote_wwpn}"
-
-		def_traddr=$(printf "nn-%s:pn-%s" \
-				    "${def_remote_wwnn}" \
-				    "${def_remote_wwpn}")
-		def_host_traddr=$(printf "nn-%s:pn-%s" \
-					 "${def_local_wwnn}" \
-					 "${def_local_wwpn}")
 	fi
 }
 
@@ -438,6 +429,32 @@ _create_nvmet_port() {
 
 	portcfs="${NVMET_CFS}/ports/${port}"
 	mkdir "${portcfs}"
+	if [[ "${trtype}" == "tcp" ]] || [[ "${trtype}" == "rdma" ]]; then
+		trsvcid=$(printf "%d" $(( trsvcid + port )) )
+	elif [[ "${trtype}" == "loop" ]]; then
+		traddr="${port}"
+		adrfam="loop"
+	elif [[ "${trtype}" == "fc" ]]; then
+		local local_wwnn
+		local local_wwpn
+		local remote_wwnn
+		local remote_wwpn
+
+		local_wwnn=$(printf "0x%08x" $(( def_local_wwnn + port )) )
+		local_wwpn=$(printf "0x%08x" $(( def_local_wwpn + port )) )
+		remote_wwnn=$(printf "0x%08x" $(( def_remote_wwnn + port )) )
+		remote_wwpn=$(printf "0x%08x" $(( def_remote_wwpn + port )) )
+		_setup_fcloop "${local_wwnn}" "${local_wwpn}" \
+			      "${remote_wwnn}" "${remote_wwpn}"
+
+		traddr=$(printf "nn-%s:pn-%s" \
+				"${remote_wwnn}" \
+				"${remote_wwpn}")
+		def_host_traddr=$(printf "nn-%s:pn-%s" \
+					 "${local_wwnn}" \
+					 "${local_wwpn}")
+		adrfam="fc"
+	fi
 	echo "${trtype}" > "${portcfs}/addr_trtype"
 	echo "${traddr}" > "${portcfs}/addr_traddr"
 	echo "${adrfam}" > "${portcfs}/addr_adrfam"
-- 
2.45.2


