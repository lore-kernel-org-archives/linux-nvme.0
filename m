From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 11 Oct 2017 13:14:09 +0300
Subject: [PATCH v2 4/7] nvme_fc: add dev_loss_tmo to controller
In-Reply-To: <20170927045046.22238-5-jsmart2021@gmail.com>
References: <20170927045046.22238-1-jsmart2021@gmail.com>
 <20170927045046.22238-5-jsmart2021@gmail.com>
Message-ID: <b9a80a06-e5f2-c15f-1155-26c3fa071142@grimberg.me>

> +static void
> +nvme_fc_set_ctrl_devloss(struct nvme_fc_ctrl *ctrl,
> +		struct nvmf_ctrl_options *opts)
> +{
> +	u32 dev_loss_tmo;
> +
> +	/*
> +	 * dev_loss_tmo will be the max amount of time after an association
> +	 * failure that will be allowed for a new association to be
> +	 * established. It doesn't matter why the original association
> +	 * failed (FC connectivity loss, transport error, admin-request).
> +	 * The new association must be established before dev_loss_tmo
> +	 * expires or the controller will be torn down.
> +	 *
> +	 * If the connect parameters are less than the FC port dev_loss_tmo
> +	 * parameter, scale dev_loss_tmo to the connect parameters.
> +	 *
> +	 * If the connect parameters are larger than the FC port
> +	 * dev_loss_tmo parameter, adjust the connect parameters so that
> +	 * there is at least 1 attempt at a reconnect attempt before failing.
> +	 * Note: reconnects will be attempted only if there is FC connectivity.
> +	 */

OK now I see where you are accounting for fabrics ctrl_loss_tmo, but
given that we have a default, what is the use for your private FC port
default?
