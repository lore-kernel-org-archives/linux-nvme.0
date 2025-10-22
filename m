Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDE92CCD1BE
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Oct 2025 06:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jutoeGXIIdFs84rYYmPLH8lp0eLcP7kJ7jyCxJubItI=; b=rlmmBO2LjK1f/uVnJd7TYaRSXt
	hh/Er7MseohWjfK3CWe7K0IogJmbZz0TIp6sNCq4/Xv1JBV7+JK6SjUm2rAcMG6eOgJhQGkfvMxob
	egc4S8IK3acHGwuXmxprbsE68qD+Dr0vf7TBH/uqsjj0GGm4BjBHsK7qfTClFBtb7C2V3MTe5iLOg
	9aYYaNnIQUEqKZWny9CLkyEOrC/o9RyEgUv3oIs5couxK/a7qtQ/UbgfVwEX41BfRwbtj4JF7+gm+
	b5kP+tzDmz2rgKmUMwpca2eGqjk4XnhgH591wwW2IKgyi8VB6IeZzKzEM3yEbYKujEPH5K/XzBT/H
	4OtGIuDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBRuA-00000001bPb-2Mhi;
	Wed, 22 Oct 2025 06:01:02 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBRu8-00000001bOj-2HR3
	for linux-nvme@lists.infradead.org;
	Wed, 22 Oct 2025 06:01:01 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 07442227A8E; Wed, 22 Oct 2025 08:00:54 +0200 (CEST)
Date: Wed, 22 Oct 2025 08:00:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de,
	Keith Busch <kbusch@kernel.org>, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCHv2] nvme-pci: use blk_map_iter for p2p metadata
Message-ID: <20251022060052.GB4220@lst.de>
References: <20251021151831.2009152-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021151831.2009152-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251021_230100_741675_502CA229 
X-CRM114-Status: GOOD (  11.06  )
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

On Tue, Oct 21, 2025 at 08:18:31AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The dma_map_bvec helper doesn't work for p2p data, so use the same
> blk_map_iter method that sgl uses for this memory type.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Although I'd still rename nvme_pci_setup_meta_sgls as in my draft as
the name is a bit misleading now.


