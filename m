Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 625FDC433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Nov 2022 00:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Swuw4Srtq7ILJ+Sr28sVCP8NRm0onxfQ8iNTcMfZrZ0=; b=39AMId3mTV1AEXWFUe0X/uEW00
	Jcq0SEXKZOYXMmhaWEJnMGvUnj55H8h2VafquPzlFO7nlqPrauVEe8JZB693amX3A3zuOJ/mTK0MA
	WEIrU6Ixx82Jn+mWS+Brx6xSdMuhQIxN4PJT4CzxXmLi/78Lg5+aIlYcBFU6oYTmKhWMoTFvNvnO8
	PRpJU0GwwENz8ABws73V4g+12ZSR2ROmYYFtqkwKZbKSa/GgKRTtovpEURmyOMSaByj/d5WY9R17a
	6m+xWo9y1Qd0QLyyDKPNOaHJfxflv5oeDL2O/xwYZhfTCAePBnEfBNyYdkfGD3gdHnVDF6d7K97nm
	nMRhEAAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxzjF-002zOO-EF; Thu, 24 Nov 2022 00:04:33 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxzjB-002zNh-Mq
	for linux-nvme@lists.infradead.org; Thu, 24 Nov 2022 00:04:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1669248266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Swuw4Srtq7ILJ+Sr28sVCP8NRm0onxfQ8iNTcMfZrZ0=;
	b=UBdYMvbehhfSVImegvfMb0mP8yd+zOXotHCEBJdSGYiqFvf6GEZj3q9SqSfQlSI5A1Fsqo
	1da88ruJ6IYW4lYXuwQcrXh4I8/qfLVLX1bNnIEAYBLUN38AY1/36HHdSaF3CcChKolrE+
	Om+258S7gLbvebkUh+I2VGY2E/8kTnY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-655-eMnJ2nuQPZ63mU3GdK9XLA-1; Wed, 23 Nov 2022 19:04:21 -0500
X-MC-Unique: eMnJ2nuQPZ63mU3GdK9XLA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3935F29AB3E1;
	Thu, 24 Nov 2022 00:04:20 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5DF81C15BB1;
	Thu, 24 Nov 2022 00:04:03 +0000 (UTC)
Date: Thu, 24 Nov 2022 08:03:56 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org,
	dm-devel@redhat.com, kbusch@kernel.org, hch@lst.de,
	sagi@grimberg.me, james.smart@broadcom.com, kch@nvidia.com,
	damien.lemoal@opensource.wdc.com, naohiro.aota@wdc.com,
	jth@kernel.org, viro@zeniv.linux.org.uk,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	anuj20.g@samsung.com, joshi.k@samsung.com, p.raghav@samsung.com,
	nitheshshetty@gmail.com, gost.dev@samsung.com, ming.lei@redhat.com
Subject: Re: [PATCH v5 02/10] block: Add copy offload support infrastructure
Message-ID: <Y3607N6lDRK6WU7/@T590>
References: <20221123055827.26996-1-nj.shetty@samsung.com>
 <CGME20221123061017epcas5p246a589e20eac655ac340cfda6028ff35@epcas5p2.samsung.com>
 <20221123055827.26996-3-nj.shetty@samsung.com>
 <Y33UAp6ncSPO84XI@T590>
 <20221123100712.GA26377@test-zns>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123100712.GA26377@test-zns>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221123_160430_048954_86C5681A 
X-CRM114-Status: GOOD (  29.57  )
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

On Wed, Nov 23, 2022 at 03:37:12PM +0530, Nitesh Shetty wrote:
> On Wed, Nov 23, 2022 at 04:04:18PM +0800, Ming Lei wrote:
> > On Wed, Nov 23, 2022 at 11:28:19AM +0530, Nitesh Shetty wrote:
> > > Introduce blkdev_issue_copy which supports source and destination bdevs,
> > > and an array of (source, destination and copy length) tuples.
> > > Introduce REQ_COPY copy offload operation flag. Create a read-write
> > > bio pair with a token as payload and submitted to the device in order.
> > > Read request populates token with source specific information which
> > > is then passed with write request.
> > > This design is courtesy Mikulas Patocka's token based copy
> > 
> > I thought this patchset is just for enabling copy command which is
> > supported by hardware. But turns out it isn't, because blk_copy_offload()
> > still submits read/write bios for doing the copy.
> > 
> > I am just wondering why not let copy_file_range() cover this kind of copy,
> > and the framework has been there.
> > 
> 
> Main goal was to enable copy command, but community suggested to add
> copy emulation as well.
> 
> blk_copy_offload - actually issues copy command in driver layer.
> The way read/write BIOs are percieved is different for copy offload.
> In copy offload we check REQ_COPY flag in NVMe driver layer to issue
> copy command. But we did missed it to add in other driver's, where they
> might be treated as normal READ/WRITE.
> 
> blk_copy_emulate - is used if we fail or if device doesn't support native
> copy offload command. Here we do READ/WRITE. Using copy_file_range for
> emulation might be possible, but we see 2 issues here.
> 1. We explored possibility of pulling dm-kcopyd to block layer so that we 
> can readily use it. But we found it had many dependecies from dm-layer.
> So later dropped that idea.

Is it just because dm-kcopyd supports async copy? If yes, I believe we
can reply on io_uring for implementing async copy_file_range, which will
be generic interface for async copy, and could get better perf.

> 2. copy_file_range, for block device atleast we saw few check's which fail
> it for raw block device. At this point I dont know much about the history of
> why such check is present.

Got it, but IMO the check in generic_copy_file_checks() can be
relaxed to cover blkdev cause splice does support blkdev.

Then your bdev offload copy work can be simplified into:

1) implement .copy_file_range for def_blk_fops, suppose it is
blkdev_copy_file_range()

2) inside blkdev_copy_file_range()

- if the bdev supports offload copy, just submit one bio to the device,
and this will be converted to one pt req to device

- otherwise, fallback to generic_copy_file_range()

> 
> > When I was researching pipe/splice code for supporting ublk zero copy[1], I
> > have got idea for async copy_file_range(), such as: io uring based
> > direct splice, user backed intermediate buffer, still zero copy, if these
> > ideas are finally implemented, we could get super-fast generic offload copy,
> > and bdev copy is really covered too.
> > 
> > [1] https://lore.kernel.org/linux-block/20221103085004.1029763-1-ming.lei@redhat.com/
> > 
> 
> Seems interesting, We will take a look into this.

BTW, that is probably one direction of ublk's async zero copy IO too.


Thanks, 
Ming


