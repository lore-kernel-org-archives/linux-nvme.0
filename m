From: kashyap.desai@broadcom.com (Kashyap Desai)
Date: Wed, 10 Jan 2018 15:02:15 +0530
Subject: [PATCH 13/14] megaraid_sas: NVME passthru command support
In-Reply-To: <20180109232305.GH15154@localhost.localdomain>
References: <1515159339-26790-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
 <20180108100531.GA6967@infradead.org>
 <35aabb7a8b8ffed4040c5ac01c01fb0a@mail.gmail.com>
 <20180109164540.GA11861@infradead.org>
 <27ebbe5f-e06b-a800-5518-ec63d65d142a@interlog.com>
 <20180109232305.GH15154@localhost.localdomain>
Message-ID: <e0eb55ccbcae2640530e43327a7b9aab@mail.gmail.com>

> -----Original Message-----
> From: Keith Busch [mailto:keith.busch at intel.com]
> Sent: Wednesday, January 10, 2018 4:53 AM
> To: Douglas Gilbert
> Cc: Christoph Hellwig; Kashyap Desai; Shivasharan Srikanteshwara; Sumit
> Saxena; Peter Rivera; linux-nvme at lists.infradead.org; linux-
> scsi at vger.kernel.org
> Subject: Re: [PATCH 13/14] megaraid_sas: NVME passthru command support
>
> On Tue, Jan 09, 2018@03:50:44PM -0500, Douglas Gilbert wrote:
> > Have you tried to do any serious work with <linux/nvme_ioctl.h> and
> > say compared it with FreeBSD and Microsoft's approach? No prize for
> > guessing which one is worst (and least extensible). Looks like the
> > Linux pass-through was at the end of a ToDo list and was "designed"
> > at 5 a.m in the morning.
>
> What the heck are you talking about? FreeBSD's NVMe passthrough is near
> identical to Linux, and Linux's existed years prior.
>
> You're not even touching the nvme subsystem, so why are you copying the
> linux-nvme mailing list to help you with a non-NVMe device? Please take
your
> ignorant and dubious claims elsewhere.

Keith -

As we discussed for mpt3sas driver NVME driver support, there was request
to add linux-nvme at lists.infradead.org for NVME related discussion.
https://marc.info/?l=linux-kernel&m=149874673729467&w=2

As you mentioned, we are not touching NVME subsystem, we can skip to add
NVME mailing list for future submission w.r.t NVME drive behind MR
(megaraid_sas) and HBA (mpt3sas).
All the NVME drives behind MegaRaid controller is SCSI device irrespective
of transport.

Kashyap
