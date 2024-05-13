Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4653C25B10
	for <linux-nvme@archiver.kernel.org>; Mon, 13 May 2024 08:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y9TfaHjT18CdtzvNmwQpp2X/7RmpdQsmO2fg/Q54E5g=; b=tJCo8x6hg7gVuEMFg/sCaWl546
	s/UGk5iRXDNFsxMtyavoFwqLC9gfCKTn4/OAlMXelGn262iTb4K3sA03+FOQN2aHoM0quq8E9CBHo
	A5NAL/HISARs9Vr0M1fojLhv+4+h12QVt4nDfNok7tiIvLt+zp2DEdHAuPFqeSJFcZiYJFu952bI+
	LtnBAa9zJb7mweg84fvAIvK0XwkOpoKLGznI72BSA1wKw6T6U4QNE9Pn4JVKlfUSy2VJHeZXpQW/8
	eR4LBQ9GgaDa8+Bl3tTBzDELqxLKQyHseIFIs4X4DEGEsLoh0pZQXJLdEphgREstMkxccrDbiClrH
	mppGeiow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6REA-0000000CFqq-0wej;
	Mon, 13 May 2024 08:40:10 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6RE7-0000000CFpX-0YgR
	for linux-nvme@lists.infradead.org;
	Mon, 13 May 2024 08:40:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715589605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y9TfaHjT18CdtzvNmwQpp2X/7RmpdQsmO2fg/Q54E5g=;
	b=W+Oh7ycGDKOrIhFn0yG2m2ZU3r8L/CNDQoxeBJnIKt+UuazJyOQPQ1hz0ZBz1LZ4tEC/4f
	G++GRTv2/zQbSS/Ue8ak1X1FLo9wZxcj3PECKJZB+GPn9BdITvJJLtPOVByB4M0i+c96s0
	fEx6ud40yMiYmKQ/bWCpSkSm3oM82vA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-5OsPxujyM4GbGF1I4fXupg-1; Mon, 13 May 2024 04:39:57 -0400
X-MC-Unique: 5OsPxujyM4GbGF1I4fXupg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BF80C800656;
	Mon, 13 May 2024 08:39:56 +0000 (UTC)
Received: from fedora (unknown [10.72.112.91])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6553540C5D0;
	Mon, 13 May 2024 08:39:52 +0000 (UTC)
Date: Mon, 13 May 2024 16:39:48 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Benjamin Meier <benjamin.meier70@gmail.com>
Cc: hch@lst.de, kbusch@kernel.org, kbusch@meta.com,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	tglx@linutronix.de, ming.lei@redhat.com
Subject: Re: [PATCH 2/2] nvme-pci: allow unmanaged interrupts
Message-ID: <ZkHR1L/cJesDEn60@fedora>
References: <20240510151047.GA10486@lst.de>
 <26d4ad30-c0fe-4286-9802-aa6afbd8074a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26d4ad30-c0fe-4286-9802-aa6afbd8074a@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240513_014007_267683_50BC3A0D 
X-CRM114-Status: GOOD (  22.04  )
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

On Mon, May 13, 2024 at 09:33:27AM +0200, Benjamin Meier wrote:
> > From: Christoph Hellwig <hch@lst.de>
> >
> > So let them argue why.  I'd rather have a really, really, really
> > good argument for this crap, and I'd like to hear it from the horses
> > mouth.
> 
> I reached out to Keith to explore the possibility of manually defining
> which cores handle NVMe interrupts.
> 
> The application which we develop and maintain (in the company I work)
> has very high requirements regarding latency. We have some isolated cores

Are these isolated cores controlled by kernel command line `isolcpus=`?

> and we run our application on those.
> 
> Our system is using kernel 5.4 which unfortunately does not support
> "isolcpus=managed_irq". Actually, we did not even know about that
> option, because we are focussed on kernel 5.4. It solves part
> of our problem, but being able to specify where exactly interrupts
> are running is still superior in our opinion.
> 
> E.g. assume the number of house-keeping cores is small, because we
> want to have full control over the system. In our case we have threads
> of different priorities where some get an exclusive core. Some other threads
> share a core (or a group of cores) with other threads. Now we are still
> happy to assign some interrupts to some of the cores which we consider as
> "medium-priority". Due to the small number of non-isolated cores, it can

So these "medium-priority" cores belong to isolated cpu list, you still expect
NVMe interrupts can be handled on these cpu cores, do I understand correctly?

If yes, I think your case still can be covered with 'isolcpus=managed_irq' which
needn't to be same with cpu cores specified from `isolcpus=`, such as
excluding medium-priority cores from 'isolcpus=managed_irq', and
meantime include them in plain `isolcpus=`.

> be tricky to assign all interrupts to those without a performance-penalty.
> 
> Given these requirements, manually specifying interrupt/core assignments
> would offer greater flexibility and control over system performance.
> Moreover, the proposed code changes appear minimal and have no
> impact on existing functionalities.

Looks your main concern is performance, but as Keith mentioned, the proposed
change may degrade nvme perf too:

https://lore.kernel.org/linux-nvme/Zj6745UDnwX1BteO@kbusch-mbp.dhcp.thefacebook.com/



thanks,
Ming


