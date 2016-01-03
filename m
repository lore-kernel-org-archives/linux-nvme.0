From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Sun, 3 Jan 2016 19:05:18 +0200
Subject: [PATCH 5/5] NVMe: IO queue deletion re-write
In-Reply-To: <20160103114052.GA24893@infradead.org>
References: <1451496471-29370-1-git-send-email-keith.busch@intel.com>
 <1451496471-29370-6-git-send-email-keith.busch@intel.com>
 <20151230180430.GA12828@infradead.org>
 <20151230190706.GC12454@localhost.localdomain>
 <20160102170730.GA30184@infradead.org>
 <20160102213008.GA10969@localhost.localdomain>
 <20160103114052.GA24893@infradead.org>
Message-ID: <568954CE.2000501@dev.mellanox.co.il>



On 03/01/2016 13:40, Christoph Hellwig wrote:
> On Sat, Jan 02, 2016@09:30:09PM +0000, Keith Busch wrote:
>> The async deletion was written for a bug reporting "hang" on a device
>> removal. The "hang" was the controller taking on the order of 100's msec
>> to delete a queue (sometimes >1sec if lots of commands queued). This
>> controller had 2k queues, and took ~15 minutes to remove serially. Async
>> deletion brought it down to ~20 seconds, so looked like a good idea.
>>
>> It wasn't a controller I make, so I personally don't care about
>> parallelizing queue deletion. The driver's been this way for so long
>> though, I don't have a good way to know how beneficial this feature
>> is anymore.
>
> How about something like the lightly tested patch below.  It uses
> synchronous command submission, but schedules a work item on the
> system unbound workqueue for each queue, allowing the scheduler
> to execture them in parallel.
>
> ---
> From: Christoph Hellwig <hch at lst.de>
> Date: Sun, 3 Jan 2016 12:09:36 +0100
> Subject: nvme: semi-synchronous queue deletion
>
> Replace the complex async queue deletetion scheme with a a work_item
> per queue that is scheduled to the system unbound workqueue.  That
> way we can use the normal synchronous command submission helpers,
> but let the scheduler distribute the deletions over all available
> CPUs.
>
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>   drivers/nvme/host/pci.c | 180 +++++++-----------------------------------------
>   1 file changed, 25 insertions(+), 155 deletions(-)
>
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index b82bbea..68ba2d4 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -89,13 +89,6 @@ static void nvme_process_cq(struct nvme_queue *nvmeq);
>   static void nvme_remove_dead_ctrl(struct nvme_dev *dev);
>   static void nvme_dev_shutdown(struct nvme_dev *dev);
>
> -struct async_cmd_info {
> -	struct kthread_work work;
> -	struct kthread_worker *worker;
> -	int status;
> -	void *ctx;
> -};
> -
>   /*
>    * Represents an NVM Express device.  Each nvme_dev is a PCI function.
>    */
> @@ -128,6 +121,10 @@ struct nvme_dev {
>   #define NVME_CTRL_RESETTING    0
>
>   	struct nvme_ctrl ctrl;
> +
> +	/* for queue deletion at shutdown time */
> +	atomic_t		queues_remaining;
> +	wait_queue_head_t	queue_delete_wait;

General question,

Any reason why you didn't just use a counting semaphore for this?
I've seen other places where people are moving away from those but
I didn't understand why...
