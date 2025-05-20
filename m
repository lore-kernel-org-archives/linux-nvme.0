Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DDB8C3ABDD
	for <linux-nvme@archiver.kernel.org>; Tue, 20 May 2025 06:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tDuOZljQM/77XO+YQ2QHRkgT5S2lnITCCzUVVG1zpAo=; b=VjymJpQ65/XAlq9HxLVYUShWQx
	yd8/3ly+CidWYYX46TWAwpgaQkzvKzi20OV7zGxN70mRCS2zW/j+MZRFwTSRTQjReFJtAYxaRmq+0
	BfRf5acF5TiEKj/9jbQtxoZZvl7pedhDHj8kblD0nLIMtfihuWEG2h9Or73jWaYQlH9Qw6YDaa2su
	ZhOfl+zG/Xqpip98g3nBhuiC/724/iHo/pxAuL3TpIbFn0kO7g3SPvL0pgnRfH8/6WwclpNm4eAl7
	iLxC8CuzYyQTyxfUu0V0yW59NX26XpJyvemTnFE33loeMIj8ODRGAstp68OCIZsUyzuj9HYsDRDap
	2S8jK6qA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHGJ6-0000000Bfqx-2iVk;
	Tue, 20 May 2025 06:18:32 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHGJ0-0000000Bfo7-0m6F
	for linux-nvme@lists.infradead.org;
	Tue, 20 May 2025 06:18:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1747721906; x=1779257906;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VflR3nQKyuYizyAMAuoU/OJE9sNaAHuQEomrn0sH7/Y=;
  b=qFHo2h0zaRuEgnseqMlQbKijfJx46neU8+05bGBI+ZvnA23lJa5RaOhL
   wme7OgYPCE8xaOZOkvSghunVq3A7/C4T5aWk/6Np4xSA5fHH8wYXA4Hci
   MZLlJN2Mug2vxdJXsvqWVhIpUUBsw50fcNWAHsmR/jumN7bhJymfFlHL8
   EvAALfvJToQEGm9iifR81ADMdBspSdj/exMcU4+JYhGkzQl1BPeZ69uvV
   vOKp8i/L9+oUk0h58wAZQolhSmQdnpE73l3n7NNASVoFtd8a9I/b0WrMx
   MBrPY0eLl+pbIVVBfQjriPw/dwZHMKkp1mNZoGUi22rhHbKJDMk5W1CYR
   g==;
X-CSE-ConnectionGUID: P8WlWEH2TQWD6DXWgeg6bQ==
X-CSE-MsgGUID: XrGrlPnnT6OcGskjy1caSw==
X-IronPort-AV: E=Sophos;i="6.15,302,1739808000"; 
   d="scan'208";a="88516363"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 May 2025 14:18:23 +0800
IronPort-SDR: 682c106b_Wr+cGhTWBxPftuyAZTcUBUp83k6o3iFFZSrRzPR+h+l+1KZ
 ZLLkBiYbRARchIQDhH23Mm2el2m4X4GxG9s1QPw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 May 2025 22:17:32 -0700
WDCIronportException: Internal
Received: from 5cg21741nf.ad.shared (HELO shinmob.wdc.com) ([10.224.163.39])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 May 2025 23:18:23 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Daniel Wagner <wagi@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 1/2] common/nvme: introduce _have_nvme_cli_with_json_support()
Date: Tue, 20 May 2025 15:18:18 +0900
Message-ID: <20250520061819.1148033-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520061819.1148033-1-shinichiro.kawasaki@wdc.com>
References: <20250520061819.1148033-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250519_231826_285108_8CF0F9C4 
X-CRM114-Status: GOOD (  13.33  )
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

To check if the nvme command supports json output format, introduce the
helper function _have_nvme_cli_with_json_support(), which verifies the
option "--output-format=" works. While at it, replace the short option
"-o" in _nvme_connect_subsys() with the long option "--output-format=".

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/nvme | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/common/nvme b/common/nvme
index ac1bbe7..04d167b 100644
--- a/common/nvme
+++ b/common/nvme
@@ -62,6 +62,16 @@ _require_nvme_trtype_is_fabrics() {
 	return 0
 }
 
+_have_nvme_cli_with_json_support() {
+	_have_program nvme || return $?
+
+	if ! nvme list --output-format=json &> /dev/null; then
+		SKIP_REASONS+=("nvme-cli does not support json output format")
+		return 1
+	fi
+	return 0
+}
+
 _nvme_fcloop_add_rport() {
 	local local_wwnn="$1"
 	local local_wwpn="$2"
@@ -415,7 +425,7 @@ _nvme_connect_subsys() {
 	if [[ ${concat} = true ]]; then
 		ARGS+=(--concat)
 	fi
-	ARGS+=(-o json)
+	ARGS+=(--output-format=json)
 	connect=$(nvme connect "${ARGS[@]}" 2> /dev/null)
 
 	# Wait until device file and sysfs attributes get ready
-- 
2.49.0


