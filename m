From: kbusch@kernel.org (Keith Busch)
Date: Thu, 1 Aug 2019 14:22:51 -0600
Subject: [Regression] Commit "nvme/pci: Use host managed power state for
 suspend" has problems
In-Reply-To: <70D536BE-8DC7-4CA2-84A9-AFB067BA520E@canonical.com>
References: <20190730144134.GA12844@localhost.localdomain>
 <100ba4aff1c6434a81e47774ab4acddc@AUSX13MPC105.AMER.DELL.COM>
 <8246360B-F7D9-42EB-94FC-82995A769E28@canonical.com>
 <20190730191934.GD13948@localhost.localdomain>
 <7d3e0b8ba1444194a153c93faa1cabb3@AUSX13MPC105.AMER.DELL.COM>
 <20190730213114.GK13948@localhost.localdomain>
 <CAJZ5v0gxfeMN8eCNRjcXmUOkReVsdozb3EccaYMpnmSHu3771g@mail.gmail.com>
 <20190731221956.GB15795@localhost.localdomain>
 <CAJZ5v0hxYGBXau39sb80MQ8jbZZCzH0JU2DYZvn9JOtYT2+30g@mail.gmail.com>
 <70D536BE-8DC7-4CA2-84A9-AFB067BA520E@canonical.com>
Message-ID: <20190801202251.GD15795@localhost.localdomain>

On Thu, Aug 01, 2019@02:05:54AM -0700, Kai-Heng Feng wrote:
>@06:33, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > On Thu, Aug 1, 2019@12:22 AM Keith Busch <kbusch@kernel.org> wrote:
> >
> >> In which case we do need to reintroduce the HMB handling.
> >
> > Right.
> 
> The patch alone doesn?t break HMB Toshiba NVMe I tested. But I think it?s  
> still safer to do proper HMB handling.

Spec requires host request controller release HMB for D3cold. I suspect
you're only getting to D3hot.
