Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A29BD0BB4A
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Oct 2024 01:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f/t4hklcGMcC2IEToGuI30+/jtAWpkrc4Wz0EwB4WcE=; b=mhg/9s/4Yah8catXI0GZTqJyau
	4rJZLsI4cXZtE+rrjegdQLUo9UoS0LPXMUPxU5epEEaDs+fTGGYEMyWR2VjzFDtDIsWezt873VSqI
	4iHmk7XzQ2Kp2kHcAOej0v+5YwLvwQVhYVwBtJsoVIZIa6sSekQJ+ddtFj3lAj+inFmgP9nuIHHF4
	tVdH48TAEXMeGhr1qW31vlZi+NpK8EQeb9UTEM8uu2sPxbjolaOH01KYaMkfoAWH9x5qEfPUsWszO
	/2p38O+kU6Hd2WMET0HssWz1LaV/At4imbrvotI9j+i3ayFtTtZsS+NkvOacojIKHokdk//xUubF9
	WQDq8OAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3mDX-0000000GMjK-0SYh;
	Thu, 24 Oct 2024 01:00:47 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3mDM-0000000GMXt-21CX
	for linux-nvme@lists.infradead.org;
	Thu, 24 Oct 2024 01:00:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1729731636; x=1761267636;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZdzWOf3Ju7u+EqB2oU4OJUBRZFoRN2wAochBbzjUi1A=;
  b=oocgvekh2a+o+RHxGFTDSOC9zSNjKzHFDrK4J0zq1BdsMz4dJU1hkLQq
   Mh67HuZjnJ5P7Y/SWJKiJXCcox1cWwj0pAuWDjphz/6xhgOSiaJLI9xTD
   Xt7sp4HJ0+p3YUyAR1ZReDbS3+CZBNZjPdPOyCIcFZQHzZxjJI5UOrBkQ
   boN+ATR+SioKMP0qEwpLYqRJCn4GIDQAdyPnzUDv0KC5kzG1gmR8jVaOo
   wxCMEuQKYWqLTSj1faXwIX+R+lfBshXV2mH+/egpqVzsifdle83PskgO5
   kpQ9SoSrY3WeX3U7Ctk1X2Z9mTWFXTUuj8pvT8O7Gwu9saghUi+CiPxKB
   w==;
X-CSE-ConnectionGUID: o6wk45E5QrKJjjLun+DHeg==
X-CSE-MsgGUID: sAEjdlnhSJWXuz7jL7Iedg==
X-IronPort-AV: E=Sophos;i="6.11,227,1725292800"; 
   d="scan'208";a="30211134"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Oct 2024 09:00:33 +0800
IronPort-SDR: 67198f19_7yX/ybIfLwIsqtptb18byILbu0djDTil8B10sjU1VVSYRLB
 39o6ltOWittmFqByXiwOp0OH2tnPQaYV2FGqaQQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Oct 2024 17:04:41 -0700
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 Oct 2024 18:00:33 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 08/15] nvme: simplify _get_nvmet_ports()
Date: Thu, 24 Oct 2024 10:00:18 +0900
Message-ID: <20241024010025.2216242-9-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241024010025.2216242-1-shinichiro.kawasaki@wdc.com>
References: <20241024010025.2216242-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241023_180036_638405_08A448A7 
X-CRM114-Status: GOOD (  10.95  )
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

Signed-off-by: Hannes Reinecke <hare@suse.de.
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


