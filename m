From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 7 Jun 2018 16:12:25 +0300
Subject: [PATCH 2/4] nvmet: ANA transition timeout handling
In-Reply-To: <20180607073556.39050-3-hare@suse.de>
References: <20180607073556.39050-1-hare@suse.de>
 <20180607073556.39050-3-hare@suse.de>
Message-ID: <fce82565-1975-2170-6257-a88729cd4419@grimberg.me>


> +	INIT_DELAYED_WORK(&ev->work, nvmet_ana_state_change_work);
> +	ev->port = port;
> +	ev->grpid = grpid;
> +	ev->state = state;
> +	mutex_lock(&port->anatt_list_lock);
> +	list_add_tail(&ev->entry, &port->anatt_list);
> +	mutex_unlock(&port->anatt_list_lock);
> +	/*
> +	 * Reduce the delay by 1 sec to not accidentally trigger an
> +	 * ANA transition timeout failure on the host.
> +	 */
> +	queue_delayed_work(nvmet_ana_wq, &ev->work,
> +			   (port->anatt - 1) * HZ);

hmm, what is that giving us?

> +}
> +
>   int nvmet_register_transport(const struct nvmet_fabrics_ops *ops)
>   {
>   	int ret = 0;
> @@ -276,11 +336,22 @@ int nvmet_enable_port(struct nvmet_port *port)
>   void nvmet_disable_port(struct nvmet_port *port)
>   {
>   	const struct nvmet_fabrics_ops *ops;
> +	struct nvmet_ana_change_event *ev, *tmp;
>   
>   	lockdep_assert_held(&nvmet_config_sem);
>   
>   	port->enabled = false;
>   
> +	mutex_lock(&port->anatt_list_lock);
> +	list_for_each_entry_safe(ev, tmp, &port->anatt_list, entry) {
> +		if (ev->port == port) {
> +			list_del_init(&ev->entry);
> +			cancel_delayed_work_sync(&ev->work);
> +			kfree(ev);

I'd splice to a local list and cancel+free outside the mutex.

> +		}
> +	}
> +	mutex_unlock(&port->anatt_list_lock);
> +
>   	ops = nvmet_transports[port->disc_addr.trtype];
>   	ops->remove_port(port);
>   	module_put(ops->owner);
> @@ -1162,6 +1233,11 @@ static int __init nvmet_init(void)
>   {
>   	int error;
>   
> +	nvmet_ana_wq = alloc_workqueue("nvmet_ana_wq",
> +			WQ_UNBOUND | WQ_MEM_RECLAIM | WQ_SYSFS, 0);
> +	if (!nvmet_ana_wq)
> +		return -ENOMEM;
> +

Why a dedicated workqueue? and why a mem reclaim one?

whats wrong with system_wq/system_unbound_wq/system_long_wq?
