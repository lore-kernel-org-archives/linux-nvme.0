From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Tue, 25 Jun 2019 05:04:45 +0900
Subject: [PATCH v3 3/5] nvme-pci: rename module parameter write_queues to
 read_queues
In-Reply-To: <d61b1b9a31c3d2fae9ece26bcd5f4504b25f059f.1561385989.git.zhangweiping@didiglobal.com>
References: <cover.1561385989.git.zhangweiping@didiglobal.com>
 <d61b1b9a31c3d2fae9ece26bcd5f4504b25f059f.1561385989.git.zhangweiping@didiglobal.com>
Message-ID: <20190624200445.GB6526@minwooim-desktop>

On 19-06-24 22:29:19, Weiping Zhang wrote:
> Now nvme support three type hardware queues, read, poll and default,
> this patch rename write_queues to read_queues to set the number of
> read queues more explicitly. This patch alos is prepared for nvme
> support WRR(weighted round robin) that we can get the number of
> each queue type easily.
> 
> Signed-off-by: Weiping Zhang <zhangweiping at didiglobal.com>

Hello, Weiping.

Thanks for making this patch as a separated one.  Actually I'd like to
hear about if the origin purpose of this param can be changed or not.

I can see a log from Jens when it gets added her:
  Commit 3b6592f70ad7("nvme: utilize two queue maps, one for reads and
                       one for writes")
  It says:
  """
  NVMe does round-robin between queues by default, which means that
  sharing a queue map for both reads and writes can be problematic
  in terms of read servicing. It's much easier to flood the queue
  with writes and reduce the read servicing.
  """

So, I'd like to hear what other people think about this patch :)

Thanks,

> ---
>  drivers/nvme/host/pci.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 5d84241f0214..a3c9bb72d90e 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -68,10 +68,10 @@ static int io_queue_depth = 1024;
>  module_param_cb(io_queue_depth, &io_queue_depth_ops, &io_queue_depth, 0644);
>  MODULE_PARM_DESC(io_queue_depth, "set io queue depth, should >= 2");
>  
> -static int write_queues;
> -module_param(write_queues, int, 0644);
> -MODULE_PARM_DESC(write_queues,
> -	"Number of queues to use for writes. If not set, reads and writes "
> +static int read_queues;
> +module_param(read_queues, int, 0644);
> +MODULE_PARM_DESC(read_queues,
> +	"Number of queues to use for reads. If not set, reads and writes "
>  	"will share a queue set.");
>  
>  static int poll_queues;
> @@ -211,7 +211,7 @@ struct nvme_iod {
>  
>  static unsigned int max_io_queues(void)
>  {
> -	return num_possible_cpus() + write_queues + poll_queues;
> +	return num_possible_cpus() + read_queues + poll_queues;
>  }
>  
>  static unsigned int max_queue_count(void)
> @@ -2021,18 +2021,16 @@ static void nvme_calc_irq_sets(struct irq_affinity *affd, unsigned int nrirqs)
>  	 * If only one interrupt is available or 'write_queue' == 0, combine
>  	 * write and read queues.
>  	 *
> -	 * If 'write_queues' > 0, ensure it leaves room for at least one read
> +	 * If 'read_queues' > 0, ensure it leaves room for at least one write
>  	 * queue.
>  	 */
> -	if (!nrirqs) {
> +	if (!nrirqs || nrirqs == 1) {
>  		nrirqs = 1;
>  		nr_read_queues = 0;
> -	} else if (nrirqs == 1 || !write_queues) {
> -		nr_read_queues = 0;
> -	} else if (write_queues >= nrirqs) {
> -		nr_read_queues = 1;
> +	} else if (read_queues >= nrirqs) {
> +		nr_read_queues = nrirqs - 1;
>  	} else {
> -		nr_read_queues = nrirqs - write_queues;
> +		nr_read_queues = read_queues;
>  	}
>  
>  	dev->io_queues[HCTX_TYPE_DEFAULT] = nrirqs - nr_read_queues;
> -- 
> 2.14.1
> 
