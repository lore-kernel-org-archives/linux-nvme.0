From: rafael@kernel.org (Rafael J. Wysocki)
Date: Thu, 1 Aug 2019 19:29:36 +0200
Subject: [Regression] Commit "nvme/pci: Use host managed power state for
 suspend" has problems
In-Reply-To: <70D536BE-8DC7-4CA2-84A9-AFB067BA520E@canonical.com>
References: <4323ed84dd07474eab65699b4d007aaf@AUSX13MPC105.AMER.DELL.COM>
 <CAJZ5v0iDQ4=kTUgW94tKGt7oJzA_3uVU_M6HAMbNCRXwp_do8A@mail.gmail.com>
 <47415939.KV5G6iaeJG@kreacher> <20190730144134.GA12844@localhost.localdomain>
 <100ba4aff1c6434a81e47774ab4acddc@AUSX13MPC105.AMER.DELL.COM>
 <8246360B-F7D9-42EB-94FC-82995A769E28@canonical.com>
 <20190730191934.GD13948@localhost.localdomain>
 <7d3e0b8ba1444194a153c93faa1cabb3@AUSX13MPC105.AMER.DELL.COM>
 <20190730213114.GK13948@localhost.localdomain>
 <CAJZ5v0gxfeMN8eCNRjcXmUOkReVsdozb3EccaYMpnmSHu3771g@mail.gmail.com>
 <20190731221956.GB15795@localhost.localdomain>
 <CAJZ5v0hxYGBXau39sb80MQ8jbZZCzH0JU2DYZvn9JOtYT2+30g@mail.gmail.com>
 <70D536BE-8DC7-4CA2-84A9-AFB067BA520E@canonical.com>
Message-ID: <CAJZ5v0hFYEv_+vFkrxaCn_pNAbyqmO_cLb5GOLNn_xxRRwjh2g@mail.gmail.com>

On Thu, Aug 1, 2019 at 11:06 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
>@06:33, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> > On Thu, Aug 1, 2019@12:22 AM Keith Busch <kbusch@kernel.org> wrote:
> >> On Wed, Jul 31, 2019@11:25:51PM +0200, Rafael J. Wysocki wrote:
> >>> A couple of remarks if you will.
> >>>
> >>> First, we don't know which case is the majority at this point.  For
> >>> now, there is one example of each, but it may very well turn out that
> >>> the SK Hynix BC501 above needs to be quirked.
> >>>
> >>> Second, the reference here really is 5.2, so if there are any systems
> >>> that are not better off with 5.3-rc than they were with 5.2, well, we
> >>> have not made progress.  However, if there are systems that are worse
> >>> off with 5.3, that's bad.  In the face of the latest findings the only
> >>> way to avoid that is to be backwards compatible with 5.2 and that's
> >>> where my patch is going.  That cannot be achieved by quirking all
> >>> cases that are reported as "bad", because there still may be
> >>> unreported ones.
> >>
> >> I have to agree. I think your proposal may allow PCI D3cold,
> >
> > Yes, it may.
>
> Somehow the 9380 with Toshiba NVMe never hits SLP_S0 with or without
> Rafael?s patch.
> But the ?real? s2idle power consumption does improve with the patch.

Do you mean this patch:

https://lore.kernel.org/linux-pm/70D536BE-8DC7-4CA2-84A9-AFB067BA520E at canonical.com/T/#m456aa5c69973a3b68f2cdd4713a1ce83be51458f

or the $subject one without the above?

> Can we use a DMI based quirk for this platform? It seems like a platform
> specific issue.

We seem to see too many "platform-specific issues" here. :-)

To me, the status quo (ie. what we have in 5.3-rc2) is not defensible.
Something needs to be done to improve the situation.

> >
> >> In which case we do need to reintroduce the HMB handling.
> >
> > Right.
>
> The patch alone doesn?t break HMB Toshiba NVMe I tested. But I think it?s
> still safer to do proper HMB handling.

Well, so can anyone please propose something specific?  Like an
alternative patch?
