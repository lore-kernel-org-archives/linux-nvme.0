Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C192D0BB4C
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Oct 2024 01:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uXYRzN0lUzpfXspffF+BOrmikd1mCk8PHuBjjAuMvrE=; b=2MK6ZhW0XaTIFdAk4QVUUbY6Ta
	dYqqalEgXXHrpdmqC0GSGQfopDVNhj9tVXoLNV6z9dDxFjL0ZZDI7j5xSgG+1UiUmtXCMlnY5GlJC
	t4b0hGObxlU26VSR1AOSxbwBulLnhjAQrdNdGewPTzChkZoWybxolGYnOO2DuAAQLImpVqBq0xaw3
	h2VaMmgH+yfUkEFQ1mjyxmgXBxe/7kiuJJpMC3cIDX1rfFFL7rsBmoKJwqBhio2H5XioggQOWC9Jr
	0eS8fuHzGysQ/Mp+tLKLBeZlC/VR2wSmoswjGZ+UwrbEkP3PFdBi4ybW5aaF2CEfSUBB6KG4YZVU5
	WIa7w90Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3mDN-0000000GMb5-1UdM;
	Thu, 24 Oct 2024 01:00:37 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3mDI-0000000GMXt-1HHP
	for linux-nvme@lists.infradead.org;
	Thu, 24 Oct 2024 01:00:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1729731632; x=1761267632;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4xeeN2AXY8UWr3KOMklCIQAjzpT1F8E5lWjp24eTSE4=;
  b=ZJK+jH3MDcQHGoYg8yIU/aPHudFpPAoq/x70SI5qBlSi7k6g/bXcMhmF
   dWZGcDX8lfhZSWDiYQXuEhfPYX3W+5kdNvut0bp2B1eTFetjYEvThXnRX
   51YhXNS1ka5P/mcRlVEW2wbg+Az3bWzZDwPX4YSVQWP+k0eC7Nu4EODzj
   8Q4jD57ugAiFF1NruZGMqH7HAnHvg4doFdsfPesAXNvYCa2NfbGiXlhVo
   ug9x3VOFsw5q8CcK6ZewfXMIX4EbfJT4uYBmXoOrevnBbIJlnr2jXKfl4
   kO6VwzejrWR+Ut2ukIG6q6dlWZA8hMtH57OmM50ltre8xtGbRVi1eL4cY
   Q==;
X-CSE-ConnectionGUID: lbqNHbujTaOrSIpvYy+FoQ==
X-CSE-MsgGUID: LhGzdh/uQxKg70KVtpcYMw==
X-IronPort-AV: E=Sophos;i="6.11,227,1725292800"; 
   d="scan'208";a="30211078"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Oct 2024 09:00:28 +0800
IronPort-SDR: 67198f14_gSB9JP0zOoPssMoeO4pM169cyQwS+69mQg+jokMCktmEFXw
 mr97zt0AVrIURe/N0It4js8x+P4KfdDv56uqUDw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Oct 2024 17:04:36 -0700
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 Oct 2024 18:00:28 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 02/15] nvme, md/001: make trtype argument to _create_nvmet_port() optional
Date: Thu, 24 Oct 2024 10:00:12 +0900
Message-ID: <20241024010025.2216242-3-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241024010025.2216242-1-shinichiro.kawasaki@wdc.com>
References: <20241024010025.2216242-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241023_180032_442248_B21DC824 
X-CRM114-Status: GOOD (  12.31  )
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

All invocations are using 'nvme_trtype' as argument to
_create_nvmet_ports(), so we can also make it optional and default
to nvme_trtype.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/nvme    | 17 ++++++++++-------
 tests/md/001   |  2 +-
 tests/nvme/002 |  2 +-
 tests/nvme/016 |  2 +-
 tests/nvme/017 |  2 +-
 tests/nvme/030 |  2 +-
 tests/nvme/031 |  2 +-
 tests/nvme/038 |  2 +-
 tests/nvme/rc  |  4 ++--
 9 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/common/nvme b/common/nvme
index c1aa8d6..99ff959 100644
--- a/common/nvme
+++ b/common/nvme
@@ -423,10 +423,11 @@ _nvme_ns_ready() {
 }
 
 _create_nvmet_port() {
-	local trtype="$1"
+	local trtype="${1:-$nvme_trtype}"
 	local traddr="${2:-$def_traddr}"
 	local adrfam="${3:-$def_adrfam}"
 	local trsvcid="${4:-$def_trsvcid}"
+	local portcfs
 
 	local port
 	for ((port = 0; ; port++)); do
@@ -435,12 +436,14 @@ _create_nvmet_port() {
 		fi
 	done
 
-	mkdir "${NVMET_CFS}/ports/${port}"
-	echo "${trtype}" > "${NVMET_CFS}/ports/${port}/addr_trtype"
-	echo "${traddr}" > "${NVMET_CFS}/ports/${port}/addr_traddr"
-	echo "${adrfam}" > "${NVMET_CFS}/ports/${port}/addr_adrfam"
-	if [[ "${adrfam}" != "fc" ]]; then
-		echo "${trsvcid}" > "${NVMET_CFS}/ports/${port}/addr_trsvcid"
+	portcfs="${NVMET_CFS}/ports/${port}"
+	mkdir "${portcfs}"
+	echo "${trtype}" > "${portcfs}/addr_trtype"
+	echo "${traddr}" > "${portcfs}/addr_traddr"
+	echo "${adrfam}" > "${portcfs}/addr_adrfam"
+	if [[ "${adrfam}" != "fc" ]] && \
+	   [[ "${adrfam}" != "loop" ]] ; then
+		echo "${trsvcid}" > "${portcfs}/addr_trsvcid"
 	fi
 
 	echo "${port}"
diff --git a/tests/md/001 b/tests/md/001
index 98da51d..5d0752f 100755
--- a/tests/md/001
+++ b/tests/md/001
@@ -50,7 +50,7 @@ setup_nvme_over_tcp() {
 	_setup_nvmet
 
 	local port
-	port="$(_create_nvmet_port "${nvme_trtype}")"
+	port="$(_create_nvmet_port)"
 
 	_create_nvmet_subsystem --subsysnqn "${def_subsysnqn}" \
 				--blkdev "/dev/mapper/ram0_big_optio" \
diff --git a/tests/nvme/002 b/tests/nvme/002
index 043ab1c..e5b751d 100755
--- a/tests/nvme/002
+++ b/tests/nvme/002
@@ -26,7 +26,7 @@ test() {
 
 	local iterations=1000
 	local port
-	port="$(_create_nvmet_port "${nvme_trtype}")"
+	port="$(_create_nvmet_port)"
 
 	local loop_dev
 	loop_dev="$(losetup -f)"
diff --git a/tests/nvme/016 b/tests/nvme/016
index 1143cab..8ab9d22 100755
--- a/tests/nvme/016
+++ b/tests/nvme/016
@@ -38,7 +38,7 @@ test() {
 				 --blkdev "${loop_dev}"
 	done
 
-	port="$(_create_nvmet_port "${nvme_trtype}")"
+	port="$(_create_nvmet_port)"
 	_add_nvmet_subsys_to_port "$port" "${def_subsysnqn}"
 
 	genctr=$(_check_genctr "${genctr}" "adding a subsystem to a port")
diff --git a/tests/nvme/017 b/tests/nvme/017
index 5721000..dd302fc 100755
--- a/tests/nvme/017
+++ b/tests/nvme/017
@@ -39,7 +39,7 @@ test() {
 				 --blkdev "$(_nvme_def_file_path)"
 	done
 
-	port="$(_create_nvmet_port "${nvme_trtype}")"
+	port="$(_create_nvmet_port)"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
 	genctr=$(_check_genctr "${genctr}" "adding a subsystem to a port")
diff --git a/tests/nvme/030 b/tests/nvme/030
index 5db20c0..1ba1274 100755
--- a/tests/nvme/030
+++ b/tests/nvme/030
@@ -28,7 +28,7 @@ test() {
 	local genctr
 	local subsys="blktests-subsystem-"
 
-	port="$(_create_nvmet_port "${nvme_trtype}")"
+	port="$(_create_nvmet_port)"
 
 	_create_nvmet_subsystem --subsysnqn "${subsys}1" \
 				--blkdev "$(losetup -f)"
diff --git a/tests/nvme/031 b/tests/nvme/031
index 00d3d18..cd69e8e 100755
--- a/tests/nvme/031
+++ b/tests/nvme/031
@@ -41,7 +41,7 @@ test() {
 
 	loop_dev="$(losetup -f --show "$(_nvme_def_file_path)")"
 
-	port="$(_create_nvmet_port "${nvme_trtype}")"
+	port="$(_create_nvmet_port)"
 
 	for ((i = 0; i < iterations; i++)); do
 		_nvmet_target_setup --subsysnqn "${subsys}$i" \
diff --git a/tests/nvme/038 b/tests/nvme/038
index 497cc88..4271ee3 100755
--- a/tests/nvme/038
+++ b/tests/nvme/038
@@ -33,7 +33,7 @@ test() {
 	mkdir -p "${subsys_path}"
 	rmdir "${subsys_path}"
 
-	port="$(_create_nvmet_port "${nvme_trtype}")"
+	port="$(_create_nvmet_port)"
 	_remove_nvmet_port "${port}"
 
 	echo "Test complete"
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 357cab9..5b4629d 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -370,7 +370,7 @@ _nvmet_target_setup() {
 				--blkdev "${blkdev}" \
 				--uuid "${subsys_uuid}" \
 				${resv_enable}
-	port="$(_create_nvmet_port "${nvme_trtype}")"
+	port="$(_create_nvmet_port)"
 	_add_nvmet_subsys_to_port "${port}" "${subsysnqn}"
 	_create_nvmet_host "${subsysnqn}" "${def_hostnqn}" \
 			"${hostkey}" "${ctrlkey}"
@@ -394,7 +394,7 @@ _nvmet_passthru_target_setup() {
 	done
 
 	_create_nvmet_passthru "${subsysnqn}"
-	port="$(_create_nvmet_port "${nvme_trtype}")"
+	port="$(_create_nvmet_port)"
 	_add_nvmet_subsys_to_port "${port}" "${subsysnqn}"
 	_create_nvmet_host "${subsysnqn}" "${def_hostnqn}"
 }
-- 
2.45.2


