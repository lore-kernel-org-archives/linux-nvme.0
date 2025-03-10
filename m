Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88E5BC282EC
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Mar 2025 14:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G5x93iHy9Zf6DG0sZeOMC2IXXxFe4yTdnB0ILSzB9X0=; b=x82Aw9f+EC0JkIf4DR1IZNbxV4
	657QncMsF1jRf1+fshtJTF7tCdNBs7DelyXIe0OUFH65dnkUHT+SEbl2xihmA6JFuiFbwjPjkqCMb
	AM8z7hXBD5PJ8BquXkA0Wg1O60BByiAEvqGVu+CS9Eejv2rajlG1We5AfakxMvFbbsq34PVMMC0pz
	c6RihZ8kDK8vMTjDNdynx7EIhBCSeE/k+JsjBPAd4qO76he6Lpmp85gomfCdJpwALef5dtEyDLR3O
	/I6PCbcJABEy3DcU6nUUVPunHJ0LWBDVgVMb8esH9ey97tCfd1VFSC+m1ItuFkVv41Rxj2IfW/7Nj
	EVM1ws9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1treRJ-000000030NI-35WJ;
	Mon, 10 Mar 2025 14:49:09 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1trd6L-00000002mYx-2cd2
	for linux-nvme@lists.infradead.org;
	Mon, 10 Mar 2025 13:23:28 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B967267373; Mon, 10 Mar 2025 14:23:11 +0100 (CET)
Date: Mon, 10 Mar 2025 14:23:11 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	nilay@linux.ibm.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2] nvme-pci: fix stuck reset on concurrent DPC and HP
Message-ID: <20250310132311.GA8835@lst.de>
References: <20250307232618.2141065-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307232618.2141065-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250310_062325_812012_A9ABFA1E 
X-CRM114-Status: GOOD (  12.59  )
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

On Fri, Mar 07, 2025 at 03:26:18PM -0800, Keith Busch wrote:
>  	struct request *abort_req;
>  	struct nvme_command cmd = { };
> +	struct pci_dev *pdev = to_pci_dev(dev->dev);
>  	u32 csts = readl(dev->bar + NVME_REG_CSTS);
>  	u8 opcode;
>  
> +	if (pci_dev_is_disconnected(pdev))
> +		nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);

Can you add a comment here (based on the commit message) explaining the
logic here, as it is anything but obvious?

Otherwise this looks good to me.

