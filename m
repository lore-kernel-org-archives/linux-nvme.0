Return-Path: <SRS0=270x=ZG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD94DC432C3
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Nov 2019 01:40:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2921206D7
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Nov 2019 01:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LOUUvOur";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ND7SuBC2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2921206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Uh1uCXl6RGFx2z57Ip/ulWKGk4zkrMW64luIlvS4K64=; b=LOUUvOurnyJEpj
	tI8Nm57pwsHofqGp8mr5BP3KjkjFr4ZadBNVQBZwh9baBbnRIlp+cQQtXPZ7EvW4FggPzfLn3x4BK
	WKK6ifajh4Og7/zzhItI4UDve/F9SvA/tqBvqy7wE4JzU12GUOEx1Z44z1PhTSXTpJUmp2q2tfUNe
	LUpWw/gmsufl2lxspv7ZxiSpuI3ozxyNQZJebuZc+HbwXuOcTBojgqqxrsFLcHaJLglBqMofsUzRu
	7NyNwOKhnYot6qrf/ZVDMKk2EmmKIpv50m7Enz2WBOv9OlxlTpAMvoHoQVQVMC14ZY3myYUdBecQQ
	Fi4q/FU1r64v2rf5sQPw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iV475-0007wS-14; Thu, 14 Nov 2019 01:39:59 +0000
Received: from us-smtp-2.mimecast.com ([205.139.110.61]
 helo=us-smtp-delivery-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iV470-0007uX-Ej
 for linux-nvme@lists.infradead.org; Thu, 14 Nov 2019 01:39:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573695593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gRNmFoI1D0nc0gkND+2x3IrZ36hZyc9gWBU7C1QGsu4=;
 b=ND7SuBC2KhiakGfgXKbqSIn+GJ0EKVBGtf1tohREsZ4g8+8aR0+L3ZAeMktG5IRLOhkvN9
 pxxtHPBoU5+0taBNMp/VlxDcIZsNRQqVuDpznXQIxn67GcUb602OEnZKQfvdDSpPrMF6Ye
 g/PPMeqJqemeWEM6BoFdQTMHv8pUbv4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-Twb9KE8mNk61-KwRf9s7Kw-1; Wed, 13 Nov 2019 20:39:49 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C560107ACC5;
 Thu, 14 Nov 2019 01:39:48 +0000 (UTC)
Received: from ming.t460p (ovpn-8-18.pek2.redhat.com [10.72.8.18])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E2895C541;
 Thu, 14 Nov 2019 01:39:41 +0000 (UTC)
Date: Thu, 14 Nov 2019 09:39:37 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH V2 2/2] nvme-pci: check CQ after batch submission for
 Microsoft device
Message-ID: <20191114013937.GD14190@ming.t460p>
References: <20191113134248.26022-1-ming.lei@redhat.com>
 <20191113134248.26022-3-ming.lei@redhat.com>
 <20191113155306.GA26795@redsun51.ssa.fujisawa.hgst.com>
 <20191114013007.GB14190@ming.t460p>
MIME-Version: 1.0
In-Reply-To: <20191114013007.GB14190@ming.t460p>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: Twb9KE8mNk61-KwRf9s7Kw-1
X-Mimecast-Spam-Score: 0
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191113_173954_579903_7D18BC33 
X-CRM114-Status: UNSURE (   9.79  )
X-CRM114-Notice: Please train this message.
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

On Thu, Nov 14, 2019 at 09:30:19AM +0800, Ming Lei wrote:
> On Thu, Nov 14, 2019 at 12:53:06AM +0900, Keith Busch wrote:
> > On Wed, Nov 13, 2019 at 09:42:48PM +0800, Ming Lei wrote:
> > > +static void nvme_check_cq(struct nvme_queue *nvmeq)
> > > +{
> > > +	if (test_bit(NVMEQ_CHECK_CQ, &nvmeq->flags) &&
> > > +			nvme_cqe_pending(nvmeq)) {
> > > +		unsigned long flags;
> > > +
> > > +		if (spin_trylock_irqsave(&nvmeq->cq_lock, flags)) {
> > 
> > What's with the irqsave? This isn't called from an irq disabled context.
> 
> Because .cq_lock is required in nvme irq handler.

However, it can be changed to spin_trylock_irq().

thanks,
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
