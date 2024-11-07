Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4ECAD43349
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Nov 2024 11:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g5TWH78FxgoHRXiZb/oqvBct8ZI0AvXHhH+OpucuHFU=; b=H+2TDA6/mLpi+ZfZRrfi+9zvOt
	pZGHYk5WkD/gJeJmcK4RZgQh/mhUe+SNoPYgSCmSzrBaO0t/Ru0DlOJ9jBX6HZlesrQj9HVlcZ7+4
	Y1BbDYxWHFMZ6fdhL0p4dXrabeLQyXN5pk6cXyCOeie+BWZRoAVJ8TXP1koHZj2ESUeCmo0oyzAYg
	rZl6orQAnt9BPVfEkKisQIROVkewWxON08puSMzwMWP3ABgc9mpsSGWoOsERoM3rSsn5QZ7397w0C
	Hvr4fYXR7ZRg4+zcBoAWOi8IONwFF0Ht8oe2/ehLy7gyje9G1Y/nj9c2CpRzqWMqwT+jpFhXL+Zk/
	ERsjeSGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t90Sl-00000006dz5-3wv1;
	Thu, 07 Nov 2024 11:14:07 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t90Sf-00000006dtE-28Tm
	for linux-nvme@lists.infradead.org;
	Thu, 07 Nov 2024 11:14:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1730978041; x=1762514041;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HDSoCxyBZoInOpbCM4t8RFyRr0IO1RPKpVNl3JyVNgE=;
  b=ZtP5quNUxAom72LjEhkcCx9Nprujduqkh4qcj/5pN5or6eVTr/nsWJNP
   gmBM4N2G0ry5ukZc+vuV1DxItMQNUVVV9gwXyMjwIO0b4xwLtEIKjOfmW
   y8iDB1u/5N2gvuHnWr5A0tnxwEYys3qL51vqr2DQsb3NSTNPnBd0togYI
   xp+5y0NzkqYurYOd4IkWe8stSffukS6ME4XLwJY0I5rLWscGl4xBrAl7P
   ep5Ee/79rW9u9eInre5ojwEEYEF31s86cxihbZ4gk5/pZGRXdwehk/p1C
   r2vy+NgpcNUg8/PA9lGEnj4E6JGlykD8o8whBJgcWpIbuQh67RtB3c217
   g==;
X-CSE-ConnectionGUID: oKTeNUOxTOeVjefGLmAC7A==
X-CSE-MsgGUID: SMKvkHc/RZSCKcHRwlD41g==
X-IronPort-AV: E=Sophos;i="6.11,265,1725292800"; 
   d="scan'208";a="30851683"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Nov 2024 19:13:59 +0800
IronPort-SDR: 672c93bf_vZ49FXR1EqfboZRR/DW3WKMxE/QFIpSpBJflamTWtvbHIcZ
 trzfCZRpfvI2T+mmVruZ+jRo4TfZD2wRWx7Prng==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Nov 2024 02:17:36 -0800
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Nov 2024 03:13:59 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 5/8] nvme/052: do not create namespace when setting up the target
Date: Thu,  7 Nov 2024 20:13:51 +0900
Message-ID: <20241107111354.80606-6-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241107111354.80606-1-shinichiro.kawasaki@wdc.com>
References: <20241107111354.80606-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241107_031401_665023_09A4691A 
X-CRM114-Status: GOOD (  12.88  )
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

Simplify the testcase by not creating a namespace when setting up
the target and have to loop iterating over all namespaces.

Signed-off-by: Hannes Reinecke <hare@suse.de>
[Shin'ichiro: resolved conflicts]
[Shin'ichiro: use for loop instead of seq per style guideline]
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/nvme/052 | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/tests/nvme/052 b/tests/nvme/052
index 2548f5c..8443c90 100755
--- a/tests/nvme/052
+++ b/tests/nvme/052
@@ -51,17 +51,14 @@ test() {
 
 	_setup_nvmet
 
-	local iterations=20
+	local i iterations=20
 	local uuid nsid filepath
 
-	_nvmet_target_setup
+	_nvmet_target_setup --blkdev none
 
 	_nvme_connect_subsys
 
-	# start iteration from def_nsid+1 because def_nsid is created
-	# by default when nvme target is setup. Also def_nsid is
-	# deleted when nvme target is cleaned up.
-	for ((i = 2; i <= iterations; i++)); do {
+	for ((i = 1; i <= iterations; i++)); do
 		nsid=$((def_nsid + i - 1))
 		filepath="$(_nvme_def_file_path).${nsid}"
 		truncate -s "${NVME_IMG_SIZE}" "$filepath"
@@ -84,7 +81,6 @@ test() {
 		fi
 
 		rm "$filepath"
-	}
 	done
 
 	_nvme_disconnect_subsys >> "${FULL}" 2>&1
-- 
2.47.0


