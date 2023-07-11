Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30E26C001B0
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jul 2023 03:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RAKJNLVa7Dz/gEOC8l+W1ubVM3SUfpJDz/d6N9kvm8w=; b=0Tdhyhl1odGuBQmZEWC8MThu94
	wCSpYMgwPvN1QomGJ/9CozB3vlRym5f7p+QtXueLxxNHs+LPNnuz2dvFS7uEWSHWEaWYp76FmH0Yt
	kHlHOxtY/gsDuqwU8WJ0jxjqpbBgJ7ychmJmqTTwaNPVkTL6Tzscg6lCXf9TeXvcmeZdEfQMMyKSM
	6ntth1ouhH4JXG1RjhGD2nnDghgaoSO+6lkv7bs4yV+ogR61vyPQVpyWAjUryHJdn89s7ZMz0+T4/
	fNN6VzQ9V2Kw2gEJo48zjQR8EF2FtoayZNEOPcK9q6AN+emB/fHAfbaeaLtXs00yVjZOqMtox+2g0
	FQ/M3bTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJ4AX-00DUkW-1a;
	Tue, 11 Jul 2023 03:36:05 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJ4AU-00DUiu-0s
	for linux-nvme@lists.infradead.org;
	Tue, 11 Jul 2023 03:36:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689046559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RAKJNLVa7Dz/gEOC8l+W1ubVM3SUfpJDz/d6N9kvm8w=;
	b=UvchCIrIJ3Pf974kKJ9AdYMuL8pVjeyd0GDjCPxIUkKmJVgAMLDmla4mVd4pB9W+wAKx3n
	e7CRs4OZrtmPTU0+UtA+ZxSMyUvhTKpGJRTfZTsvMCk8xL5oC2W1f4NLd2kmWBQ8sxAWCZ
	kXiBDt0TnR93Kj2DsWrzdGWqKTNNX2s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-498-rnGtRtxZNxW8idSVCPY9jA-1; Mon, 10 Jul 2023 23:35:56 -0400
X-MC-Unique: rnGtRtxZNxW8idSVCPY9jA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 765518028B2;
	Tue, 11 Jul 2023 03:35:55 +0000 (UTC)
Received: from localhost (ovpn-12-93.pek2.redhat.com [10.72.12.93])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2547DC52D9C;
	Tue, 11 Jul 2023 03:35:53 +0000 (UTC)
Date: Tue, 11 Jul 2023 11:35:50 +0800
From: Baoquan He <bhe@redhat.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Wen Xiong <wenxiong@linux.ibm.com>, Keith Busch <kbusch@kernel.org>,
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/2] nvme-pci: use blk_mq_max_nr_hw_queues() to calculate
 io queues
Message-ID: <ZKzOFkokjTVwd4Ry@MiWiFi-R3L-srv>
References: <20230708020259.1343736-1-ming.lei@redhat.com>
 <20230708020259.1343736-3-ming.lei@redhat.com>
 <20230710064109.GB24519@lst.de>
 <ZKvL58L58rY3GWnt@ovpn-8-31.pek2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKvL58L58rY3GWnt@ovpn-8-31.pek2.redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230710_203602_386297_FC0B08C8 
X-CRM114-Status: GOOD (  24.11  )
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

On 07/10/23 at 05:14pm, Ming Lei wrote:
> On Mon, Jul 10, 2023 at 08:41:09AM +0200, Christoph Hellwig wrote:
> > On Sat, Jul 08, 2023 at 10:02:59AM +0800, Ming Lei wrote:
> > > Take blk-mq's knowledge into account for calculating io queues.
> > > 
> > > Fix wrong queue mapping in case of kdump kernel.
> > > 
> > > On arm and ppc64, 'maxcpus=1' is passed to kdump command line, see
> > > `Documentation/admin-guide/kdump/kdump.rst`, so num_possible_cpus()
> > > still returns all CPUs.
> > 
> > That's simply broken.  Please fix the arch code to make sure
> > it does not return a bogus num_possible_cpus value for these
> 
> That is documented in Documentation/admin-guide/kdump/kdump.rst.
> 
> On arm and ppc64, 'maxcpus=1' is passed for kdump kernel, and "maxcpu=1"
> simply keep one of CPU cores as online, and others as offline.

I don't know maxcpus on arm and ppc64 well. But maxcpus=1 or nr_cpus=1
are suggested parameter. Because usually nr_cpus=1 is enough to make
kdump kernel work well to capture vmcore. However, user is allowed to
specify nr_cpus=n (n>1) if they think multiple cpus are needed in kdump
kernel. Your hard coding of cpu number in kdump kernel may be not so
reasonable.

Please cc kexec mailing list when posting so that people can view the
whole thread of discussion.

Thanks
Baoquan

> 
> So Cc our arch(arm & ppc64) & kdump guys wrt. passing 'maxcpus=1' for
> kdump kernel.
> 
> > setups, otherwise you'll have to paper over it in all kind of
> > drivers.
> 
> The issue is only triggered for drivers which use managed irq &
> multiple hw queues.
> 
> 
> Thanks,
> Ming
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 


