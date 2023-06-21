Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 767B4EB64D7
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Jun 2023 13:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZDD02Z5+WJCX7fsOFHZfgS83xanLJ6GHVD5UFf+JeIA=; b=H7GPiZ/ksCng8bmaALQa6dAbFa
	Kx8l9wdxaTPMm5MiTKgx6B7UVnd1m2QReU6MvQ0jEg/DESiQZzDQ8ALzm1ZAKaWQQz1GQAXYiPsKp
	i3paK911brIrsUfIDX71alBApjHL6z9u1d1BI2zESsRCFA6J6arStNcJQjQGcS36VeXRUDZeuoHOi
	Z/R7crtNkAsR4YI85RXeXzRgapnVlLJOZz2pmpzCiI7XY7QawIfbnrUvB6jH9f5tXtyxyN0BMSNfm
	+1Ut54sF/OSZTBOjDzgHSQLSAjnArmoARwx0YJ1R324Umxhm4BezKnpZIxh7R9ZqOWINN/JQLdbKu
	qSFU/7lw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qBxsD-00Efyv-1E;
	Wed, 21 Jun 2023 13:27:49 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qBxs9-00Efxg-2q
	for linux-nvme@lists.infradead.org;
	Wed, 21 Jun 2023 13:27:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687354063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZDD02Z5+WJCX7fsOFHZfgS83xanLJ6GHVD5UFf+JeIA=;
	b=dQbv7o8XBj0tizkM7YH0/1xXBvfrh7CWZT6uULfhCIq/B57Kc/KEnScSTcCocCVt2eKeo1
	KjBfwAjuBsf7ZmL8ZvGqwQytg1yYzDMwKtDsHGtRRPzw/V9KjnHapAbXE1LbsO43jXFD/z
	neV1KY+ns8VepiNc81bTf45FASfhyQg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-155-dGzulW4LO0iSYEMlXJukhw-1; Wed, 21 Jun 2023 09:27:42 -0400
X-MC-Unique: dGzulW4LO0iSYEMlXJukhw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 80B413815F61;
	Wed, 21 Jun 2023 13:27:41 +0000 (UTC)
Received: from ovpn-8-23.pek2.redhat.com (ovpn-8-18.pek2.redhat.com [10.72.8.18])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E6A3140EBB8;
	Wed, 21 Jun 2023 13:27:36 +0000 (UTC)
Date: Wed, 21 Jun 2023 21:27:31 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	Yi Zhang <yi.zhang@redhat.com>, linux-block@vger.kernel.org,
	Chunguang Xu <brookxu.cn@gmail.com>
Subject: Re: [PATCH V2 0/4] nvme: fix two kinds of IO hang from removing NSs
Message-ID: <ZJL6w+K6e95WWJzV@ovpn-8-23.pek2.redhat.com>
References: <20230620013349.906601-1-ming.lei@redhat.com>
 <86c10889-4d4a-1892-9779-a5f7b4e93392@grimberg.me>
 <ZJGoWGJ5/fKfIhx+@ovpn-8-23.pek2.redhat.com>
 <27ce75fc-f6c5-7bf3-8448-242ee3e65067@grimberg.me>
 <ZJI/1w8/9pLIyXZ2@ovpn-8-23.pek2.redhat.com>
 <caa80682-3c3e-f709-804a-6ee913e4524f@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <caa80682-3c3e-f709-804a-6ee913e4524f@grimberg.me>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230621_062746_011908_719D77FA 
X-CRM114-Status: GOOD (  27.38  )
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

On Wed, Jun 21, 2023 at 01:13:05PM +0300, Sagi Grimberg wrote:
> 
> > > > > > Hello,
> > > > > > 
> > > > > > The 1st three patch fixes io hang when controller removal interrupts error
> > > > > > recovery, then queue is left as frozen.
> > > > > > 
> > > > > > The 4th patch fixes io hang when controller is left as unquiesce.
> > > > > 
> > > > > Ming, what happened to nvme-tcp/rdma move of freeze/unfreeze to the
> > > > > connect patches?
> > > > 
> > > > I'd suggest to handle all drivers(include nvme-pci) in same logic for avoiding
> > > > extra maintain burden wrt. error handling, but looks Keith worries about the
> > > > delay freezing may cause too many requests queued during error handling, and
> > > > that might cause user report.
> > > 
> > > For nvme-tcp/rdma your patch also addresses IO not failing over because
> > > they block on queue enter. So I definitely want this for fabrics.
> > 
> > The patch in the following link should fix these issues too:
> > 
> > https://lore.kernel.org/linux-block/ZJGmW7lEaipT6saa@ovpn-8-23.pek2.redhat.com/T/#u
> > 
> > I guess you still want the paired freeze patch because it makes freeze &
> > unfreeze more reliable in error handling. If yes, I can make one fabric
> > only change for you.
> 
> Not sure exactly what reliability is referred here.

freeze and unfreeze have to be called strictly in pair, but nvme calls
the two from different contexts, so unfreeze may easily be missed, and
causes mismatched freeze count. There has many such reports so far.

> I agree that there
> is an issue with controller delete during error recovery. The patch
> was a way to side-step it, great. But it addressed I/O blocked on enter
> and not failing over.
> 
> So yes, for fabrics we should have it. I would argue that it would be
> the right thing to do for pci as well. But I won't argue if Keith feels
> otherwise.

Keith, can you update with us if you are fine with moving
nvme_start_freeze() into nvme_reset_work() for nvme pci driver?


Thanks,
Ming


