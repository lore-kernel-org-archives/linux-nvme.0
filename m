Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68889C3DA4A
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Jul 2024 16:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Rs7RFFdEOK955mKfTd8yYL6Ru6E1nsTxb1EBD57fEPM=; b=2xqr8IXH+ZWQjJzVfN3Tr5CV5r
	knOSXdBFkIRboCBnBzU1uf+GJGoYq13+sjCh0rjUS57RCKgYvAT5m8zKRNSc3JoVW9AgQFcakeZRY
	m4QKI2FpLxASZMlWHz/gm+n6yYaQQXz5bF+VTuAAGZkSIq+Nl0UJueIE1SLVR+Y6rwKnimaGgQOIH
	1e2g4UkTvdAdc5Gb8P3GrpSVxX9yPCXeJiKIkEN7fdlRG+kf1cn8FnntoFUnsixVqyt2KVhmgQ84U
	q/F17Tutx0KYxoh+CH48OeSXGRiFfw+7hix6JMMcyUofPHsrrffw4hc+aYn1fg/WHnPJHu7pz1OkB
	w4tJE8Jw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTOUW-00000007jGA-1OUe;
	Mon, 15 Jul 2024 16:23:56 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTOUS-00000007jFE-41fl
	for linux-nvme@lists.infradead.org;
	Mon, 15 Jul 2024 16:23:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721060631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rs7RFFdEOK955mKfTd8yYL6Ru6E1nsTxb1EBD57fEPM=;
	b=HZjzPq2YqvW6qF/iEi5Pe7KlJkJay4+76zYwbJmJhH8XXI3OQFsS99sNrGxoj3hNjg8L3b
	rdT8YOgmwclRGy32eFEtKJGHQripw3Tm8QvJSBedVxYQEANb6E3tety0xLjsw2dhQIxAfb
	fpPVoLaxS1ZhGSqp5fxP+yCvV6fGnv4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-490-t_mXC4-NPvSy8ovwUtZwzw-1; Mon,
 15 Jul 2024 12:23:48 -0400
X-MC-Unique: t_mXC4-NPvSy8ovwUtZwzw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5800E1955F3B;
	Mon, 15 Jul 2024 16:23:46 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.96.133.7])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 23BA1300018E;
	Mon, 15 Jul 2024 16:23:45 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
	id 5F05C403A81AA; Mon, 15 Jul 2024 13:23:20 -0300 (-03)
Date: Mon, 15 Jul 2024 13:23:20 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
	Lawrence Troup <ltroup@cisco.com>
Subject: Re: [PATCH V3] nvme-pci: allow unmanaged interrupts
Message-ID: <ZpVM+K2n77sLYNNz@tpad>
References: <20240702104112.4123810-1-ming.lei@redhat.com>
 <ZpVINh3BA88U6KEc@tpad>
MIME-Version: 1.0
In-Reply-To: <ZpVINh3BA88U6KEc@tpad>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240715_092353_093077_312AC7D9 
X-CRM114-Status: GOOD (  26.75  )
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

On Mon, Jul 15, 2024 at 01:03:02PM -0300, Marcelo Tosatti wrote:
> On Tue, Jul 02, 2024 at 06:41:12PM +0800, Ming Lei wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > People _really_ want to control their interrupt affinity in some
> > cases, such as Openshift with Performance profile, in which each
> > irq's affinity is completely specified from userspace. Turns out
> > that 'isolcpus=managed_irqs' isn't enough.
> > 
> > Add module parameter to allow unmanaged interrupts, just as some
> > SCSI drivers are doing.
> > 
> > Cc: Marcelo Tosatti <mtosatti@redhat.com>
> > Signed-off-by: Keith Busch <kbusch@kernel.org>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> > v2->v3:
> > 	- rebase on for-next
> > 	- add openshift use case
> > 
> > v1->v2: skip the the AFFINITY vector allocation if the parameter is
> > provided instead trying to make the vector code handle all post_vectors.
> > 
> >  drivers/nvme/host/pci.c | 18 ++++++++++++++++--
> >  1 file changed, 16 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > index 5d8035218de9..a39c99c9b64d 100644
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -63,6 +63,11 @@ MODULE_PARM_DESC(sgl_threshold,
> >  		"Use SGLs when average request segment size is larger or equal to "
> >  		"this size. Use 0 to disable SGLs.");
> >  
> > +static bool managed_irqs = true;
> > +module_param(managed_irqs, bool, 0444);
> > +MODULE_PARM_DESC(managed_irqs,
> > +		 "set to false for user controlled irq affinity");
> > +
> 
> What if you set "static bool managed_irqs" to false when isolcpus is being used?
> 
> For example:
> 
> if (housekeeping_enabled(HK_TYPE_MANAGED_IRQ))
> 	managed_irqs = false;

Well, that is confusing.

Maybe just:

if (housekeeping_enabled(HK_FLAG_MISC))
	managed_irqs = false;

Instead.

> 
> Then there is no additional parameter to tune (which addresses
> Christoph's concern).


