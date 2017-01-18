From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Wed, 18 Jan 2017 11:11:12 +0100
Subject: [PATCH 03/17] lpfc: NVME Initiator: Base modifications Part B
In-Reply-To: <587ec2ee.01djIfQsSlhQj6k1%jsmart2021@gmail.com>
References: <587ec2ee.01djIfQsSlhQj6k1%jsmart2021@gmail.com>
Message-ID: <20170118101112.GC3514@linux-x5ow.site>

On Tue, Jan 17, 2017@05:20:46PM -0800, James Smart wrote:
> 
> NVME Initiator: Base modifications
> 
> This is part B of parts A..F.
> 
> Part B is limited to lpfc_attr.c: lpfc attribute modifications
> 
> *********
> 
> Refer to Part A for a description of base modifications
> 
> Signed-off-by: Dick Kennedy <dick.kennedy at broadcom.com>
> Signed-off-by: James Smart <james.smart at broadcom.com>
> ---

[...]

> +	len += snprintf(buf + len, PAGE_SIZE - len,
> +			"%s%d WWPN x%llx WWNN x%llx DID x%06x %s\n",
> +			"NVME LPORT lpfc",

Is it the lack of coffee or should it be 
			"NVME LPORT lpfc%d WWPN x%llx WWNN x%llx DID x%06x %s\n"

I think you're doing it to not hit the 80 chars limit, but then there are
way more offenders than that one, so...


> +			phba->brd_no,
> +			wwn_to_u64(vport->fc_portname.u.wwn),
> +			wwn_to_u64(vport->fc_nodename.u.wwn),
> +			localport->port_id, statep);

[...]

> +int
> +lpfc_emptyq_wait(struct lpfc_hba *phba, struct list_head *q, spinlock_t *lock)
> +{
> +	int cnt = 0;
> +
> +	spin_lock_irq(lock);
> +	while (!list_empty(q)) {
> +		spin_unlock_irq(lock);
> +		msleep(20);
> +		if (cnt++ > 250) {  /* 5 secs */
> +			lpfc_printf_log(phba, KERN_WARNING, LOG_INIT,
> +					"0466 %s %s\n",
> +					"Outstanding IO when ",
> +					"bringing Adapter offline\n");
> +				return 0;
> +		}
> +		spin_lock_irq(lock);
> +	}
> +	spin_unlock_irq(lock);
> +	return 1;
> +}
> +

Aren't you using lpc_emptyq_wait() in patches prior to that already? This
breaks git bisect. Pleas test-build (ideally + checkpatch and sparse/smatch)
each patch in the series individually.

[...]

Thanks,
	Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
