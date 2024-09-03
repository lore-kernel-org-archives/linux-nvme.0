Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9D41CD37AC
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Sep 2024 20:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LO1F3C8pTgA53/+xbjsN7DzLKK4EXDmtTLZYwHeZU/k=; b=p303PYoN1f8dXHBIo6N5dkZ0zZ
	26oXrzTcE3P5jSskdd93vXdX7/SufdWKvgwdBm6WBIab0x70nqW043sHay3uVccm7qk5efKx62SXm
	M8cN4c6hxSSiaSPrTXgxtzF/CQE4wtIkGpD9AtZQ5emZvAEHPGm0nsImogPaKQEVrDUWSpHtDI6/v
	FiqCafgo7KgkWI8VMXXlQRdXgKyNBJFz9vUGGb2+TPnMw8eSJbHvC+BFgZ2djzSzRBkJ100Kz05+C
	LktixMC2hbVNc9WFeQgrl5uY6KJzslpbCPWYyEp9kuxKR4oOROH9dmOSrQCvmipvOmZJfN4hVIzHS
	tKKm/X0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slZog-00000001hWI-2G7h;
	Tue, 03 Sep 2024 20:07:54 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slZoL-00000001hUv-2Gtc
	for linux-nvme@lists.infradead.org;
	Tue, 03 Sep 2024 20:07:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 7A847A43E19;
	Tue,  3 Sep 2024 20:07:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9704C4CEC4;
	Tue,  3 Sep 2024 20:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725394052;
	bh=w9ZlkozZYNADHJG2knoMm9mmuRh8k6zMyV5Clc+hUuU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B2ID/5KPNAoLxVWr//DCXOoWoCNUaynCnMBvb6hOAQNiuVhydvSDUIW3VfIN8ufN7
	 ORCK9YJfWJhZKVwb1qErc01WxPixgHdGGPVepnRbTyK3fnyZBddJF747mghFD2mlCb
	 2nUFikyYsfnH9pKrKH8NZ7Iku3zDRRmVz7s9+3eNRWOj6qeaNoPehOehk6y0lbW3DO
	 Zsdjz3TW+vnAkuP8gKoLzeYM8m//1gahjWk86emu6shafE2nLHyPys5cYrJGmE4b6h
	 pYXAzZ7SiXTCUQdMVNdgaXmtL3KLSERha3srfl8BaVBmZq2eTKCLW07MgurP8TksZx
	 18xJDoSg+CyUg==
Date: Tue, 3 Sep 2024 14:07:29 -0600
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
	Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-pci: check for valid request when polling for
 completions
Message-ID: <ZtdsgaDzdk9rLStb@kbusch-mbp>
References: <20240902130728.1999-1-hare@kernel.org>
 <d916ae67-fd43-403d-8053-4a5c0a472738@grimberg.me>
 <93dbb39f-3c5f-4631-aabf-1f4222781b06@suse.de>
 <Ztcn04fAPHM5BeAy@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ztcn04fAPHM5BeAy@kbusch-mbp>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240903_130733_664083_36A20F32 
X-CRM114-Status: GOOD (  18.06  )
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

On Tue, Sep 03, 2024 at 09:14:27AM -0600, Keith Busch wrote:
> On Tue, Sep 03, 2024 at 08:25:08AM +0200, Hannes Reinecke wrote:
> > On 9/2/24 19:04, Sagi Grimberg wrote:
> > > On 02/09/2024 16:07, Hannes Reinecke wrote:
> > > > When polling for completions from the timeout handler we traverse
> > > > over _all_ cqes, and the fetching the request via blk_mq_tag_to_rq().
> > > > Unfortunately that function will always return a request, even if
> > > > that request is already completed.
> > > > So we need to check if the command is still in flight before
> > > > attempting to complete it.
> 
> So the very same command was completed in some other context? We've
> disabled the queue's interrupt here, there should be no other context
> that can concurrently complete it. The timeout poll check is supposed to
> check only unseen cqes, not "all" of them. Is disable_irq() not a
> sufficient barrier for accessing the cq head or something?

Ooo, I think I see a problem. Does your device have more than one
namespace? I think we need to lock this queue for that condition because
the timeout work executes per-namespace, and we're not locking that
today. If you do have a muliti-namespace controller, does the below fix
your observation? 

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6cd9395ba9ec3..2c73ccd21afe3 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1109,9 +1109,11 @@ static void nvme_poll_irqdisable(struct nvme_queue *nvmeq)
 
 	WARN_ON_ONCE(test_bit(NVMEQ_POLLED, &nvmeq->flags));
 
+	spin_lock(&nvmeq->cq_poll_lock);
 	disable_irq(pci_irq_vector(pdev, nvmeq->cq_vector));
 	nvme_poll_cq(nvmeq, NULL);
 	enable_irq(pci_irq_vector(pdev, nvmeq->cq_vector));
+	spin_unlock(&nvmeq->cq_poll_lock);
 }
 
 static int nvme_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)

