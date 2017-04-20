From: sbates@raithlin.com (Stephen  Bates)
Date: Thu, 20 Apr 2017 20:43:47 +0000
Subject: [RFC 0/8] Copy Offload with Peer-to-Peer PCI Memory
In-Reply-To: <CAPcyv4gxBgVsbSez7_dZYkZojUWU0X0txs7FxiJ+Z3xsMt6TqQ@mail.gmail.com>
References: <20170418164557.GA7181@obsidianresearch.com>
 <cce00131-1f28-27b3-40ab-04f8783f1e5a@deltatee.com>
 <20170418190138.GH7181@obsidianresearch.com>
 <df1351d8-b86c-2e21-1948-4688ece5dc2b@deltatee.com>
 <CAPcyv4gScx6A7vG9VEHpNF41GOy1Nxst7QQ3QC3uZ54bWoxbMg@mail.gmail.com>
 <20170418210339.GA24257@obsidianresearch.com>
 <1492564806.25766.124.camel@kernel.crashing.org>
 <20170419155557.GA8497@obsidianresearch.com>
 <4899b011-bdfb-18d8-ef00-33a1516216a6@deltatee.com>
 <CAPcyv4iJ9H8Ykwnjqa2R_D1qG6PsSQmi=QxYH-rKLF_ihrsWyw@mail.gmail.com>
 <20170419173225.GA11255@redhat.com>
 <CAPcyv4gxBgVsbSez7_dZYkZojUWU0X0txs7FxiJ+Z3xsMt6TqQ@mail.gmail.com>
Message-ID: <D79A59A8-DC7E-413F-ABB8-05F373A9DFD4@raithlin.com>


> Yes, this makes sense I think we really just want to distinguish host
> memory or not in terms of the dev_pagemap type.

I would like to see mutually exclusive flags for host memory (or not) and persistence (or not).

Stephen
