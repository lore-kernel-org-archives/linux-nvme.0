Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 002FBCCD1BC
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Oct 2025 08:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EZJcoG882HHp7inpoigLZjYjAAr4ChrT6TgIjVfqHJY=; b=ud9I9052e++i0HHlyVJ+vRfYiK
	FAG3Gz0ZPn2yTiSIaQm9/2AsVd6m5EAmRWQ35F53c83yRqoeo6l1n6QwhXTg8HXx2i0e97WXlfliW
	3LQPPrdmkuLGj2LKnn1wxXiBd/82N4Lsd+bXB5xXcomLTrLuLJ06YEJ9TjVjIC8YWbfxAGAFhNjZo
	4MtQkW6DfXyAlZSHPMcN9QcmL4iDtd9wJtAqG7oBIWkKNDe0ndsSQJN5n4AtPCfS/HgMmOptOPTly
	/vc3ZkQo6KABx9cgW2+oejFR/EOKdupGlswcmoGJBa8b6u/Zp0n3oJlVt4/MibttvuNtE4w/VBwXF
	Ni4sJqCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBqSH-00000005Ujc-1x0y;
	Thu, 23 Oct 2025 08:13:53 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBqSG-00000005Uiq-2UiO
	for linux-nvme@bombadil.infradead.org;
	Thu, 23 Oct 2025 08:13:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EZJcoG882HHp7inpoigLZjYjAAr4ChrT6TgIjVfqHJY=; b=T4bJ2kPv3C1wkYCORINIX+TrPo
	7/ZSytzCvjuYnAwnXKU33u+Qy7D+ncaKScOFxY5hkm2D4+BTmvPkrJMoyxLvlIvgVLONwdFIYa/mC
	ZlBCIW6bY7z5y2H1fhIWim861DLgstVopzOV1xWP7mX3aByygVF1WDdV2+0UD4gxY3F0EhQWiSeZn
	SrpBz5ZGnt7OH0xfLZammFOY8W/ssxnSPT+mJLHVP6M+fzLFOK+Rvk8pWVWNbz44m2KYMwlZOfa4z
	+II/0QEEwGF+6/dDsEgVGCrpFy85IKlLg1oDrweO1+l4SeT9SaJWg31IzUxC/VQdM8ZPkvrHshw8e
	N3zbKg0w==;
Received: from verein.lst.de ([213.95.11.211])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBpaW-00000001BCi-1hD7
	for linux-nvme@lists.infradead.org;
	Thu, 23 Oct 2025 07:18:24 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 861B9227AAA; Thu, 23 Oct 2025 10:13:41 +0200 (CEST)
Date: Thu, 23 Oct 2025 10:13:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: Gerd Bayer <gbayer@linux.ibm.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] nvme-pci: Add debug message on fail to read CSTS
Message-ID: <20251023081341.GB302@lst.de>
References: <20251022-nvme_probefail-v2-0-26bbdf94280e@linux.ibm.com> <20251022-nvme_probefail-v2-2-26bbdf94280e@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022-nvme_probefail-v2-2-26bbdf94280e@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251023_081820_572525_89F95628 
X-CRM114-Status: GOOD (  12.28  )
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

On Wed, Oct 22, 2025 at 12:33:17PM +0200, Gerd Bayer wrote:
> Add a debug log spelling out that reading the CSTS register failed - to
> distinguish this from other reasons for ENODEV.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

