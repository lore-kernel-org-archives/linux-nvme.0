Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E0D0C63797
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Jan 2023 05:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EXIYO6rXhT1+VLu3//uM5Tl3Y+gAagv7iPCsQM7USgA=; b=M35aUp6k0gjH1t5d64TZVGUJLd
	K1gQ1HqbAvVVbQg2zA3ekb1nlUWuyqUTdup8FRDQVwHqkrcfvYlqPmeMOR2/oWOfVCqLnFHjN9odJ
	7E3MnrdytJo6ceDczLcb+dwGcPjfJCAbrzfYaDVZbmHMV/iDCUJBb8MIHlnWvmDURvOECxjSEbiXb
	BLCi8Wp/jlHhgmW68Zz0hfOZ/vJIpirQdKjrapYul+cyZvpYfkgFCfOgHKrMfIWaasULZXx4YD6RF
	MCRUo6AyB/lVEr2af6ixagmC4C0G70HCEq524Z/5rLQ5IUE1/ZY0PtKMV4jF52+Ha+G9JElGHAiOR
	wXSEa/SQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHezJ-00D110-E7; Tue, 17 Jan 2023 05:58:25 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHezG-00D10a-UV
	for linux-nvme@lists.infradead.org; Tue, 17 Jan 2023 05:58:24 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 54EDA67373; Tue, 17 Jan 2023 06:58:19 +0100 (CET)
Date: Tue, 17 Jan 2023 06:58:19 +0100
From: Christoph Hellwig <hch@lst.de>
To: Klaus Jensen <its@irrelevant.dk>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: regression on aarch64? panic on boot
Message-ID: <20230117055819.GB13795@lst.de>
References: <Y8XINx8fpGPKudW6@cormorant.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8XINx8fpGPKudW6@cormorant.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230116_215823_161423_ADAD78D7 
X-CRM114-Status: GOOD (  14.99  )
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

On Mon, Jan 16, 2023 at 10:57:11PM +0100, Klaus Jensen wrote:
> Hi,
> 
> I'm getting panics when booting from a QEMU hw/nvme device on an aarch64
> guest in roughly 20% of boots on v6.2-rc4. Example panic below.

This smells like your setup somehow doesn't wait for async driver
probe.  Does the hack below work around it?

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b13baccedb4a95..f47e19c701d520 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3508,7 +3508,6 @@ static struct pci_driver nvme_driver = {
 	.remove		= nvme_remove,
 	.shutdown	= nvme_shutdown,
 	.driver		= {
-		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
 #ifdef CONFIG_PM_SLEEP
 		.pm		= &nvme_dev_pm_ops,
 #endif

