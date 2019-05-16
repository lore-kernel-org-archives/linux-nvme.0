From: kenneth.heitke@intel.com (Heitke, Kenneth)
Date: Thu, 16 May 2019 15:22:13 -0600
Subject: [PATCH 1/2] nvme: add thermal zone infrastructure
In-Reply-To: <1557933437-4693-2-git-send-email-akinobu.mita@gmail.com>
References: <1557933437-4693-1-git-send-email-akinobu.mita@gmail.com>
 <1557933437-4693-2-git-send-email-akinobu.mita@gmail.com>
Message-ID: <2bf1e2cf-b922-d947-c939-375aba75994d@intel.com>



On 5/15/2019 9:17 AM, Akinobu Mita wrote:
> The NVMe controller reports up to nine temperature values in the SMART /
> Health log page (the composite temperature and temperature sensor 1 through
> temperature sensor 8).
> The temperature threshold feature (Feature Identifier 04h) configures the
> asynchronous event request command to complete when the temperature is
> crossed its correspoinding temperature threshold.

s/correspoinding/corresponding/

> +
> +static void nvme_thermal_init(struct nvme_ctrl *ctrl)
> +{
> +	INIT_WORK(&ctrl->thermal_work, nvme_thermal_work);
> +}

Does this work queue need to be destroyed at some point?
