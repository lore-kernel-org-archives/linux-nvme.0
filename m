Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBF9BD4334A
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Nov 2024 11:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wMAJrmNc0mlWt0Usya0sP7Jc7FsOGGfhsHOoaZdGE5o=; b=iEYEdrp9qtNRWPZB8/as1dnPgK
	u7EDFiveiGNm4fintK6EJ19ITWsOgG+PHNyEN3El74zgzLb+QIGlPPjcfK8AlR8/P+pr2Y30bhmm0
	4NFgr4iNGbpQ2K2d0eFTyGZM1vrVQa5cKZMJGKQM8d+DIifkTSw2+pJ5STFITbKV4LgRiNbBfoZg7
	KIczvlg2YJ0Q8DaV9rpIoO7DDkGKWPGFzQanJAB0lc0TNujujA0ZTXrPQaiMgH+nIfRmKMrFTsrgW
	3eVsdu0O3it8hUjB+nAKn5HJwc9BepfwNwHHQZukiNKkGliznIkT1X9RNRqIIjcxQzHeMDWSDsOX+
	16HFtNVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t90St-00000006e6d-3Gz7;
	Thu, 07 Nov 2024 11:14:15 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t90Sh-00000006dtE-0uly
	for linux-nvme@lists.infradead.org;
	Thu, 07 Nov 2024 11:14:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1730978043; x=1762514043;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iQMx6e3YVr7TQefKSEDpPW5yOeJ6kigZR3A/E1sKpTY=;
  b=Ko5JEckwcPYC+U0sciZNHkD7IB7Xn8+hbqGyenWIF+P0AcIvcg/tjMTI
   TH3JkyVTQXFC6SDtJacT9h4fWyMI4dXo7mcQuHm9V3VR+aiEOzDwBp1/c
   06m/PutETwXYcDJ4fFgunDLm+Glu2Lgs80E/8EjpGG/ajST8MuuzrD8Rt
   pAuMqndlDRm132BHTDSCrOaFF9LskGMw5W+GUYlOEpdadTqeblJdamBjk
   zfwhNazANAFdOrzwR4a9Q5RqWUBhwaDtWeH4FFuSIt6NQx/ATERky+weY
   awR8GCHfwLI0Uish/v3rrQjI7npgmCHuKCjSqCgwOSMEhOO3Ug+MG40uD
   Q==;
X-CSE-ConnectionGUID: PpB+JsXzSzaFKD/Vs/faxA==
X-CSE-MsgGUID: 8CA9aW8ET7OxFn2dZL4+4g==
X-IronPort-AV: E=Sophos;i="6.11,265,1725292800"; 
   d="scan'208";a="30851687"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Nov 2024 19:14:02 +0800
IronPort-SDR: 672c93c2_/YitiH3V/ddh7uFedyVrllyWw7HJneByAGsZ/Qs3++3686T
 UBWLsEX//bH190bETjKupN0MBabgxuGchrCkuyA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Nov 2024 02:17:38 -0800
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Nov 2024 03:14:02 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 8/8] nvme: drop arguments from _create_nvmet_port()
Date: Thu,  7 Nov 2024 20:13:54 +0900
Message-ID: <20241107111354.80606-9-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241107111354.80606-1-shinichiro.kawasaki@wdc.com>
References: <20241107111354.80606-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241107_031403_355850_3ED6F1A9 
X-CRM114-Status: GOOD (  11.13  )
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

Always called without arguments, so drop the assignment.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/nvme | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/common/nvme b/common/nvme
index 1190de7..688193b 100644
--- a/common/nvme
+++ b/common/nvme
@@ -430,10 +430,10 @@ _fc_host_traddr() {
 }
 
 _create_nvmet_port() {
-	local trtype="${1:-$nvme_trtype}"
-	local traddr="${2:-$def_traddr}"
-	local adrfam="${3:-$def_adrfam}"
-	local trsvcid="${4:-$def_trsvcid}"
+	local trtype="${nvme_trtype}"
+	local traddr="${def_traddr}"
+	local adrfam="${def_adrfam}"
+	local trsvcid="${def_trsvcid}"
 	local portcfs
 
 	local port
-- 
2.47.0


