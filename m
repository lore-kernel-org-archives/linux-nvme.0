Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2DFDC71157
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Jun 2025 03:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=BaP2fs95scO53+6/ZSVDPUKsz0XzJRaaqTDjoxwU5rA=; b=KURYZO7xf7DXXrslsxBykBqww8
	Z0p9WeAbL9BmmUSPCEzRV8YpnKWJB1oS3iXIw7hKf6s3WN6NTzkz7b7LdruHgyBEEDw/YftFYLpmR
	shur9o56mw5j/RbvZImxY4OqHKndeqRhDSj3B69h3JuTqiaoFofARmPGyPTY2Keijh55e4JVPRPKp
	+iywFmjvv9guz/w9D8g76PcQjaKmOMBRXcCqoagFDgNmq0x9NDFHHnzWzCYIgbdSGNhcECxAzIHp9
	50LwvjQi9pQOzaL+t+U45XAQ0Pi9um3s1RWELZ2MXWUhYCfzfDGYlmNiAb/2xhBgMjBypJDgeJ0YO
	oydoT0Rg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uR05P-00000003DB7-3wM8;
	Mon, 16 Jun 2025 03:00:39 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uQzFq-00000003875-2Zrj
	for linux-nvme@lists.infradead.org;
	Mon, 16 Jun 2025 02:07:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1750039642; x=1781575642;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=a23zc64JCl1Eks8CpQP0iYIGP+/xmfrIA9EMxx5T83w=;
  b=HMaSDyC5+ablvjqwUuRhNZakXNxq4kU7uOOF6xga6BPzPLYbd0yYRjEX
   /gloiDtf3zL7Nnrjpn6uEnp++4VTqMoGvVjoWrnhrg7uqdXXhBEv+ZEsa
   Tj5BmQzXlpsASVvUvJyQ9M7I8iesP1Eo6hALsmdMTM8pYatNfk/M0H/yl
   CLKPreJ+AkrGGRf0OZ6V08GqvYRmKg5zIgAomRC8kf8HNQlVmaNaJE1Ta
   jXMK6rOSnXhowCo+bK0zUvKthz3I1oj0Mc01vUWkYyNbva3p2Kg44EIq0
   7FKx8wdYMEPI+Q67pgELdRnbqkDNF/JH0fsKLlDj1DpTqP20XPlYF3CPf
   A==;
X-CSE-ConnectionGUID: A6KSGYErQa+F/Gl0lPeyDg==
X-CSE-MsgGUID: H6d14KQSS/iBQmu762YvwA==
X-IronPort-AV: E=Sophos;i="6.16,240,1744041600"; 
   d="scan'208";a="84623407"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jun 2025 10:07:18 +0800
IronPort-SDR: 684f6de5_cGFdBeYAYNmnD9vAwITkjR0b5fL+dqWsdORvYU1CbVX5HbO
 IqyKutzsAdrqF3D2ESRHuptfUUZBWuKJ3cp7Q9g==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jun 2025 18:05:42 -0700
WDCIronportException: Internal
Received: from wdap-do3irrikgj.ad.shared (HELO shinmob.flets-east.jp) ([10.224.163.172])
  by uls-op-cesaip01.wdc.com with ESMTP; 15 Jun 2025 19:07:17 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Cc: Keith Busch <kbusch@meta.com>,
	Keith Busch <kbusch@kernel.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 0/2] nvme: add nvme metadata passthrough test
Date: Mon, 16 Jun 2025 11:07:14 +0900
Message-ID: <20250616020716.2789576-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250615_190722_675720_E3748991 
X-CRM114-Status: GOOD (  13.54  )
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

Keith contributed a test case to cover nvme metadata passthrough [1],
which confirms a kernel fix by the commit 43a67dd812c5 ("block: flip iter
directions in blk_rq_integrity_map_user()"). I made some slight
improvements on it and repost as this series. The first patch introduces
two helper functions to check requirements of the test target
namespaces. The second patch adds the test case.

[1] https://lore.kernel.org/linux-nvme/20250609154122.2119007-1-kbusch@meta.com/

P.S. When I ran blktests to confirm this patch using QEMU nvme
     namespaces with metadata as TEST_DEV, I found some existing test
     cases fail: nvme/034, 035, 049 and 053. Three of the test cases
     need improvements to avoid the failure. I'm preparing another
     series for it. The other test case nvme/053 shows weird fio
     failure. It passes with metadata size 8 bytes and 16 bytes (md=8 and
     md=16 QEMU options. But it fails when metadata size is 64 bytes
     (md=64). This needs some more debug effort.

Keith Busch (1):
  nvme: add nvme metadata passthrough test

Shin'ichiro Kawasaki (1):
  nvme/rc: introduce helper functions to check namespace metadata

 src/.gitignore              |   1 +
 src/Makefile                |   1 +
 src/nvme-passthrough-meta.c | 232 ++++++++++++++++++++++++++++++++++++
 tests/nvme/064              |  34 ++++++
 tests/nvme/064.out          |   2 +
 tests/nvme/rc               |  23 ++++
 6 files changed, 293 insertions(+)
 create mode 100644 src/nvme-passthrough-meta.c
 create mode 100755 tests/nvme/064
 create mode 100644 tests/nvme/064.out

-- 
2.49.0


