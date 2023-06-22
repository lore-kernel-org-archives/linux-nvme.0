Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54A33EB64D8
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Jun 2023 14:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p0fPxV/wMjVoAwIIb2Y+knLrDM0Fo4FVoLy8mG07128=; b=v3qnVLrpNeYM0M1C+4n84bJxp2
	ozzJqTUTXf6x1wqtEtCKDcXjuvEzJbfvKFxO7FGrZAc0xei6fiIALcvAXqQkOLlrooAwI49ZTz3v1
	8jHwX1SuKQlDVZ5xwUmL/ziPzXzmiHaGIE/BRo/q79JajYCi5mrRumFMnnpDKy8r693NWVC6/hK21
	uDY2btBeyzMxAmgjRCWMiin214rGKNjj/DG6ducgDiAG8vCGd3QKYO23Etru9o4ZxPzZSmQLwhHmk
	5+eAXme0lJBRN0y7NFPQs2m8SM+gw9JKSLDbcDI5A2udfCMsBg4VmfEcu3khAGTyn+w8L1DVZe+Zf
	ZQe1i9BA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qCLgi-0012xj-0G;
	Thu, 22 Jun 2023 14:53:32 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qCLgf-0012x1-2Q
	for linux-nvme@lists.infradead.org;
	Thu, 22 Jun 2023 14:53:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687445607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p0fPxV/wMjVoAwIIb2Y+knLrDM0Fo4FVoLy8mG07128=;
	b=W2qDIPDCegyzLS/GdXkuQ1gnYflfsRGl1KC2+KtwcD+alkK8pjkaq+dBexReghAdaQBOsG
	Hj3TRT4JUI6R9qJEkbxxXNlM6pipRaufEPc0N/nE42+s+DzF4zdpDN5IjsFNwNYHIpQigl
	6X6Kah+6XQXSJPGp9NUIMDyPwg0/Auk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-364-P0hfoX0MNDu1ooUouLAgeA-1; Thu, 22 Jun 2023 10:53:23 -0400
X-MC-Unique: P0hfoX0MNDu1ooUouLAgeA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5175C38149BC;
	Thu, 22 Jun 2023 14:53:15 +0000 (UTC)
Received: from ovpn-8-19.pek2.redhat.com (ovpn-8-17.pek2.redhat.com [10.72.8.17])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B6A072166B25;
	Thu, 22 Jun 2023 14:53:10 +0000 (UTC)
Date: Thu, 22 Jun 2023 22:53:05 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	Yi Zhang <yi.zhang@redhat.com>, linux-block@vger.kernel.org,
	Chunguang Xu <brookxu.cn@gmail.com>
Subject: Re: [PATCH V2 0/4] nvme: fix two kinds of IO hang from removing NSs
Message-ID: <ZJRgUXfRuuOoIN1o@ovpn-8-19.pek2.redhat.com>
References: <20230620013349.906601-1-ming.lei@redhat.com>
 <86c10889-4d4a-1892-9779-a5f7b4e93392@grimberg.me>
 <ZJGoWGJ5/fKfIhx+@ovpn-8-23.pek2.redhat.com>
 <27ce75fc-f6c5-7bf3-8448-242ee3e65067@grimberg.me>
 <ZJI/1w8/9pLIyXZ2@ovpn-8-23.pek2.redhat.com>
 <caa80682-3c3e-f709-804a-6ee913e4524f@grimberg.me>
 <ZJL6w+K6e95WWJzV@ovpn-8-23.pek2.redhat.com>
 <ZJMb4f0i9wm8y4pi@kbusch-mbp.dhcp.thefacebook.com>
 <ZJRR0C9sqLp7zhAv@ovpn-8-19.pek2.redhat.com>
 <ZJRcRWyn7o7lLEDM@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJRcRWyn7o7lLEDM@kbusch-mbp.dhcp.thefacebook.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230622_075329_860330_12D08FE1 
X-CRM114-Status: GOOD (  22.21  )
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

On Thu, Jun 22, 2023 at 08:35:49AM -0600, Keith Busch wrote:
> On Thu, Jun 22, 2023 at 09:51:12PM +0800, Ming Lei wrote:
> > On Wed, Jun 21, 2023 at 09:48:49AM -0600, Keith Busch wrote:
> > > The point was to contain requests from entering while the hctx's are
> > > being reconfigured. If you're going to pair up the freezes as you've
> > > suggested, we might as well just not call freeze at all.
> > 
> > blk_mq_update_nr_hw_queues() requires queue to be frozen.
> 
> It's too late at that point. Let's work through a real example. You'll
> need a system that has more CPU's than your nvme has IO queues.
> 
> Boot without any special nvme parameters. Every possible nvme IO queue
> will be assigned "default" hctx type. Now start IO to every queue, then
> run:
> 
>   # echo 8 > /sys/modules/nvme/parameters/poll_queues && echo 1 > /sys/class/nvme/nvme0/reset_controller
> 
> Today, we freeze prior to tearing down the "default" IO queues, so
> there's nothing entered into them while the driver reconfigures the
> queues.

nvme_start_freeze() just prevents new IO from being queued, and old ones
may still be entering block layer queue, and what matters here is
actually quiesce, which prevents new IO from being queued to
driver/hardware.

> 
> What you're suggesting will allow IO to queue up in a queisced "default"
> queue, which will become "polled" without an interrupt hanlder on the
> other side of the reset. The application doesn't know that, so the IO
> you're allowing to queue up will time out.

time out only happens after the request is queued to driver/hardware, or after
blk_mq_start_request() is called in nvme_queue_rq(), but quiesce actually
prevents new IOs from being dispatched to driver or be queued via .queue_rq(),
meantime old requests have been canceled, so no any request can be
timed out.


Thanks,
Ming


