From: keith.busch@intel.com (Keith Busch)
Date: Mon, 27 Feb 2017 13:50:17 -0500
Subject: [PATCH 1/2] lightnvm: add generic ocssd detection
In-Reply-To: <108882ac-9f55-e4f5-c04e-244848139db8@grimberg.me>
References: <20170224171649.27409-1-matias@cnexlabs.com>
 <20170225182117.GA26447@infradead.org>
 <8cce0bfd-a153-ba4e-0d84-bea29764982e@cnexlabs.com>
 <20170226064701.GA7557@infradead.org>
 <108882ac-9f55-e4f5-c04e-244848139db8@grimberg.me>
Message-ID: <20170227185016.GC5789@localhost.localdomain>

On Mon, Feb 27, 2017@08:35:06PM +0200, Sagi Grimberg wrote:
> > On Sat, Feb 25, 2017@08:16:04PM +0100, Matias Bj?rling wrote:
> > > On 02/25/2017 07:21 PM, Christoph Hellwig wrote:
> > > > No way in hell.  vs is vendor specific and we absolutely can't overload
> > > > it with any sort of meaning.  Get OCSSD support properly standardized and
> > > > add a class code for it.  Until then it's individual PCI IDs.
> > > > 
> > > 
> > > You are right, that is the right way to go, and we are working on it. In the
> > > meantime, there are a couple of reasons I want to do a pragmatic solution:
> > 
> > Reasonable reaosons, but that's just not how standard interfaces work.
> > Either you standardize the behaviour and have a standardized trigger
> > for it, or it is vendor specific and needs to be keyed off a specific
> > vendor/device identification.
> 
> I agree, I don't see how we're allowed to use vs for that.

>From personal experience, some OEMs will put whatever they want in the
VS region for their rebranded device, making it an unreliable place to
check for a capability.
