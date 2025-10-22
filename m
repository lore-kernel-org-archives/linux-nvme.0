Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AB12CCD1BE
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Oct 2025 06:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JE+VSzzrdZs+oVSXykDzcbShw5YcmtiV5c73cnzYWXM=; b=VCUe1JC62Y9Xf2sbeKaOdpVoiT
	0eko7yqTFjLkIWpEL0GBVu3VJK1s+nVxL1yI5er4dBIxLfuQjl5+YwGQk80tTF9MEz8qgAnXmgW5Y
	okwREprg8Z1pD5r4O+Kk636pVjALWOFgS6xrL2eKh2c19nmzsYxfgcroO379g2tfy+vQK0s6Eq+5F
	eQYnt29SyeKgprFZlutrjKu9CYV9z0M8iSJBLx+t5RBMs4l9qLT6MJSfCcls4Hh3g5audN3VHmaqP
	UfuaCfl3Zu8gBl8DCD38kKMxn2ciLTfIto0uCXikC9p9E2pe5/lhjpGbZwhZNetQjN94VbPPgiwSz
	bemeHdHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBSJp-00000001ewH-1XLy;
	Wed, 22 Oct 2025 06:27:33 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBSJn-00000001evl-0Lsi
	for linux-nvme@lists.infradead.org;
	Wed, 22 Oct 2025 06:27:32 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6EDE66732A; Wed, 22 Oct 2025 08:27:27 +0200 (CEST)
Date: Wed, 22 Oct 2025 08:27:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: Gerd Bayer <gbayer@linux.ibm.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] nvme-pci: Add debug message on fail to read CSTS
Message-ID: <20251022062727.GB4790@lst.de>
References: <20251020-nvme_probefail-v1-0-a420046d98f0@linux.ibm.com> <20251020-nvme_probefail-v1-2-a420046d98f0@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020-nvme_probefail-v1-2-a420046d98f0@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251021_232731_270109_7A4F6D11 
X-CRM114-Status: GOOD (  15.78  )
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

On Mon, Oct 20, 2025 at 05:29:08PM +0200, Gerd Bayer wrote:
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 7544c4bac2c4a230d32cf729abb9e94bf93a921f..c3b0a9d56ac1f32f67ce0890becd6425eb80ebad 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2906,6 +2906,7 @@ static int nvme_pci_enable(struct nvme_dev *dev)
>  	pci_set_master(pdev);
>  
>  	if (readl(dev->bar + NVME_REG_CSTS) == -1) {
> +		dev_dbg(dev->ctrl.device, "Read CSTS register failed");

Should this say "reading" instead of "read"?  Also most (but not
all) nvme errors don't start with capitalized words, like most drivers
as far as I can tell.


