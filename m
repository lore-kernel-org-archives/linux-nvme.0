From: bvanassche@acm.org (Bart Van Assche)
Date: Wed, 20 Mar 2019 08:28:06 -0700
Subject: [PATCH 0/9] RFC: NVME VFIO mediated device
In-Reply-To: <20190319144116.400-1-mlevitsk@redhat.com>
References: <20190319144116.400-1-mlevitsk@redhat.com>
Message-ID: <1553095686.65329.36.camel@acm.org>

On Tue, 2019-03-19@16:41 +0200, Maxim Levitsky wrote:
> *  All guest memory is mapped into the physical nvme device 
>    but not 1:1 as vfio-pci would do this.
>    This allows very efficient DMA.
>    To support this, patch 2 adds ability for a mdev device to listen on 
>    guest's memory map events. 
>    Any such memory is immediately pinned and then DMA mapped.
>    (Support for fabric drivers where this is not possible exits too,
>     in which case the fabric driver will do its own DMA mapping)

Does this mean that all guest memory is pinned all the time? If so, are you
sure that's acceptable?

Additionally, what is the performance overhead of the IOMMU notifier added
by patch 8/9? How often was that notifier called per second in your tests
and how much time was spent per call in the notifier callbacks?

Thanks,

Bart.
