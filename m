From: keith.busch@intel.com (Keith Busch)
Date: Fri, 25 Jul 2014 17:41:16 -0600 (MDT)
Subject: [PATCH] NVMe: Correctly handle IOCTL_SUBMIT_IO when cpus > online
 queues
In-Reply-To: <53D2CFFB.8010908@micron.com>
References: <53D2CFFB.8010908@micron.com>
Message-ID: <alpine.LRH.2.03.1407251723330.4703@AMR>

On Fri, 25 Jul 2014, Sam Bradshaw wrote:
> nvme_submit_io_cmd() use smp_processor_id() to pick an IO queue index.  This patch
> fixes the case where there are more cpus from which the ioctl call can originate
> than online queues, which can happen when a device supports or was allocated fewer
> interrupt vectors than exist cpu cores.

Oh you're right, but I think the idea was to use the queue associated
with the cpu, though the code was clearly broken before.

-	return nvme_submit_sync_cmd(dev, smp_processor_id() + 1, cmd, result,
+	return nvme_submit_sync_cmd(dev, this_cpu_read(*dev->io_queues), cmd, result,
  							NVME_IO_TIMEOUT);

> Signed-off-by: Sam Bradshaw <sbradshaw at micron.com>
> ---
>
> diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
> index 28aec2d..5171753 100644
> --- a/drivers/block/nvme-core.c
> +++ b/drivers/block/nvme-core.c
> @@ -979,8 +979,9 @@ int nvme_submit_admin_cmd(struct nvme_dev *dev, struct nvme_command *cmd,
> int nvme_submit_io_cmd(struct nvme_dev *dev, struct nvme_command *cmd,
> 								u32 *result)
> {
> -	return nvme_submit_sync_cmd(dev, smp_processor_id() + 1, cmd, result,
> -							NVME_IO_TIMEOUT);
> +	return nvme_submit_sync_cmd(dev, (smp_processor_id() %
> +						(dev->online_queues - 1)) + 1,
> +						 cmd, result, NVME_IO_TIMEOUT);
> }
>
> static int nvme_submit_admin_cmd_async(struct nvme_dev *dev,
