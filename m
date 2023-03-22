Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B0CAC6FD1C
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Mar 2023 08:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OfDlAHq1gfve7C44UnoNldFUsJXY6lwWLJyhPZ7TgRM=; b=AgRDjlaiHesWVji5kJo+ag2Jge
	EybhH+jYeusIXiGpL6uIey8jR+TTdoxBQa7JLaSUktfov6eDS7lS5iGBXx8ARCVUarNy/ekCtdqLP
	r1k3uEFQG97kx1LU8YXP+PqsrpKTSOE00FcAhmcKJ5wHDYTh97WKPJf2k+BI558llhSw2o/B9XxCA
	wM5T2460cA8zvrpoNxCT55w6m7xgT3JsC7l59j6W8cN1pYFpfZ2X6/Dnvlg5Q88YcV9fLhMQJGzEP
	/1b/Fjy54c5Vu5a7UvfCV7q0d1DrGEdkL7t5plQvyTh1A6VjldZw85ceDleFDCyBO+0MvGG31jekD
	q6f1ZPrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1petoZ-00FAoH-0x;
	Wed, 22 Mar 2023 08:27:23 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1petoX-00FAnl-1B
	for linux-nvme@lists.infradead.org;
	Wed, 22 Mar 2023 08:27:22 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8F99D68C7B; Wed, 22 Mar 2023 09:27:17 +0100 (CET)
Date: Wed, 22 Mar 2023 09:27:17 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	axboe@kernel.dk, linux-nvme@lists.infradead.org, hch@lst.de,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 1/3] nvme-fabrics: add queue setup helpers
Message-ID: <20230322082717.GC22782@lst.de>
References: <20230322002350.4038048-1-kbusch@meta.com> <20230322002350.4038048-2-kbusch@meta.com> <ac4ecdd4-104e-0fcf-0ac5-42dde79daf35@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac4ecdd4-104e-0fcf-0ac5-42dde79daf35@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_012721_547460_5FEFDDF6 
X-CRM114-Status: GOOD (  18.93  )
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

On Wed, Mar 22, 2023 at 09:35:46AM +0200, Sagi Grimberg wrote:
>>   +unsigned int nvme_nr_io_queues(struct nvmf_ctrl_options *opts)
>> +{
>> +	unsigned int nr_io_queues;
>> +
>> +	nr_io_queues = min(opts->nr_io_queues, num_online_cpus());
>> +	nr_io_queues += min(opts->nr_write_queues, num_online_cpus());
>> +	nr_io_queues += min(opts->nr_poll_queues, num_online_cpus());
>> +
>> +	return nr_io_queues;
>> +}
>> +EXPORT_SYMBOL_GPL(nvme_nr_io_queues);
>
> Given that it is shared only with tcp/rdma, maybe rename it
> to nvmf_ip_nr_io_queues.

Even if the other transports don't use it, nothing is really IP
specific here, so I don't think that's too useful.  But I'd use
the nvmf_ prefix like other functions in this file.

Just a personal choice, but I'd write this as:

	return min(opts->nr_io_queues, num_online_cpus()) +
		min(opts->nr_write_queues, num_online_cpus()) +
		min(opts->nr_poll_queues, num_online_cpus());

>> +EXPORT_SYMBOL_GPL(nvme_set_io_queues);
>
> nvmf_ip_set_io_queues. Unless you think that this can be shared with
> pci/fc as well?

Again I'd drop the _ip as nothing is IP specific.  FC might or might not
eventually use it, for PCI we don't have the opts structure anyway
(never mind this sits in fabrics.c).

>> +void nvme_map_queues(struct blk_mq_tag_set *set, struct nvme_ctrl *ctrl,
>> +		     struct ib_device *dev, u32 io_queues[HCTX_MAX_TYPES])
>
> Ugh, the ib_device input that may be null is bad...
> I think that we can kill blk_mq_rdma_map_queues altogether
> and unify the two.

Yes, I don't think anything touching an ib_device should be in
common code.

