From: sbates@raithlin.com (Stephen  Bates)
Date: Tue, 25 Apr 2017 21:23:30 +0000
Subject: [RFC 0/8] Copy Offload with Peer-to-Peer PCI Memory
In-Reply-To: <0cc95df5-b9dd-6493-15fe-771d535c1020@deltatee.com>
References: <1490911959-5146-1-git-send-email-logang@deltatee.com>
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
 <9b6c0830-a728-c7ca-e6c6-2135f3f760ed@deltatee.com>
 <1493101803.3171.246.camel@oracle.com>
 <0cc95df5-b9dd-6493-15fe-771d535c1020@deltatee.com>
Message-ID: <B5A68214-E3A6-45F6-9820-758C5C84688A@raithlin.com>

>> Yes, that's why I used 'significant'. One good thing is that given resources 
>> it can easily be done in parallel with other development, and will give additional
>> insight of some form.
>
>Yup, well if someone wants to start working on an emulated RDMA device
>that actually simulates proper DMA transfers that would be great!

Give that each RDMA vendor?s devices expose a different MMIO I don?t expect this to happen anytime soon.

> Yes, the nvme device in qemu has a CMB buffer which is a good choice to
> test with but we don't have code to use it for p2p transfers in the
>kernel so it is a bit awkward.

Note the CMB code is not in upstream QEMU, it?s in Keith?s fork [1]. I will see if I can push this upstream.

Stephen

[1] git://git.infradead.org/users/kbusch/qemu-nvme.git
