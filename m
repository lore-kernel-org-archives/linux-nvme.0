Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B4ACD1CDA1
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Oct 2024 07:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=geISZYnqC8zF6hE8Gf9cCNpibOdSVkrYZJHYKT5c4kA=; b=FsJLf48a1iMATvD16w1IIl6RaQ
	JgoGqLTe9YzpD3ct55HJLF1h0SN5DabVEifq8XVbyXfJ/UrpDbqUJLHzE7Zi+U2Vp5/e6OlK+MH2F
	cunlzZkXV1RdNPcnBJojgWFhRQNqDFxqpkNcerPrYm/ztHxHMIe8kZSOo0a7dR8I/eEwZaW/r1v0A
	drHzXt4JqR3Buphk5YITSuJoW85O6TqiyCYXhUoMymPv/R5y9o5t9EGzeT63/8q9FnoYuu3JP/xTo
	4+9YN1XBNtSzmlc2vA3TMql6/Jiq37jrdBnyUU5LlX0StmfLFbINtM/hDFNc3swEv7cqn7tCNrMYy
	tIzD2jqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t39Be-00000009xDG-2WHe;
	Tue, 22 Oct 2024 07:20:14 +0000
Received: from cmccmta2.chinamobile.com ([111.22.67.135] helo=cmccmta1.chinamobile.com)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t39B9-00000009x6N-2l9h
	for linux-nvme@lists.infradead.org;
	Tue, 22 Oct 2024 07:19:46 +0000
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee367175206930-2c14b;
	Tue, 22 Oct 2024 15:19:34 +0800 (CST)
X-RM-TRANSID: 2ee367175206930-2c14b
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain.localdomain (unknown[10.55.1.70])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee867175205938-7bce6;
	Tue, 22 Oct 2024 15:19:34 +0800 (CST)
X-RM-TRANSID: 2ee867175205938-7bce6
From: Liu Jing <liujing@cmss.chinamobile.com>
To: kbusch@kernel.org
Cc: axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Liu Jing <liujing@cmss.chinamobile.com>
Subject: [PATCH] nvme-pci: After the memory is released, the corresponding pointer needs to point to empty
Date: Tue, 22 Oct 2024 03:01:50 +0800
Message-Id: <20241021190150.5974-1-liujing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241022_001944_238634_81F1196C 
X-CRM114-Status: UNSURE (   8.34  )
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

The code frees memory pointed to by dev->queues. After freeing memory,
dev->queues should be set to NULL to avoid dangling Pointers.

Signed-off-by: Liu Jing <liujing@cmss.chinamobile.com>
---
 drivers/nvme/host/pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 1cbff7537788..c1500c00f571 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2731,7 +2731,9 @@ static void nvme_pci_free_ctrl(struct nvme_ctrl *ctrl)
 	nvme_free_tagset(dev);
 	put_device(dev->dev);
 	kfree(dev->queues);
+	dev->queues = NULL;
 	kfree(dev);
+	dev = NULL;
 }
 
 static void nvme_reset_work(struct work_struct *work)
@@ -3055,8 +3057,10 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
 out_put_device:
 	put_device(dev->dev);
 	kfree(dev->queues);
+	dev->queues = NULL;
 out_free_dev:
 	kfree(dev);
+	dev = NULL;
 	return ERR_PTR(ret);
 }
 
-- 
2.27.0




