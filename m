Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A429BE937E3
	for <linux-nvme@archiver.kernel.org>; Sun, 12 Apr 2026 15:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HzOvPiW8ztwbs3wF3jjs1dxbj2pwYigEFa9b+mMyiMw=; b=hpuuCofxrcDn2uoVkgj0HpaEiu
	Msaz9o5MNF8aa+Qt94UVuXY4qqkVWxZMcfzT3P4iHNwRz0dadqxHcB70ZoFyzqcgYKY614ixtdKko
	BS/uSiKPio1xZSz9mGSvMLHoyGMLF3PueviYzXcTNuxTVovmBHc3wpWjl3NHWXHpyhxNFh12gmCOt
	mTjO7DaF03gfPbo6qmyXlJv3ObdZSA1hUOeFpM0jKVeIR1mE82GHi/G7L7wyG/wmC3MNzR1jEcvp+
	il9a3Y4thDIK3s5xTJwL5HbiKw7DTfMqJk+QyJboUxoIndzFEqFJ6EEpWxKNLZfRdXxxJg1+k6TdX
	O/lGQ9qQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wBwLP-0000000EQ8A-0Scx;
	Sun, 12 Apr 2026 15:03:27 +0000
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wBXp7-0000000DRlu-1ti6
	for linux-nvme@lists.infradead.org;
	Sat, 11 Apr 2026 12:52:30 +0000
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-b9b1df1a6b3so339580566b.0
        for <linux-nvme@lists.infradead.org>; Sat, 11 Apr 2026 05:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775911947; x=1776516747; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HzOvPiW8ztwbs3wF3jjs1dxbj2pwYigEFa9b+mMyiMw=;
        b=RfHe5buIiGLycOprVrgwZDwHXhkZiv9J92smvIBBG0lpd99Xm008tjuLVh7AvMOYZH
         vZry2LuJ/uhSuKt/sWibfe9877F+OEbZZOIlshT+45oFLH7Vyhenzh52xhCHj8Q3WTuU
         rciS+LS0/qKvMnXpvMx+z3MHgoabnB4hysQW6GYYj6Np+yebIJhKAo6UPmE8DYBNrEnN
         5fgSuRgP9X9MdylHmXhC+oq2mUEiMjgMqxKHVuP0ndOJwT+AYhd/UfyCus4RP820HnUB
         5nhWQpOMFCZL97agn4+iCiUNqzuVrP3hCqmojVHgSBJcMlm+K444SWZ0sFjUrZvwZ5ha
         lH6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775911947; x=1776516747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HzOvPiW8ztwbs3wF3jjs1dxbj2pwYigEFa9b+mMyiMw=;
        b=D5zzXQYGQ4dws9lUb5z473DlqUWGG5DPsHGzCPBD/7ajKC79G9QLBXSEB/UCQ2GBvV
         RU9nXUXJ0RKtTvyMohGLGRwHvmq4ZU6ONgeDkN1jWKlTqkOxz1WxBbDcpMzX0NIDlIJT
         egnyDVsUo+rwhDf+BwJ6AEESN1xxEM9M47jHEZIlE8r+v2OXOW6cWGp+Y9Tc6Pxk2D59
         ohAc8VCs/33r1UbW1Uqk/dDJOpO2GaqOhOb2O4cmf5TgC1+VV4427TLxDvqDyp9f9Izt
         8hcAXm6V/27ePb70LSO0K4nnTHplh3m54jOVMKjMb95rzgRBIy2dSfVV53MeG5r5AlSZ
         EKcA==
X-Forwarded-Encrypted: i=1; AJvYcCUMrQ+arUu/wFbueltrE3Xynn7gXwYpaA4zf0h3pp7r3dwomEklttCrwdYXIBHIv3OWfvzWOWPejjsI@lists.infradead.org
X-Gm-Message-State: AOJu0YxSxIqTWSmtwqJTmcN7pCHebfF9fCIE6+zzX8e8WodjwXTPNQIA
	8KgSVQuU01kJQHpeQ9ZhYMQvtED7LirOXPfHHuabfvgUDtH/etxI3kdm
X-Gm-Gg: AeBDiesrZlkuIYnNhO1JbaYpKh18pMfDDyXbdAtMASFNhLh0Ociy0atskPy00cKRz/o
	vYGRLhUD4ifUQtuR4pFcuJumTDSTjat8cfhMKsz2QLxij7AokhbCB6hMf+71F8j1czaZCDA7SPB
	F9egY8ysjfOn9S5WcjGfYbOHqO6LrSt/m5W+Rxf0XKFlCfnUjQGZ29OPj+tnlGsckxkTs4sRYKm
	a99HhO18YWm4tXqO46H2/MDoSHqUcjCEOlnEHJZsDQYD83xLMlQBU7gnrwzHZzIUXTETJarGn5I
	HNblMEglqQUgJMPxC+fLnfKn7BfLuakqEc+EouQjo9eANzqa9RKrdhk/7ZlTWf8T/VSiu1Tjj8I
	KaTPlt/PMAx1kbcN8B3XF+a7PhpVURjiBBhvOWgz7kbaa6PJ4xAcwPC7zXMKcqZigP58SCg2OdC
	iFxD+P8lnwgIH+1vj1cVCukv7IV+yYOHTFz2mtuyD+Z63+mxUBw1/AOzNqT25eoioagUkNkk9jB
	QJVdil1
X-Received: by 2002:a17:907:8b98:b0:b87:d09c:1825 with SMTP id a640c23a62f3a-b9d72792c0cmr382274666b.13.1775911946574;
        Sat, 11 Apr 2026 05:52:26 -0700 (PDT)
Received: from fedora (185-147-214-8.mad.as62651.net. [185.147.214.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9d6e7f1e87sm159883666b.61.2026.04.11.05.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 05:52:25 -0700 (PDT)
Date: Sat, 11 Apr 2026 20:52:00 +0800
From: Ming Lei <tom.leiming@gmail.com>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: Ming Lei <ming.lei@redhat.com>, axboe@kernel.dk, kbusch@kernel.org,
	hch@lst.de, sagi@grimberg.me, mst@redhat.com, aacraid@microsemi.com,
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
Message-ID: <adpD8M8cNu3IZzEL@fedora>
References: <20260401222312.772334-1-atomlin@atomlin.com>
 <20260401222312.772334-14-atomlin@atomlin.com>
 <ac8l-w8ERG1YN2Wm@fedora>
 <nxe24ixebb4lm2d5w4aubhtwr23df6mumqd663axj35oswdiyv@amtqhtsidyr4>
 <adMoon3Zf6gO-UbA@fedora>
 <zawhqvn53mcp4wf7axsmuq4cg73upxs5h2zgrfta5dpat3sfy4@zctfbz2ttz5m>
 <CAFj5m9JE5e4DRGbzQFxDdZWU76ZPQ3G+C9JpLu0mhTB6aesZ9g@mail.gmail.com>
 <a566smu6morqeefqal23eek4ibezfuiwhs774xtxhyyclpbtsx@uzzwgbzmwdjd>
 <adhj_w11cpMfeEgN@fedora>
 <dzpxscrhibmi5okkozf5jfull4dcajgpctldvdyfcjgmpeetk5@tkeyqouyabzy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dzpxscrhibmi5okkozf5jfull4dcajgpctldvdyfcjgmpeetk5@tkeyqouyabzy>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260411_055229_561941_F18CF7E8 
X-CRM114-Status: GOOD (  27.05  )
X-Mailman-Approved-At: Sun, 12 Apr 2026 08:03:19 -0700
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

On Fri, Apr 10, 2026 at 03:31:22PM -0400, Aaron Tomlin wrote:
> On Fri, Apr 10, 2026 at 10:44:15AM +0800, Ming Lei wrote:
> > For unmanaged interrupts, user can set irq affinity on housekeeping cpus
> > from /proc or kernel command line.
> > 
> > Why is unmanaged interrupts involved with this patchset?
> 
> Thank you for your continued engagement and for ultimately supporting the
> progression of this series.
> 
> To clarify the handling of unmanaged interrupts, while it is entirely true
> that an administrator could attempt to manually configure "irqaffinity=" or
> via procfs after the fact, this series actively address unmanaged interrupts.
> 
> > > CPUs, thereby breaking isolation. By applying the constraint via io_queue
> > > at the block layer, we restrict the hardware queue count and map the
> > > isolated CPUs to the housekeeping queues, ensuring isolation is maintained
> > > regardless of whether the driver uses managed interrupts.
> > > 
> > > Does the above help?
> > 
> > As I mentioned, managed irq already covers it:
> > 
> > - typically application submits IO from housekeeping CPUs, which is mapped
> >   to one hardware, which effective interrupt affinity excludes isolated
> >   CPUs if possible.
> > 
> > I'd suggest to share some real problems you found instead of something
> > imaginary.
> 
> If we trace how mpi3mr sets up its ISRs, it relies heavily on the core
> grouping logic:
> 
> mpi3mr_setup_isr
> {
>   unsigned int irq_flags = PCI_IRQ_MSIX
> 
>   struct irq_affinity desc = { .pre_vectors =  1, .post_vectors = 1, }
> 
>   pci_alloc_irq_vectors_affinity(mrioc->pdev, min_vec,
>                                  max_vectors, irq_flags, &desc)
>   {
>     if (flags & PCI_IRQ_MSIX) {
>       // affd != NULL
>       __pci_enable_msix_range(dev, NULL, min_vecs, max_vecs, affd, flags)
>       {
> 
>         for (;;) {
> 
>           msix_capability_init(dev, entries, nvec, affd)
>           {
>             msix_setup_interrupts(dev, entries, nvec, affd)
>             {
>               // affd
>               irq_create_affinity_masks(nvec, affd)
>               {
>                 for (i = 0, usedvecs = 0; i < affd->nr_sets; i++) {
>                   unsigned int nr_masks, this_vecs = affd->set_size[i]
>                   struct cpumask *result = group_cpus_evenly(this_vecs,
>                                                              &nr_masks)
>                   if (!result) {
>                     kfree(masks)
>                     return NULL
>                   }
> 
>                   for (int j = 0; j < nr_masks; j++)
>                     cpumask_copy(&masks[curvec + j].mask, &result[j])
>                   kfree(result);
> 
>                   curvec += nr_masks
>                   usedvecs += nr_masks
>                 }
>               }
>             }
>           }
>         }
>       }
>     }
>   }
> }
> 
> The critical issue lies at the invocation of group_cpus_evenly(). Without
> this patchset, the core logic lacks the necessary constraints to respect
> CPU isolation. It is entirely possible, and indeed happens in practice, for
> an isolated CPU to be assigned to a CPU mask group.

It is one bug report? No, because it doesn't show any trouble from user
viewpoint.

Sebastian explains/shows how "isolcpus=managed_irq" works perfectly in the
following link:

https://lore.kernel.org/all/20260401110232.ET5RxZfl@linutronix.de/

You have reviewed it...

What matters is that IO won't interrupt isolated CPU.

> 
> The newer implementation of irq_create_affinity_masks() introduced by this
> series resolves this. It considers the new CPU mask added to the IRQ
> affinity descriptor. When group_mask_cpus_evenly() is called, this mask is
> evaluated [1], guaranteeing that isolated CPUs are entirely excluded from
> the mask groups.
> 
> [1]: https://lore.kernel.org/lkml/20260401222312.772334-8-atomlin@atomlin.com/

Not at all.

isolated CPU is still included in each group's cpu mask, please see patch
9:

https://lore.kernel.org/linux-block/20260401222312.772334-1-atomlin@atomlin.com/T/#m59df0689ef144f5361535ce59c9ed5923d6e21d5



Thanks, 
Ming

