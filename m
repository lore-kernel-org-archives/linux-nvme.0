From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 14 Feb 2019 19:38:53 +0100 (CET)
Subject: [PATCH V4 1/4] genirq/affinity: store interrupt sets size in
 'struct irq_affinity'
In-Reply-To: <20190214122347.17372-2-ming.lei@redhat.com>
References: <20190214122347.17372-1-ming.lei@redhat.com>
 <20190214122347.17372-2-ming.lei@redhat.com>
Message-ID: <alpine.DEB.2.21.1902141937240.1646@nanos.tec.linutronix.de>

On Thu, 14 Feb 2019, Ming Lei wrote:
> The driver passes initial configuration for the interrupt allocation via
> a pointer to struct affinity_desc.

Btw, blindly copying a suggestion without proof reading is a bad idea. That
want's to be 'struct irq_affinity' obviously. Tired brain confused them
yesterday night.

Thanks,

	tglx
