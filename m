From: sbates@raithlin.com (Stephen  Bates)
Date: Tue, 25 Apr 2017 21:23:31 +0000
Subject: [RFC 0/8] Copy Offload with Peer-to-Peer PCI Memory
In-Reply-To: <1493019397.3171.118.camel@oracle.com>
References: <1490911959-5146-1-git-send-email-logang@deltatee.com>
 <1491974532.7236.43.camel@kernel.crashing.org>
 <5ac22496-56ec-025d-f153-140001d2a7f9@deltatee.com>
 <1492034124.7236.77.camel@kernel.crashing.org>
 <81888a1e-eb0d-cbbc-dc66-0a09c32e4ea2@deltatee.com>
 <20170413232631.GB24910@bhelgaas-glaptop.roam.corp.google.com>
 <20170414041656.GA30694@obsidianresearch.com>
 <1492169849.25766.3.camel@kernel.crashing.org>
 <630c1c63-ff17-1116-e069-2b8f93e50fa2@deltatee.com>
 <20170414190452.GA15679@bhelgaas-glaptop.roam.corp.google.com>
 <1492207643.25766.18.camel@kernel.crashing.org>
 <bff1e503-95a9-e19f-bfd9-0ff962c63a81@deltatee.com>
 <CAPcyv4jUeKzKDARp6Z35kdPLKnP-M6aF8X5KpOx55CLyjnj4dA@mail.gmail.com>
 <1492311719.25766.37.camel@kernel.crashing.org>
 <CAPcyv4iqnz1B00Q3xG-nGrLXdOyB7ditxmwZyotksLFgUqr+jA@mail.gmail.com>
 <5e43818e-8c6b-8be8-23ff-b798633d2a73@deltatee.com>
 <1492381907.25766.49.camel@kernel.crashing.org>
 <1493019397.3171.118.camel@oracle.com>
Message-ID: <705B114E-A084-4C0C-84BD-47E752FEE198@raithlin.com>


> My first reflex when reading this thread was to think that this whole domain
> lends it self excellently to testing via Qemu. Could it be that doing this in 
> the opposite direction might be a safer approach in the long run even though 
> (significant) more work up-front?

While the idea of QEMU for this work is attractive it will be a long time before QEMU is in a position to support this development. 

Another approach is to propose a common development platform for p2pmem work using a platform we know is going to work. This an extreme version of the whitelisting approach that was discussed on this thread. We can list a very specific set of hardware (motherboard, PCIe end-points and (possibly) PCIe switch enclosure) that has been shown to work that others can copy for their development purposes.

p2pmem.io perhaps ;-)?

Stephen
