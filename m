Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F15A7C25B10
	for <linux-nvme@archiver.kernel.org>; Sat, 11 May 2024 00:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lP4kjDNJl8Z5kVFnY+PpwH5yXWS5Ek6nqlqRnF2wXwM=; b=MnJcW1TdFMgT6nfLCDXhuoOoHV
	MNOYnvr6VIkK0lTkPbPlHMcPHeGhRJfoDBtA60FhWlKleUvEjbb6U+gU38ZvAOS5JZDDeU4EXAtoB
	SvYQjSm4ENdXQUpQaCOERbmPD1NSKgGGXLpWojjEMPQtlxXfvYrWI6zrmVoTSnkbn3t5NiigUwxRB
	IE5MIKnW6uJSOqp47IwJuv1idgotgLE2g7Re0XwnwPYZaWLp9IvxGaj0BMXXDD0OJ/iiPT9cILqXF
	eDKeY4IKgYgYlmIdzn5UjyyCRw5g2Vz7rctSZjySxtVa2VPHIkp8M5TZXcYLbwfZWksZoO3h3fyrm
	sFl3tOCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5b5V-00000006xPb-3ImU;
	Sat, 11 May 2024 00:59:45 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5b5T-00000006xOg-1QkF
	for linux-nvme@lists.infradead.org;
	Sat, 11 May 2024 00:59:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715389180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lP4kjDNJl8Z5kVFnY+PpwH5yXWS5Ek6nqlqRnF2wXwM=;
	b=aJZDVGsV3UUFsg+JaW97BNZhXzW00Kh53M6ZURX/alFurURCis3VnfB+ijpS2B+Q+1txAh
	n8newg04yrF22egQ3pkMVOgPloCd9upcvK9bTOlOCS9puYzNSKFQpvnMHx8DxH8M99FiAS
	TKT/r5C/LsB9/If9vY6KqbWcdlI+pyc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-325-Ej9y5OyQOUO58lzfQejPXA-1; Fri,
 10 May 2024 20:59:25 -0400
X-MC-Unique: Ej9y5OyQOUO58lzfQejPXA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2FE8A3C02521;
	Sat, 11 May 2024 00:59:25 +0000 (UTC)
Received: from fedora (unknown [10.72.116.30])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B647C2011804;
	Sat, 11 May 2024 00:59:21 +0000 (UTC)
Date: Sat, 11 May 2024 08:59:17 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	tglx@linutronix.de
Subject: Re: [PATCH 2/2] nvme-pci: allow unmanaged interrupts
Message-ID: <Zj7C5fPCAdGwGsrI@fedora>
References: <20240510141459.3207725-1-kbusch@meta.com>
 <20240510141459.3207725-2-kbusch@meta.com>
 <20240510151047.GA10486@lst.de>
 <Zj5JMqWRY187PqnD@kbusch-mbp.dhcp.thefacebook.com>
 <Zj6yvTxIpUnOXl7R@fedora>
 <Zj6-1sXvUNZWO1pB@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zj6-1sXvUNZWO1pB@kbusch-mbp.dhcp.thefacebook.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240510_175943_481940_F833D3A1 
X-CRM114-Status: GOOD (  26.89  )
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

On Fri, May 10, 2024 at 06:41:58PM -0600, Keith Busch wrote:
> On Sat, May 11, 2024 at 07:50:21AM +0800, Ming Lei wrote:
> > On Fri, May 10, 2024 at 10:20:02AM -0600, Keith Busch wrote:
> > > On Fri, May 10, 2024 at 05:10:47PM +0200, Christoph Hellwig wrote:
> > > > On Fri, May 10, 2024 at 07:14:59AM -0700, Keith Busch wrote:
> > > > > From: Keith Busch <kbusch@kernel.org>
> > > > > 
> > > > > Some people _really_ want to control their interrupt affinity.
> > > > 
> > > > So let them argue why.  I'd rather have a really, really, really
> > > > good argument for this crap, and I'd like to hear it from the horses
> > > > mouth.
> > > 
> > > It's just prioritizing predictable user task scheduling for a subset of
> > > CPUs instead of having consistently better storage performance.
> > > 
> > > We already have "isolcpus=managed_irq," parameter to prevent managed
> > > interrupts from running on a subset of CPUs, so the use case is already
> > > kind of supported. The problem with that parameter is it is a no-op if
> > > the starting affinity spread contains only isolated CPUs.
> > 
> > Can you explain a bit why it is a no-op? If only isolated CPUs are
> > spread on one queue, there will be no IO originated from these isolated
> > CPUs, that is exactly what the isolation needs.
> 
> The "isolcpus=managed_irq," option doesn't limit the dispatching CPUs.

Please see commit a46c27026da1 ("blk-mq: don't schedule block kworker on isolated CPUs")
in for-6.10/block.

> It only limits where the managed irq will assign the effective_cpus as a
> best effort.

Most of times it does work.

> 
> Example, I boot with a system with 4 threads, one nvme device, and
> kernel parameter:
> 
>   isolcpus=managed_irq,2-3
> 
> Run this:
> 
>   for i in $(seq 0 3); do taskset -c $i dd if=/dev/nvme0n1 of=/dev/null bs=4k count=1000 iflag=direct; done

It is one test problem, when you try to isolate '2-3', it isn't expected
to submit IO or run application on these isolated CPUs.


Thanks, 
Ming


