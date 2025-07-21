Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D46FC87FC5
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Jul 2025 17:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dYhY74J8bJ3ilFjTGclu1hZEsozjGDpwdnIlyfumlZk=; b=WB9TlrI3agMTe1G+Rf2Sexkc8y
	tMN1kwkzXTIe1iiAYk4wbifho/orStjsYPbZI4ov8GxQTBjt5JrWgBcysCIndBx8gTGex+0lMpd3U
	Mqd09vsf5y0NOvgkEjrbVhBlB97frxFO0UMJcdqbMJ2CLll2wpLqoSMQy/0frtJzD4/X2SPnJqg5u
	iNg9V2P1+eWclTEV9gWiKW1fwSFyH4uVA4tzy4L5iYPkR7JI1RrMR/IgVLDIMFt5nBiPqWqftbk/1
	3FW6rlKHwWwN47vhAow5Qaa1NvKWqo/FImI6H+d/s8oVYz0wqQbICc9fEYb5QDKAB+3f6rKUa0iXT
	p+sHOyZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uduiM-00000000N01-24Cy;
	Mon, 21 Jul 2025 17:54:14 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uduRk-00000000Kk9-3yag
	for linux-nvme@lists.infradead.org;
	Mon, 21 Jul 2025 17:37:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1753119424; x=1784655424;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CJds0Lr+8Es9u+yAumJM5EvNWV0O6fqnJESH/YqrpHk=;
  b=EqzimBxZqncA3YIi0/L4k0kXutRbND4SkUC4xlBCJxZkvps12pkYvOBQ
   VzLAwFig2x+wNSMSyBGTs9AJyBImDzleIn6V9/mYiUPfiQxQEfJI13KQD
   ZhT8650pCUQ7ZAyjaWhkSm3YwltVpqseS4lP5hj4BHy4B9RhkIwL/xd7Z
   ZQnNx7+q+pUcOf7muXAYXXwLikjGJ/chVW/yCvwFYElrDqXDwycGaYPX2
   R+n3NXbpCaBgyoV8bzNUCN/QTCK4YWw2xl5WIb7wwdZvTb2qBY3neVUWH
   va0mWbKovEU/f/T0fupW++SRMz3ZwihjGuXxJMko69ZeB4PQwnRyt8FiJ
   Q==;
X-CSE-ConnectionGUID: 7w9xGAvOQfyWqfBhi7ygBg==
X-CSE-MsgGUID: q6zKJAJ8QoW7LP3nZbllJw==
X-IronPort-AV: E=Sophos;i="6.16,329,1744041600"; 
   d="scan'208";a="93974997"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jul 2025 01:37:02 +0800
IronPort-SDR: 687e6c13_kpQ6JXNdWB/WVz5uwnZ/+eKvUYjKAgb86K4Et9hqSlnlp7T
 uc96+hBDvRMID3o7WfuREygM97vtCy8aBtZAzvA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Jul 2025 09:34:28 -0700
WDCIronportException: Internal
Received: from ros-3.wdc.com ([10.23.145.79])
  by uls-op-cesaip01.wdc.com with ESMTP; 21 Jul 2025 10:37:02 -0700
From: Kamaljit Singh <kamaljit.singh1@wdc.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: cassel@kernel.org,
	dlemoal@kernel.org,
	kamaljit.singh1@wdc.com
Subject: [PATCH v4 2/2] nvme: prevent admin controller from smart log fetch (LID 2)
Date: Mon, 21 Jul 2025 10:37:00 -0700
Message-ID: <20250721173700.4153098-3-kamaljit.singh1@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250721173700.4153098-1-kamaljit.singh1@wdc.com>
References: <20250721173700.4153098-1-kamaljit.singh1@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250721_103704_991950_A01B8954 
X-CRM114-Status: GOOD (  15.08  )
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

Similar to a discovery ctrl, prevent an admin-ctrl from getting a smart
log. LID 2 is optional for admin controllers to support.

In the future when support for the newly added LID=0 (supported log
pages) is added, GLP accesses can be made smarter by basing such calls
on response from LID=0 reads.

Reference: NVMe Base rev 2.2, sec 3.1.3.5, fig 31.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Kamaljit Singh <kamaljit.singh1@wdc.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a6388ed3ddca..0cec1e58e845 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3700,7 +3700,7 @@ int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl, bool was_suspended)
 
 	nvme_configure_opal(ctrl, was_suspended);
 
-	if (!ctrl->identified && !nvme_discovery_ctrl(ctrl)) {
+	if (!ctrl->identified && !nvme_discovery_ctrl(ctrl) && !nvme_admin_ctrl(ctrl)) {
 		/*
 		 * Do not return errors unless we are in a controller reset,
 		 * the controller works perfectly fine without hwmon.
-- 
2.43.0


