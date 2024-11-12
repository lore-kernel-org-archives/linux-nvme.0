Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EFECD42BAB
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2024 16:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2RbeROxEcb6+obaSwiGZrDBztqKs+YwYJ9DgQNyWTCQ=; b=ur/+POiG82pMeKlpcDKJs4M6Jl
	9zf5lK/ViSFv6cF+er69c94iOKAnMikcrEtz6K9Ee9Rye40thINfn0IUs4YUgH00Kb183nEA7h33v
	M5Q+F2qGSkU/Vsuf1uS3d/qrhTGdScFjpK/9Opbs+b9q2K8xNBRnnt8C3+1V/u1iRzmtUH8Gcg8k2
	zG04shlGfL8IBjazL3Prhk9FPJ5nmG2I/22U/O5I47GZI31z7sei5xcG/6JvqT+V1ciqDyag11okC
	oerJaypS3SnDVkrMoPipOLJYdEXfUBTI8CuUYqcB9cZu/Ms2zAbVoppCn4FB6iebSgzv2fr+ef0VU
	P5pQJbFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tAu2e-00000004Cdl-2KdK;
	Tue, 12 Nov 2024 16:47:00 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tAt2T-00000003zbW-2RN3
	for linux-nvme@lists.infradead.org;
	Tue, 12 Nov 2024 15:42:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id CFC375C5409;
	Tue, 12 Nov 2024 15:41:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FB60C4CECD;
	Tue, 12 Nov 2024 15:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731426163;
	bh=tdd3NZ+GHcRdJCaOdNApZtNodQGwtd707HfpjA9pncQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N2ajiGJcJzz74Ud6lZK2wFDlIGZ3O4eOdH0hr+de2c5HOW9+GPcsdPg4Jbk0ecMJQ
	 HzLiG2lJ6uDpGxNxfgvBAi+DEzcVf6ABtx+BALpCkjWI8ANBXGooww4MqSAjDxv7sH
	 72AS1Q9Q40HtYbXDSbYWO7kVyWeZFH8BKQ9eINvE=
Date: Tue, 12 Nov 2024 16:42:40 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: Daniel Wagner <wagi@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev, linux-scsi@vger.kernel.org,
	megaraidlinux.pdl@broadcom.com, mpi3mr-linuxdrv.pdl@broadcom.com,
	MPT-FusionLinux.pdl@broadcom.com, storagedev@microchip.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 4/8] blk-mp: introduce blk_mq_hctx_map_queues
Message-ID: <2024111215-jury-unlighted-3953@gregkh>
References: <20241112-refactor-blk-affinity-helpers-v3-0-573bfca0cbd8@kernel.org>
 <20241112-refactor-blk-affinity-helpers-v3-4-573bfca0cbd8@kernel.org>
 <2024111202-parish-prowess-78bc@gregkh>
 <c8c671c1-267a-4aa7-a64b-51a461176ad3@flourine.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8c671c1-267a-4aa7-a64b-51a461176ad3@flourine.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241112_074245_743371_6EAD402A 
X-CRM114-Status: GOOD (  17.86  )
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

On Tue, Nov 12, 2024 at 04:33:09PM +0100, Daniel Wagner wrote:
> On Tue, Nov 12, 2024 at 02:58:43PM +0100, Greg Kroah-Hartman wrote:
> > > +void blk_mq_hctx_map_queues(struct blk_mq_queue_map *qmap,
> > > +			    struct device *dev, unsigned int offset)
> > > +
> > > +{
> > > +	const struct cpumask *mask;
> > > +	unsigned int queue, cpu;
> > > +
> > > +	if (!dev->bus->irq_get_affinity)
> > > +		goto fallback;
> > 
> > I think this is better than hard-coding it, but are you sure that the
> > bus will always be bound to the device here so that you have a valid
> > bus-> pointer?
> 
> No, I just assumed the bus pointer is always valid. If it is possible to
> have a device without a bus, than I'll better extend the condition to
> 
> 	if (!dev->bus || !dev->bus->irq_get_affinity)
>         	goto fallback;

I don't know if it's possible as I don't know what codepaths are calling
this, it was hard to unwind.  But you should check "just to be safe" :)

thanks,

greg k-h

