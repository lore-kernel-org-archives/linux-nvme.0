Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF864C3601A
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Apr 2025 07:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GjAjz6YbeD65jmDI5FxZ2eLAkrGUiU+a8Q57n2/M/7I=; b=4hlcVnNFkMcGZtv5TD7Vmt8V2f
	MIC3/1Gym5dGPLGh7FDz6i+81vSoXpAy1eQdewdm9NtlaqUWEd2dE4zyrHzhzQYNtxRBOBMcGPfSJ
	02JHuJDpW7jVs3gq74s89PSiKmm4Cp6iSvATbilSVRYc79l6wxevZgaN9xAP/rwXcpDXJghzz6W9q
	r3uhcbxM6lRdRU/+BeDAa6yyWOZ7cXSBa7llY+r+OBcI7Q2qPBRE408OD9u8LgicTydVL2Z793Wn9
	mWY6dkRvfNldVBSxnEu6FiZCRJquKhMIdUgbEPKEiPTMZgrvGRuoKiag+PIb50XDgEqvRgS0Rct7m
	8VYn7cgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzsYz-00000005ND8-0rKZ;
	Wed, 02 Apr 2025 07:31:05 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzsDo-00000005Jv8-0R0h
	for linux-nvme@lists.infradead.org;
	Wed, 02 Apr 2025 07:09:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1743577752; x=1775113752;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VrB4fyxXXV8fR9OLATgUooSVYgD6QeH7LZfh/6lSCFQ=;
  b=C16kbyI844Ob+AIAwEJLS9mn7obBVJi0CypJO997xQyOeOiL+Mosc/Jz
   cjTgwCo9eb9PEdFxzs0kC11pP1s+zBuaXcDSTX0losnKD214/9PuntGdn
   OpICu8/8B3jlpKsg+8QNASlQgCQlxM12jCpIC4oJ7XQ2GjUyA6k/x8hgm
   3zMPHFVTinM4+VvHib+ccOzo0XSAGVSeRUIFyhx+A8OWTsqFOQuToy71N
   vlgoXOzxVBMzAbPIADXkd9SfnLAQO561ZMWbuje06dnF6Dmx9vHWsU2Oi
   mBtROXBZISkzQX6HE/f7z9/VUDErtbpn8ZC9a9y92jR/HlgZe55TdW09/
   A==;
X-CSE-ConnectionGUID: puV6wz4sSeu1NwU8w+ag6g==
X-CSE-MsgGUID: 1YDoSsCqR++hRecu9d8IUg==
X-IronPort-AV: E=Sophos;i="6.14,295,1736784000"; 
   d="scan'208";a="67793489"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Apr 2025 15:09:11 +0800
IronPort-SDR: 67ecd4a0_oKERSQj5jvwFeo0TdQNhC0DqvlqwYJEfQloOlmtOTEsnqKf
 dOQvIKubDDqdI0aa/NBTaf6ND0PYyOuU3vGSXJw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Apr 2025 23:09:37 -0700
WDCIronportException: Internal
Received: from 5cg2075fn7.ad.shared (HELO shinmob.wdc.com) ([10.224.102.114])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 Apr 2025 00:09:12 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 03/10] common/rc,fio: factor out _compare_three_version_numbers()
Date: Wed,  2 Apr 2025 16:08:59 +0900
Message-ID: <20250402070906.393160-4-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250402070906.393160-1-shinichiro.kawasaki@wdc.com>
References: <20250402070906.393160-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250402_000912_167736_44EBCBF3 
X-CRM114-Status: GOOD (  13.72  )
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

The helper functions _have_kver() and _have_fio_ver() have the common
logic that compares three numbers with the version string in the format
"a.b.c". Factor out the common logic to the new helper function
_compare_three_version_numbers(). This prepares for to introduce more
functions for version checks.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/fio |  9 +++------
 common/rc  | 25 +++++++++++++++++++------
 2 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/common/fio b/common/fio
index 046791f..7c88460 100644
--- a/common/fio
+++ b/common/fio
@@ -28,14 +28,11 @@ _have_fio_zbd_zonemode() {
 
 # Check whether the version of the fio is greater than or equal to $1.$2.$3
 _have_fio_ver() {
-	local d=$1 e=$2 f=$3
-
 	_have_fio || return $?
 
-	IFS='.' read -r a b c < <(fio --version | cut -c 5- | sed 's/-.*//')
-	if [ $((a * 65536 + b * 256 + c)) -lt $((d * 65536 + e * 256 + f)) ];
-	then
-		SKIP_REASONS+=("fio version too old")
+	if _compare_three_version_numbers \
+	     "$(fio --version | cut -c 5- | sed 's/-.*//')" "$1" "$2" "$3"; then
+		SKIP_REASONS+=("fio version is older than ${1}.${2}.${3:-0}")
 		return 1
 	fi
 	return 0
diff --git a/common/rc b/common/rc
index 068a676..ff3f0a3 100644
--- a/common/rc
+++ b/common/rc
@@ -226,15 +226,28 @@ _have_kernel_option() {
 	return 0
 }
 
+# Compare the version string in $1 in "a.b.c" format with "$2.$3.$4".
+# If "a.b.c" is smaller than "$2.$3.$4", return true. Otherwise, return
+# false.
+_compare_three_version_numbers() {
+	local -i a b c d e f
+
+	IFS='.' read -r a b c <<< "$1"
+	d=${2:0}
+	e=${3:0}
+	f=${4:0}
+	if ((a * 65536 + b * 256 + c < d * 65536 + e * 256 + f)); then
+		return 0
+	fi
+	return 1
+}
+
 # Check whether the version of the running kernel is greater than or equal to
 # $1.$2.$3
 _have_kver() {
-	local d=$1 e=$2 f=$3
-
-	IFS='.' read -r a b c < <(uname -r | sed 's/-.*//;s/[^.0-9]//')
-	if [ $((a * 65536 + b * 256 + c)) -lt $((d * 65536 + e * 256 + f)) ];
-	then
-		SKIP_REASONS+=("Kernel version too old")
+	if _compare_three_version_numbers \
+	     "$(uname -r | sed 's/-.*//;s/[^.0-9]//')" "$1" "$2" "$3"; then
+		SKIP_REASONS+=("Kernel version is older than ${1}.${2}.${3}")
 		return 1
 	fi
 }
-- 
2.49.0


