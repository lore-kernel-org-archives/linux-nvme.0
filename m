Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6B78D6EC0A
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Nov 2024 13:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y7UyIsLixo+x2f06jx27wlqZ8HUxbc/cJv2ZLOVAY4o=; b=mRFsEIBd09ocPwXqKvaw7vNHLJ
	6IPA3ck5MBWGQvO3MfwAppDpp4AV+gZ+EQys4cP75e57PFg6+BwGDUciL0nLmj2e4eJaNgPdnH9FH
	4ydchIu8u1uAreAb/OyHPYg4573+mcpXQGJSbJO2ZW9Rgp9HYfkD4wl13Cxoz9TxrhmWyhy3axdAW
	O78UJx6DyY7/0pwOrhRDyxqJ4jnoZ+qQotuLXDqmpi9FmRVE+DOA/oFskC29MkdGNUewmi+A3pyhz
	NDMvGQIP0Qnxf5mY1Mu39XODirUrbCyj+YTvMnmz3qYkkRmD3XtgirBKfhVyWy8B16hzi7GIHzF3h
	zLw6i+CA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tH10u-00000000BMf-0nJv;
	Fri, 29 Nov 2024 13:26:28 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tH10p-00000000BIH-2oL4
	for linux-nvme@lists.infradead.org;
	Fri, 29 Nov 2024 13:26:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1732886783; x=1764422783;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aiOILeI6mKGmj3hYfxMx39ariUVOzeujD/Xekw3N4+4=;
  b=qIBTYX/qregfciTNQQcmKDM5bcihFv9qcIetNEpyp6LUO3vmkPLPe9F9
   hs7t+fSqV93q8m9R81FgOfMcc4PhREvSDx5ClBsLkyxGEJRV7vktRJU6B
   pEWIPzru8O/FzNUHGdamdS7pe/rSqmKrGFOAcgOF6sg2v441XqHxNt53L
   Nd15VA6HXw/oYHxJO6ip3QYamQ2TSKLQ2UYCLGUBLuR56q4pxbGIVUvgk
   nrcHzz/5r9RY0XiRrSbj4GJzeovd3jT49c6CQ2Ualm8Mue+4m325kOgUw
   2lu28EGWL4sY5h5kyu8QwR+mc3mmRlRep1XkqOSW9rVHdhtXyc1SQMmOk
   A==;
X-CSE-ConnectionGUID: VhKOvFB5RYqVk/vP2nUgWg==
X-CSE-MsgGUID: p4R1moZrTmSv9EsxBnbC8A==
X-IronPort-AV: E=Sophos;i="6.12,195,1728921600"; 
   d="scan'208";a="32015171"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Nov 2024 21:26:21 +0800
IronPort-SDR: 6749b25e_aL3TasX6Xl4EE87dANu6iPX5EDjvO5BerF3SpTB0l6rCsN9
 TRcXk0fD7j2fAy4FzcngqIavPFARUqs4xG77wvw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Nov 2024 04:23:59 -0800
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 Nov 2024 05:26:21 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 3/7] nvme: add _setup_nvmet_ns_ana()
Date: Fri, 29 Nov 2024 22:26:13 +0900
Message-ID: <20241129132617.400429-4-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241129132617.400429-1-shinichiro.kawasaki@wdc.com>
References: <20241129132617.400429-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241129_052623_769389_96DC0784 
X-CRM114-Status: GOOD (  10.55  )
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

Add a function to set the ANA groupid for a namespace.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/nvme | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/common/nvme b/common/nvme
index e11776b..9786e4e 100644
--- a/common/nvme
+++ b/common/nvme
@@ -564,6 +564,19 @@ _create_nvmet_ns() {
 	echo "${uuid}"
 }
 
+_setup_nvmet_ns_ana() {
+	local nvmet_subsystem="$1"
+	local nsid="$2"
+	local anagrpid="${3:-def_anagrpid}"
+	local subsys_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
+	local ns_path="${subsys_path}/namespaces/${nsid}"
+
+	if [[ ! -d "${ns_path}" ]]; then
+		return
+	fi
+	echo "${anagrpid}" > "${ns_path}/anagrpid"
+}
+
 _create_nvmet_subsystem() {
 	local subsystem="${def_subsysnqn}"
 	local blkdev
-- 
2.47.0


