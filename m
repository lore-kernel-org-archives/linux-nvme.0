Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76DB0C83F26
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Jul 2025 13:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=sGOgskg8s5xBFSO7BcKKXe8Vx92lIyfPLMggAd8wFCU=; b=jZhpPymyZ83J3ikSB66GK/nrA0
	5QrmgsCoP9v3mxZJ3mzWRZGiAvxmXhA8ajFuArX0fvn4QOZQDW08+Io5WE5awERnJaQcP26Inv2uj
	mizuAYRDEB4ig9Ah9a4kM+KfGsChk6WXc54/TwxhS469bY069qovHH2W1U+NAaTWRhW4c1O6j0S1b
	fI6KMEhFw73S7XF4j1O5SY1OV6RDKLB3EY9CfhQByzz77SoWMQxS6GsnateZ1/JM/rl0PYtRhsrHx
	gmhfRAaa89Abpwk9uxZK6odrQ3lJ1hfFCYIdXSARACiqBQXsx1gMLLUWUvRXTtzHAQ2sLb1609Eb6
	QuuwCBDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uewNW-00000007ZnB-0s5L;
	Thu, 24 Jul 2025 13:52:58 +0000
Received: from m16.mail.163.com ([220.197.31.4])
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uetXa-00000007Fyp-1zJv
	for linux-nvme@lists.infradead.org;
	Thu, 24 Jul 2025 10:51:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=sG
	Ogskg8s5xBFSO7BcKKXe8Vx92lIyfPLMggAd8wFCU=; b=NUVkUtvD/r42anpWZe
	1/lwKQxb0J9aAVjZM2tyv5ACz7+JAxfpJ+r9bkClL5fNE5MJnzx41iGGRUR8MGXY
	1rCn+tM7AFUdk43A/CBk1DjMg26YSFrMa+cfB/nLzHFjx9aAk/nE0j3DEhozoEJZ
	58wtZ1+hULZKtAo/ltccbL6no=
Received: from vbox.. (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wAXcwIFEIJokrTYGw--.35831S2;
	Thu, 24 Jul 2025 18:50:46 +0800 (CST)
From: likunyu10 <likunyu10@163.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	likunyu15 <likunyu15@jd.com>
Subject: [PATCH] drivers/nvme/host/pci: Fix the asynchronous detection issue of nvme devices
Date: Mon, 21 Jul 2025 02:51:54 +0800
Message-ID: <20250720185154.138391-1-likunyu10@163.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAXcwIFEIJokrTYGw--.35831S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xw17tw48ArW5WF1ruryUKFg_yoWfJFc_Ar
	yfur43Xay0kF4vqw12ga1fZryUKwsxXw1xua1SgF9agFnrWa9xJwn5ZFnxZ34fWwnYkF9r
	WFWUGryfZrW7ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU5nZ2DUUUUU==
X-Originating-IP: [111.202.148.190]
X-CM-SenderInfo: poln30d1xriqqrwthudrp/1tbiNh6UpGiCA2PurwAAsT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250724_035110_920169_5AE8D24B 
X-CRM114-Status: UNSURE (   9.14  )
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

From: likunyu15 <likunyu15@jd.com>

PROBE_PREFER_ASYNCHRONOUS asynchronous detection has a significant impact
on important devices. For example, if a server has two or more nvme disk
devices, it can cause disk loading disorder, which can also have a
certain impact on actual production environments.

Signed-off-by: likunyu15 <likunyu15@jd.com>
---
 drivers/nvme/host/pci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 320aaa41ec39..c7f90621e633 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3832,7 +3832,6 @@ static struct pci_driver nvme_driver = {
 	.remove		= nvme_remove,
 	.shutdown	= nvme_shutdown,
 	.driver		= {
-		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
 #ifdef CONFIG_PM_SLEEP
 		.pm		= &nvme_dev_pm_ops,
 #endif
-- 
2.41.0


