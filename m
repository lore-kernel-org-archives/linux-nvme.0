From: james.smart@broadcom.com (James Smart)
Date: Fri, 1 Dec 2017 08:21:50 -0800
Subject: [PATCHv2] nvme/fc: add 'discovery' sysfs attribute to fc
 transport device
In-Reply-To: <1512120436-58685-1-git-send-email-hare@suse.de>
References: <1512120436-58685-1-git-send-email-hare@suse.de>
Message-ID: <aa2b156b-7fa0-dc0d-4885-7ac4b4dd9842@broadcom.com>

On 12/1/2017 1:27 AM, Hannes Reinecke wrote:
> +	spin_lock_irqsave(&nvme_fc_lock, flags);
> +	list_for_each_entry(lport, &nvme_fc_lport_list, port_list) {
> +		list_for_each_entry(rport, &lport->endp_list, endp_list) {
> +			if (!nvme_fc_lport_get(lport))
> +				continue;
> +			if (!nvme_fc_rport_get(rport))
> +				continue;

ref counting messed up if rport_get fails - need to back out the lport get.

-- james
