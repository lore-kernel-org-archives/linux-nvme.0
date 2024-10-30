Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC2ABD7497A
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2024 06:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sQ+wRH7r7M3PRwoy68BTJkuFsNqhfCfoiwtKC5sgxes=; b=wCy7VROMIEgXMPsnUqIwgJbuPn
	WuqCMxHnqlfJlwZpdZjpMk9E2hzTCxJAgn2+S8fmP3+Edy/qnulc5ZcfXwAnQa9s2EDT/DRUTUM/m
	akQVOhYY0/NGaRbIfVaY70+AS/s83O4ngncSdJcyOQHUUYmOWfIxGkI1e8TIhNvqyXDo7wGBn8T3p
	l71ujCCUzrG5lcWYXIQ7n4s+Cqm0c+BdZdhO31kI4Kzkg4Cz9uvsD67RzDvMleZjCZsPJY1Z8BrVG
	lxb2XFDpIVztk7i7j6qyEM/hJMzkyPTeORaFkIm7mom0R18PIKO2iTpj6tClvHC7yTbHu7BX4FYtE
	oiyspM4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t62Yl-0000000H2HQ-1Fut;
	Wed, 30 Oct 2024 06:52:03 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t62Ye-0000000H2Ac-2GZg
	for linux-nvme@lists.infradead.org;
	Wed, 30 Oct 2024 06:51:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1730271116; x=1761807116;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=65C4pupAzLpijUq3qsKLa9OCA0BpbgPXGSqqmWw+fnA=;
  b=iAqfnNKnZ+s+nkim8rLdr+vu6PGTx0nk0PyN9hVQDykSBwNmwdDnNWyk
   y1S6U8tY/8EbXKLb5j8mtZXenK8CQ28qjnLwSCBn0/zx4URprY0kbaDnY
   psA4F1OGetzxN2c29n0jHYU3OYGCMKL/2RABIThfRuCcafK+CbBedapOP
   CiAbqRE6ckSwGoCUwFhwJtV8llYCGdUkn5bTXPvdSaeJEA7m5di+Ek2TQ
   3DtuN3WRxCj/QA+GvwxWSC/8b7p8op8Giq/66GNu+daG4NzuGxJOmJJFC
   iq4PlnMcrQhUfCNbcItDI6dQZroR2CT2lIbmDrcDrYDAeekjVznzElC8o
   A==;
X-CSE-ConnectionGUID: hgnpenErRZuMUG4p9iGB5w==
X-CSE-MsgGUID: S/zrVuUGR5iy/9OqyL0u8Q==
X-IronPort-AV: E=Sophos;i="6.11,244,1725292800"; 
   d="scan'208";a="31314339"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2024 14:51:56 +0800
IronPort-SDR: 6721ca5e_fr7IPqo5kKTbevJU9QyspeddIhIzuprufIWIxGhfosCWg56
 BcJQV4L3vnAv+JZLtnGoFXW655AwaTUvMvKkiBg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Oct 2024 22:55:42 -0700
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 Oct 2024 23:51:56 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v2 06/13] nvme: fix fc port clean up failure
Date: Wed, 30 Oct 2024 15:51:42 +0900
Message-ID: <20241030065149.2297405-7-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241030065149.2297405-1-shinichiro.kawasaki@wdc.com>
References: <20241030065149.2297405-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_235156_633221_DCE0AC86 
X-CRM114-Status: GOOD (  11.58  )
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
modified the wwnn and the wwpn names to be calculated based on port ID.
However, this port dependent wwnn and wwpn calculation was not reflected
to the clean up steps. This made the test case nvme/031 fail. To avoid
the failure, add clean up steps based on the port ID.

Reviewed-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/nvme | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/common/nvme b/common/nvme
index 3e388c2..2ef9fd8 100644
--- a/common/nvme
+++ b/common/nvme
@@ -183,6 +183,12 @@ _cleanup_nvmet() {
 	for port in "${NVMET_CFS}"/ports/*; do
 		name=$(basename "${port}")
 		echo "WARNING: Test did not clean up port: ${name}"
+		if [[ "${nvme_trtype}" == "fc" ]]; then
+			_cleanup_fcloop "$(_local_wwnn "$port")" \
+					"$(_local_wwpn "$port")" \
+					"$(_remote_wwnn "$port")" \
+					"$(_remote_wwpn "$port")"
+		fi
 		rm -f "${port}"/subsystems/*
 		rmdir "${port}"
 	done
@@ -206,8 +212,6 @@ _cleanup_nvmet() {
 	trap SIGINT
 
 	if [[ "${nvme_trtype}" == "fc" ]]; then
-		_cleanup_fcloop "${def_local_wwnn}" "${def_local_wwpn}" \
-				"${def_remote_wwnn}" "${def_remote_wwpn}"
 		modprobe -rq nvme-fcloop 2>/dev/null
 	fi
 	modprobe -rq nvme-"${nvme_trtype}" 2>/dev/null
@@ -493,6 +497,13 @@ _create_nvmet_port() {
 
 _remove_nvmet_port() {
 	local port="$1"
+
+	if [[ "${nvme_trtype}" == "fc" ]]; then
+		_cleanup_fcloop "$(_local_wwnn "$port")" \
+				"$(_local_wwpn "$port")" \
+				"$(_remote_wwnn "$port")" \
+				"$(_remote_wwpn "$port")"
+	fi
 	rmdir "${NVMET_CFS}/ports/${port}"
 }
 
-- 
2.45.2


