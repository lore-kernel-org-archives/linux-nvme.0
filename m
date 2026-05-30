Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD37CD5BD0
	for <linux-nvme@archiver.kernel.org>; Sat, 30 May 2026 05:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=BXTaBA63N7jYwvUg1DPVa3UegWacK/Xsh8mrhBFr4q8=; b=j4oneKBbST3NYEE23vt7vP5n2S
	6YZL/F24SZGNGu56XypaDfWBFOMB+gbO7UdfeUQQccIzvPFKJaP8PGH8TD/l/IlnK/tC/4dYTy+rX
	1pYvlSrSHy5Cb6S9ZxhAYE66sORxMj3QO1OefUTbH4SRFIEMjUVTqMGhk04c3kAccOZaHqEayclOv
	RQJpQWvD2Z9+ikgtZdgN8tE8JkyHADSBImzdZidxALDUdp+prUK3omReLf/6aQ5IoFqhVfwZNuOVc
	MLj1SsYPhLn4JhkC61nIhWjcyFfSg4bef8rekLXC7e874n+tpjx7tfGefZdQPrQ+WInkzUYDCuqsw
	UEDORhiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTC8g-00000008SX6-3PpD;
	Sat, 30 May 2026 05:21:38 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTC8X-00000008SW5-0Wyt
	for linux-nvme@lists.infradead.org;
	Sat, 30 May 2026 05:21:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1780118489; x=1811654489;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=e1dN6/FDb97aHR4TKlcxkIpEGCfde7S+/4ZvXNwaStA=;
  b=rPf4kl3+WUKDP4N7AzMVsge0eOR7MMQE0GzObM1ccqp9ncPeL7JzSVuD
   4iK43IQaBAy2UmWNZr4MuBspx8IJT88lKRD9QLJ6oLVDwLWdzO1NevSOx
   UyDOB1HpDSnoa6Vb/IDUwVn0e56MFyFumMfYqgVQSeuCnzFPYgmRVqqMN
   mQtuZe+tx3UBhzsQlynKHnCwCIi15Nt6R7I10BNrMslt0FKPVyk7BMf1V
   1rpY9J+2+YH3ErQlF9eIrB0B2mjbuQ3xe6ywMXYRMBF6AazadqgazMTfW
   O0Arj9oji/TflqtiBl3r6Tu8n1O13WtKzhHxi53/OxKFzmE1xTci58dsE
   Q==;
X-CSE-ConnectionGUID: oYha7NVATai0WZZQGEVBcw==
X-CSE-MsgGUID: FVkMxdB1QAmRcw0hu9WTBg==
X-IronPort-AV: E=Sophos;i="6.24,176,1774281600"; 
   d="scan'208";a="148919911"
Received: from unknown (HELO uls-op-esad1-o.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 May 2026 13:21:27 +0800
X-CSE-ConnectionGUID: BJsKYhxDRfi/zyFrDXtJ6g==
X-CSE-MsgGUID: 9S/mlTRlRIu2Pdrf2jSgwg==
IronPort-SDR: 6a1a73af_8MFALj+jA1pto15iLWOsqneXDeB8j+iMvmhuEU7VCUtdrLi
 CYke4DjbOTqNrtrdsKp4/L8qreCB6+DhfPwhfOA==
Received: from uls-op-esai1-o.wdc.com ([10.248.3.45])
  by uls-op-esad1-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 May 2026 22:20:46 -0700
X-CSE-ConnectionGUID: WHSKN/xbR2WkZ0QLi6qAZA==
X-CSE-MsgGUID: trYHl1zvSXOZ4GvRkhpiSw==
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.67.30])
  by uls-op-esai1-o.wdc.com with ESMTP; 29 May 2026 22:20:46 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH 0/2] nvme-tcp: lockdep: use dynamic lockdep keys per socket instance
Date: Sat, 30 May 2026 14:20:43 +0900
Message-ID: <20260530052045.296749-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260529_222129_240807_2055AC80 
X-CRM114-Status: UNSURE (   9.52  )
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

When NVMe-TCP controller setup and teardown are repeated with lockdep
enabled, lockdep reports false-positive WARNs. This was observed when
running blktests nvme/005 on v7.1-rc1 with a patch [1]. Analysis by
Nilay [2] confirmed that the WARNs are false positives caused by lockdep
confusing different socket instances due to shared static lockdep keys.

This series resolves the issue by using dynamically allocated lockdep
keys per socket instance instead of static keys. This ensures lockdep
correctly tracks locks across different socket instances. For that
purpose, the first patch moves a function as preparation. The second
patch introduces the dynamic lockdep keys.

[1] https://lore.kernel.org/linux-nvme/afB5syZbUrppgsDQ@shinmob/
[2] https://lore.kernel.org/linux-nvme/c4ddc101-184a-4e4f-82ca-c3123bce5e34@linux.ibm.com/

Shin'ichiro Kawasaki (2):
  nvme-tcp: move nvme_tcp_reclassify_socket()
  nvme-tcp: lockdep: use dynamic lockdep keys per socket instance

 drivers/nvme/host/tcp.c | 88 +++++++++++++++++++++++------------------
 1 file changed, 49 insertions(+), 39 deletions(-)

-- 
2.54.0


