From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 13 Jun 2018 04:33:25 -0700
Subject: [PATCH v3 4/4] nvme_fc: add 'nvme_discovery' sysfs attribute to
 fc transport device
In-Reply-To: <20180612235028.17969-5-jsmart2021@gmail.com>
References: <20180612235028.17969-1-jsmart2021@gmail.com>
 <20180612235028.17969-5-jsmart2021@gmail.com>
Message-ID: <20180613113325.GD18531@infradead.org>

On Tue, Jun 12, 2018@04:50:28PM -0700, James Smart wrote:
> The fc transport device should allow for a rediscovery, as userspace
> might have lost the events. Example is udev events not handled during
> system startup.

Please stop adding hacks for your non-standard discovery methods.

> +static void nvme_fc_discovery_unwind(struct list_head *lheadp)
> +{
> +	unsigned long flags;
> +	struct nvme_fc_lport *lport;
> +	struct nvme_fc_rport *rport, *tmp_rport;
> +
> +	list_for_each_entry_safe(rport, tmp_rport,
> +				 lheadp, disc_list) {
> +		spin_lock_irqsave(&nvme_fc_lock, flags);
> +		list_del_init(&rport->disc_list);
> +		spin_unlock_irqrestore(&nvme_fc_lock, flags);

Without the lock taken around the list iteration this is racy.
