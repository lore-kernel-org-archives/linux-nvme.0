Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 375CEC28B20
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Apr 2025 07:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b7jIjZs6egaylkxZkJuyvTmfSoJw54OiPgj6nxdREPg=; b=f4pgpcYqmgnz1z/37PWb1SCpVp
	Ka4VoZEBYnQ2Nfl+e2czCuP8q5VBavW0ZHJHhj8rTtko4avaVKAU//OlDE1DthmTLt43MWGhK+9wn
	LkWCnZwSipjnASZu9n3JZ9brb8BxV1r6ikgpspluSuFr3LDhg0usdHULqSHi+tyHj7XaHV7ox5CnR
	m85thumdRSlzBcwe4PiE+1qS9FLjF7NG+5S6pVsYt18ygOmlpJwDEYvrTnnPz2Ih6f5A+OcMiHkg8
	X2lEswb0w9PldvfTk7Vtt08NGuvUm4f5cbPAXBcEWtXYY1COK2HNtjQyMWufMrREg/2C4pR8EXVU7
	czJGhLxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzsZ2-00000005NG0-3M3o;
	Wed, 02 Apr 2025 07:31:08 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzsDs-00000005Jwm-3m6x
	for linux-nvme@lists.infradead.org;
	Wed, 02 Apr 2025 07:09:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1743577756; x=1775113756;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TINAFm3X74n/MGQFIZO+LLmFc58R1cN4e58MBJh5UUA=;
  b=hFrraZd3vGoKT4+tF5OPTjGQ+QJFRD63VoEKSnLY/tJhDRwX1P0kijGb
   Dr2ujk5qva3eovNE8sVHR7+9oMlRvIxIIiNmFMW0vjcCaCmaqdRoMdAs2
   ssDn61y16p2lUf1OFn0bhWgxmgq7kkP/VwvXFWQZpaZE1YLCPXQ29pOJ2
   5gx09ML8jBDhhKaWV3jWCxRTOAAWaV8TFwNz2yGmjEhJingsN7Sn0sgsi
   6vOpx/kRdsXioN5Vs1J4hxZJ2xl0oYyL05zaZjBRgc6Fcn8eKD32zAXhR
   XanTUjUlLM9ZVXA3V+JxknL4VuMbrgIg2H2Z4CUdEAyvhCujzeF4+12S7
   g==;
X-CSE-ConnectionGUID: 5wCFv3B/RKukG4iDK9bgXQ==
X-CSE-MsgGUID: ULEmzHBbQ8WI7m8dz13F7Q==
X-IronPort-AV: E=Sophos;i="6.14,295,1736784000"; 
   d="scan'208";a="67793497"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Apr 2025 15:09:16 +0800
IronPort-SDR: 67ecd4a5_b+fOZaSu6h758Byub9Y5UgojhEuYBYD5C/EmFkxsD1hA9f+
 T/dQ/C+KMXI0C9mZjMDUKDtCT0zoJ1IY4I22MUw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Apr 2025 23:09:41 -0700
WDCIronportException: Internal
Received: from 5cg2075fn7.ad.shared (HELO shinmob.wdc.com) ([10.224.102.114])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 Apr 2025 00:09:16 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 07/10] common/nvme: TLS target support
Date: Wed,  2 Apr 2025 16:09:03 +0900
Message-ID: <20250402070906.393160-8-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250402070906.393160-1-shinichiro.kawasaki@wdc.com>
References: <20250402070906.393160-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250402_000916_944361_10E3C90A 
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

From: Hannes Reinecke <hare@suse.de>

Add --tls option to _create_nvmet_subsystem and allow to specify
the tls requirements in _create_nvmet_port.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/nvme | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/common/nvme b/common/nvme
index 9327dff..47bcdc9 100644
--- a/common/nvme
+++ b/common/nvme
@@ -477,6 +477,7 @@ _fc_host_traddr() {
 }
 
 _create_nvmet_port() {
+	local tls="${1:-none}"
 	local trtype="${nvme_trtype}"
 	local traddr="${def_traddr}"
 	local adrfam="${def_adrfam}"
@@ -513,7 +514,13 @@ _create_nvmet_port() {
 	   [[ "${adrfam}" != "loop" ]] ; then
 		echo "${trsvcid}" > "${portcfs}/addr_trsvcid"
 	fi
-
+	if [[ "${trtype}" == "tcp" ]] && \
+		   [[ "${tls}" != "none" ]]; then
+		echo "tls1.3" > "${portcfs}/addr_tsas"
+		if [[ "${tls}" != "required" ]]; then
+			echo "not required" > "${portcfs}/addr_treq"
+		fi
+	fi
 	echo "${port}"
 }
 
@@ -878,6 +885,7 @@ _nvmet_target_setup() {
 	local port p
 	local resv_enable=""
 	local num_ports=1
+	local tls="none"
 	local -a ARGS
 
 	while [[ $# -gt 0 ]]; do
@@ -910,6 +918,14 @@ _nvmet_target_setup() {
 				num_ports="$2"
 				shift 2
 				;;
+			--tls)
+				tls="not-required"
+				shift 1
+				;;
+			--force-tls)
+				tls="required"
+				shift 1
+				;;
 			*)
 				echo "WARNING: unknown argument: $1"
 				shift
@@ -956,7 +972,7 @@ _nvmet_target_setup() {
 
 	p=0
 	while (( p < num_ports )); do
-		port="$(_create_nvmet_port)"
+		port="$(_create_nvmet_port ${tls})"
 		_add_nvmet_subsys_to_port "${port}" "${subsysnqn}"
 		p=$(( p + 1 ))
 	done
-- 
2.49.0


