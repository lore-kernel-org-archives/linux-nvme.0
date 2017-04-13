From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Thu, 13 Apr 2017 04:47:03 +0200
Subject: kmemleak complaints in nvme PM
In-Reply-To: <CALCETrURYPsHZOfpey33vm-9HHLTBQqjti8YCXLkJJHs5nXByQ@mail.gmail.com>
References: <006f3319-0cd8-9d47-95cd-454b775a9b04@grimberg.me>
 <20170412172939.GE8639@lst.de>
 <CALCETrURYPsHZOfpey33vm-9HHLTBQqjti8YCXLkJJHs5nXByQ@mail.gmail.com>
Message-ID: <3179162.n86QkeM4IM@aspire.rjw.lan>

On Wednesday, April 12, 2017 10:42:51 AM Andy Lutomirski wrote:
> On Wed, Apr 12, 2017@10:29 AM, Christoph Hellwig <hch@lst.de> wrote:
> > On Sun, Apr 09, 2017@03:47:35PM +0300, Sagi Grimberg wrote:
> >> Hi folks,
> >>
> >> I got this kmemleak complaint [1] on nvme-loop (but I'm pretty
> >> confident it should happen with any nvme transport).
> >>
> >> Initial code stare tells me that
> >> dev_pm_qos_update_user_latency_tolerance() can (and usually will
> >> in controller initializaion) allocate a dev_pm_qos_request, but I
> >> didn't see a pairing free of that request.
> >>
> >> I'll try to find some time looking into it, but thought it might
> >> be a good idea to throw it out here in the mean time...
> >
> > Seems like the only way to free dev->power.qos->latency_tolerance_req
> > is to call dev_pm_qos_update_user_latency_tolerance with a negative
> > val argument.  What an odd API..
> 
> Greg and/or Rafael, what's the right way to fix this?  I would imagine
> that the driver core should free pm_qos requests when the device goes
> away, no?

Yes, it should.

Thanks,
Rafael
