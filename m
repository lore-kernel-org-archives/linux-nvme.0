Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03969C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 24 May 2022 13:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c1qLdjqil3jmin70RbCjyAc/6UwNrhR6VisAmK/fKX0=; b=h6Fv+kISnR5Z+XQQ7uTAk1F6MA
	/UIOHdkJmL6+PZyWTFB9ivdzoVz0RyANgdxWzn+66/shQMLZUEszr+sQZtgvv54S3CIOs7ZVt2Es0
	7PkE3H1vP94PSJcI83CzTtkbqq9TnlfT12xcJe4LkQ0GAz8Z5k17OUkppbHG0Jyo9cTQyu2mWNQL8
	YaT/oeX+29jEWnwmROkhaN4TrTRb+/EzVE0Vz0pYJi6fHQ8haLxszYF+ikgfy8BN2vanyN+FmV9UH
	Jk0eaAnv1sy655ilcaIURvpuYnXHqfq7VG763bj0EdAKZVh7pQn0V+a5arpTtrMC29i8sAh9W/NZ5
	TXNbct3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ntUwV-008ArX-KY; Tue, 24 May 2022 13:51:23 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ntUwS-008Aom-2g
 for linux-nvme@lists.infradead.org; Tue, 24 May 2022 13:51:22 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 5144168AFE; Tue, 24 May 2022 15:50:58 +0200 (CEST)
Date: Tue, 24 May 2022 15:50:58 +0200
From: "hch@lst.de" <hch@lst.de>
To: Arman Hajishafieha <arman.hajishafieha@hotmail.com>
Cc: "hch@lst.de" <hch@lst.de>, "me@kingtous.cn" <me@kingtous.cn>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 "kingtous@qq.com" <kingtous@qq.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "axboe@fb.com" <axboe@fb.com>
Subject: Re: [PATCH] fix: nvme_update_ns_info method should be called even
 if nvme_ms_ids_equal return false
Message-ID: <20220524135058.GA31121@lst.de>
References: <20220408160424.GB27746@lst.de>
 <21ac620f-d234-13a1-0de7-e3ec1b3272db@kingtous.cn>
 <20220409044351.GA17212@lst.de>
 <33f34253-4418-e16a-89fb-92257749cf3f@kingtous.cn>
 <20220411054945.GA14311@lst.de>
 <dc6e8c8c-7eaf-f502-207c-4907ce58a474@kingtous.cn>
 <20220411060746.GA14519@lst.de>
 <2c504d2e-5c64-72fb-c26b-e086588ecd8d@kingtous.cn>
 <20220412050441.GA5311@lst.de>
 <741c80abb8a443c4745f213e9ecd413f6a6a7467.camel@hotmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <741c80abb8a443c4745f213e9ecd413f6a6a7467.camel@hotmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220524_065120_657165_ED20C139 
X-CRM114-Status: GOOD (  14.29  )
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

On Mon, May 23, 2022 at 06:18:01PM +0000, Arman Hajishafieha wrote:
> I can confirm that "MAXIO MAP1001" (1e4b:1001) controller found in
> "Asgard N2 1TB SSD" suffers from the exact same issue as well.
> After applying the patch to disable checking namespace identifiers it
> can resume from suspend normally. It seems like this issue affects a
> wider range of Maxio controllers.
> Could you please add a quirk for this device as well?

Please try this:


diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 5a98a7de09642..cb4adc0c22843 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3453,6 +3453,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
 	{ PCI_DEVICE(0x2646, 0x2263),   /* KINGSTON A2000 NVMe SSD  */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
+	{ PCI_DEVICE(0x1e4B, 0x1001),   /* MAXIO MAP1001 */
+		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1e4B, 0x1002),   /* MAXIO MAP1002 */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1e4B, 0x1202),   /* MAXIO MAP1202 */


