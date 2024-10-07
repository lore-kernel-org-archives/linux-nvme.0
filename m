Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACB7DCFB440
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Oct 2024 06:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ua3/wY6aF/S/Wy4L6Vuz40z8tdhD13d/9Dt9DqE1SNM=; b=bofiheMidqgv3XcGoRk/Ar4h2N
	TdGkSnoVXNnneTJpM7t0p3X4GSBsu8GSU4UGYhnPTOo+s4RN7TZm7PN5z5kPrb1QIqDXpHfEivIoW
	LUyMmA20FNRQMP9AW1XDRGAQOwzptSK0fzeZXvCgCKqi58MFC3YeL7u70AFAlny41mkOiKAmoN3hC
	4JVGQDhk6L94onTpjRySuVf1jbRaTO24vaDONVO2pOGtDM769XbWGZVdh9/haDRO7KUQeMVPTjpic
	kGRXAKQI0YTthc90m4UKCcGxIZCaV65XUqgRBCwtiFyHtrMDeIGX3gKuYYii6jfeqfX+sy2kI887W
	xI/btUTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sxhIP-00000001RU9-35uW;
	Mon, 07 Oct 2024 06:32:41 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sxh5l-00000001P2G-2WvQ
	for linux-nvme@lists.infradead.org;
	Mon, 07 Oct 2024 06:19:39 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 854F8227A8E; Mon,  7 Oct 2024 08:19:26 +0200 (CEST)
Date: Mon, 7 Oct 2024 08:19:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Tero Kristo <tero.kristo@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
	linux-nvme@lists.infradead.org, sagi@grimberg.me, kbusch@kernel.org
Subject: Re: [PATCH 1/1] nvme-pci: Add CPU latency pm-qos handling
Message-ID: <20241007061926.GA800@lst.de>
References: <20241004101014.3716006-1-tero.kristo@linux.intel.com> <20241004101014.3716006-2-tero.kristo@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004101014.3716006-2-tero.kristo@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241006_231937_807378_FDA46ECC 
X-CRM114-Status: GOOD (  11.14  )
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

> @@ -483,6 +498,27 @@ static inline void nvme_write_sq_db(struct nvme_queue *nvmeq, bool write_sq)
>  			nvmeq->dbbuf_sq_db, nvmeq->dbbuf_sq_ei))
>  		writel(nvmeq->sq_tail, nvmeq->q_db);
>  	nvmeq->last_sq_tail = nvmeq->sq_tail;
> +
> +	/* Kick CPU latency while updating queue. */
> +	dev = nvmeq->dev;
> +	if (!dev || dev->cpu_latency < 0)
> +		return;
> +
> +	for_each_cpu(cpu, nvmeq->irq_aff_mask) {

Doing something as complex as this for every doorbell write is not
going to fly.

Even if it was I see nothing nvme-specific in the interface.

So please figure out a way to make things cheap in the I/O path
and move code to the right layers.

Also please avoid all these overly long lines.

