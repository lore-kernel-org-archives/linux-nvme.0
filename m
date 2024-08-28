Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 614C5C63685
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Aug 2024 15:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nq4rvs8NnWGrg17fvxqZ/IqzNHd6+88ivbvzoINk3aI=; b=oVyVlJzl2E6Fys9Dtf72MCJJax
	9wDbwzvP8z4qhMCq1olVEnjAdJLcmrg11iKdSkXlZf54i1NMb8z44+RHjhbIjqRpkux9y4/d/M/W0
	ryyXyZRSpPgWXZBR+fn2JgwMQyrXDlMDfpPjkdNi00CPfo6wSQkm8D1HfipsvZlvwG3RVivBwqKhR
	w0gMzyWVqdlbNIzaH7GBqq6bNc5zOzRlPJXNtjEy5jqWe9k/L1pS6c+1V0+Bz5BZPmopfuLbW2I+t
	edHdu94bYnM5f8t8m2bAOyF7gdbNmZOD0RhkBOBjXMP0t+k4OYtdi77Z80MpJi+TB70nXrGMlTzKV
	kJmt/ylw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjL2k-0000000G6OE-3Lmy;
	Wed, 28 Aug 2024 15:57:11 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjKyH-0000000G5UA-1InU
	for linux-nvme@lists.infradead.org;
	Wed, 28 Aug 2024 15:52:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id D6C6BA41AC2;
	Wed, 28 Aug 2024 15:52:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED034C4CEC2;
	Wed, 28 Aug 2024 15:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724860351;
	bh=aLJZstYbMFsoiIlcnF9iYgXbHkoB/kdXa6tTizeKPLA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K+idIZXhm71qDaiB+CSRtRkiCrA21en25/YuTiXq4wMjDxpUitQFB/2D2gN8oUbdU
	 JPG7wE1lHOx8AgAyo/QB+EZ1t2YoiREcVuhOHIwEQ/Y9ipfMgwb8NZPA5XMH3W5tZ/
	 JmFuwCnj2YXHJrnUlBcucITQZSFEySs+smgK6SRG1aEmTAz9AvpNt/8QJo+apHLNJQ
	 3km0M4JMnfCmZFUemMQ3zVyhkbLL4kSURg9n6yMA4VBWyWdgCxPgQ5tBZtN+VsCi7A
	 YNiuHVmYexJ2yYZeYX01IgD8BOPftu4jArnYwLx+yHmYPaChULyrffo9QUfOvdkALc
	 oHMANM+Taynmw==
Date: Wed, 28 Aug 2024 09:52:28 -0600
From: Keith Busch <kbusch@kernel.org>
To: Puranjay Mohan <pjy@amazon.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, puranjay@kernel.org
Subject: Re: [PATCH v2] nvme: check if the namespace supports metadata in
 nvme_map_user_request()
Message-ID: <Zs9HvJh8GRvYilFB@kbusch-mbp>
References: <20240827132327.1704-1-pjy@amazon.com>
 <Zs8360kRPGa1B5xy@kbusch-mbp>
 <mb61p1q28y88y.fsf@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mb61p1q28y88y.fsf@amazon.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240828_085233_434689_74EC63DF 
X-CRM114-Status: GOOD (  22.69  )
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

On Wed, Aug 28, 2024 at 03:31:09PM +0000, Puranjay Mohan wrote:
> Keith Busch <kbusch@kernel.org> writes:
> 
> > On Tue, Aug 27, 2024 at 01:23:27PM +0000, Puranjay Mohan wrote:
> >> @@ -119,9 +120,13 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
> >>  	struct request_queue *q = req->q;
> >>  	struct nvme_ns *ns = q->queuedata;
> >>  	struct block_device *bdev = ns ? ns->disk->part0 : NULL;
> >> +	bool has_metadata = bdev && meta_buffer && meta_len;
> >
> > If this is an admin command, then bdev is NULL, so "has_metadata" is
> > false.
> >
> >>  	struct bio *bio = NULL;
> >>  	int ret;
> >>  
> >> +	if (has_metadata && !blk_get_integrity(bdev->bd_disk))
> >> +		return -EINVAL;
> >> +
> >
> > Since has_metadata is false, we continue on to process this admin
> > command, but ignore the user's metadata settings. Do we want to return
> > error there too?
> 
> As an admin command with metadata is an invalid configuration, we can

It's not that it's an invalid configuration. The spec defines the common
command format allowing admin commands to transfer metadata.

There's just no existing spec defined command that makes use of it.
Nothing stops a vendor specific command from using it. If someone
tried, the kernel reports success, but we didn't execute the requested
command.

> ignore the metada and go ahead with the admin command or I can add the
> following after the above check:
> 
> 	if (!bdev && (meta_buffer || meta_len))
>     	return -EINVAL;
> 
> I don't know what is the best approach here.

Yeah, or just do it in one line with the bdev case too:

	bool has_metadata = meta_buffer && meta_len;
	...

	if (has_metadata && (!bdev || !blk_get_integrity(bdev->bd_disk)))
		return -EINVAL

