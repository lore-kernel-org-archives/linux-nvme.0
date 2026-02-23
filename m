Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2935E98DF3
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Feb 2026 07:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iVerhcYmjAIj42k/2rQdNZFliXniR7LcGFDy2wtRrHU=; b=UCFyFwjaOlhFw7gqxQOYwmRDek
	eHArvUe4dHlzDfiRg8HCaFd57RVpFr63epyBkrgxHAiFX639Ru/3keYkFspLBAnA40q45X+HZdW0K
	2cYOiCwRbsqF3O3e8SWFsumxXwjibeTBiKVHosCIgIQjQrxidgkit84JRcLQMCDRwZJUWqHlVfFHy
	zwKer6YIt6mdnfBNNhoVTbr/7+VMzTt+B3Bqrg91KWZVOSN+PSXHami6UsmoHHoHN+0DY4z4ochA0
	EU9Gm+cw8M/1/04nCLQemdiOj1CLmFH6BDHN/YE5rZqXoO41BGWi0/py7TveGRc9GwBa9HhsGcEik
	bwFR7UoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuQZD-0000000HOOZ-3m7l;
	Mon, 23 Feb 2026 07:41:19 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuQZ9-0000000HON3-2rYw
	for linux-nvme@lists.infradead.org;
	Mon, 23 Feb 2026 07:41:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1771832475; x=1803368475;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z7EHGTUJatx1XpP3ZQWdxqIemjSrwDl6rN0F6p0eYCY=;
  b=Xp+jOG9yXGrfpzSdUs+2uJ7mw9L3yzMNrupnjqSBTOE+YY4sqhvgcUW4
   4ovZlDb5BdmEMMFK6iLwimVSxPw+HmSL482RRteUPMGTe0o7MsZaQb6Z5
   Zt1MZbo4AKM77CRfG2Z1lGV577iFXdG72pMLA0LRmXVwCj//5ZEXKRomZ
   ct6kVf9a4MYVEYT2VzBDCWIBSU+8hWD9eFZCJmmuqX6eLW321QQvRyLsY
   aOouA9l5X3paT1t4UnxdulfGGaBq11Dknb6dbicsAP5wiaWjK/HU9iA3Q
   TOxmawD9zhkiPT1ku3WzEVIiXg8xINFW5sq99mGcSKgr4Pbm/Cg9J1QgO
   Q==;
X-CSE-ConnectionGUID: 3aiud03JRE6wuFGRMUmC2Q==
X-CSE-MsgGUID: GGLWyeOfSZCfKKtSnceQ0Q==
X-IronPort-AV: E=Sophos;i="6.21,306,1763395200"; 
   d="scan'208";a="141214632"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Feb 2026 15:41:15 +0800
IronPort-SDR: 699c049b_ycBod8U/TrHe4xMf4BqJIv3UXwyt4fkiyhNGBQRfFIx87Py
 qnBkbKdyCGQalIlJ2jzBYRfdRkEMFa11v9Lj8aA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Feb 2026 23:41:15 -0800
WDCIronportException: Internal
Received: from 5cg217417w.ad.shared (HELO shinmob.wdc.com) ([10.224.109.142])
  by uls-op-cesaip01.wdc.com with ESMTP; 22 Feb 2026 23:41:14 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 2/3] check: increment bash requirement version from 4.2 to 4.3
Date: Mon, 23 Feb 2026 16:41:09 +0900
Message-ID: <20260223074110.144758-3-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260223074110.144758-1-shinichiro.kawasaki@wdc.com>
References: <20260223074110.144758-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260222_234115_721462_9CC717C4 
X-CRM114-Status: GOOD (  13.32  )
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

The helper functions _get_nvmet_ports() and _get_nvmet_port_params() use
the bash 'nameref' feature, introduced in the bash version 4.3.
Currently, blktests README and the check script declare bash version
4.2 as the minimum bash version, leading to a version mismatch.

Fix this inconsistency by updating the minimum required bash version
to 4.3. Note that bash 4.2 was released in 2011, while bash 4.3 was
released in 2014. This change is unlikely to affect blktests users.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 README.md | 2 +-
 check     | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/README.md b/README.md
index e993105..b137a43 100644
--- a/README.md
+++ b/README.md
@@ -12,7 +12,7 @@ filesystem testing framework. It was originally written by Omar Sandoval and
 
 The dependencies are minimal, but make sure you have them installed:
 
-- bash (>= 4.2)
+- bash (>= 4.3)
 - GNU coreutils
 - GNU awk
 - util-linux
diff --git a/check b/check
index a2c19a2..8c113b3 100755
--- a/check
+++ b/check
@@ -1074,11 +1074,11 @@ _check_dependencies() {
 	local -A required_commands_and_packages
 	local cmd
 
-	# Require bash version 4.2
+	# Require bash version 4.3
 	IFS='.' read -r v1 v2 v3 < <(bash --version | grep version | head -1 | \
 					   sed 's/.*version \([0-9.]\+\).*/\1/')
-	if ((v1 * 65536 + v2 * 256 + v3 < 4 * 65536 + 2 * 256)); then
-		_warning "bash version is older than 4.2"
+	if ((v1 * 65536 + v2 * 256 + v3 < 4 * 65536 + 3 * 256)); then
+		_warning "bash version is older than 4.3"
 	fi
 
 	# Check dependent commands to run blktests
-- 
2.53.0


