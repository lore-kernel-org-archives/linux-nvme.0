From: hch@infradead.org (Christoph Hellwig)
Date: Sat, 25 Feb 2017 22:47:01 -0800
Subject: [PATCH 1/2] lightnvm: add generic ocssd detection
In-Reply-To: <8cce0bfd-a153-ba4e-0d84-bea29764982e@cnexlabs.com>
References: <20170224171649.27409-1-matias@cnexlabs.com>
 <20170225182117.GA26447@infradead.org>
 <8cce0bfd-a153-ba4e-0d84-bea29764982e@cnexlabs.com>
Message-ID: <20170226064701.GA7557@infradead.org>

[adding linux-nvme to Cc as the patch changes the nvme driver, despite
the subject line]

On Sat, Feb 25, 2017@08:16:04PM +0100, Matias Bj?rling wrote:
> On 02/25/2017 07:21 PM, Christoph Hellwig wrote:
> > On Fri, Feb 24, 2017@06:16:48PM +0100, Matias Bj?rling wrote:
> > > More implementations of OCSSDs are becoming available. Adding each using
> > > pci ids are becoming a hassle. Instead, use a 16 byte string in the
> > > vendor-specific area of the identification command to identify an
> > > Open-Channel SSD.
> > > 
> > > The large string should make the collision probability with other
> > > vendor-specific strings to be near nil.
> > 
> > No way in hell.  vs is vendor specific and we absolutely can't overload
> > it with any sort of meaning.  Get OCSSD support properly standardized and
> > add a class code for it.  Until then it's individual PCI IDs.
> > 
> 
> You are right, that is the right way to go, and we are working on it. In the
> meantime, there are a couple of reasons I want to do a pragmatic solution:

Reasonable reaosons, but that's just not how standard interfaces work.
Either you standardize the behaviour and have a standardized trigger
for it, or it is vendor specific and needs to be keyed off a specific
vendor/device identification.

> 1. Enabling open-channel SSDs on NVMeoF. Customers are asking to use OCSSDs
> with NVMoeF. I do not think detection of PCI ids works with that.

To use NVMoeF your protocol needs to be NVMe.  Get it standardized.

> 2. Some vendors are circumventing the OCSSD detection by utilizing the CNEX
> Labs PCI ids. That is not very helpful and shows that there is a need for a
> generic approach. When they become public and will use their PCI id (if they
> will do that...), it is cumbersome to backport their PCI ids back to
> previous kernel versions to detect support.

Sue them.

> 3. Things are not a technical issue for why this is not adopted today. It
> will be soon enough one way or another, but until then, a pragmatic approach
> would go a long way.

It's not a pragmatic approach, it's broken so please don't use these
whitewashing words.

> If identify VS is too specific, is there another combination that solves the
> above in a generic and practical way that would satisfy you and the above?

Standardize your interface and get a I/O command set bit for it
standardized in the NVMe spec.  You've had a year and a half since
the lightnvm code hit the kernel tree to do this.
