Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A90EBD4334A
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Nov 2024 11:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BMbVHxHQseALIx2pyFsMD10fK0CPYIhh3LbBhWK4QQU=; b=rAXAZcbBom6iKCNS3/2zKofrY9
	7qgoe/C7/mmLNtEzBAyp9ZBhIoyth3YEkETA96YsXo2K85a/tyZteu4aaL7DAv4GtC8QX4lsNPqKe
	4I/nh0hlgAlqSPUhpULf1t8Z7u732iNaaTcJC39w2aUNScsT8/gGRT3vmrOkhoxwDh5fiznASck3R
	+EtKjvEXpqZU62Ig9q2dCYbbtvyYtcPNH+FQzSLIW3o6eyBvPukpDn7DU8eO2HodQAQTvIohcM6u7
	Mpvy0tpdM5w9w7eW26iQcoGAcjU6v1CQxoq5OQwWuSxQ94MQ+kxXcX+cB1TzU/Etl1UmpX++mDqt6
	PbiXoqHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t90Sk-00000006dyK-445s;
	Thu, 07 Nov 2024 11:14:06 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t90Se-00000006drt-30ai
	for linux-nvme@lists.infradead.org;
	Thu, 07 Nov 2024 11:14:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1730978040; x=1762514040;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SkzeBRlGxI3uq4SC2/DnB2YK+U5vN5I5tNL1i8pkVU0=;
  b=Yf3HGbYMwVhzQaC0kX+yKPhp68zJbNvqmgE18py8D8Twh3h84a3vsUDr
   ek+h7UXI0A8PQAX37riSLosvEnK12/e1HJSx3pBcaN/r+ct1tUiTvsEP8
   poupe6Csg9cwRuZsiJkQ6g19RWg3ycBbkysgqZp5hhpapmU8w3duf/NPo
   /3+5JwTBqn2FJsR7HAd7dfy82btuEp7AlQMRZtQMxc3lbjPlotCXZZQFJ
   OWd3RJfyZLWsdryDOVtAVWpXDU26hW/fgqaVSH7oEvutj9lpfmeaLN6lF
   9TJ9HA4/9J7GPym4P7FPE9zsbZChxiMklF6GhOrjnzWWHa0z+eKzyu3La
   w==;
X-CSE-ConnectionGUID: MbxsIxyxRieppbOHnFWW+Q==
X-CSE-MsgGUID: RFeZ86bPSKmvaYZQ4uC3WQ==
X-IronPort-AV: E=Sophos;i="6.11,265,1725292800"; 
   d="scan'208";a="30851680"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Nov 2024 19:13:58 +0800
IronPort-SDR: 672c93be_euYFvO2wO1XQDn13pemVP03/qgVLDiaZS7G4tmbM3MaIq2q
 ZIqOvsK7o5RAqNbkqI4K5TOairIUPTCWJ4iZhsw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Nov 2024 02:17:35 -0800
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Nov 2024 03:13:58 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 4/8] nvme/017: do not create namespace when setting up the target
Date: Thu,  7 Nov 2024 20:13:50 +0900
Message-ID: <20241107111354.80606-5-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241107111354.80606-1-shinichiro.kawasaki@wdc.com>
References: <20241107111354.80606-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241107_031400_877670_E575DCAC 
X-CRM114-Status: GOOD (  12.67  )
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
[Shin'ichiro: use for loop instead of seq per style guideline]
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/nvme/017 | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/nvme/017 b/tests/nvme/017
index 07b91a6..a22c748 100755
--- a/tests/nvme/017
+++ b/tests/nvme/017
@@ -23,16 +23,16 @@ test() {
 	_setup_nvmet
 
 	local port
-	local iterations="${NVME_NUM_ITER}"
+	local i iterations="${NVME_NUM_ITER}"
 	local nsid
 
 	truncate -s "${NVME_IMG_SIZE}" "$(_nvme_def_file_path)"
 
 	local genctr=1
 
-	_create_nvmet_subsystem --blkdev "$(_nvme_def_file_path)"
+	_create_nvmet_subsystem
 
-	for ((i = 2; i <= iterations; i++)); do
+	for ((i = 1; i <= iterations; i++)); do
 		nsid=$((def_nsid + i - 1))
 		_create_nvmet_ns --nsid "${nsid}" \
 				 --blkdev "$(_nvme_def_file_path)" > /dev/null
-- 
2.47.0


