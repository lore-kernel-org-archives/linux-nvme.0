From: kbusch@kernel.org (Keith Busch)
Date: Tue, 19 Mar 2019 09:22:13 -0600
Subject: your mail
In-Reply-To: <20190319144116.400-1-mlevitsk@redhat.com>
References: <20190319144116.400-1-mlevitsk@redhat.com>
Message-ID: <20190319152212.GC24176@localhost.localdomain>

On Tue, Mar 19, 2019@04:41:07PM +0200, Maxim Levitsky wrote:
>   -> Share the NVMe device between host and guest. 
>      Even in fully virtualized configurations,
>      some partitions of nvme device could be used by guests as block devices 
>      while others passed through with nvme-mdev to achieve balance between
>      all features of full IO stack emulation and performance.
>   
>   -> NVME-MDEV is a bit faster due to the fact that in-kernel driver 
>      can send interrupts to the guest directly without a context 
>      switch that can be expensive due to meltdown mitigation.
> 
>   -> Is able to utilize interrupts to get reasonable performance. 
>      This is only implemented
>      as a proof of concept and not included in the patches, 
>      but interrupt driven mode shows reasonable performance
>      
>   -> This is a framework that later can be used to support NVMe devices 
>      with more of the IO virtualization built-in 
>      (IOMMU with PASID support coupled with device that supports it)

Would be very interested to see the PASID support. You wouldn't even
need to mediate the IO doorbells or translations if assigning entire
namespaces, and should be much faster than the shadow doorbells.

I think you should send 6/9 "nvme/pci: init shadow doorbell after each
reset" separately for immediate inclusion.

I like the idea in principle, but it will take me a little time to get
through reviewing your implementation. I would have guessed we could
have leveraged something from the existing nvme/target for the mediating
controller register access and admin commands. Maybe even start with
implementing an nvme passthrough namespace target type (we currently
have block and file).
