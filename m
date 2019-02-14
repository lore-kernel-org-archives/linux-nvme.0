From: helgaas@kernel.org (Bjorn Helgaas)
Date: Thu, 14 Feb 2019 14:14:41 -0600
Subject: [PATCH V4 2/4] genirq/affinity: add new callback for caculating
 interrupt sets size
In-Reply-To: <20190214122347.17372-3-ming.lei@redhat.com>
References: <20190214122347.17372-1-ming.lei@redhat.com>
 <20190214122347.17372-3-ming.lei@redhat.com>
Message-ID: <20190214201441.GM96272@google.com>

On Thu, Feb 14, 2019@08:23:45PM +0800, Ming Lei wrote:
> The interrupt affinity spreading mechanism supports to spread out
> affinities for one or more interrupt sets. A interrupt set contains one
> or more interrupts. Each set is mapped to a specific functionality of a
> device, e.g. general I/O queues and read I/O queus of multiqueue block
> devices.
> 
> The number of interrupts per set is defined by the driver. It depends on
> the total number of available interrupts for the device, which is
> determined by the PCI capabilites and the availability of underlying CPU
> resources, and the number of queues which the device provides and the
> driver wants to instantiate.
> 
> The driver passes initial configuration for the interrupt allocation via
> a pointer to struct affinity_desc.
> 
> Right now the allocation mechanism is complex as it requires to have a
> loop in the driver to determine the maximum number of interrupts which
> are provided by the PCI capabilities and the underlying CPU resources.
> This loop would have to be replicated in every driver which wants to
> utilize this mechanism. That's unwanted code duplication and error
> prone.
> 
> In order to move this into generic facilities it is required to have a
> mechanism, which allows the recalculation of the interrupt sets and
> their size, in the core code. As the core code does not have any
> knowledge about the underlying device, a driver specific callback will
> be added to struct affinity_desc, which will be invoked by the core
> code. The callback will get the number of available interupts as an
> argument, so the driver can calculate the corresponding number and size
> of interrupt sets.
> 
> To support this, two modifications for the handling of struct
> affinity_desc are required:
> 
> 1) The (optional) interrupt sets size information is contained in a
>    separate array of integers and struct affinity_desc contains a
>    pointer to it.
> 
>    This is cumbersome and as the maximum number of interrupt sets is
>    small, there is no reason to have separate storage. Moving the size
>    array into struct affinity_desc avoids indirections makes the code
>    simpler.
> 
> 2) At the moment the struct affinity_desc pointer which is handed in from
>    the driver and passed through to several core functions is marked
>    'const'.
> 
> This patch adds callback to recalculate the number and size of interrupt sets,
> also removes the 'const' qualifier for 'affd'.
> 
> Reviewed-by: Jens Axboe <axboe at kernel.dk>
> Signed-off-by: Ming Lei <ming.lei at redhat.com>

I know you have something to work out in the affinity.c part of this, but
I'm fine with the PCI part, so:

Acked-by: Bjorn Helgaas <bhelgaas at google.com>
