From: logang@deltatee.com (Logan Gunthorpe)
Date: Sat, 15 Apr 2017 22:46:25 -0600
Subject: [RFC 0/8] Copy Offload with Peer-to-Peer PCI Memory
In-Reply-To: <1492311719.25766.37.camel@kernel.crashing.org>
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
Message-ID: <ccdcb41c-f734-a0d4-beaf-906262076fac@deltatee.com>



On 15/04/17 09:01 PM, Benjamin Herrenschmidt wrote:
> Are ZONE_DEVICE pages identifiable based on the struct page alone ? (a
> flag ?)

Well you can't use ZONE_DEVICE as an indicator. They may be regular RAM,
(eg. pmem). It would need a separate flag indicating it is backed by iomem.

Logan
