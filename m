From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 14 Feb 2019 15:50:35 +0100 (CET)
Subject: [PATCH V4 2/4] genirq/affinity: add new callback for caculating
 interrupt sets size
In-Reply-To: <20190214122347.17372-3-ming.lei@redhat.com>
References: <20190214122347.17372-1-ming.lei@redhat.com>
 <20190214122347.17372-3-ming.lei@redhat.com>
Message-ID: <alpine.DEB.2.21.1902141547320.1561@nanos.tec.linutronix.de>

On Thu, 14 Feb 2019, Ming Lei wrote:
> +	if (affd->calc_sets) {
> +		affd->calc_sets(affd, nvecs);
> +	} else if (!affd->nr_sets) {
> +		affd->nr_sets = 1;
> +		affd->set_size[0] = affvecs;

Hrmpf. I suggested that to you to get rid of the nr_sets local variable,
but that's actually broken. The reason is that on the first invocation from
the pci code, which is with maxvecs usually, the size is stored and if that
allocation failed, the subsequent invocation with maxvecs - 1 will not
update set_size[0] because affd->nr_sets == 1.

/me scratches head and stares at the code some more...

Thanks,

	tglx
