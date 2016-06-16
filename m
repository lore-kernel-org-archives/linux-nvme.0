From: bart.vanassche@sandisk.com (Bart Van Assche)
Date: Thu, 16 Jun 2016 11:08:48 +0200
Subject: [PATCH 02/13] irq: Introduce IRQD_AFFINITY_MANAGED flag
In-Reply-To: <1465934346-20648-3-git-send-email-hch@lst.de>
References: <1465934346-20648-1-git-send-email-hch@lst.de>
 <1465934346-20648-3-git-send-email-hch@lst.de>
Message-ID: <d368370a-1601-e127-4f61-458e6839fa28@sandisk.com>

On 06/14/2016 09:58 PM, Christoph Hellwig wrote:
> diff --git a/include/linux/irq.h b/include/linux/irq.h
> index 4d758a7..49d66d1 100644
> --- a/include/linux/irq.h
> +++ b/include/linux/irq.h
> @@ -197,6 +197,7 @@ struct irq_data {
>   * IRQD_IRQ_INPROGRESS		- In progress state of the interrupt
>   * IRQD_WAKEUP_ARMED		- Wakeup mode armed
>   * IRQD_FORWARDED_TO_VCPU	- The interrupt is forwarded to a VCPU
> + * IRQD_AFFINITY_MANAGED	- Affinity is managed automatically
>   */

Does "managed automatically" mean managed by software? If so, I think it 
would help to mention which software manages IRQ affinity if the 
IRQD_AFFINITY_MANAGED flag has been set.

Thanks,

Bart.
