Return-Path: <SRS0=I4H8=LP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F732C48BE5
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Jun 2021 08:36:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E38A26023B
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Jun 2021 08:36:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E38A26023B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uQXm5RgfiMH22//Y5Qh8Jgnv2YY0zLTTHwQvtg2mzzQ=; b=ip+ExMc3e8DSSL
	JysDkM0g+WMjuXkfYe/m/EJGC84o2DLwmaUIAnmG6qbJPpEYtSxKEwzCU3kMA/a9RVjn/yDQ53lWs
	ii+NmjSwwP0PJOGu2orCL+1pV2pTUdNCwz4Ca8yxVk2jzC/6AWLUGqGqoCJPSbPtRFi0GEQLbeonT
	wVeVarYApyubEPix0pt5fZUWxy6zNXdqfY8gp5B6oav84DDTrpTpH8GsRoMBinxZcBd0HoIyiRj0T
	TGsmwtG0gIIHhc9+bjMwJ42s4a3C/PY21DjAVujx2IkGYb53+i4qRSznN6LluddwyrZMJtHfjyfvV
	bkjlSbNyzW0dQW/CBNEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lvFPL-002juQ-NF; Mon, 21 Jun 2021 08:35:51 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lvFPJ-002jrG-Iq
 for linux-nvme@lists.infradead.org; Mon, 21 Jun 2021 08:35:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1624264546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kDqaJylOpEO+y/MxTzmjHISDevTkUAwoLV6gGI0zT9E=;
 b=U0RyjVWTT0ji5g8Zt5yOMGZOLSoOvEs243Dv66sLvG5teX91i4I82Ysxf/uyq/xZqH9cjk
 BpyR+tFSjgtnKJ25wCalIdTvT4GjhpcQm4z1V7GRmGdBrMGXx8SCMeVBQj0F52ySDwdjBJ
 LDZ5laQMbDy2LV5jfWITk/gaW8ad0S4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-HSBqi19DNOSAtdmrF3VSXQ-1; Mon, 21 Jun 2021 04:35:45 -0400
X-MC-Unique: HSBqi19DNOSAtdmrF3VSXQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 741D81084F53;
 Mon, 21 Jun 2021 08:35:43 +0000 (UTC)
Received: from T590 (ovpn-13-237.pek2.redhat.com [10.72.13.237])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9EB5F60CA1;
 Mon, 21 Jun 2021 08:35:34 +0000 (UTC)
Date: Mon, 21 Jun 2021 16:35:29 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Jeffle Xu <jefflexu@linux.alibaba.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "Vasudevan, Anil" <anil.vasudevan@intel.com>,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH 13/16] block: switch polling to be bio based
Message-ID: <YNBPUUVtxSb6/gv1@T590>
References: <20210615131034.752623-1-hch@lst.de>
 <20210615131034.752623-14-hch@lst.de> <YMliP6sFVuPhMbOB@T590>
 <20210618140147.GA16258@lst.de> <YMytSIBm7k2pqFlc@T590>
 <20210621072005.GA6651@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210621072005.GA6651@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210621_013549_756937_37971A9F 
X-CRM114-Status: GOOD (  25.25  )
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

On Mon, Jun 21, 2021 at 09:20:05AM +0200, Christoph Hellwig wrote:
> On Fri, Jun 18, 2021 at 10:27:20PM +0800, Ming Lei wrote:
> > > How?  On a block device the caller needs to hold the block device open
> > > to read/write from it.  On a file systems the file systems needs to
> > > be mounted, which also holds a bdev reference.
> > 
> > +       rcu_read_lock();
> > +       bio = READ_ONCE(kiocb->private);
> > +       if (bio && bio->bi_bdev)
> > 
> > The bio may be ended now from another polling job, then the disk is
> > closed & deleted, and released. Then request queue & hctxs are released.
> > 
> > +               ret = bio_poll(bio, flags);
> > 
> > But disk & request queue & hctx can still be referred in above bio_poll().
> 
> I don't see how this can happen.  A bio stashed into kiocb->private needs
> to belong to the correct device initially.  For it to point to the "wrong"
> device it needs to have been completed on the correct one, and then be
> reused for a different device.  At the point it is reused that device
> must obviously have been alive, and for it to be freed a RCU grace
> period must have been passed.  And that grace period can't have started
> earlier than when iocb_bio_iopoll was called.

gendisk isn't freed after a RCU grace period, so even though bio->bi_bdev
may not be freed really, but the gendisk may have been freed already.

+       rcu_read_lock();
+       bio = READ_ONCE(kiocb->private);
+       if (bio && bio->bi_bdev)

The bio may be ended now from another polling job, and it is freed
and re-allocated & freed, then bio->bi_bdev->bd_disk is freed too, which
will be observed in the following bio_poll().

+               ret = bio_poll(bio, flags);


Thanks,
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
