Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD35C25B10
	for <linux-nvme@archiver.kernel.org>; Fri, 10 May 2024 23:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m0dHDeJXZCALlp2ufSH87EqN0Fr/YawjQbxw3fUy5tg=; b=aEVkP30OrY6ct9703BHZhIkCLL
	yfaYCHZIsZc1kMURM3mEz7ui9h18nzLBJ6r0lKQvag2dADw7W9DbjRO85duZPTX10IyXCfucpTNA/
	S/Sn3hyVMHkFsqpRFNS0L6oiocp1tYlqQ55GrzDs3Y7YW03aPHrErcN3cJe10hIYDAHIXP8RD2u/C
	jmF50+NqF1L5E4H9Fiwe8Sk1WYtP3b2wuqbCS/t97WtS0sstTncO0KrXC3Nhg/cjdn7oiqN+Eb8VZ
	rG3k4gvfCz1izbxOyHT0xcGLbs2j5+8PAQGeZiFOQYn5vwDrRimBF4mGx5yJPn7VoHmhZE+6elMN+
	0N8fe80g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5a0f-00000006pMk-2C9G;
	Fri, 10 May 2024 23:50:41 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5a0c-00000006pMH-02Sx
	for linux-nvme@lists.infradead.org;
	Fri, 10 May 2024 23:50:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715385036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m0dHDeJXZCALlp2ufSH87EqN0Fr/YawjQbxw3fUy5tg=;
	b=VRKgU9W5cYrg2qCF+0g/SoTW5+sfJ0+SYmpYgU8LX7F5mKbW/bZIuUTO8CkfBcBRVg2R1k
	gzf0NvWssOQXWUiuKT9TmCs2C9vAw1MIMAw517PSObdMsKAJzC8MpiTdehpUmFQs9WInRq
	uaoeLpFM5BihD3P0+Ifi/JiVj91omBM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-sE9Mt34nMKKddJMPk9c91g-1; Fri, 10 May 2024 19:50:34 -0400
X-MC-Unique: sE9Mt34nMKKddJMPk9c91g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DB3CD8030A5;
	Fri, 10 May 2024 23:50:33 +0000 (UTC)
Received: from fedora (unknown [10.72.116.15])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7193344E3AFE;
	Fri, 10 May 2024 23:50:30 +0000 (UTC)
Date: Sat, 11 May 2024 07:50:21 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	tglx@linutronix.de
Subject: Re: [PATCH 2/2] nvme-pci: allow unmanaged interrupts
Message-ID: <Zj6yvTxIpUnOXl7R@fedora>
References: <20240510141459.3207725-1-kbusch@meta.com>
 <20240510141459.3207725-2-kbusch@meta.com>
 <20240510151047.GA10486@lst.de>
 <Zj5JMqWRY187PqnD@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zj5JMqWRY187PqnD@kbusch-mbp.dhcp.thefacebook.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240510_165038_143961_A0DE7232 
X-CRM114-Status: GOOD (  18.29  )
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

On Fri, May 10, 2024 at 10:20:02AM -0600, Keith Busch wrote:
> On Fri, May 10, 2024 at 05:10:47PM +0200, Christoph Hellwig wrote:
> > On Fri, May 10, 2024 at 07:14:59AM -0700, Keith Busch wrote:
> > > From: Keith Busch <kbusch@kernel.org>
> > > 
> > > Some people _really_ want to control their interrupt affinity.
> > 
> > So let them argue why.  I'd rather have a really, really, really
> > good argument for this crap, and I'd like to hear it from the horses
> > mouth.
> 
> It's just prioritizing predictable user task scheduling for a subset of
> CPUs instead of having consistently better storage performance.
> 
> We already have "isolcpus=managed_irq," parameter to prevent managed
> interrupts from running on a subset of CPUs, so the use case is already
> kind of supported. The problem with that parameter is it is a no-op if
> the starting affinity spread contains only isolated CPUs.

Can you explain a bit why it is a no-op? If only isolated CPUs are
spread on one queue, there will be no IO originated from these isolated
CPUs, that is exactly what the isolation needs.



Thanks,
Ming


