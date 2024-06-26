Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF074C27C4F
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jun 2024 08:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=H8E+Sy95f1wvg9QrRX1Lu+FTsFS+/TcipMRWQA1B6NE=; b=KnOPYEblesQd3xBobc2D4R4+w4
	0qvkDvVlVLeQMMLjC0yvyID5C7YRfdbjd/T4GRg7nmKSaf4YUWLXhG5Ei4TdKLzli3+DLLkZ3K+Ih
	H//E+ozTx9qAugM7iENxAdLSzWy6MgdzzvCoGL0M0drKbY+LsDm89ZbTZYQNw+d72lgpPmbKawaH+
	UlZfVcm0bfGefiYf7MSMWgu8Vc50DLh/pHwscdF0Y8g2gDYULPZvLE+Uy7+YOQp1vNYXJdEhUwPrH
	CGEnwnIhyBtf/kmXsd9DnWNeY4jBrsfmw94Illj849ynYMb71PMfEdqNpNaDqyk9a9lAG55/UbH6d
	YIKT+GlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMO2A-00000005va1-3LUl;
	Wed, 26 Jun 2024 08:29:42 +0000
Received: from m16.mail.163.com ([117.135.210.3])
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMO26-00000005vXX-1X0a
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jun 2024 08:29:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=H8E+S
	y95f1wvg9QrRX1Lu+FTsFS+/TcipMRWQA1B6NE=; b=XLd6TTiNyw3hUu6nc0IGn
	TVNP6HWQzGY6Y05aAJHV8R8SbbM+zMr5AZRufyruURRdWymu/2Zvx4y8VlMgSR6A
	2m/eyHNMULIoZzMiXpt7Un/nyBoVAPVp7qP8xFKXltky19/VMsjnv4IBZH/WIEr9
	MDdIlS13utgMeqTGBIbFzw=
Received: from localhost.localdomain (unknown [139.226.176.191])
	by gzga-smtp-mta-g3-2 (Coremail) with SMTP id _____wD3__Ve0XtmGuclAg--.42928S2;
	Wed, 26 Jun 2024 16:29:18 +0800 (CST)
From: Ping Gan <jacky_gam_2001@163.com>
To: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: ping.gan@dell.com,
	Ping Gan <jacky_gam_2001@163.com>
Subject: [PATCH 0/2] nvmet: support polling task for RDMA and TCP
Date: Wed, 26 Jun 2024 16:28:21 +0800
Message-Id: <20240626082823.48326-1-jacky_gam_2001@163.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3__Ve0XtmGuclAg--.42928S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF4DCrW8tr45XF1kWr1DGFg_yoWfWrc_ZF
	WfJryDGa1xWa4DtFy7KryrZrZ5t3y5tryUuF4vqF4Utr98Xr1UAr1UAryrCF1xAr18JF15
	JrnxAF4fCwsxCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRAwI63UUUUU==
X-Originating-IP: [139.226.176.191]
X-CM-SenderInfo: 5mdfy55bjdzsisqqiqqrwthudrp/1tbiEAEKKWXAln0mkAABsL
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240626_012938_860263_F55EF3DE 
X-CRM114-Status: UNSURE (   6.74  )
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

When running nvmf on SMP platform, current nvme target's RDMA and
TCP use kworker to handle IO. But if there is other high workload 
in the system(eg: on kubernetes), the competition between the 
kworker and other workload is very radical. And since the kworker
is scheduled by OS randomly, it's difficult to control OS resource 
and also tune the performance. If target support to use delicated 
polling task to handle IO, it's useful to control OS resource and 
gain good performance. So it makes sense to add polling task in
rdma-rdma and rdma-tcp modules.

Ping Gan (2):
  nvmet-rdma: add polling cq task for nvmet-rdma
  nvmet-tcp: add polling task for nvmet-tcp

 drivers/nvme/target/rdma.c | 331 +++++++++++++++++++++++++++++++++-
 drivers/nvme/target/tcp.c  | 356 +++++++++++++++++++++++++++++++++++--
 2 files changed, 665 insertions(+), 22 deletions(-)

-- 
2.26.2


