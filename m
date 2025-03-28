Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19F84C28B20
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Mar 2025 21:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YWsX9A33OWeNqOiULwqYTZKF/hq+HPTNQUQTYMV/y4k=; b=J2BIVfu2DlENWuVng9mqIM+92D
	wB4ObxDpxL8+iOfKYD1RTJq9Px+5aULOW918BG2/TE+dlriquGcK5anrN62w7hfBRzrbh41socXGS
	IBUWoc0rfrLvSwm/oBhkxse3okr8pGftDq6z2WK58G2hyJF+DvmDaoIgUuIEQhvWnp4pvFgcOqmOJ
	5EsUNlxB99CDlKL5Nbxvv0dxLZtzJ5aqT+aHVIX9zpb3dr+B708MiiT0eoK3lbW+wgT3gSSssbBwK
	UA0c5Sf2kzfuwCEsXOaoU8hk3iFeVzRckyEgNN29cn8Ofl0Wd1aW1UzvcC/t3o82tZQpztip2Pn0k
	jMMOihqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tyHNg-0000000ELsN-1CV0;
	Fri, 28 Mar 2025 21:36:48 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tyHNc-0000000ELre-3l7g
	for linux-nvme@lists.infradead.org;
	Fri, 28 Mar 2025 21:36:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1743197805; x=1774733805;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Q+GbWtdwEqzg39Cv1cNvcP+cTr2XNrpFOrJ4DNQnH1A=;
  b=RxijtoLralPr6yFPUJbghRjRH6rQVbVYEMGC+7H+Qsxx13+FVLwbDJsd
   RW5KFLfZvSVUXNo+0TI9FDxC38WqvKD+T0lNBpCB3h8eBV8lRwx5d7Xu6
   ZiHpwDCUcjCJ8c5cPDCW4B5DlGq+IhKQAlRg8z0/GWfp1o+dLXK4m0MZc
   ENcEKZHXE+55Y6jadqH7LlFNE8LQiSRUeXeYRsllH3m7pBhE5gMK45Qfc
   DBb7O540GVP1opgPdUS4JdRLMXZ++wYq7Qb5c1WkiRKK7TCD0C5UgdZPi
   o+FqhOxtKQkPNop0AtcAMKvtjAbFiR82IMWD6l8ib5ynyR6f+EMPLiRt9
   Q==;
X-CSE-ConnectionGUID: kOVu8w75S/29jZAP3293BA==
X-CSE-MsgGUID: MmFh1fZQRJOZ7MbNTnmCPA==
X-IronPort-AV: E=Sophos;i="6.14,284,1736784000"; 
   d="scan'208";a="64005079"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Mar 2025 05:36:41 +0800
IronPort-SDR: 67e70879_ulmI1iKqwDiDv1bF+6YJ8QQ3JZMnCgv7ZGUiFsTu0A9u2Gz
 SqxKH91Ou8YaMoh8CP1o+ZnB0KmdD/+Qqb/0Tyg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Mar 2025 13:37:13 -0700
WDCIronportException: Internal
Received: from ros-3.wdc.com ([10.23.145.79])
  by uls-op-cesaip01.wdc.com with ESMTP; 28 Mar 2025 14:36:41 -0700
From: Kamaljit Singh <kamaljit.singh1@wdc.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: niklas.cassel@wdc.com,
	damien.lemoal@wdc.com,
	kamaljit.singh1@wdc.com
Subject: [PATCH v1 0/1] nvme: add admin controller support. prohibit ioq creation for admin & disco ctrlrs
Date: Fri, 28 Mar 2025 14:36:39 -0700
Message-ID: <20250328213640.798910-1-kamaljit.singh1@wdc.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250328_143645_021325_39D4DA60 
X-CRM114-Status: UNSURE (   7.68  )
X-CRM114-Notice: Please train this message.
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

Added capability to connect to an Administrative Controller by 
preventing ioq creation for admin-controllers. Also prevent ioq 
creation for discovery-controllers as the spec prohibits them. 


Kamaljit Singh (1):
  nvme: add admin controller support. prohibit ioq creation for admin &
    disco ctrlrs

 drivers/nvme/host/core.c    | 25 +++++++++++++------------
 drivers/nvme/host/fabrics.h |  5 +++++
 drivers/nvme/host/nvme.h    |  5 +++++
 drivers/nvme/host/rdma.c    | 11 +++++++++++
 drivers/nvme/host/tcp.c     | 11 +++++++++++
 5 files changed, 45 insertions(+), 12 deletions(-)

-- 
2.43.0


