Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AD4EC47258
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jan 2024 14:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DAdwpABuOILV1uxH1rKXtKcK7ll1p9ugUOxYJn2Narc=; b=jGsEFI48EZRKz/0qXeHMNdjamM
	pToV4PB6IzwVHLITtdKghaKf5rHAH/VvX412dFXovsprQjcUf/TLUU2uepOT+DMmFUti5sO0cJ+nv
	Eb3FB1DWcaFms/I5m47SwHyTNIKx1N5uiTfVvpHDtLrXi++SD2DA8uO8MCPz0JvZc3JsBf2wSrTq8
	m6Lpw5Fo2Gb1YuRtyvylHCsHT+dF1etrg42Df9SxP4YqWJlwdev/HXV5bKC3fOs7q6u9lRX2gMkx2
	7L0+qvv3bicz6oiVG4Vkl22Z/BRjWjHcIXn0rPDSwsHBfiCwcpLk64pODLYNN9Nw3SnzflWaQrM2z
	0iqAioKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rT0pS-00000000OZ1-3wAk;
	Thu, 25 Jan 2024 14:35:42 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rT0pQ-00000000OYU-0xLj
	for linux-nvme@lists.infradead.org;
	Thu, 25 Jan 2024 14:35:41 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id AF6A867373; Thu, 25 Jan 2024 15:35:36 +0100 (CET)
Date: Thu, 25 Jan 2024 15:35:36 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH 03/15] block: add an API to atomically update queue
 limits
Message-ID: <20240125143536.GB17817@lst.de>
References: <20240122173645.1686078-1-hch@lst.de> <20240122173645.1686078-4-hch@lst.de> <79eb5c4c-d9c0-4a70-94ac-04892bbf8085@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79eb5c4c-d9c0-4a70-94ac-04892bbf8085@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240125_063540_455512_1F5D4C94 
X-CRM114-Status: GOOD (  24.56  )
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

On Thu, Jan 25, 2024 at 10:28:49AM +0000, John Garry wrote:
>
>> +
>> +int blk_validate_limits(struct queue_limits *lim)
>> +{
>> +	unsigned int max_hw_sectors;
>> +
>> +	if (!lim->logical_block_size)
>> +		lim->logical_block_size = SECTOR_SIZE;
>
> nit: This function is doing a bit more than validating, as the function 
> name suggests

Well, it validates and fixes up.  But that sucks as a name.  If you
have a good naming suggestion I can pick it up, but I couldn't come
up with a better name.

>> +	if (!lim->physical_block_size)
>> +		lim->physical_block_size = SECTOR_SIZE;
>> +	if (lim->physical_block_size < lim->logical_block_size)
>> +		lim->physical_block_size = lim->physical_block_size;
>> +
>> +	if (!lim->io_min)
>> +		lim->io_min = SECTOR_SIZE;
>> +	if (lim->io_min < lim->physical_block_size)
>> +		lim->io_min = lim->physical_block_size;
>> +
>> +	if (!lim->max_hw_sectors)
>> +		lim->max_hw_sectors = BLK_SAFE_MAX_SECTORS;
>> +	if (WARN_ON_ONCE(lim->max_hw_sectors < PAGE_SIZE / SECTOR_SIZE))
>> +		return -EINVAL;
>
> The WARN_ON_ONCE usage is odd, as it will only ever WARN once for a 
> specific q, while other queues associated with other drivers may have the 
> same limit issue. But I suppose if one issue is fixed, then the other will 
> make itself known...

Yeah.  The idea is to give a loud warning for the API misuse as this
is not an error a normal user action could trigger.

>> +	int error = blk_validate_limits(lim);
>> +
>> +	if (!error) {
>> +		q->limits = *lim;
>
> this is duplicating what blk_alloc_queue() does

I originally had another helper to do the limits assignment
and the blk_apply_bdi_limits.  But as only one caller needs
the blk_apply_bdi_limits it felt a little silly.

>> +static inline struct queue_limits
>> +queue_limits_start_update(struct request_queue *q)
>> +	__acquires(q->limits_lock)
>> +{
>> +	mutex_lock(&q->limits_lock);
>> +	return q->limits;
>> +}
>> +int queue_limits_commit_update(struct request_queue *q,
>> +		struct queue_limits *lim);
>
> It ain't so nice that the code for queue_limits_start_update() and 
> queue_limits_commit_update() pair are in separate files.

We do that for a lot of APIs where part is inline.  And I really do
want queue_limits_start_update inline as passing large structs by
value generates horrible code, and for this API to work it needs
to be returned by value.  In fact it probably should be __always_inline
to avoid gcc doing stupid thing with -Os.


