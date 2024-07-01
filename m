Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29EC0C3065B
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jul 2024 07:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date
	:Subject:Cc:To:From:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H8E+Sy95f1wvg9QrRX1Lu+FTsFS+/TcipMRWQA1B6NE=; b=E1SJIXtWfk5p28rddfLHeU+lNr
	Xt7mkWKpBp13MjT6uc/qqFTYTieB5TWiJjw9tdovCSouj0LYd5wiJT2Gr86R916xmeT/xkL2Sm3A+
	u4z6VgzyLxFBIaCOFTWo3anHi3h6ESY/vIxJ0V7s3qfwngGUzjQgXXZ5JxSYtokU1oCwi5646naIb
	S/lq7Buh2WWBFETGBpqvST+UeqW7Wt+vM1/sw8hKDNB4BAl6QfZM5wcpZjlws5NupECkcPc7pyQ7/
	muvYxQhz+UK6VdsimieY3RdlqgdF0AK1VmbD63z8P6I2oltisY5LOou0XA15FxxQqHh3LnV7B5k1E
	haXY6wFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOBi1-000000026Dr-1kfy;
	Mon, 01 Jul 2024 07:44:21 +0000
Received: from m16.mail.163.com ([117.135.210.2])
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOBhy-000000026CY-3VM3
	for linux-nvme@lists.infradead.org;
	Mon, 01 Jul 2024 07:44:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:Reply-To:MIME-Version;
	bh=H8E+Sy95f1wvg9QrRX1Lu+FTsFS+/TcipMRWQA1B6NE=; b=iM6da1CY9oYSs
	ws2niEEAtMzcu1/BJCDCrG5FwiVqrP5b2oAi3KyO9D0EAZuv0OEnyUTaUmxTpiHa
	MVFt6R+/Qmc9zLhgFpdhg3eLXr6v2HEH/TgVnG8VMbXBoLa6UInr5UAPXDiw5SKs
	H2/Z7mZf7RJnHCbo8HvQ1+FZrSKUZw=
Received: from localhost.localdomain (unknown [223.104.212.168])
	by gzga-smtp-mta-g2-3 (Coremail) with SMTP id _____wD3v3UpXoJmVPDIAw--.64400S3;
	Mon, 01 Jul 2024 15:43:45 +0800 (CST)
From: Ping Gan <jacky_gam_2001@163.com>
To: sagi@grimberg.me,
	hch@lst.de,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: ping.gan@dell.com,
	Ping Gan <jacky_gam_2001@163.com>
Subject: [PATCH 0/2] nvmet: support polling task for RDMA and TCP
Date: Mon,  1 Jul 2024 15:42:45 +0800
Message-Id: <20240701074245.73348-2-jacky_gam_2001@163.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20240701074245.73348-1-jacky_gam_2001@163.com>
References: <0779b376-38e3-42ef-b32a-a9cfab2749f2@grimberg.me>
 <20240701074245.73348-1-jacky_gam_2001@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3v3UpXoJmVPDIAw--.64400S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF4DCrW8tr45XF1kWr1DGFg_yoWfWrc_ZF
	WfJryDGa1xWa4DtFy7KryrZrZ5t3y5tryUuF4vqF4Utr98Xr1UAr1UAryrCF1xAr18JF15
	JrnxAF4fCwsxCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRk9NztUUUUU==
X-Originating-IP: [223.104.212.168]
X-CM-SenderInfo: 5mdfy55bjdzsisqqiqqrwthudrp/1tbiKBQPKWXAmCk5VwAAsg
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240701_004419_323024_699E2C50 
X-CRM114-Status: UNSURE (   6.76  )
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


