Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F68FC3601C
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Apr 2025 07:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OEjPfKpXmbWQup7FIjFiwSy5obC7idSrzn6/YZ/21p0=; b=f/FnzbKMupQoF7gc6Py5X609oa
	qMTe9xnMyPVQfx2aHT6LLr0qTmzwgbHHfMgaIdA2yJAGK/0SiXGrpjmVEvZ7oJntqpbqQVuMYm4D+
	2WOt/KaTZWHs+yCoT2up9ZmiDlL/2toNLf9g7y8yNjDjnut+YuGPxjn4QF5DJ5ApwFltYNF2xpZhL
	W+GmWYX74eE3alU6ElmpQtj2ZMlV0L7rep6SWy9vQKiR3FODW3RlumGzFxE4q7Q8PQR2/Bij9vOuI
	o8H1wSNeFXY6PABXl/SBObzxQiChmdiG4Az5/7+FZ9/JkTg6krDFgOr19hlvGLz9BeTArt+lFSPi8
	py/1/C8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzsZ1-00000005NF9-3IKF;
	Wed, 02 Apr 2025 07:31:07 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzsDr-00000005Jwm-3HlL
	for linux-nvme@lists.infradead.org;
	Wed, 02 Apr 2025 07:09:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1743577755; x=1775113755;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tftTrXPbJbZQ11TozRGfTpfYSu/Q0A0MVEOzzzAL7/E=;
  b=leiXIYHnBSpxzdUkF++aH3A1fBWD89uqtwg112HNsrmlAmOMiRtAxIIe
   7Lpv1+4+25CSvo61R7wcQ/TMLbkELfeQZEb6vcXsuypSZH9kYHlJMkOIJ
   U33h5fm3svMyBR8fgzS6gGBUS3VLo+nLU7D9a1n++jBc8w6pxsRaEVadY
   iIAemsC+PVrqYkMDk/loK+DDbfgQmj0SVCDwBpZFbot13u9m48EhedxY/
   S4944q1ArAxgCA7yqc7tiKZFOfmFMYoEN3OQRCBxCpla+HBZiHwgzit+m
   o7B66iQ6FZaaK4EGNPw/7JqnHOaAgFOokHI3XYVYzWtRCttLiHdrXlNRV
   w==;
X-CSE-ConnectionGUID: S9XKiwB5QXOjka0sAwZYyw==
X-CSE-MsgGUID: s4FX/XW7RbC+VIPC5nQHaw==
X-IronPort-AV: E=Sophos;i="6.14,295,1736784000"; 
   d="scan'208";a="67793496"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Apr 2025 15:09:15 +0800
IronPort-SDR: 67ecd4a4_DmhdP/QpYEJJqZ81jmHkazKevUKUPHjixhhtpseaJjvhhms
 u9QD0DIEGWbfo/Z9VYUSwbPUbBPZTecANaDuwZA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Apr 2025 23:09:40 -0700
WDCIronportException: Internal
Received: from 5cg2075fn7.ad.shared (HELO shinmob.wdc.com) ([10.224.102.114])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 Apr 2025 00:09:15 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 06/10] common/nvme: add '--tls' argument to _nvme_connect_subsys()
Date: Wed,  2 Apr 2025 16:09:02 +0900
Message-ID: <20250402070906.393160-7-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250402070906.393160-1-shinichiro.kawasaki@wdc.com>
References: <20250402070906.393160-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250402_000915_824397_C28D82B1 
X-CRM114-Status: GOOD (  10.23  )
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

To start TLS-encrypted connections.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/nvme | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/common/nvme b/common/nvme
index 3761329..9327dff 100644
--- a/common/nvme
+++ b/common/nvme
@@ -274,6 +274,7 @@ _nvme_connect_subsys() {
 	local no_wait=false
 	local hdr_digest=false
 	local data_digest=false
+	local tls=false
 	local port
 	local i
 	local -a ARGS
@@ -340,6 +341,10 @@ _nvme_connect_subsys() {
 				data_digest=true
 				shift 1
 				;;
+			--tls)
+				tls=true
+				shift 1
+				;;
 			*)
 				echo "WARNING: unknown argument: $1"
 				shift
@@ -397,6 +402,9 @@ _nvme_connect_subsys() {
 	if [[ ${data_digest} = true ]]; then
 		ARGS+=(--data-digest)
 	fi
+	if [[ ${tls} = true ]]; then
+		ARGS+=(--tls)
+	fi
 	ARGS+=(-o json)
 	connect=$(nvme connect "${ARGS[@]}" 2> /dev/null)
 
-- 
2.49.0


