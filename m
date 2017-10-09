From: keith.busch@intel.com (Keith Busch)
Date: Mon, 9 Oct 2017 16:14:14 -0600
Subject: Fwd: [Bug 196907] [Regression] New default s2idle does not work
 on Dell XPS 13 9360 with Ubuntu 16.04.3 LTS (Xenial Xerus)
In-Reply-To: <1636342.6qveo3Fvtu@aspire.rjw.lan>
References: <1636342.6qveo3Fvtu@aspire.rjw.lan>
Message-ID: <20171009221413.GE19329@localhost.localdomain>

On Mon, Oct 09, 2017@11:52:26PM +0200, Rafael J. Wysocki wrote:
> Hi,
> 
> We are seeing a resume issue with a Hynix SSD (PC300 NVMe SK hynix 512GB)
> with respect to suspend-to-idle (S3 resume works for the reporter,
> interestingly enough).  It appears to be limited to Hynix and to that
> specific SSD ATM.
> 
> Also it is reported to work in 4.11-rc1 and it already is failing in 4.13,
> so it looks like something between the two broke it.
> 
> Any ideas of what that might be?
> 
> Or anything we should try/test to narrow it down?
> 
> Any help will be appreciated.

I'd start with the APST feature and see if disabling that helps.
That can be done with the nvme_core module param:

  default_ps_max_latency_us=0
