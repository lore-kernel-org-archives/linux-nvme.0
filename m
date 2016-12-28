From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 28 Dec 2016 00:39:56 -0800
Subject: [PATCH v3 4/5] nvme: Implement resume_from_suspend and SED
 Allocation code.
In-Reply-To: <20161227221221.GA2902@sbauer-Z170X-UD5>
References: <1482176149-2257-1-git-send-email-scott.bauer@intel.com>
 <1482176149-2257-5-git-send-email-scott.bauer@intel.com>
 <3d8b8516-aac6-c11c-dbbb-47fc01308f8c@jbeekman.nl>
 <20161227221221.GA2902@sbauer-Z170X-UD5>
Message-ID: <20161228083955.GA2811@infradead.org>

> for OPAL. In order to determine if the controller supports opal we need to allocate
> the previously mentioned structures anyway. I want to stay away from making payloads
> (specifically discovery0 ) payload in the nvme driver and allow the opal core to do a
> all the grunt work. In the future we'll probably have to refactor the core a bit to do
> just packet generation. It looks like at least for NVMe we're going to have to do a discovery
> to figure out whether we've got mutiple locking ranges per NS or just one global lr during
> initialization.

We might have to do discovery in the nvme driver - there also is the
ATA security feature supported by various consumer drives.  Jethro has
been doing some work in that direction, although driven by userspace
for now. 
