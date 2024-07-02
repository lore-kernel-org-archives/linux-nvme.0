Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52410C3064D
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jul 2024 10:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date
	:Subject:Cc:To:From:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H8E+Sy95f1wvg9QrRX1Lu+FTsFS+/TcipMRWQA1B6NE=; b=pOyc7DSVpxscA6k5ysuSE2XKLp
	O0tD4H3yt+4FPCZUwrShXP9Xg5C7rQ0gDjo4NSjSQRm2EMcMWoC7bdUGPM+CiSyHVSPS5sHPAqMG6
	iZqVqaGB2r5qGR/JhtKSxazILVer9CZNqo7VccEg1uuX6V5AJjg65F8F+ylVpiad8hFqQXLXwLkwH
	QdsOgGCDlibboO5J3IUSAZlc64ktb7TsjrU4oVIqkZvMWj560jNKVSvOoq9CeTGcvDdACr/zi4jEI
	v9Df1g89pEydKP1CwgvMS+MwicTGsBfoMLoLLmDzFYiZRaepdGIDZ5dkaf+3zeaEBSpTG135t5Ay1
	hupNjIFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOaMB-00000006HdM-3sgX;
	Tue, 02 Jul 2024 10:03:27 +0000
Received: from m16.mail.163.com ([117.135.210.2])
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOaM9-00000006Hbn-01m4
	for linux-nvme@lists.infradead.org;
	Tue, 02 Jul 2024 10:03:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:Reply-To:MIME-Version;
	bh=H8E+Sy95f1wvg9QrRX1Lu+FTsFS+/TcipMRWQA1B6NE=; b=g1tJa76q6qe2y
	O1ICk0Tph2/eQ4o/z2y8d4IQVbWdVeG7TqWTV0ZoraxpK1IdU/LLXsNGyyQPbdd2
	TV5Nss5DQ5u8DffCm0NWOahcufmG4bneu0IKSDqaep67ABbirYaNXhtH8W4WbxKa
	gWU+hOCT33pbW3aisu1rUXqyuz498Q=
Received: from localhost.localdomain (unknown [183.192.130.164])
	by gzga-smtp-mta-g1-2 (Coremail) with SMTP id _____wD3_2Vb0INmpmSMBQ--.35615S3;
	Tue, 02 Jul 2024 18:03:14 +0800 (CST)
From: Ping Gan <jacky_gam_2001@163.com>
To: sagi@grimberg.me,
	hch@lst.de,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: ping.gan@dell.com,
	Ping Gan <jacky_gam_2001@163.com>
Subject: [PATCH 0/2] nvmet: support polling task for RDMA and TCP
Date: Tue,  2 Jul 2024 18:02:15 +0800
Message-Id: <20240702100215.2265-2-jacky_gam_2001@163.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20240702100215.2265-1-jacky_gam_2001@163.com>
References: <f9828eb4-39be-498b-8b90-2cb7ce42d3c7@grimberg.me>
 <20240702100215.2265-1-jacky_gam_2001@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3_2Vb0INmpmSMBQ--.35615S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF4DCrW8tr45XF1kWr1DGFg_yoWfWrc_ZF
	WfJryDGa1xWa4DtFy7KryrZrZ5t3y5tryUuF4vqF4Utr98Xr1UAr1UAryrCF1xAr18JF15
	JrnxAF4fCwsxCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRmzutUUUUUU==
X-Originating-IP: [183.192.130.164]
X-CM-SenderInfo: 5mdfy55bjdzsisqqiqqrwthudrp/1tbiEB0QKWXAluk-igABsa
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240702_030325_441837_747F27CA 
X-CRM114-Status: UNSURE (   6.78  )
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
Reply-To: sagi@grimberg.me
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


