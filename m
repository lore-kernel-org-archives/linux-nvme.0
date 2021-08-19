Return-Path: <SRS0=ZTQI=NK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D2FC4338F
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Aug 2021 14:59:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20AA5610FE
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Aug 2021 14:59:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 20AA5610FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sIWr2fDc2KDx93yo6+ANzKlyy0tWWzS70Kmr510a1Q4=; b=EcNJgZEN5XL1/9
	x9bF2/5cBiyZpmp4SBhC734omM7TfS1uwMf+IZ3Ohg0vsLGDtWBILIGKrHvKxB8PnpeSFKIuq4gUn
	Tilwl4qFgudSVhqHZjc5b44V2yxXaCIC7ws9xHfJaJNqszyHIYLHoK4xSmC01AT19YkvToDK6iZsu
	X7JlcfhjGl29L2i/Pimiqlk6qSw9Y43HRwM+FohxAFaeD8t9V4VbPCcDyRlz1PcLpCkLPXWTxwDBV
	VF0ZL1CSVroKIy5Hg8fwW7ZGwaJFZFPYgIesDarSfJzG3sAOWANHr8yy7Tdi/5O747+d8icKvOe+T
	352gfYhI/CqALkv4dDxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mGjV7-008hzo-1Z; Thu, 19 Aug 2021 14:58:37 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mGjV4-008hyb-6V
 for linux-nvme@lists.infradead.org; Thu, 19 Aug 2021 14:58:35 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 78B7C600CC;
 Thu, 19 Aug 2021 14:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629385111;
 bh=d1ZrYuBgxQrYKEiHUt8gEL89IWjUwToNfik22onXj3o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qW9z4aXL8rfteGmaWxKJwkBG5/VnJvjle4qMQkRZw5oVMFmTmhwkA28mUTcJ5czwG
 wbbW4tAaffiaRxgK9KaQW2Nom2GvGqpK0J1AN+FfgUWCCYYGvj7fJ5/UTMTORNOJLO
 xZvg/t5ikzvQExA+EByJlEoY1ofJzTtSfyfI/JgBM8ke5nBx72KEyIZ5dSpWaBiwnx
 R8WyC3wlGnx2rvCppp7/0GVbxlzmQIftrAXdDwExR7e8aQCrRsEeSWZgThVUZ02zbz
 LXrgQVusUoUIu17ZJg/TWvOXlgxJ+RcIbXRekbq6ivD5yXyogeAkkm3dvsrEi5LWyN
 lxUPY6PYmkhlQ==
Date: Thu, 19 Aug 2021 07:58:28 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Stefan Haberland <sth@linux.ibm.com>,
 Jan Hoeppner <hoeppner@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Doug Gilbert <dgilbert@interlog.com>,
 Kai =?iso-8859-1?Q?M=E4kisara?= <Kai.Makisara@kolumbus.fi>,
 Luis Chamberlain <mcgrof@kernel.org>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org
Subject: Re: [PATCH 1/9] nvme: use blk_mq_alloc_disk
Message-ID: <20210819145828.GA227577@dhcp-10-100-145-180.wdc.com>
References: <20210816131910.615153-1-hch@lst.de>
 <20210816131910.615153-2-hch@lst.de>
 <20210819145455.GA227568@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210819145455.GA227568@dhcp-10-100-145-180.wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210819_075834_321471_D1592538 
X-CRM114-Status: GOOD (  15.62  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Aug 19, 2021 at 07:54:55AM -0700, Keith Busch wrote:
> On Mon, Aug 16, 2021 at 03:19:02PM +0200, Christoph Hellwig wrote:
> > @@ -3729,9 +3729,14 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
> >  	if (!ns)
> >  		goto out_free_id;
> >  
> > -	ns->queue = blk_mq_init_queue(ctrl->tagset);
> > -	if (IS_ERR(ns->queue))
> > +	disk = blk_mq_alloc_disk(ctrl->tagset, ns);
> > +	if (IS_ERR(disk))
> >  		goto out_free_ns;
> > +	disk->fops = &nvme_bdev_ops;
> > +	disk->private_data = ns;
> > +
> > +	ns->disk = disk;
> > +	ns->queue = disk->queue;
> >  
> >  	if (ctrl->opts && ctrl->opts->data_digest)
> >  		blk_queue_flag_set(QUEUE_FLAG_STABLE_WRITES, ns->queue);
> > @@ -3740,20 +3745,12 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
> >  	if (ctrl->ops->flags & NVME_F_PCI_P2PDMA)
> >  		blk_queue_flag_set(QUEUE_FLAG_PCI_P2PDMA, ns->queue);
> >  
> > -	ns->queue->queuedata = ns;
> >  	ns->ctrl = ctrl;
> >  	kref_init(&ns->kref);
> 
> With this removal, I don't find queuedata being set anywhere, but
> the driver still uses it in various places expecting 'ns'. Am I missing
> something? Should all nvme's queuedata references be changed to
> q->disk->private_data?

Oops, I see the queuedata is set via blk_mq_alloc_disk().

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
