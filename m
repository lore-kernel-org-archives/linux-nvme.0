Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BF81C47DDB
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jan 2024 05:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hlO+DakUzjEkk8EIcvBYXdQEDrqtpVlTf7vifGXpeuI=; b=sgB87WfO88o7ErC57R7cW36yG2
	1B5yPHAs2VTH9MnhWqF/7D9JipYgl55zqLHzObT+bueHnYLVPnpuxMDgHW9SGeeTXEiBYDeDEkrGz
	hzureVvDFWrSafRgr1XBrvGYgHZpiz96T8F7HyzYlmbS9FztZ2xxmhZXjozB2291bM54gezn3U6zW
	/qdk8SAWihlKTSw0OZjy275Q8inXa5JcBsWQLinPr740kZkf2LtGuksYgS+iAaa2evZhKvsS6kuI6
	TDMUsBAZnwlt/Dzj+VS1bTO1mUlpNxNVWX59I32ss6DVMasGT3mu09XoweOL2dtH1I0DZ+bSWoKT+
	Vbo5Z33w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rS9K0-00F8ym-1d;
	Tue, 23 Jan 2024 05:27:40 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rS9Jx-00F8yN-32
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jan 2024 05:27:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 700A161378;
	Tue, 23 Jan 2024 05:27:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59CBCC433C7;
	Tue, 23 Jan 2024 05:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705987627;
	bh=cPpu6ryn6gkRkvgmx4NerAEJXJOWL4ErojxtTppxpQo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=M+V5V36ZwxIdQ8NpR4onAMDbaeC9+Rg48L4OWqwJG51BX9RMubDfuV8sjIh05WA2J
	 GpYgeCxXjJk8jFhXnrGYDtshunmpZLjdt7NKlE76dOwuIJp888x8RsuVgJxk03V6So
	 yi8MkobMZ4oZ1nWwGQKESKgY1gbD5jgohXPS1LZKOG1YOsQNQK5KDHs3C/q0FCte6O
	 8ZEe3S9IVUrQ1xM8r5aFclcW+QFL0tzfCiyKOXKkx1xAW+GTwAlytvEtbLbbxYHsc9
	 jnwXrLixQoKT9kNjOXdrvMBpyl3BuYPS2VdPrnEG2NOrL3jjGyprVZeWuu5ncV06cJ
	 E0TCPQK3VmsFg==
Message-ID: <0e8dacc9-0353-4e1c-a954-986426abdbf6@kernel.org>
Date: Tue, 23 Jan 2024 14:27:05 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/15] virtio_blk: pass queue_limits to blk_mq_alloc_disk
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 virtualization@lists.linux.dev
References: <20240122173645.1686078-1-hch@lst.de>
 <20240122173645.1686078-13-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240122173645.1686078-13-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240122_212738_021617_BE67540E 
X-CRM114-Status: UNSURE (   9.74  )
X-CRM114-Notice: Please train this message.
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

On 1/23/24 02:36, Christoph Hellwig wrote:
> Call virtblk_read_limits and most of virtblk_probe_zoned_device before
> allocating the gendisk and thus request_queue and make them read into
> a queue_limits structure instead.  Pass this initialized queue_limits
> to blk_mq_alloc_disk to set the queue up with the right parameters
> from the start and only leave a few final touches for zoned devices
> to be done just before adding the disk.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


