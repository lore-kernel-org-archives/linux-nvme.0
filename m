Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E1EAF46C47
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Apr 2026 15:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QMs4B+i4gWp0fPDDgUUvzkKR5xdCLJxCya7S4/Pg2oI=; b=N8Mypn/0gzR24mQxxjblnbkVL5
	A8VgMt26WDbkmpw+mcbK+c5pWYdLYrvCYhRsn1aWIZXQkXm9C0gl+BLTJR0nUXMZbXRztT29CWhzx
	TK2/AHBMesIqWMTgkb8L2vg2dYVxDVACUz8/WkvQQWDaIksfgCAQQFha1VDbliWHuh4TJ+VN4OsvQ
	ldVgVrVz+7ZujkDvg4Hl27YNAcU8K4QSsEDlKjHcZD6m0l35/dtXigR+arsnSpaGXf2TLtEZxftP8
	ZH8CnLRdC/dHVjA6Lvvsa0mt9UHstlRtfAguj7UN3r2Yz/IHcLion5hJX56k2BSW/lvRGv1SFFEYG
	A4t8H+jw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9lUK-00000005EwO-2N3r;
	Mon, 06 Apr 2026 15:03:40 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9afS-00000004jtW-1fFl
	for linux-nvme@lists.infradead.org;
	Mon, 06 Apr 2026 03:30:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775446223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QMs4B+i4gWp0fPDDgUUvzkKR5xdCLJxCya7S4/Pg2oI=;
	b=EuIqYlD6SGGbckDFDcRcNweeD2krwMLTix6SyCXDhiF1L6K04zFi5TvA7hhcgoazRP8tQz
	SrThwNXuHIOqk5aKLpx9CxfAYozGc4uQIve6aPubtiFGQsSd85kROEWZGnqxpiSZb01gCL
	QMqn645iVcuR7ZM4Y3hPmpIHPJeecck=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-WT4xYZ7RM_SDhcbZJXQjhA-1; Sun,
 05 Apr 2026 23:30:16 -0400
X-MC-Unique: WT4xYZ7RM_SDhcbZJXQjhA-1
X-Mimecast-MFC-AGG-ID: WT4xYZ7RM_SDhcbZJXQjhA_1775446212
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5B3B11956080;
	Mon,  6 Apr 2026 03:30:09 +0000 (UTC)
Received: from fedora (unknown [10.72.116.2])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B3FED1800576;
	Mon,  6 Apr 2026 03:29:43 +0000 (UTC)
Date: Mon, 6 Apr 2026 11:29:38 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	mst@redhat.com, aacraid@microsemi.com,
	James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com,
	liyihang9@h-partners.com, kashyap.desai@broadcom.com,
	sumit.saxena@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
	chandrakanth.patil@broadcom.com, sathya.prakash@broadcom.com,
	sreekanth.reddy@broadcom.com, suganath-prabu.subramani@broadcom.com,
	ranjan.kumar@broadcom.com, jinpu.wang@cloud.ionos.com,
	tglx@kernel.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	akpm@linux-foundation.org, maz@kernel.org, ruanjinjie@huawei.com,
	bigeasy@linutronix.de, yphbchou0911@gmail.com, wagi@kernel.org,
	frederic@kernel.org, longman@redhat.com, chenridong@huawei.com,
	hare@suse.de, kch@nvidia.com, steve@abita.co, sean@ashe.io,
	chjohnst@gmail.com, neelx@suse.com, mproche@gmail.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com,
	mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com
Subject: Re: [PATCH v10 13/13] docs: add io_queue flag to isolcpus
Message-ID: <adMoon3Zf6gO-UbA@fedora>
References: <20260401222312.772334-1-atomlin@atomlin.com>
 <20260401222312.772334-14-atomlin@atomlin.com>
 <ac8l-w8ERG1YN2Wm@fedora>
 <nxe24ixebb4lm2d5w4aubhtwr23df6mumqd663axj35oswdiyv@amtqhtsidyr4>
MIME-Version: 1.0
In-Reply-To: <nxe24ixebb4lm2d5w4aubhtwr23df6mumqd663axj35oswdiyv@amtqhtsidyr4>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: AHfcM-n9vZIzPWSfDAYSVX4W1a0JN0rBmLEV5Hm6Ulo_1775446212
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260405_203026_644583_B69330BC 
X-CRM114-Status: GOOD (  31.73  )
X-Mailman-Approved-At: Mon, 06 Apr 2026 08:03:38 -0700
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

On Sun, Apr 05, 2026 at 09:15:36PM -0400, Aaron Tomlin wrote:
> On Fri, Apr 03, 2026 at 10:30:26AM +0800, Ming Lei wrote:
> > On Wed, Apr 01, 2026 at 06:23:12PM -0400, Aaron Tomlin wrote:
> > 
> > All these can be supported by `managed_irq` already, please document the thing
> > which `io_queue` solves, and `managed_irq` can't cover, so user can know
> > how to choose between the two command lines.
> > 
> > `Restrict the placement of queues to housekeeping CPUs only` looks totally
> > stale, please see patch 10, in which isolated CPUs are spread too.
> 
> Dear Ming,
> 
> Thank you for your careful review of the documentation and for raising
> these excellent points. I completely agree that the administrator guide
> must be as unambiguous as possible.
> 
> Regarding your first point on the distinction between managed_irq and
> io_queue, you are entirely correct that the documentation must explicitly
> guide the user in their choice. I shall revise the text to clarify that
> where managed_irq solely restricts the affinity of hardware interrupts at
> the interrupt controller level, io_queue governs the block layer
> multi-queue mapping algorithm itself. I will add a clear explanation that
> io_queue is required for users who utilise polling queues, which do not
> rely on interrupts, or specific drivers that do not use the managed
> interrupt infrastructure. Without io_queue, the block layer would still
> assign these polling duties to isolated CPUs, thereby breaking the
> isolation.

I don't think there is such breaking isolation thing. For iopoll, if
applications won't submit polled IO on isolated CPUs, everything is just
fine. If they do it, IO may be reaped from isolated CPUs, that is just their
choice, anything is wrong?

> 
> Every logical CPU, including the isolated ones, must logically map to a
> hardware context in order to submit input and output requests, saying they
> are completely restricted is indeed stale and technically inaccurate. The
> isolation mechanism actually ensures that the hardware contexts themselves
> are serviced by the housekeeping CPUs, while the isolated CPUs are simply
> mapped onto these housekeeping queues for submission purposes. I will
> rewrite this paragraph to accurately reflect this topology, ensuring it
> aligns perfectly with the behaviour introduced in patch 10.

I am not sure if the above words is helpful from administrator viewpoint about
the two kernel parameters.

IMO, only two differences from this viewpoint:

1) `io_queue` may reduce nr_hw_queues

2) when application submits IO from isolated CPUs, `io_queue` can complete
IO from housekeeping CPUs.

> 
> > > +
> > > +			  The io_queue configuration takes precedence
> > > +			  over managed_irq. When io_queue is used,
> > > +			  managed_irq placement constrains have no
> > > +			  effect.
> > > +
> > > +			  Note: Offlining housekeeping CPUS which serve
> > > +			  isolated CPUs will be rejected. Isolated CPUs
> > > +			  need to be offlined before offlining the
> > > +			  housekeeping CPUs.
> > > +
> > > +			  Note: When an isolated CPU issues an I/O request,
> > > +			  it is forwarded to a housekeeping CPU. This will
> > > +			  trigger a software interrupt on the completion
> > > +			  path.
> > 
> > `io_queue` doesn't touch io completion code path, which is more
> > implementation details, so not sure if the above Note is needed.
> 
> Possibly the original author intended to suggest that the software
> interrupt is sent to the isolated CPU?

I meant this point can't be found in the patches.


Thanks, 
Ming


