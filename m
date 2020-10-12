Return-Path: <SRS0=YdFy=DT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F54C433E7
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Oct 2020 08:13:32 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 476A32087D
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Oct 2020 08:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AZ+G0A5o";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H99Jz3UE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 476A32087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=HJm3MjvcTE4cnyQrcZeMjO3EHv/399cu3X1RpwHNBdA=; b=AZ+G0A5o6vgZSGcb8xvTexskv
	di4gMerdLV4jgvcIx/otqrs/fDOuM7mK62yQJloPsMAAtkZLdY3G6y0M0IuzLgtqwzBMXpDx7eXj0
	QJxDY4KG9njN2GDzg9Z0VhvndC3qgHKrOugG45NPNRJvp3O/t+xHmZ6a+B3bx+XoYyieSD7yotXZf
	9jaN2WKMXYTXbJ2YtEt/SqMkEW7brP/MRLUEYTG1GbgsMzmB5TqfQZ3YBrCpJy82W7M+BDoWR49/c
	poYzpPB3JLADMfRcNLKD5i6lGY8w0y6tLviMvX1zD5bnQ6I9Fv1bEApSbIE5/5mB01c3OEdLZvTpY
	XqCeoX8nw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kRsxV-00027r-OI; Mon, 12 Oct 2020 08:13:29 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kRsxT-00027G-92
 for linux-nvme@lists.infradead.org; Mon, 12 Oct 2020 08:13:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602490406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cem/gNp247LYga6BNkaCK5NWZZonWFz2KLOKkw9NSWo=;
 b=H99Jz3UEz5Kp6cxaspdWzKR2W9GlwUYUaZJUnKe3p8WyVKtfoCjWE3M7hX7YWQKOEd/YMS
 jvvLZ1L3QWSzqRmEwSeqBpfNEMb6wss+5ppRhmRo+c09XAGIqNNcDBFZwAEzYogmplhK/+
 r+xTYTKyznpJrlZBKAXYNaXmlQbBkBM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-rGX0XLj5PQOQbez47LxsFw-1; Mon, 12 Oct 2020 04:13:24 -0400
X-MC-Unique: rGX0XLj5PQOQbez47LxsFw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6480718BE161;
 Mon, 12 Oct 2020 08:13:22 +0000 (UTC)
Received: from T590 (ovpn-13-62.pek2.redhat.com [10.72.13.62])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 80117614F5;
 Mon, 12 Oct 2020 08:13:11 +0000 (UTC)
Date: Mon, 12 Oct 2020 16:13:06 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Chao Leng <lengchao@huawei.com>
Subject: Re: [PATCH] block: re-introduce blk_mq_complete_request_sync
Message-ID: <20201012081306.GB556731@T590>
References: <20201008213750.899462-1-sagi@grimberg.me>
 <20201009043938.GC27356@T590>
 <1711488120.3435389.1602219830518.JavaMail.zimbra@redhat.com>
 <e39b711e-ebbd-8955-ca19-07c1dad26fa2@grimberg.me>
 <23f19725-f46b-7de7-915d-b97fd6d69cdc@redhat.com>
 <ced685bf-ad48-ac41-8089-8c5ba09abfcb@grimberg.me>
 <7a7aca6e-30f5-0754-fb7f-599699b97108@redhat.com>
 <6f2a5ae2-2e6a-0386-691c-baefeecb5478@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6f2a5ae2-2e6a-0386-691c-baefeecb5478@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201012_041327_349110_740919A9 
X-CRM114-Status: GOOD (  21.94  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Jens Axboe <axboe@kernel.dk>, Yi Zhang <yi.zhang@redhat.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Oct 12, 2020 at 11:59:21AM +0800, Chao Leng wrote:
> =

> =

> On 2020/10/10 14:08, Yi Zhang wrote:
> > =

> > =

> > On 10/10/20 2:29 AM, Sagi Grimberg wrote:
> > > =

> > > =

> > > On 10/9/20 6:55 AM, Yi Zhang wrote:
> > > > Hi Sagi
> > > > =

> > > > On 10/9/20 4:09 PM, Sagi Grimberg wrote:
> > > > > > Hi Sagi
> > > > > > =

> > > > > > I applied this patch on block origin/for-next and still can rep=
roduce it.
> > > > > =

> > > > > That's unexpected, can you try this patch?
> > > > > -- =

> > > > > diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> > > > > index 629b025685d1..46428ff0b0fc 100644
> > > > > --- a/drivers/nvme/host/tcp.c
> > > > > +++ b/drivers/nvme/host/tcp.c
> > > > > @@ -2175,7 +2175,7 @@ static void nvme_tcp_complete_timed_out(str=
uct request *rq)
> > > > > =A0=A0=A0=A0=A0=A0=A0 /* fence other contexts that may complete t=
he command */
> > > > > =A0=A0=A0=A0=A0=A0=A0 mutex_lock(&to_tcp_ctrl(ctrl)->teardown_loc=
k);
> > > > > =A0=A0=A0=A0=A0=A0=A0 nvme_tcp_stop_queue(ctrl, nvme_tcp_queue_id=
(req->queue));
> > > > > -=A0=A0=A0=A0=A0=A0 if (!blk_mq_request_completed(rq)) {
> > > > > +=A0=A0=A0=A0=A0=A0 if (blk_mq_request_started(rq) && !blk_mq_req=
uest_completed(rq)) {
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 nvme_req(rq)->statu=
s =3D NVME_SC_HOST_ABORTED_CMD;
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 blk_mq_complete_req=
uest_sync(rq);
> > > > > =A0=A0=A0=A0=A0=A0=A0 }
> This may just reduce the probability. The concurrency of timeout and tear=
down will cause the same request
> be treated repeatly, this is not we expected.

That is right, not like SCSI, NVME doesn't apply atomic request completion,=
 so
request may be completed/freed from both timeout & nvme_cancel_request().

.teardown_lock still may cover the race with Sagi's patch because teardown
actually cancels requests in sync style.

> In the teardown process, after quiesced queues delete the timer and cance=
l the timeout work maybe a better option.

Seems better solution, given it is aligned with NVME PCI's reset
handling. nvme_sync_queues() may be called in nvme_tcp_teardown_io_queues()=
 to
avoid this race.


Thanks, =

Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
