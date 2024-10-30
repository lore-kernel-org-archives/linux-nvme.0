Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1412DD74977
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2024 06:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ts1e3Zde5BGNIF683xXUASKAT33hzD13R6RZihvPKXk=; b=jcUhkmIE4X0PkPMNpL94tRvSgA
	DMnnlO0l9aHNwuGFaE7UsWzLtZfRiQvvyZIkAJ44jfEGCDkmjeJj+6XnaD1DH9wkK8KHQFwzQjgSB
	C+Dl3kCDZVCAk9afIJ0AFo7AMCcG/dr6UWzKZxY9ed55svzZ6C70Sc358r33lCZQRRBaFbUJlaRms
	mOmCZhHYUrd7lEid6i4qizaexx1jzsQ0qdnE0J3hoHE+z8wDTfhd0gR/ABCilfFv4Iipf/mMcXIn0
	CHvSkDuAYJFFywuxrHsgNNi/F/r77L2+0vHnFtKmgvPDnxw906I15PVLNyzoekixK6aVh1uxzA809
	t0m4N+dQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t62Yu-0000000H2NQ-2uq3;
	Wed, 30 Oct 2024 06:52:12 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t62Yg-0000000H2Dc-0Vad
	for linux-nvme@lists.infradead.org;
	Wed, 30 Oct 2024 06:51:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1730271118; x=1761807118;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2uY2DGwFBeqqtXzdz3N3DWeM+i1jWefwNOoGjQlLOGY=;
  b=VHeaxrjLgntC1Ecc/TAzxT+fe170U+gB2OoPi/KqiuWMifYcT1+tMz6z
   wGHKcU48y7iTWx7lWNDYgOO2oOZfVeGYxTS5gAxgzEKeHxlrkuUTWYZTP
   cNDJL60Cszu7fxxawDcQAlXEYU1cO4sWuSNoRtHfwKhIOUuCuIMvs9uNJ
   6tZA2slHVkTJS2VDe9PI6XOHPFrcO0GMR/8NHUXm7ZPod1pqRy9YGHZO/
   iit0wPzz+a4oIi0v76p/sDHyrl11eRAxkiPyNRO1rLIG1yhAisNeBTLIn
   u9d9cFcbHM6sj0yhWiPx2dELm+e6mQIE1m1IUG5fR0T+8/eQP5Up9qedl
   w==;
X-CSE-ConnectionGUID: udAp/goLRrucSDnHx4+lQw==
X-CSE-MsgGUID: GyleXSw6Q9Gi//a2PbQLZg==
X-IronPort-AV: E=Sophos;i="6.11,244,1725292800"; 
   d="scan'208";a="31314344"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2024 14:51:57 +0800
IronPort-SDR: 6721ca5f_ymBASEAS8hEMbCIiXb17nOxMpy83Z/QFDl3Tb18YxM1TV3G
 gDRD0X1HfQGsylLdyW3MUvSjpGSBjq5YUjqjSTA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Oct 2024 22:55:44 -0700
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 Oct 2024 23:51:58 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v2 08/13] nvme: simplify _get_nvmet_ports()
Date: Wed, 30 Oct 2024 15:51:44 +0900
Message-ID: <20241030065149.2297405-9-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241030065149.2297405-1-shinichiro.kawasaki@wdc.com>
References: <20241030065149.2297405-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_235158_191818_0A52D455 
X-CRM114-Status: GOOD (  11.46  )
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

Rework the loop to iterate over ports, and check for the correct
subsysnqn afterwards. With that we can drop 'sed' calls and simplify
the loop.

Signed-off-by: Hannes Reinecke <hare@suse.de.>
Reviewed-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/nvme | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/common/nvme b/common/nvme
index 5d2e38e..758df33 100644
--- a/common/nvme
+++ b/common/nvme
@@ -672,15 +672,14 @@ _remove_nvmet_subsystem_from_port() {
 }
 
 _get_nvmet_ports() {
-	local nvmet_subsystem="$1"
+	local nvmet_subsysnqn="${1:-$def_subsysnqn}"
 	local -n nvmet_ports="$2"
 	local cfs_path="${NVMET_CFS}/ports"
-	local sarg
 
-	sarg="s;^${cfs_path}/\([0-9]\+\)/subsystems/${nvmet_subsystem}$;\1;p"
-
-	for path in "${cfs_path}/"*"/subsystems/${nvmet_subsystem}"; do
-		nvmet_ports+=("$(echo "${path}" | sed -n -s "${sarg}")")
+	for port in "${cfs_path}/"*; do
+		if [[ -e "${port}/subsystems/${nvmet_subsysnqn}" ]]; then
+			nvmet_ports+=("${port##*/}")
+		fi
 	done
 }
 
-- 
2.45.2


