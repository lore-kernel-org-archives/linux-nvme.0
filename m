From: jglisse@redhat.com (Jerome Glisse)
Date: Thu, 30 Aug 2018 15:20:12 -0400
Subject: [PATCH v5 00/13] Copy Offload in NVMe Fabrics with P2P PCI Memory
In-Reply-To: <20180830185352.3369-1-logang@deltatee.com>
References: <20180830185352.3369-1-logang@deltatee.com>
Message-ID: <20180830192012.GG3529@redhat.com>

On Thu, Aug 30, 2018@12:53:39PM -0600, Logan Gunthorpe wrote:

[...]

> 
> When the PCI P2PDMA config option is selected the ACS bits in every
> bridge port in the system are turned off to allow traffic to
> pass freely behind the root port. At this time, the bit must be disabled
> at boot so the IOMMU subsystem can correctly create the groups, though
> this could be addressed in the future. There is no way to dynamically
> disable the bit and alter the groups.

Can you provide an example on how to test this ? Like kernel command
line option, the doc patch does not have any such example. It would be
nice to add.

Maybe i have miss it in some of the patch. I just skimmed over for
now.

Cheers,
J?r?me
