From: maxg@mellanox.com (Max Gurtovoy)
Date: Mon, 5 Dec 2016 16:15:21 +0200
Subject: [PATCH 3/3] nvme: Make controller state visible via sysfs
In-Reply-To: <1480936146-6406-4-git-send-email-sagi@grimberg.me>
References: <1480936146-6406-1-git-send-email-sagi@grimberg.me>
 <1480936146-6406-4-git-send-email-sagi@grimberg.me>
Message-ID: <06f399ae-4483-2790-878e-08bfc04bea4b@mellanox.com>

Sagi,
what about locking the "ctrl->lock" and making it more up-to-date ?

On 12/5/2016 1:09 PM, Sagi Grimberg wrote:
> Easier for debugging and testing state machine
> transitions.
>
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>  drivers/nvme/host/core.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index a37cb215652b..c5b8f7b56042 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1569,6 +1569,26 @@ static ssize_t nvme_sysfs_show_transport(struct device *dev,
>  }
>  static DEVICE_ATTR(transport, S_IRUGO, nvme_sysfs_show_transport, NULL);
>
> +static ssize_t nvme_sysfs_show_state(struct device *dev,
> +					 struct device_attribute *attr,
> +					 char *buf)
> +{
> +	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> +	static const char *const state_name[] = {
> +		[NVME_CTRL_NEW]		= "new",
> +		[NVME_CTRL_LIVE]	= "live",
> +		[NVME_CTRL_RESETTING]	= "resetting",
> +		[NVME_CTRL_RECONNECTING]= "reconnecting",
> +		[NVME_CTRL_DELETING]	= "deleting",
> +		[NVME_CTRL_DEAD]	= "dead",
> +	};
> +
> +	return sprintf(buf, "%s\n",
> +		       (unsigned)ctrl->state < ARRAY_SIZE(state_name) ?
> +		       state_name[ctrl->state] : "???");
> +}
> +static DEVICE_ATTR(state, S_IRUGO, nvme_sysfs_show_state, NULL);
> +
>  static ssize_t nvme_sysfs_show_subsysnqn(struct device *dev,
>  					 struct device_attribute *attr,
>  					 char *buf)
> @@ -1601,6 +1621,7 @@ static struct attribute *nvme_dev_attrs[] = {
>  	&dev_attr_transport.attr,
>  	&dev_attr_subsysnqn.attr,
>  	&dev_attr_address.attr,
> +	&dev_attr_state.attr,
>  	NULL
>  };
>
>
