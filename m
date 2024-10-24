Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80656D0BB4A
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Oct 2024 01:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OHZU3kt3XWTyPHUmizSBH6F4lDfZipBeFNAXW/yREr4=; b=Yr97yo9OIhAnrs3d+ykODDkhxv
	YfQngwsW0rAVYMpkdPoajFCHktRRbc9GTL8+iIArDifUoJnMcvAZmd+kIEz+U9heLuA9x/ot4x9bd
	q5UyuKgRYv5JoAh0O4mc+7vpIjByXY4cLu4BMOjnMcSNBPM5qc5bQchSVK9sGmveZK0EO5hSiluEi
	GCrfTYf/uSH4uFqqxhAvdf5vKIqloyUPyjuVesF039sBvnIiBXjhYJw3fOlAwHS3ZTnuzXsbsxq1V
	6oVb3APVctEMtFBGe9d4Ev8s6O/unY2Sx/tqZia27bZmndMI2JUpdoIvhOBUVqz80AJsKcvBVJ9ey
	5HGWjgPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3mDe-0000000GMqM-2iPM;
	Thu, 24 Oct 2024 01:00:54 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3mDO-0000000GMXt-065l
	for linux-nvme@lists.infradead.org;
	Thu, 24 Oct 2024 01:00:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1729731637; x=1761267637;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h9e+PsIj7jyMe68jXfEeI4H8/IJj3FOEraZa/7OHDcM=;
  b=m7sDf9IGsPrXtzINyxKcqgaX0nwn+j5TgCQwhnszGpXuh7K7S8A1nXcx
   MWfLjQLpG3+sBDTho0+gKGo466tzckoJysdiVzKSbx/CxT1Ts4GVTLH65
   q50Csf29Tvb8u7g2++DR4dYps9iezgdaKWBkTkdKBh62cn11bNYXKko/Z
   1likmHd0qsc8Yb7vH0htOmZlvmOK98oGXNZ0iGAvd7EHNdko9zj24mv/k
   uNSgl/9PD7Az8ZLrR0ivtiIwkHl3a+5QofjKUbx/wv/8p9jPUJhSZx03K
   oLLHjIeF+4cpunXorzsuIL8BGzTXsBn+4pYdMXqd7dquRreYgI1A+j5n+
   g==;
X-CSE-ConnectionGUID: z4bMlFWhSQOjXKxpCDxR/g==
X-CSE-MsgGUID: WL7A1bsIQoeFpX3p6YyxVA==
X-IronPort-AV: E=Sophos;i="6.11,227,1725292800"; 
   d="scan'208";a="30211149"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Oct 2024 09:00:35 +0800
IronPort-SDR: 67198f1b_lig3bLIbnmXHCXR9livz7ApehMI1XvTw8VmOvxaFskAuc77
 hyp9j8ja62VLDcr97xtKcP2APxuGc2/yRdb2GsA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Oct 2024 17:04:44 -0700
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 Oct 2024 18:00:35 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 11/15] common/nvme, nvme/003: add --no_port option to _nvme_connect_subsys
Date: Thu, 24 Oct 2024 10:00:21 +0900
Message-ID: <20241024010025.2216242-12-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241024010025.2216242-1-shinichiro.kawasaki@wdc.com>
References: <20241024010025.2216242-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241023_180038_229725_636F8A33 
X-CRM114-Status: GOOD (  14.32  )
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

To avoid the failure, introduce --no_port option. When this is option is
specified, _nvme_connect_subsys() skips the port finding step.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/nvme    | 33 ++++++++++++++++++++++++---------
 tests/nvme/003 |  3 ++-
 2 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/common/nvme b/common/nvme
index 95a05de..758e248 100644
--- a/common/nvme
+++ b/common/nvme
@@ -275,7 +275,9 @@ _nvme_connect_subsys() {
 	local ctrl_loss_tmo=""
 	local no_wait=false
 	local port
+	local no_port=false
 	local i
+	local -a ARGS
 
 	while [[ $# -gt 0 ]]; do
 		case $1 in
@@ -283,6 +285,10 @@ _nvme_connect_subsys() {
 				port="$2"
 				shift 2
 				;;
+			--no_port)
+				no_port=true
+				shift
+				;;
 			--subsysnqn)
 				subsysnqn="$2"
 				shift 2
@@ -338,7 +344,9 @@ _nvme_connect_subsys() {
 		esac
 	done
 
-	if [[ -z "${port}" ]]; then
+	if [[ $no_port == true ]]; then
+		port=none
+	elif [[ -z "${port}" && $no_port == false ]]; then
 		local ports
 
 		_get_nvmet_ports "${subsysnqn}" ports
@@ -689,17 +697,24 @@ _get_nvmet_port_params() {
 	local port="$1"
 	local -a args=()
 	local cfs_path="${NVMET_CFS}/ports/${port}"
-	local trtype
-	local traddr
-	local trsvcid
+	local trtype="${nvme_trtype}"
+	local traddr="${def_traddr}"
+	local trsvcid="${def_trsvcid}"
+
+	if [[ $port != none ]]; then
+		[[ -d "${cfs_path}" ]] || exit 1
+		trtype=$(cat "${cfs_path}/addr_trtype")
+		traddr=$(cat "${cfs_path}/addr_traddr")
+		args+=(--traddr "${traddr}")
+		if [[ "${trtype}" == "tcp" ]] || [[ "${trtype}" == "rdma" ]]; then
+			trsvcid=$(cat "${cfs_path}/addr_trsvcid")
+		fi
+	elif [[ "${trtype}" != "loop" ]]; then
+		args+=(--traddr "${traddr}")
+	fi
 
-	[[ -d "${cfs_path}" ]] || exit 1
-	trtype=$(cat "${cfs_path}/addr_trtype")
 	args+=(--transport "${trtype}")
-	traddr=$(cat "${cfs_path}/addr_traddr")
-	args+=(--traddr "${traddr}")
 	if [[ "${trtype}" == "tcp" ]] || [[ "${trtype}" == "rdma" ]]; then
-		trsvcid=$(cat "${cfs_path}/addr_trsvcid")
 		args+=(--trsvcid "${trsvcid}")
 	elif [[ "${trtype}" == "fc" ]]; then
 		args+=(--traddr "$(_fc_traddr "$port")")
diff --git a/tests/nvme/003 b/tests/nvme/003
index 36c0753..67c7df6 100755
--- a/tests/nvme/003
+++ b/tests/nvme/003
@@ -28,7 +28,8 @@ test() {
 
 	_nvmet_target_setup
 
-	_nvme_connect_subsys --subsysnqn "nqn.2014-08.org.nvmexpress.discovery"
+	_nvme_connect_subsys --no_port \
+			     --subsysnqn "nqn.2014-08.org.nvmexpress.discovery"
 
 	# This is ugly but checking for the absence of error messages is ...
 	sleep 10
-- 
2.45.2


