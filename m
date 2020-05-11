Return-Path: <SRS0=0nye=6Z=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB23C47255
	for <linux-nvme@archiver.kernel.org>; Mon, 11 May 2020 11:49:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F0C42075E
	for <linux-nvme@archiver.kernel.org>; Mon, 11 May 2020 11:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EABgSzDT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PgB2qKCP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F0C42075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=INKudaqcwqN6VUhtWp0EwrQgm62vpTc4gnXt+Yx/HLs=; b=EABgSzDT0Oy15I
	WzHVF5H0UNZbbjIZS44xAGvQUB1kxYdeEQMkh3VKOkKJRv37Aa4ZNPRmfWB8az1+dqK66rT3SX581
	QeH9HBOob9QvNLmTcuf+HaCnzOZcQBe9r5s/SZ2gNt2TjDCGZkai+m0qc1B/ZhxVd+ziSBZRR0NFT
	qyQSvf5xT32UmbYSiZcoUciJQRG5jobay8tVUgl0MQ4mC/ZrXNf+ue3AySLjMfiJqM4SmCQl6FKVf
	Km0pnF5vqVaG3fULnKaMAtVstWQKDR+8DmqZIiF0g6LlLrsAaUs/R4F3dMmeEFzKehppWRbK4/46v
	ni7yf9ZyljoSC3anm9Sg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jY6vp-0005zH-6x; Mon, 11 May 2020 11:49:13 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jY6vm-0005yk-R3
 for linux-nvme@lists.infradead.org; Mon, 11 May 2020 11:49:12 +0000
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7A73820735;
 Mon, 11 May 2020 11:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1589197750;
 bh=BvRZXmMuapuNp0p+2M6WPeTL8fmI8i3xlnVzt8b0bak=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PgB2qKCP4VjfRypQYBWANSGIb/OU97qoVl3xsOy+pm1fek2orhH9BwpTHne9TN1V9
 aiW0HWCe/ExDoUqtr/3hb/qLBzLiKBodTQzvHiVoFHTYpg5SxnUaCCcbRS7sgv+8CX
 Q0P5THY5SmM02u+T2Wx1RPX/QaiZwn6PDHjxIISQ=
Date: Mon, 11 May 2020 12:49:06 +0100
From: Will Deacon <will@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme-pci: dma read memory barrier for completions
Message-ID: <20200511114905.GC18310@willie-the-truck>
References: <20200508200406.2814437-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200508200406.2814437-1-kbusch@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200511_044910_895296_C073DDC6 
X-CRM114-Status: GOOD (  16.87  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: John Garry <john.garry@huawei.com>, hch@lst.de,
 linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, May 08, 2020 at 01:04:06PM -0700, Keith Busch wrote:
> Control dependencies do not guarantee load order across the condition,
> allowing a CPU to predict and speculate memory reads.
> 
> Commit 324b494c2862 inlined verifying a new completion with its
> handling. At least one architecture was observed to access the contents
> out of order, resulting in the driver using stale data for the
> completion.
> 
> Add a dma read barrier before reading the completion queue entry and
> after the condition its contents depend on to ensure the read order is
> determinsitic.
> 
> Reported-by: John Garry <john.garry@huawei.com>
> Suggested-by: Will Deacon <will@kernel.org>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/nvme/host/pci.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index e13c370de830..3726dc780d15 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -989,6 +989,11 @@ static inline int nvme_process_cq(struct nvme_queue *nvmeq)
>  
>  	while (nvme_cqe_pending(nvmeq)) {
>  		found++;
> +		/*
> +		 * load-load control dependency between phase and the rest of
> +		 * the cqe requires a full read memory barrier
> +		 */
> +		dma_rmb();
>  		nvme_handle_cqe(nvmeq, nvmeq->cq_head);
>  		nvme_update_cq_head(nvmeq);
>  	}

Thanks for doing this:

Acked-by: Will Deacon <will@kernel.org>

Will

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
