From: alex.williamson@redhat.com (Alex Williamson)
Date: Mon, 23 Jul 2018 19:57:11 -0600
Subject: [PATCH v2 2/2] PCI: NVMe device specific reset quirk
In-Reply-To: <abc86e6b-7df5-a84c-7e98-107c605812c6@kernel.org>
References: <20180724000944.7671.64284.stgit@gimli.home>
 <20180724001310.7671.41243.stgit@gimli.home>
 <abc86e6b-7df5-a84c-7e98-107c605812c6@kernel.org>
Message-ID: <20180723195711.0a3c9301@t450s.home>

On Mon, 23 Jul 2018 17:40:02 -0700
Sinan Kaya <okaya@kernel.org> wrote:

> On 7/23/2018 5:13 PM, Alex Williamson wrote:
> > + * The NVMe specification requires that controllers support PCIe FLR, but
> > + * but some Samsung SM961/PM961 controllers fail to recover after FLR (-1
> > + * config space) unless the device is quiesced prior to FLR.  
> 
> Does disabling the memory bit in PCI config space as part of the FLR 
> reset function help? (like the very first thing)

No, it does not.  I modified this to only clear PCI_COMMAND_MEMORY and
call pcie_flr(), the Samsung controller dies just as it did previously.
 
> Can we do that in the pcie_flr() function to cover other endpoint types
> that might be pushing traffic while code is trying to do a reset?

Do you mean PCI_COMMAND_MASTER rather than PCI_COMMAND_MEMORY?  I tried
that too, it doesn't work either.  I'm not really sure the theory
behind clearing memory, clearing busmaster to stop DMA seems like a
sane thing to do, but doesn't help here.  Thanks,

Alex
