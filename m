Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D888C25B75
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Jun 2024 14:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iqw3ulTgT3WOYmTar3ZvencBj9bvK1e+eNQvYeGna2o=; b=iUPuyXZzJmjO5bR0X/1Rqe5blt
	vay12ehmE00CUrhZGveg5DLPWVMVWgF8/htvAJyUM2X5sD4SFwgexp47Jk/TOhseyA3VavOJe8wpN
	OvF4nF6GjLzdFMEiWJpWe2UOD3pHKgy3+aDjNeD1lXw2ftvj0jVEkTaBvIuAL7g82C4qaB84a1XwX
	KNF8hwLO00jc82syX3+YdjkOoRfezs8lFnxDEJVg7wAva8Zh2y6AbDEvP5vPY5NU2jWF+IIGIzMfy
	rGR+/TUBBCgLzjc64nCHBh/PU0gXucr2qG54GcZiB2GTMREROehvhrGLQWvcZE55nyTCx9cw8z8Nz
	/GxuxWGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFE8R-0000000A5Sd-1xX0;
	Thu, 06 Jun 2024 14:30:35 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFE8M-0000000A5RZ-1QUS
	for linux-nvme@lists.infradead.org;
	Thu, 06 Jun 2024 14:30:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717684227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iqw3ulTgT3WOYmTar3ZvencBj9bvK1e+eNQvYeGna2o=;
	b=QzSuwhL+jDiuNkoleoJ35rTKDWuoYCi0ASe1urcTbpnh+21y0dZfygRxfJQgfW05L0ROyH
	UR8E93TMS59maBJx1EGfbvDUGBbmL+LdCmRBScuBKFXAC5vOb1Oe4wzc6LHnyWauAzvrCA
	NfSAhnvSA/GNx0P6xhYpcpE3HjgSda8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-303-bNueIWOhOgeP9J9aaoLCfA-1; Thu,
 06 Jun 2024 10:30:22 -0400
X-MC-Unique: bNueIWOhOgeP9J9aaoLCfA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5062F196DFDF;
	Thu,  6 Jun 2024 14:30:20 +0000 (UTC)
Received: from fedora (unknown [10.72.113.78])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6B9301959178;
	Thu,  6 Jun 2024 14:30:11 +0000 (UTC)
Date: Thu, 6 Jun 2024 22:30:06 +0800
From: Ming Lei <ming.lei@redhat.com>
To: yebin <yebin@huaweicloud.com>
Cc: Christoph Hellwig <hch@infradead.org>, axboe@kernel.dk,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ye Bin <yebin10@huawei.com>, Zhang Yi <yizhan@redhat.com>,
	"Ewan D. Milne" <emilne@redhat.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] block: bio-integrity: fix potential null-ptr-deref in
 bio_integrity_free
Message-ID: <ZmHH7mW0M80RaPlj@fedora>
References: <20240606062655.2185006-1-yebin@huaweicloud.com>
 <ZmFatW3BEzTPgR7S@infradead.org>
 <66619EB6.4040002@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66619EB6.4040002@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240606_073030_547120_79806E13 
X-CRM114-Status: GOOD (  19.18  )
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

On Thu, Jun 06, 2024 at 07:34:14PM +0800, yebin wrote:
> 
> 
> On 2024/6/6 14:44, Christoph Hellwig wrote:
> > What kernel is this on?  As of Linux 6.9 we are now always freezing
> v4.18
> > the queue while updating the logical_block_size in the nvme driver,
> > so there should be no inflight I/O while it is changing.
> > 
> The root cause of the problem is that there is no concurrency protection
> between
> issuing DIO checks in __ blkdev direct IO simple() and updating logical
> block sizes ,
> resulting in the block layer being able to see DIOs that are not aligned
> with logical
> blocks.

Yeah, that is one area queue freezing can't cover logical block size
change, but I'd suggest to put the logical bs check into submit_bio() or
slow path of __bio_queue_enter() at least.

BTW, Yi has one reproducer, and slab is corrupted just like this report
when running 'nvme format' & IO on partitions.

I am not sure if this kind of change can avoid the issue completely, anyway
Yi and I can test it and see if the kind of change works.

My concern is that nvme format is started without draining IO, and
IO can be submitted to hardware when nvme FW is handling formatting.
I am not sure if nvme FW can deal with this situation correctly.
Ewan suggested to run 'nvme format' with exclusive nvme disk open, which
needs nvme-cli change.



Thanks,
Ming


