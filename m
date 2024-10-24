Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1372D0BB4B
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Oct 2024 01:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RjUwl8DsSlU5baIOdK/b9tNWvGno6HgzgnLfNRg35ZA=; b=AMxQFy+PBRPBYSDoKa9VzGoWT1
	Bn1zdXVfGM8NSq4jaxS2ATYm0luOoG/pVk9pemkYCmXyehXs8lbMkS/O4kqfFbwy9C89ocPeUiwDL
	zireI558HrJYtyN5dmTQ0oXtHGGaHbkby+2y7iCWA2ZgzNkTWaHCimLQ0CIYaRVuK+1/bUiOXvry5
	h5cz2mT2nlXrW7mgimYzyQF/wq93i7VKu0nH4F9JsZ+NmU/G6XAUPljkbVx1M28ovFVoSUdJxorHq
	WAzv8t/AKmS3Y4p6VvscqiO3iVygmjaSBaBGkheOx565y3iZSfilaiYfoNRWH3Yt3tkA8M8DpCe1F
	Wm4FgX9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3mDb-0000000GMnB-1LaL;
	Thu, 24 Oct 2024 01:00:51 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3mDO-0000000GMX3-0ksG
	for linux-nvme@lists.infradead.org;
	Thu, 24 Oct 2024 01:00:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1729731637; x=1761267637;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QUyHcjhFcYX0MI1OWiALNVprEFNxd/wSlco+MrWxt9E=;
  b=CQTMhYcL2CGO7GKwOjN1lha4fd5/lRZTo027IUOq3Bqv4eXvVjZ6fG3F
   0I90CWn0TkjUid2I/7S6uXQxR4dRx1NlB3sij4aBdQTDGVywMZuH3Bz+2
   pqPBfKvlwOUFxNsIWbKDrtPr/Uge8x7OLlyvrtQJnrQLEDVcQ8ru9QjG6
   uKWAJULFeJZJ8Ajy6bYrO46eGV9XJZRFVBWn1bOi220xkwr9uk7dLKBKg
   Kdajo+N+vHKcE82o4DnF3F7ywCtEoFqaHOg6mC8xZ53AERi8CwVlOzM5i
   lzUqgokLEhDquEcomSUtDFenCAbsd3MHr05hExMOS+aE/gZe4DNlX8xH4
   w==;
X-CSE-ConnectionGUID: 1u4BCxOmQsmKVEM8O3TNbA==
X-CSE-MsgGUID: 7EfHNl6gQh6tgVa2TG8fzg==
X-IronPort-AV: E=Sophos;i="6.11,227,1725292800"; 
   d="scan'208";a="30211155"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Oct 2024 09:00:36 +0800
IronPort-SDR: 67198f1c_m6AYlQZhuoHmqV//hnv/k6SUXt4bAxo5RYcmjULTirVSeWp
 uVvtKWJKCb6Mksh/LxcogehgDV2NWONrY18Q9xg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Oct 2024 17:04:44 -0700
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 Oct 2024 18:00:36 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 12/15] nvme: remove "local -n" from _get_nvmet_ports()
Date: Thu, 24 Oct 2024 10:00:22 +0900
Message-ID: <20241024010025.2216242-13-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241024010025.2216242-1-shinichiro.kawasaki@wdc.com>
References: <20241024010025.2216242-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241023_180038_349208_EAAA1421 
X-CRM114-Status: GOOD (  11.44  )
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

The -n option of the bash local variable declaration means that the
variable is used as nameref. However, this nameref feature was
introduced to bash at its version 4.3. On the other hand, blktests
requires bash version 4.2. To not rely on the bash version 4.3, replace
the nameref feature with the "read -ra" command to parse arguments.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/nvme   | 10 +++++++---
 tests/nvme/rc |  2 +-
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/common/nvme b/common/nvme
index 758e248..dce3943 100644
--- a/common/nvme
+++ b/common/nvme
@@ -349,7 +349,7 @@ _nvme_connect_subsys() {
 	elif [[ -z "${port}" && $no_port == false ]]; then
 		local ports
 
-		_get_nvmet_ports "${subsysnqn}" ports
+		read -ra ports < <(_get_nvmet_ports "${subsysnqn}")
 		port="${ports[0]##*/}"
 		if [[ -z "${port}" ]]; then
 			echo "WARNING: no port found"
@@ -683,7 +683,7 @@ _remove_nvmet_subsystem_from_port() {
 
 _get_nvmet_ports() {
 	local nvmet_subsysnqn="${1:-$def_subsysnqn}"
-	local -n nvmet_ports="$2"
+	local -a nvmet_ports=()
 	local cfs_path="${NVMET_CFS}/ports"
 
 	for port in "${cfs_path}/"*; do
@@ -691,6 +691,10 @@ _get_nvmet_ports() {
 			nvmet_ports+=("${port##*/}")
 		fi
 	done
+
+	if (( ${#nvmet_ports[@]} )); then
+		echo "${nvmet_ports[@]}"
+	fi
 }
 
 _get_nvmet_port_params() {
@@ -784,7 +788,7 @@ _nvmet_target_cleanup() {
 		esac
 	done
 
-	_get_nvmet_ports "${subsysnqn}" ports
+	read -ra ports < <(_get_nvmet_ports "${subsysnqn}")
 
 	for port in "${ports[@]}"; do
 		_remove_nvmet_subsystem_from_port "${port}" "${subsysnqn}"
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 64a31e0..167e085 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -452,7 +452,7 @@ _nvmet_passthru_target_cleanup() {
 		esac
 	done
 
-	_get_nvmet_ports "${subsysnqn}" ports
+	read -ra ports < <(_get_nvmet_ports "${subsysnqn}")
 
 	for port in "${ports[@]}"; do
 		_remove_nvmet_subsystem_from_port "${port}" "${subsysnqn}"
-- 
2.45.2


