Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC3C5D63920
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Nov 2024 10:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YFO3kSx+lY74rhQ9pxDH85zQ7VQ0EVjey1CCLg8dNOk=; b=iFy9u/52nBg126oyfEyAawXms3
	/C01OoRvLNxsEWj9ZSLVtFik5W4gqimoEhi8ciO4DGiOoy3Xh5UcXLwpRC6Wt4tXFKWOsIrWb8tKb
	VJGFiur+XwSn5Jq6s33kIFCO9LJfDC2ErM/Utn3bN/odqMjcpyjj75BKCluw+tqEQqzsAXxs5e/QL
	FpbzSn9RvN75KG3gd+ofUWy2rmvEkihWvw2Y+SHNLM422ptNUsJJaVW/6yOtrByEVRX6lCR433teT
	N6Gv6bl5pqEj+dH6AcuuOSqWAoz0Z42r1oSKQT5FrgaUmd4/iXwrVjyamYRT/pw9qgqdk0Rf8+1Rk
	60gMzkrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tDhpQ-0000000F2jY-3Qsb;
	Wed, 20 Nov 2024 10:20:56 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tDhpO-0000000F2jB-10Ip
	for linux-nvme@lists.infradead.org;
	Wed, 20 Nov 2024 10:20:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1732098054; x=1763634054;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pPkNc3jl15Gdr/6GmBSRrHcYN/n44bHC7UpdDj8V+Ig=;
  b=f+l4eLO/B7gb90NcRfVXQyhEEDPyLgL3uZIUYMZHayp/wbcONg+7yQb1
   DfL/U+Nlo3Y7nxiysE81Q+QlUoly+ZdZZ4CLDwSl1GZVWnUC1/+kylYy8
   qYiu9lk7co6zW9BImNEkauldJXErXOi/IoI9eVmqJIefr4AXxfhnIW39v
   4SCHuKNFtdcSTilZd1ICObw0W9OpLJSurAZ8qWmPXStFmKAPQBzlw5RZ8
   Ml2kvTJyjeroScyuGvjHEzA5I9eZZBbUME+kYUyK2N4Mb76JXhFDSREyv
   cf4fRQfe6Tvs3ABlpmZvmA62f3UK4KM1awPqtwTBwvDJ8zq8qFydjPiQ0
   g==;
X-CSE-ConnectionGUID: QVxfsXWtTxGWxHHm3AUX5g==
X-CSE-MsgGUID: iMkRf/9+SnCmajJZjJlExg==
X-IronPort-AV: E=Sophos;i="6.12,169,1728921600"; 
   d="scan'208";a="32934748"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Nov 2024 18:20:52 +0800
IronPort-SDR: 673da971_J1/Orw/aP2ouF7pf/iqAxAlSyUtImZTFVpndHECTJ+FkxTi
 SHCdxpRAhmDYK1I0mVPDEn5PvNt+zNPc/SLlCZw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Nov 2024 01:18:41 -0800
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 20 Nov 2024 02:20:52 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: Yi Zhang <yi.zhang@redhat.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests] nvme: delete all namespaces in _remove_nvmet_subsystem()
Date: Wed, 20 Nov 2024 19:20:51 +0900
Message-ID: <20241120102051.247995-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241120_022054_293148_23B36C09 
X-CRM114-Status: GOOD (  15.76  )
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

A subsystem might have more than one namespace, so delete all of them in
_remove_nvmet_subsystem().

This change was to be made before the commit 67e25d71bc58 ("nvme/052: do
not create namespace when setting up the target"), which assumes that
_remove_nvmet_subsystem() delets all namespaces. However, commit order
was modified then the test case nvme/052 now fails without this commit.

Signed-off-by: Hannes Reinecke <hare@suse.de>
[Shin'ichiro: resolved conflicts]
Fixes: 67e25d71bc58 ("nvme/052: do not create namespace when setting up the target")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
This patch is a part of the ANA support work by Hannes. It was once included in
the first series of the work, but it was dropped from the series to be included
in the later series [1]. After the second series of the work was applied, Yi
Zhang found nvme/052 fails [2]. It turned out that this patch is required for
the one of the patches in the second series, which is the commit 67e25d71bc58
("nvme/052: do not create namespace when setting up the target").

Of note is that this patch also prepares for one of the new test cases to be
included in the third series [3].

[1] https://lore.kernel.org/linux-nvme/20241024010025.2216242-14-shinichiro.kawasaki@wdc.com/
[2] https://lore.kernel.org/linux-nvme/20241120024925.1397864-1-yi.zhang@redhat.com/
[3] https://github.com/kawasaki/blktests/commit/31091d116eaea4e7d5ad3cf76e106d1085209c07

 common/nvme    | 5 ++++-
 tests/nvme/016 | 5 -----
 tests/nvme/017 | 5 -----
 3 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/common/nvme b/common/nvme
index 688193b..fd472fe 100644
--- a/common/nvme
+++ b/common/nvme
@@ -640,7 +640,10 @@ _remove_nvmet_subsystem() {
 	local nvmet_subsystem="$1"
 	local subsys_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
 
-	_remove_nvmet_ns "${nvmet_subsystem}" "${def_nsid}"
+	for n in "${subsys_path}/namespaces/"*; do
+		[ -d "${n}" ] || continue
+		_remove_nvmet_ns "${nvmet_subsystem}" "${n##*/}"
+	done
 	rm -f "${subsys_path}"/allowed_hosts/*
 	rmdir "${subsys_path}"
 }
diff --git a/tests/nvme/016 b/tests/nvme/016
index dd3cb44..95b0df4 100755
--- a/tests/nvme/016
+++ b/tests/nvme/016
@@ -47,11 +47,6 @@ test() {
 	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
 	_remove_nvmet_port "${port}"
 
-	for ((i = iterations; i > 1; i--)); do
-		nsid=$((def_nsid + i - 1))
-		_remove_nvmet_ns "${def_subsysnqn}" "${nsid}"
-	done
-
 	_remove_nvmet_subsystem "${def_subsysnqn}"
 
 	echo "Test complete"
diff --git a/tests/nvme/017 b/tests/nvme/017
index a22c748..3483929 100755
--- a/tests/nvme/017
+++ b/tests/nvme/017
@@ -47,11 +47,6 @@ test() {
 	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
 	_remove_nvmet_port "${port}"
 
-	for ((i = iterations; i > 1; i--)); do
-		nsid=$((def_nsid + i - 1))
-		_remove_nvmet_ns "${def_subsysnqn}" "${nsid}"
-	done
-
 	_remove_nvmet_subsystem "${def_subsysnqn}"
 
 	rm "$(_nvme_def_file_path)"
-- 
2.47.0


