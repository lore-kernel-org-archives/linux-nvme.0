From: sbates@raithlin.com (Stephen  Bates)
Date: Thu, 20 Apr 2017 23:07:06 +0000
Subject: [RFC 0/8] Copy Offload with Peer-to-Peer PCI Memory
In-Reply-To: <CAPcyv4i+a_14E58SjFHncyq2O2-zf_PB=aT7k0a-Jc0XsfPapQ@mail.gmail.com>
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
 <D79A59A8-DC7E-413F-ABB8-05F373A9DFD4@raithlin.com>
 <CAPcyv4i+a_14E58SjFHncyq2O2-zf_PB=aT7k0a-Jc0XsfPapQ@mail.gmail.com>
Message-ID: <D090F830-2753-4479-A291-CEE37DC0A853@raithlin.com>

>> Yes, this makes sense I think we really just want to distinguish host
>> memory or not in terms of the dev_pagemap type.
>
>> I would like to see mutually exclusive flags for host memory (or not) and persistence (or not).
>>
>
> Why persistence? It has zero meaning to the mm.

I like the idea of having properties of the memory in one place. While mm might not use persistence today it may make use certain things that persistence implies (like finite endurance and/or higher write latency) in the future. Also the persistence of the memory must have issues for mm security? Again not addressed today but useful in the future.

In addition I am not sure where else would be an appropriate place to put something like a persistence property flag. I know the NVDIMM section of the kernel uses things like NFIT to describe properties of the memory but we don?t yet (to my knowledge) have something similar for IO memory.

Stephen
