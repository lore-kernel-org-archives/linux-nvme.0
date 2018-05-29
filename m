From: snitzer@redhat.com (Mike Snitzer)
Date: Mon, 28 May 2018 23:02:36 -0400
Subject: [PATCH 0/3] Provide more fine grained control over multipathing
In-Reply-To: <yq1muwj45sg.fsf@oracle.com>
References: <20180525125322.15398-1-jthumshirn@suse.de>
 <20180525130535.GA24239@lst.de> <20180525135813.GB9591@redhat.com>
 <20180525141211.GA25971@lst.de> <20180525145056.GD9591@redhat.com>
 <yq1muwj45sg.fsf@oracle.com>
Message-ID: <20180529030236.GA28895@redhat.com>

On Mon, May 28 2018 at  9:19pm -0400,
Martin K. Petersen <martin.petersen@oracle.com> wrote:

> 
> Mike,
> 
> I understand and appreciate your position but I still don't think the
> arguments for enabling DM multipath are sufficiently compelling. The
> whole point of ANA is for things to be plug and play without any admin
> intervention whatsoever.
> 
> I also think we're getting ahead of ourselves a bit. The assumption
> seems to be that NVMe ANA devices are going to be broken--or that they
> will require the same amount of tweaking as SCSI devices--and therefore
> DM multipath support is inevitable. However, I'm not sure that will be
> the case.
> 
> > Thing is you really don't get to dictate that to the industry.  Sorry.
> 
> We are in the fortunate position of being able to influence how the spec
> is written. It's a great opportunity to fix the mistakes of the past in
> SCSI. And to encourage the industry to ship products that don't need the
> current level of manual configuration and complex management.
> 
> So I am in favor of Johannes' patches *if* we get to the point where a
> Plan B is needed. But I am not entirely convinced that's the case just
> yet. Let's see some more ANA devices first. And once we do, we are also
> in a position where we can put some pressure on the vendors to either
> amend the specification or fix their implementations to work with ANA.

ANA really isn't a motivating factor for whether or not to apply this
patch.  So no, I don't have any interest in waiting to apply it.

You're somehow missing that your implied "Plan A" (native NVMe
multipath) has been pushed as the only way forward for NVMe multipath
despite it being unproven.  Worse, literally no userspace infrastructure
exists to control native NVMe multipath (and this is supposed to be
comforting because the spec is tightly coupled to hch's implementation
that he controls with an iron fist).

We're supposed to be OK with completely _forced_ obsolescence of
dm-multipath infrastructure that has proven itself capable of managing a
wide range of complex multipath deployments for a tremendous amount of
enterprise Linux customers (of multiple vendors)!?  This is a tough sell
given the content of my previous paragraph (coupled with the fact the
next enterprise Linux versions are being hardened _now_).

No, what both Red Hat and SUSE are saying is: cool let's have a go at
"Plan A" but, in parallel, what harm is there in allowing "Plan B" (dm
multipath) to be conditionally enabled to coexist with native NVMe
multipath?

Nobody can explain why this patch is some sort of detriment.  It
literally is an amazingly simple switch that provides flexibility we
_need_.  hch had some non-specific concern about this patch forcing
support of some "ABI".  Which ABI is that _exactly_?

Mike
