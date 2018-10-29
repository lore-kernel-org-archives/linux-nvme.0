From: hare@suse.de (Hannes Reinecke)
Date: Mon, 29 Oct 2018 08:43:21 +0100
Subject: [PATCH 11/14] irq: add support for allocating (and affinitizing)
 sets of IRQs
In-Reply-To: <20181025211626.12692-12-axboe@kernel.dk>
References: <20181025211626.12692-1-axboe@kernel.dk>
 <20181025211626.12692-12-axboe@kernel.dk>
Message-ID: <61ddcb9e-267d-ff36-dcec-70485ee3aa47@suse.de>

On 10/25/18 11:16 PM, Jens Axboe wrote:
> A driver may have a need to allocate multiple sets of MSI/MSI-X
> interrupts, and have them appropriately affinitized. Add support for
> defining a number of sets in the irq_affinity structure, of varying
> sizes, and get each set affinitized correctly across the machine.
> 
> Cc: Thomas Gleixner <tglx at linutronix.de>
> Cc: linux-kernel at vger.kernel.org
> Signed-off-by: Jens Axboe <axboe at kernel.dk>
> ---
>   include/linux/interrupt.h |  4 ++++
>   kernel/irq/affinity.c     | 31 +++++++++++++++++++++++++------
>   2 files changed, 29 insertions(+), 6 deletions(-)
> 

Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
