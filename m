Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A0D4D74978
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2024 06:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G8hSeI2w04xGfeQRleuOMxfnSXo/X9D1qIkFI1pUTx4=; b=ssLu7Hx0YhVyEOhqwVtk3mNAcm
	DcBuWlGQiI9uYMgnlBLOOsTHi5kHSOdnCD/kFvc4a7z4MKu+8P8JglL6ffJU0atiUjegn4mCzawnE
	VM6sjGxTrLZfvr0DVJHiLkxntg8CGlbQjroeoiX0OVrW5rrTNONP6g2XbogCq66PGpXUPw0PjWbgm
	1UR8L7KxWTSLpssZdkwaGQ3INgrjVWf76xkkpvkJCVQchZ2LbIe/DgiEaG2ItoDo/Kvd4jj3vHBuJ
	z19pPnOaP1oRQXB0DNS8YJKIUoWsGye2umsWJerKyvIOinYFuAb75ICMvhUI9McL9i+fFoWbOGksb
	h2atsSgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t62Z2-0000000H2UZ-2DBQ;
	Wed, 30 Oct 2024 06:52:20 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t62Yi-0000000H2AZ-2dcV
	for linux-nvme@lists.infradead.org;
	Wed, 30 Oct 2024 06:52:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1730271120; x=1761807120;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cizhS5XHaNj6PGUgQl0fQJ0Ajsoof+Rw/mI4B1AdIyg=;
  b=pjbT28nA/hqNn+VCE1aHXYi1te23U7s/7vee5ErXloXn1vJRQmL+xQLQ
   DcCpcqxXRz9m34L7taFrDivdJWx/wveZ0cue4zhgNzIRlWnrtWHAgAtTj
   CqUmNHh92zKdfc3rSNFpIoHGzvBkc10ZEtlUKzxIRKDSobf/xsMK+hMkk
   wQ02v6HNOI9PtSI7XD6/OFlKXnszkTPIdxdwG0LwQmW75f5XRFRSpQNMl
   3tiWIHqLRCN934kMjG4Yf/Pj+r2OB5wCkKaTfArpvVjl+VhF4eYBfAwTL
   zEmIfcFqbeMKkg6DxzdKJLEmlQLSmpaUyTP7IxgYQPM/nIYHrWfd+RGwY
   Q==;
X-CSE-ConnectionGUID: bfVdy/G1SVO9L3lWM+81qg==
X-CSE-MsgGUID: 5+c4HzzaQH2K5rE0YJZ3kA==
X-IronPort-AV: E=Sophos;i="6.11,244,1725292800"; 
   d="scan'208";a="31314348"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2024 14:52:00 +0800
IronPort-SDR: 6721ca62_gSjGhx7uq3PRs35W7bCrpw6jfrIGeVJO7UaXzZew1/rQbBC
 fTPKJP6Ea1GqW31Kw47a5TUU/qpzSxvhwwlybKA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Oct 2024 22:55:46 -0700
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 Oct 2024 23:52:00 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v2 11/13] common/nvme, nvme/003: specify "--port none" to _nvme_connect_subsys()
Date: Wed, 30 Oct 2024 15:51:47 +0900
Message-ID: <20241030065149.2297405-12-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241030065149.2297405-1-shinichiro.kawasaki@wdc.com>
References: <20241030065149.2297405-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_235200_743484_E8B4067B 
X-CRM114-Status: GOOD (  15.64  )
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

Commit "nvme: pass in port parameter to _nvme_connect_subsys()"
introduced the --port argument to _nvme_connect_subsys(). If the option
is not specified, _nvme_connect_subsys() automatically finds the port
for the specified subsysnqn. However, this does not work for the test
case nvme/003, since the test case connects to the subsys for discovery,
then, the port of the created subsysnqn is not to be used. This causes
the failure of the test case.

To avoid the failure, modify _nvme_connect_subsys() to take the special
value "none" for the --port option. When "--port none" is specified,
_nvme_connect_subsys() skips the steps to obtain port dependent
parameters and just use default parameters.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/nvme    | 41 ++++++++++++++++++++++++++++++-----------
 tests/nvme/003 |  3 ++-
 2 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/common/nvme b/common/nvme
index 6513205..3a2bb35 100644
--- a/common/nvme
+++ b/common/nvme
@@ -690,22 +690,41 @@ _get_nvmet_port_params() {
 	local port="$1"
 	local -n args="$2"
 	local cfs_path="${NVMET_CFS}/ports/${port}"
-	local trtype
-	local traddr
-	local trsvcid
+	local trtype="${nvme_trtype}"
+	local traddr="${def_traddr}"
+	local trsvcid="${def_trsvcid}"
 
-	[[ -d "${cfs_path}" ]] || exit 1
-	trtype=$(cat "${cfs_path}/addr_trtype")
+	# When port is specified, get port dependent parameter values
+	if [[ $port != none ]]; then
+		[[ -d "${cfs_path}" ]] || exit 1
+		trtype=$(cat "${cfs_path}/addr_trtype")
+		traddr=$(cat "${cfs_path}/addr_traddr")
+		args+=(--traddr "${traddr}")
+		if [[ "${trtype}" == "tcp" ]] || [[ "${trtype}" == "rdma" ]]; then
+			trsvcid=$(cat "${cfs_path}/addr_trsvcid")
+		fi
+	fi
+
+	# Prepare parameter options
 	args+=(--transport "${trtype}")
-	traddr=$(cat "${cfs_path}/addr_traddr")
-	args+=(--traddr "${traddr}")
-	if [[ "${trtype}" == "tcp" ]] || [[ "${trtype}" == "rdma" ]]; then
-		trsvcid=$(cat "${cfs_path}/addr_trsvcid")
+	case ${trtype} in
+	loop)
+		;;
+	rdma | tcp)
+		if [[ $port == none ]]; then
+			args+=(--traddr "${traddr}")
+		fi
 		args+=(--trsvcid "${trsvcid}")
-	elif [[ "${trtype}" == "fc" ]]; then
+		;;
+	fc)
 		args+=(--traddr "$(_fc_traddr "$port")")
 		args+=(--host-traddr "$(_fc_host_traddr "$port")")
-	fi
+		;;
+	*)
+		echo Unexpected transport type: "${trtype}"
+		exit
+		;;
+	esac
 }
 
 _find_nvme_dev() {
diff --git a/tests/nvme/003 b/tests/nvme/003
index 36c0753..2222ad1 100755
--- a/tests/nvme/003
+++ b/tests/nvme/003
@@ -28,7 +28,8 @@ test() {
 
 	_nvmet_target_setup
 
-	_nvme_connect_subsys --subsysnqn "nqn.2014-08.org.nvmexpress.discovery"
+	_nvme_connect_subsys --port none \
+			     --subsysnqn "nqn.2014-08.org.nvmexpress.discovery"
 
 	# This is ugly but checking for the absence of error messages is ...
 	sleep 10
-- 
2.45.2


