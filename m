Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB244D0BB4B
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Oct 2024 01:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GvW4nBvc4eSiGdeHRM5f8G8UmobBTbaCwjJ0GWENwK8=; b=pHmuaE9BvbJKsxmK/uMAsCPtyI
	1fcalwjKLmuzWadNaN7UbzEHtpZPw0N1avpF3CZSxME8bsloX7hYkO1juFDJFRAtmlKoFwgL/bvIE
	JdIBd8XUPMDt5SAki6q1XeZw9iZ+WxCizS3aIDJoVCeDGr56Ved/eVdDlhKx1mV6lKUvR+QuH6flG
	wwJToogA2o068boj5r5dVpUkKxHb817wepuoK8IzHevm2MXjZA7V9YxtY63NYyK9IaiS1VqWipOfU
	orzjGPtrQzBNB+/khu/iJBSuOjswv5M5mSvTqH/+5PiutV83myZ7dsK6nRhCuX7wGJjL0zJjm+sQy
	6JitXZ4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3mDU-0000000GMgw-2G2i;
	Thu, 24 Oct 2024 01:00:44 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3mDK-0000000GMX3-3soW
	for linux-nvme@lists.infradead.org;
	Thu, 24 Oct 2024 01:00:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1729731634; x=1761267634;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rOURoJafmwKhRD+8GuwQFWbOU5Ms70ExZI4aS9RSiz4=;
  b=W93BDcfqQLcoWTYsNNp9VsWY1iS22CDF0edpAi7Y1bVdMQrMVx8UUg8X
   +VLRFhiGK94dmAFAeuqpJ1bfoDoFDVdqV7Nyip4Zi0SXOP8fSmQTM2pbr
   22BrIyJKiHHRRa3rFp2i2UZijX/1vD6Z/kkwZcgrMA+da7w8DihrEJ4D5
   29EBZSzdnucgosOdKdi+VDOY8K2FvNL+6F+1hqspmuF3h3sP/+Syzl97l
   82WHFOgXZDnE94Qld1dM9ywdzQqEGY4RcgmxiBDHxY7iYMkOr5QN3wVU9
   uXIQnYvrHpWxYlXn2EMwhKVto4WjwFizR9ybC4vBSB5GDBOXF1Y3mzLrq
   A==;
X-CSE-ConnectionGUID: w9er1P1qTQecIw/Q3iGP9g==
X-CSE-MsgGUID: huns8pmdSR65QicKO+8irg==
X-IronPort-AV: E=Sophos;i="6.11,227,1725292800"; 
   d="scan'208";a="30211114"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Oct 2024 09:00:31 +0800
IronPort-SDR: 67198f17_c89se+KIS6Bvr7iwKNzL7IvyKgE5GVzGm6vg7LgoNNr8k3x
 b/R9UfRuhOx92sS/iXaYcvJ3p3rpyV3R/RksY1Q==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Oct 2024 17:04:39 -0700
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 Oct 2024 18:00:31 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 06/15] nvme: fix fc port clean up failure
Date: Thu, 24 Oct 2024 10:00:16 +0900
Message-ID: <20241024010025.2216242-7-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241024010025.2216242-1-shinichiro.kawasaki@wdc.com>
References: <20241024010025.2216242-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241023_180035_208387_CD372B00 
X-CRM114-Status: GOOD (  11.05  )
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


