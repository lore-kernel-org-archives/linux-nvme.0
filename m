Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 568FEC43219
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Oct 2022 07:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GPYV/O/ZP80BawMj0Drm042FEtLUyd3jGtoJuGeBCyg=; b=DPYaG28pxntpOSUGEt0OZ8oFTu
	U5Aqh5WLDqoCdlNmENkWB3ZC5xD1AsMBc+gOlTYc1ggK+VZPJwuSry8pFIoLvYfams1Kj3G5KOCAN
	NMeryBgPDLRUGibRFa1tLGL24DPs1MXCfgaQmplUiO+2G5LBJgb7fEfYpR0nFkpadFsl3dB1Owl3t
	oCmjV8l2yZ0yiMWmJNpR1/Ie4yI054u41zUAuksTiYqHM+IRMOUY8GGbqrd09lV84V4IshDTisNsn
	YH07okalTQa4qCSARyqvLjgv82ciGduSJH7Udr3wc3HYZclFyCMIRzDKXzX0/jN94HIhEcGxLLSA1
	xuub4dpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ofFic-004MNt-DV; Mon, 03 Oct 2022 07:18:26 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ofFiZ-004MK3-Jy
	for linux-nvme@lists.infradead.org; Mon, 03 Oct 2022 07:18:25 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6059568B05; Mon,  3 Oct 2022 09:18:16 +0200 (CEST)
Date: Mon, 3 Oct 2022 09:18:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: Xander Li <xander_li@kingston.corp-partner.google.com>
Cc: paulburton@kernel.org, kbusch@kernel.org, axboe@fb.com, hch@lst.de,
	sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, ralf@linux-mips.org,
	jhogan@kernel.org, christian@brauner.io,
	jeff_yang@kingston.corp-partner.google.com,
	dora_chueh@kingston.corp-partner.google.com,
	james_liu@kingston.corp-partner.google.com,
	vincent_wu@kingston.com.tw, xander_li@kingston.com.tw
Subject: Re: [PATCH] nvme-pci-disable-write-zeros-support-on-kingston-SSD
Message-ID: <20221003071816.GA2065@lst.de>
References: <20220930091401.14862-1-xander_li@kingston.corp-partner.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220930091401.14862-1-xander_li@kingston.corp-partner.google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221003_001823_839384_E586C549 
X-CRM114-Status: GOOD (  10.98  )
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

Please write a proper changelog and use a proper subject line.

On Fri, Sep 30, 2022 at 02:14:01AM -0700, Xander Li wrote:
> ---
>  drivers/nvme/host/pci.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>  mode change 100644 => 100755 drivers/nvme/host/pci.c

... and don't change file modes.

