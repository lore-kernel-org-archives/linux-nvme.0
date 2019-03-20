From: alex.williamson@redhat.com (Alex Williamson)
Date: Wed, 20 Mar 2019 11:03:25 -0600
Subject: [PATCH 0/9] RFC: NVME VFIO mediated device
In-Reply-To: <8994f43d26ebf6040b9d5d5e3866ee81abcf1a1c.camel@redhat.com>
References: <20190319144116.400-1-mlevitsk@redhat.com>
 <1553095686.65329.36.camel@acm.org>
 <8994f43d26ebf6040b9d5d5e3866ee81abcf1a1c.camel@redhat.com>
Message-ID: <20190320110325.465c1dff@x1.home>

On Wed, 20 Mar 2019 18:42:02 +0200
Maxim Levitsky <mlevitsk@redhat.com> wrote:

> On Wed, 2019-03-20@08:28 -0700, Bart Van Assche wrote:
> > On Tue, 2019-03-19 at 16:41 +0200, Maxim Levitsky wrote:  
> > > *  All guest memory is mapped into the physical nvme device 
> > >    but not 1:1 as vfio-pci would do this.
> > >    This allows very efficient DMA.
> > >    To support this, patch 2 adds ability for a mdev device to listen on 
> > >    guest's memory map events. 
> > >    Any such memory is immediately pinned and then DMA mapped.
> > >    (Support for fabric drivers where this is not possible exits too,
> > >     in which case the fabric driver will do its own DMA mapping)  
> > 
> > Does this mean that all guest memory is pinned all the time? If so, are you
> > sure that's acceptable?  
> I think so. The VFIO pci passthrough also pins all the guest memory.
> SPDK also does this (pins and dma maps) all the guest memory.
> 
> I agree that this is not an ideal solution but this is a fastest and simplest
> solution possible.

FWIW, the pinned memory request up through the vfio iommu driver count
against the user's locked memory limits, if that's the concern.  Thanks,

Alex
