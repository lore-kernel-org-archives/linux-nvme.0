Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E67CC83F04
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Jul 2025 00:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=PBczThBKVUg14mp0exhlHBDMR+WCF0wjh03XAjWta2M=; b=KqDjBBXc7eoQ9R8QrZP+QeD3Zy
	YqYh9tfg/u4rlw1tec8tA4vPAgUKoE76JvX27XUFCEZuO8LMmLIMySPMyvIizFDlF8utl+DumUVeZ
	WRgNr1JFYthv9Nx8414+bn/gqN1dUsh+DP8xB7eIOPvXav1/3WXB7G8iqwcTcPQTcHqa7vI7drtBj
	gAj/xBjNkR/rYFfb4xFsJniT0hKaE4Bewo94hoU84oAlKSCNp1TuQRpnQAK8DM4FcsETYbTbJy1iZ
	t3otcg5jJ7Xadu55IZQzoUQ/FM1sPOm9pAHQ7/hkNB3Qu847DNkbBicr75+Z5wqJdIJpFeP7qWlh6
	rGNKNcrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWlo3-00000006wWc-1qnD;
	Wed, 02 Jul 2025 00:58:35 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWlo1-00000006wVV-19RA
	for linux-nvme@lists.infradead.org;
	Wed, 02 Jul 2025 00:58:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1751417913; x=1782953913;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=n42XEmlwI9c+//NMG8q8fg4flyY6Xnx1t5tK0abhNT4=;
  b=iz3py3OCXkNH8dCq8aSXBsV+or72l6R6XadNas+h5vHg0KatyOR3G7pX
   GFTWo7B6ab+kjXRDOMLR1jlMtKz8gJ3I3W56yi2lXpEx8Cww90o1DMdM2
   uk86Tq1R8Ipm7HwaDpxL2QhSEbwqj4QTogaM8n++hBtOMfHlvrFFc36kT
   g9SyyDgb1VEftKuJ833Gxdu+FPjhLjkl7n1bdvgeawQjIFlmdI9QdzfFy
   VDfMMCrBmWItA3RA6d/8Aey0QAOJIpD0pi3XnnxuzFrmxF4qSVLTu9brO
   P+XGkzprIMYnlBJQPaIUmn43xJR1aFQxD3raiAXIJSVwrwtlmchO1TtcO
   g==;
X-CSE-ConnectionGUID: zaKe25MwQlSgtzP6l3tMxw==
X-CSE-MsgGUID: N8i1EenpQ7yiHMnKYxyt5w==
X-IronPort-AV: E=Sophos;i="6.16,280,1744041600"; 
   d="scan'208";a="91662743"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jul 2025 08:58:30 +0800
IronPort-SDR: 686475ac_PboZAsfXk9TmLqZUv+5JWkKtffAJYS8g9Ud62n/VTx0XJw+
 +EvHzhRXgnBQDaSBBcRSQkLuLSMjCUKS9CQJGcg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Jul 2025 16:56:28 -0700
WDCIronportException: Internal
Received: from ros-3.wdc.com ([10.23.145.79])
  by uls-op-cesaip01.wdc.com with ESMTP; 01 Jul 2025 17:58:31 -0700
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
Subject: [PATCH v2 0/3] Support for Administrative Controllers
Date: Tue,  1 Jul 2025 17:58:26 -0700
Message-ID: <20250702005830.889217-1-kamaljit.singh1@wdc.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250701_175833_398783_4BE6A6CE 
X-CRM114-Status: GOOD (  10.70  )
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

[1] Add capability to connect to an admin controller
    - prevents ioq creation for admin-controllers.

[2] Prevent admin controller from smart log fetch (LID 2)
    - LID 2 is optional for admin controllers.

[3] Prevent ioq creation for discovery controllers
    - prohibited by spec



Kamaljit Singh (3):
  nvme: add capability to connect to an admin controller
  nvme: prevent admin controller from smart log fetch (LID 2)
  nvme: prevent ioq creation for discovery controllers

 drivers/nvme/host/core.c | 23 ++++++++++++++++++++++-
 drivers/nvme/host/nvme.h |  1 +
 drivers/nvme/host/rdma.c |  2 ++
 drivers/nvme/host/tcp.c  |  2 ++
 4 files changed, 27 insertions(+), 1 deletion(-)

-- 
2.43.0


