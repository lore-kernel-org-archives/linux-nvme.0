From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Tue, 10 Oct 2017 00:01:33 +0200
Subject: Fwd: [Bug 196907] [Regression] New default s2idle does not work
 on Dell XPS 13 9360 with Ubuntu 16.04.3 LTS (Xenial Xerus)
In-Reply-To: <20171009221413.GE19329@localhost.localdomain>
References: <1636342.6qveo3Fvtu@aspire.rjw.lan>
 <20171009221413.GE19329@localhost.localdomain>
Message-ID: <5479293.9hsiVanX3S@aspire.rjw.lan>

On Tuesday, October 10, 2017 12:14:14 AM CEST Keith Busch wrote:
> On Mon, Oct 09, 2017@11:52:26PM +0200, Rafael J. Wysocki wrote:
> > Hi,
> > 
> > We are seeing a resume issue with a Hynix SSD (PC300 NVMe SK hynix 512GB)
> > with respect to suspend-to-idle (S3 resume works for the reporter,
> > interestingly enough).  It appears to be limited to Hynix and to that
> > specific SSD ATM.
> > 
> > Also it is reported to work in 4.11-rc1 and it already is failing in 4.13,
> > so it looks like something between the two broke it.
> > 
> > Any ideas of what that might be?
> > 
> > Or anything we should try/test to narrow it down?
> > 
> > Any help will be appreciated.
> 
> I'd start with the APST feature and see if disabling that helps.
> That can be done with the nvme_core module param:
> 
>   default_ps_max_latency_us=0
> 

We've tried that and it doesn't help.
