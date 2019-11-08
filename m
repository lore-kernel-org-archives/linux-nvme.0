Return-Path: <SRS0=cJ6X=ZA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99125FA372C
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Nov 2019 07:09:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D5782087E
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Nov 2019 07:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ne420RyW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A9hj5mC8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D5782087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MndpoC5ov5BiCdOM6eEnccJhyW2QD8SyShgRRxLdzaw=; b=ne420RyWWzCU/g
	GFFuDJ/IHUhUkI/rM3f/e5tQsz7dlTm9r03QRxupj/0xTCIY0MVXBtcjw2/MqOpEOE/a05MykU+ns
	qsYE1LLGU9mN8Bbd57dlIT1alTi3CtgcmQrqQECr9SoLNNs9wlkuEWw6kcXJVrccdv3djAYXU7ff0
	aWAjONpMQWf5LTLdXA/lRzss5wdvRtRpokaBht3S5NMKqrMMtoqWv3+byv3d9eQLS0ZylX0CE6bbl
	DbqSGrgCYZ1pK7BXNE60J3yprQuui2/xTVBCY4nb0/8yFtWgJTo/IEkaabYiDgl0KS23ABbDqZSgq
	MTey6B9abemgybngFCZw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iSyOa-0008DC-Cl; Fri, 08 Nov 2019 07:09:24 +0000
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iSyOX-0008Cf-N1
 for linux-nvme@lists.infradead.org; Fri, 08 Nov 2019 07:09:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573196960;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A/klCkMzg+ukdEkDQYXJnGezAxmHUH1N1khjEf6RJ1Y=;
 b=A9hj5mC8bjKnBMTzX6tABtYXtr7Yk3ZBsHCGAn4cOqc1A46uZDDMJ/+nvF1any+FcAQUHM
 SsDR3QQAqXGrhD30AkMb7bWpKQiSDjx+M12Meu3DtC9KLwo6Z+8M8mm7z4yZWFaD3pbCsk
 b3Pf5eyeLrNdjMp9BvykLlFWMueyPeo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-OOLKCfI1No2bkDGLQ5_6EQ-1; Fri, 08 Nov 2019 02:09:16 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 968AE477;
 Fri,  8 Nov 2019 07:09:15 +0000 (UTC)
Received: from ming.t460p (ovpn-8-21.pek2.redhat.com [10.72.8.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D5335C1BB;
 Fri,  8 Nov 2019 07:09:08 +0000 (UTC)
Date: Fri, 8 Nov 2019 15:09:04 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 1/2] nvme-pci: move sq/cq_poll lock initialization into
 nvme_init_queue
Message-ID: <20191108070904.GA28512@ming.t460p>
References: <20191108035508.26395-1-ming.lei@redhat.com>
 <20191108035508.26395-2-ming.lei@redhat.com>
 <20191108041251.GA2775@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
In-Reply-To: <20191108041251.GA2775@redsun51.ssa.fujisawa.hgst.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: OOLKCfI1No2bkDGLQ5_6EQ-1
X-Mimecast-Spam-Score: 0
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191107_230921_830646_D0696D68 
X-CRM114-Status: GOOD (  12.81  )
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
Cc: Jens Axboe <axboe@fb.com>, Long Li <longli@microsoft.com>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Nov 08, 2019 at 01:12:51PM +0900, Keith Busch wrote:
> On Fri, Nov 08, 2019 at 11:55:07AM +0800, Ming Lei wrote:
> > Prepare for adding new cq lock for improving IO performance in case
> > of multi-mapping queue, and the new added cq_lock can share space with
> > cq_poll_lock.
> > 
> > Move sq/cq_poll lock initialization into nvme_init_queue so that
> > we may initialize the added cq_lock correctly and lockdep warning
> > can be avoided.
> > 
> > This way is safe because no IO can be started until nvme_init_queue
> > is returned.
> 
> Yes, but we call nvme_init_queue() on every reset. I think it looks it's
> okay to reinit a lock as long as it's not held, but it really shouldn't
> be necessary, right?

Yeah, however, this patch doesn't change the current behavior.

Looks not a big deal given the queue is really quiesced during
nvme_init_queue().

Thanks,
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
