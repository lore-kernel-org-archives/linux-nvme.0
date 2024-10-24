Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7865DD0BB4D
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Oct 2024 01:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rhKFKLYQZjuU2DWtdlBUnQCXfs63rRgT/aoBhsk0iA0=; b=hMUd8laT+qOKFNdDtc9/1Q4gm7
	ZXDF/pym1KjRKqbLzeSKLh8KpJzu8pxDYr6TrXqP2tQEow8vOSYeUv66fg/zMo/mEWYRXhg8YjtAE
	yGodJMcCU+K3BKtiflYct3aOvyyJQaLu8YmStRAYqUFTm7gLQthR97KMSuHVQrmk3zdxzyd80HvwZ
	fNTndnPno3GajKjKDZfqiS/2uSuxSmESghjT+WQlomoM2b3dzGbqK1Vx/pta/OseU9l2MEN5en3TE
	45GOzbcocsctB5QFLzhRMAqdp3Bv4kOpk+o29dkRHjmx0xSJJYMlUz8zGVcret4pUhElEDgpQadHp
	O5swnqyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3mDO-0000000GMc9-1aVW;
	Thu, 24 Oct 2024 01:00:38 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3mDI-0000000GMX3-42uP
	for linux-nvme@lists.infradead.org;
	Thu, 24 Oct 2024 01:00:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1729731632; x=1761267632;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fbyQ9ZEcZbiI4Hnep/rFn/jhSpPnCn9ZMRMhwVae/rw=;
  b=diFS4i9EDCrJydqYj5F1vqOMPEc/5cJs0gfyGnO7XeuPmSHsQlZkubV3
   fljPRPhTV3hlSTaN4exDXmncgoXxT6kMGMnZkP2BL6E326nZCV+9wKAyE
   yyiiGIDcS544P/VBC9z6XwtTJ21KZDh20OeZet/mFTne14w9J1EKfTqFQ
   DgOSMKF5CwP8u/Wiw+6j9MWj9GktZJnIOIRLiwJlU4/1tRVJy3blCnRW2
   b9hp+PuCjboxtfwqhuIl2kzqMovDp1zycZ+QPRRzXvTsLOlJ1Ozhy4ZoA
   sBbXC0vhcHCCUSvxhui6g1gMglYfSdt7SqDshm4bjc+AN3cumKlMUY+pR
   A==;
X-CSE-ConnectionGUID: v5RgzsKIQsu3hErbq2IXmQ==
X-CSE-MsgGUID: rbx9uEvLRTiHVE/PrBlINw==
X-IronPort-AV: E=Sophos;i="6.11,227,1725292800"; 
   d="scan'208";a="30211084"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Oct 2024 09:00:29 +0800
IronPort-SDR: 67198f14_V7DEtKc95lWL/mYYa4eKGCbHeG/q3ZRlXUF/r2PW5NVZDxF
 hBlmEPccglRxX0ZeyQJEN64Yh41i4ylM5kuiu/Q==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Oct 2024 17:04:37 -0700
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 Oct 2024 18:00:28 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 03/15] nvme: sanitize transport parameter in _create_nvmet_port()
Date: Thu, 24 Oct 2024 10:00:13 +0900
Message-ID: <20241024010025.2216242-4-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241024010025.2216242-1-shinichiro.kawasaki@wdc.com>
References: <20241024010025.2216242-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241023_180033_093049_39225B1D 
X-CRM114-Status: UNSURE (   9.90  )
X-CRM114-Notice: Please train this message.
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
type.

Signed-off-by: Hannes Reinecke <hare@suse.de>
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


