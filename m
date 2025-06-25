Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9A3CC7EE2A
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Jun 2025 16:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=zO5jrLEaq1wfP6QwgWXRIN673rBE39/GNOwBgNvopIc=; b=qWuE+CIxHIVxnSXGbcefbH9Q/h
	l4KhlqRVUSTo4YCwQnST8+ViV5YMoc3UawnzDrTN5Zk1MUwsL7HUkVcEqD0WFgzKAm6no61u7///X
	Y3cn101vguY6+R+u+xAc+E7yEEm3v0S8Rv8my6JoMDjynAi55PmtTEqHNZdM1xvhzS/CUerJQPZkq
	GKBmR2v5a2+TX+rnrHMPiWsRGqjoyMFzwn0pOBt4raIhZi4VcSoYCaJbVqPnhBLFMuXjymEdTFG+t
	81Yxrj/bW3OBpTKcrDklo/9tgoqO4VXQLVBSo+Z/JDCVzmHlALPYwacG31ehRzj/DZBrJHk24j4wo
	nyzXtq4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUT0h-00000009Htx-2yZp;
	Wed, 25 Jun 2025 16:30:07 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUOYu-00000008Wje-3Uox
	for linux-nvme@lists.infradead.org;
	Wed, 25 Jun 2025 11:45:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1750851908; x=1782387908;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=L4iolfUlrjcvKRCrK0EY039xTf5KB94qyUrsaP4ddQE=;
  b=O7BHg5ybk7HKHZ05FfgbKgJyeOpwstBVV3pdFJNMCObM+fBr7B0Ld1PB
   5kZOPJKRc0J+8/YaShKdg2DRJVWSrK5a/fkrkZMo0pUB4t88lIER1A7pN
   g8iCFS20bgwaok8CGfdnJbGQJTZT0zULDaEP7iLv2NrnC6V7PQUAFDJ38
   /rvgd4YiIadDZQADce4Wkmuss93+7obNnkXXdRzE1pEm6jEXjAldLa9Lb
   pMUOlUMK/ufPM+HiWyuMS/51Pxl+I9TkiBC9SkkWhukokJg2eBuwDdBAt
   bQD91axb1Y3lhgB1Md0G9sJiJW0HyCSPXUuA5BiUdElvKUZOff5Jb7m0M
   w==;
X-CSE-ConnectionGUID: /VQG98FWQMK4ZEMftxLXrw==
X-CSE-MsgGUID: bdin1gs2QPOyXb3N3qgTwQ==
X-IronPort-AV: E=Sophos;i="6.16,264,1744041600"; 
   d="scan'208";a="85954399"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jun 2025 19:45:06 +0800
IronPort-SDR: 685bd2c2_fzaRu+1lpSFFwtgaWC0FOjG+TlvhKG3muPYEQoD8/vmEkNP
 aLZdqZv4xFp4o3hRVbbFJwgNQfYXRslLj039szg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jun 2025 03:43:14 -0700
WDCIronportException: Internal
Received: from 5cg2075g47.ad.shared (HELO shinmob.wdc.com) ([10.224.173.209])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Jun 2025 04:45:05 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 0/2] nvme: avoid failures of TEST_DEV with metadata
Date: Wed, 25 Jun 2025 20:45:03 +0900
Message-ID: <20250625114505.532610-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250625_044508_875994_20A1AF23 
X-CRM114-Status: GOOD (  10.86  )
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

Recently, the new test case nvme/064 was introduced to cover namespaces
formatted with metadata [1]. To run the test case, it is required to
specify namespaces with metadata as TEST_DEV. When this TEST_DEV is used
for other test cases, a few other test cases fail. This series addresses
the failures. The first patch allows skipping nvme/034 and nvme/035 when
TEST_DEV has metadata. The second patch adds an option to the fio
command in nvme/049 that is required for TEST_DEV with metadata.

[1] https://lore.kernel.org/linux-nvme/20250616020716.2789576-1-shinichiro.kawasaki@wdc.com/

P.S. I had observed nvme/053 failure using TEST_DEV with metadata, but
     it was because I configured QEMU NVME namespace as TEST_DEV with
     512b block size. With 4k block size, the failure disappeared.


Shin'ichiro Kawasaki (2):
  nvme/{034,035}: skip when the test target namespace has metadata
  nvme/049: add fio md_per_io_size option

 tests/nvme/034 |  1 +
 tests/nvme/035 |  1 +
 tests/nvme/049 | 13 +++++++++++++
 tests/nvme/rc  |  8 ++++++++
 4 files changed, 23 insertions(+)

-- 
2.49.0


