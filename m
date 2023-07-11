Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD96EB64DC
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jul 2023 04:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Sanp52G7qe4emaxcQItrkn4g0y24nEg66UbSkbqz794=; b=Zao2kINoXEdSQZ00wiH51DCt0J
	P4mEWaPLngSaUB1RlMGe30lxTE1sM/o+h8r8TxAt7LpVMTMOCX1pc26dyIrv0DUKhc66vZMAL+xG0
	aeJiWPxAUbNkAitTc0IMzYj4OXKMVEnqN2w3O4baX78XP8iBEb2UreFyUv7/P10AMu3mGfqQj1NUx
	UOoVhXVgkm5F6Yp2vEEdxJ10AQ2R8kmz4jPOmpUjfm5R6R1TJYc5Il9fNOhJu/DYsdsPcD0zjVAeE
	pD/oofepexeEmu68fdWwSqibJ1PkP2PPhz1shQls6OwucT5YsGgHZ93uCRb5Bvi0DBLsh4fK92A+/
	2SRZ1TQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJ4dE-00DZMM-2S;
	Tue, 11 Jul 2023 04:05:44 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJ4dA-00DZKT-1V
	for linux-nvme@lists.infradead.org;
	Tue, 11 Jul 2023 04:05:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689048339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sanp52G7qe4emaxcQItrkn4g0y24nEg66UbSkbqz794=;
	b=PBzbNEHyLcR/bqjTWLqLDIWYTju6lTFNhqcx4hnSd5Z669/JQW3NeNy0invYzOX1tduJAi
	YVcDEGkJ1KLy61qB5sIzcWhrqj6AjprLpAmAhjAtHBQo8m2BndsLP797FfRqJh/OxT/Z98
	mYjzggxHRo9LGlH1xZe+AILmlxBdjsc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-03nUTlYYOOeYXFQIqnT-6A-1; Tue, 11 Jul 2023 00:05:36 -0400
X-MC-Unique: 03nUTlYYOOeYXFQIqnT-6A-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6351121aa10so55607846d6.0
        for <linux-nvme@lists.infradead.org>; Mon, 10 Jul 2023 21:05:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689048336; x=1691640336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sanp52G7qe4emaxcQItrkn4g0y24nEg66UbSkbqz794=;
        b=YART/gzCtjBRn3+SpMDnH44vCCBaNy329AfWFyMeq+y/VgN0DosP4/0sTr6EkdM+Ep
         pD54sx8Ca37/yS210Iy5vYRO6P/bG1d/CMmEY5hdGD7sarun7JPvkiDWK6bVAvRTFdx7
         fH0qDHE9CC1SPBE5mtPEtyoyDSIXtxgXbDUX6UZHCrNjixbD9m8b1aLFh+SLnPzBWmOa
         Ufl6To63a4F+N9rcnwH19HfYSOp5s8F3fukuv6NhhrcUQeuEw2ElUMNEDLXmK13daXBJ
         S9Qn0e7nL36nYPOcnGx+0G4J1ONNxudE/MZRpNfTWWUC9adfWcwoUl8kKN3QiLJ2mpRR
         XJtA==
X-Gm-Message-State: ABy/qLa4Ci9VaogsH9fo4zmJ7P/3pLV2L9po5O7SJW431gOd/xZQ4gOH
	53JpWlNjR77X+W3Xq7Jy2uonx+Zq/xYm/v78xV8qqAiWHBWGv6iKGN4CCD8ohNxeehg1aziVf3d
	onmA/HizbkPbaaoiiprM52QnJ+R8KSElFY2BBGsdg0Dw=
X-Received: by 2002:a0c:e44d:0:b0:62d:ef66:ff1c with SMTP id d13-20020a0ce44d000000b0062def66ff1cmr12076660qvm.24.1689048335875;
        Mon, 10 Jul 2023 21:05:35 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEGTtnbv4lplqsuwMA0lcF/2QRhbSnqCLDEDGVhD6GZ6v3vRL7xgj3ixm6UdOxJvERNjVYrT8Aw+QUQlev+2Ls=
X-Received: by 2002:a0c:e44d:0:b0:62d:ef66:ff1c with SMTP id
 d13-20020a0ce44d000000b0062def66ff1cmr12076645qvm.24.1689048335643; Mon, 10
 Jul 2023 21:05:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230708020259.1343736-1-ming.lei@redhat.com> <20230708020259.1343736-3-ming.lei@redhat.com>
 <20230710064109.GB24519@lst.de> <ZKvL58L58rY3GWnt@ovpn-8-31.pek2.redhat.com>
In-Reply-To: <ZKvL58L58rY3GWnt@ovpn-8-31.pek2.redhat.com>
From: Pingfan Liu <piliu@redhat.com>
Date: Tue, 11 Jul 2023 12:05:24 +0800
Message-ID: <CAF+s44T5Hn5ikNq+YMp2Nucb6rBT=e4VHW8WN8YDhZHe9JmqGw@mail.gmail.com>
Subject: Re: [PATCH 2/2] nvme-pci: use blk_mq_max_nr_hw_queues() to calculate
 io queues
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org, 
	linux-block@vger.kernel.org, Wen Xiong <wenxiong@linux.ibm.com>, 
	Keith Busch <kbusch@kernel.org>, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, 
	Thomas Gleixner <tglx@linutronix.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230710_210540_575492_9C42C561 
X-CRM114-Status: GOOD (  22.29  )
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

Hi Ming,

Having no [PATCH 1/2] blk-mq: add blk_mq_max_nr_hw_queues() in inbox.
So I reply here.

At first glance, I think that  the cpu hot plug callback hook should
be the remedy for the newly introduced blk_mq_max_nr_hw_queues(),
although it is more complicated.

Consider the scene where nr_cpus=3D4, which can speed up the dumping
process, the blk_mq_max_nr_hw_queues() can not utilize the other three
cpus.


Thanks,

Pingfan

On Mon, Jul 10, 2023 at 5:16=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Mon, Jul 10, 2023 at 08:41:09AM +0200, Christoph Hellwig wrote:
> > On Sat, Jul 08, 2023 at 10:02:59AM +0800, Ming Lei wrote:
> > > Take blk-mq's knowledge into account for calculating io queues.
> > >
> > > Fix wrong queue mapping in case of kdump kernel.
> > >
> > > On arm and ppc64, 'maxcpus=3D1' is passed to kdump command line, see
> > > `Documentation/admin-guide/kdump/kdump.rst`, so num_possible_cpus()
> > > still returns all CPUs.
> >
> > That's simply broken.  Please fix the arch code to make sure
> > it does not return a bogus num_possible_cpus value for these
>
> That is documented in Documentation/admin-guide/kdump/kdump.rst.
>
> On arm and ppc64, 'maxcpus=3D1' is passed for kdump kernel, and "maxcpu=
=3D1"
> simply keep one of CPU cores as online, and others as offline.
>
> So Cc our arch(arm & ppc64) & kdump guys wrt. passing 'maxcpus=3D1' for
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
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
>


