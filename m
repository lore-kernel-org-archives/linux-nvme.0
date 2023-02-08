Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31612C636CC
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Feb 2023 15:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:Message-ID:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Qg5KtfKZiV/ZqaaIQUZRlBZL0rHLp1N9TFg1ZGWKc78=; b=g2wynZOjc/ZIbO5gikur6VqsGY
	GUgXE4bEiY6iQtUOeMgCCfsDQ0xqzig7ue0X8i2trR1IbP+v+jaejtKxq8hNgEA3gWg/VsY4hlzZY
	GDu9mPejsYcr9o/NXKUpf2kEPusl5TFtI9FFNwSfS7Q6kgrlgtUYKuu2tWb8AGQ51EsQAhIXwdtzY
	Q8VhUDk6o4Ef2dfkYD5u4l+CK9LbtZB4kahk+r6+x2mA3O74dcwBUsYpejvQzjh2pZWAfF/zElW8K
	Tu3Qq+90yIYcwHmdYf2mWSCpGVgXULR90SPHMB/THD+Jhfe/ddu25e8wT72lrNlr+mxTascMlZhaX
	i5+O8NlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPmXX-00G6bk-9N; Wed, 08 Feb 2023 15:39:19 +0000
Received: from smtpout01-ext2.partage.renater.fr ([194.254.240.33])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPmXR-00G6Zb-IS
	for linux-nvme@lists.infradead.org; Wed, 08 Feb 2023 15:39:18 +0000
Received: from zmtaout01.partage.renater.fr (zmtaout01.partage.renater.fr [194.254.240.30])
	by smtpout10.partage.renater.fr (Postfix) with ESMTP id B004664A14;
	Wed,  8 Feb 2023 16:38:55 +0100 (CET)
Received: from zmtaout01.partage.renater.fr (localhost [127.0.0.1])
	by zmtaout01.partage.renater.fr (Postfix) with ESMTPS id 40CCE1A0139;
	Wed,  8 Feb 2023 16:38:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zmtaout01.partage.renater.fr (Postfix) with ESMTP id 35B791A013B;
	Wed,  8 Feb 2023 16:38:55 +0100 (CET)
Received: from zmtaout01.partage.renater.fr ([127.0.0.1])
	by localhost (zmtaout01.partage.renater.fr [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id CWrDa3tUR0XS; Wed,  8 Feb 2023 16:38:55 +0100 (CET)
Received: from zstore-b0-026.partage.renater.fr (zstore-b0-026.partage.renater.fr [10.254.240.112])
	by zmtaout01.partage.renater.fr (Postfix) with ESMTP id EE91B1A0139;
	Wed,  8 Feb 2023 16:38:54 +0100 (CET)
Date: Wed, 8 Feb 2023 16:38:54 +0100 (CET)
From: Irvin Cote <irvin.cote@insa-lyon.fr>
To: kbusch@kernel.org
Cc: axboe@fb.com, hch@lst.de, sagi@grimberg.me, kch@nvidia.com, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Message-ID: <1517857586.68818728.1675870734911.JavaMail.zimbra@insa-lyon.fr>
Subject: [PATCH] nvme-pci : rectifying the nvme_probe teardown path
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_4372 (ZimbraWebClient - GC103 (Linux)/8.8.15_GA_4372)
Thread-Index: fRAkiwxiQyLsYAI+MScOvhD1znFs/A==
Thread-Topic: nvme-pci : rectifying the nvme_probe teardown path
X-Virus-Scanned: clamav-milter 0.103.6 at clamav02
X-Virus-Status: Clean
X-Renater-Ptge-SpamState: clean
X-Renater-Ptge-SpamScore: 0
X-Renater-Ptge-SpamCause: gggruggvucftvghtrhhoucdtuddrgedvhedrudehuddgudeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecutffgpfetvffgtfenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefkufggtgfgofhtsehtjegttdertdejnecuhfhrohhmpefkrhhvihhnucevohhtvgcuoehirhhvihhnrdgtohhtvgesihhnshgrqdhlhihonhdrfhhrqeenucggtffrrghtthgvrhhnpeeiuddtveeivdekhfekffetfeefieduudejueejteejffetveekhffftdekudehteenucfkphepuddtrddvheegrddvgedtrdduuddvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddtrddvheegrddvgedtrdduuddvpdhhvghlohepiihsthhorhgvqdgstddqtddviedrphgrrhhtrghgvgdrrhgvnhgrthgvrhdrfhhrpdhmrghilhhfrhhomhepkfhrvhhinhcuvehothgvuceoihhrvhhinhdrtghothgvsehinhhsrgdqlhihohhnrdhfrheqpdhnsggprhgtphhtthhopeejpdhrtghpthhtohepkhgsuhhstghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrgigsohgvsehfsgdrtghomhdprhgtphhtthhopehhtghhsehlshhtrdguvgdprhgtphhtthhopehsrghgihesghhrihhmsggvrhhgrdhmvgdprhgtphhtthhopehktghhsehnvhhiughirgdrtghomhdprhgtphhtthhopehlihhnuhigqdhnvhhmvgeslhhishhtshdrihhnfhhrrgguvggrugdrohhrgh
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230208_073913_910315_D6DD3CAE 
X-CRM114-Status: UNSURE (   7.95  )
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

From ced363dcd3ef076e509bfbb4ce9815ebaff6aee7 Mon Sep 17 00:00:00 2001
From: Irvin Cote <irvin.cote@insa-lyon.fr>
Date: Wed, 8 Feb 2023 11:38:39 -0300
Subject: [PATCH] nvme-pci : rectifying the nvme_probe teardown path
The nvme_probe teardown path did not account for
undoing the work of nvme_pci_alloc_dev, which is
what nvme_pci_free_ctrl seemed to be intended for.
Thus I displaced the call to nvme_uninit_ctrl
from nvme_probe to nvme_pci_free_ctrl and added
a call to the latter in the teardown path of nvme_probe.

Fixes: eac3ef262941 ("nvme-pci: split the initial probe from the rest path")
Signed-off-by: Irvin Cote <irvin.cote@insa-lyon.fr>
---
 drivers/nvme/host/pci.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c734934c407c..db480bc64c7b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2731,6 +2731,7 @@ static void nvme_pci_free_ctrl(struct nvme_ctrl *ctrl)
 	struct nvme_dev *dev = to_nvme_dev(ctrl);

 	nvme_free_tagset(dev);
+	nvme_uninit_ctrl(ctrl);
 	put_device(dev->dev);
 	kfree(dev->queues);
 	kfree(dev);
@@ -3036,7 +3037,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)

 	result = nvme_dev_map(dev);
 	if (result)
-		goto out_uninit_ctrl;
+		goto out_unalloc_dev;

 	result = nvme_setup_prp_pools(dev);
 	if (result)
@@ -3118,8 +3119,8 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	nvme_release_prp_pools(dev);
 out_dev_unmap:
 	nvme_dev_unmap(dev);
-out_uninit_ctrl:
-	nvme_uninit_ctrl(&dev->ctrl);
+out_unalloc_dev:
+	nvme_pci_free_ctrl(&dev->ctrl);
 	return result;
 }

--
2.37.2

