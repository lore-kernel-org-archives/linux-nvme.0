From: hare@suse.de (Hannes Reinecke)
Date: Fri, 21 Jun 2019 08:14:45 +0200
Subject: [PATCH 2/2] nvme: flush scan_work when resetting controller
In-Reply-To: <20190620013650.GB31179@ming.t460p>
References: <20190618101025.78840-1-hare@suse.de>
 <20190618101025.78840-3-hare@suse.de> <20190620013650.GB31179@ming.t460p>
Message-ID: <3dbb8dc0-2491-6226-8715-b0f5b7f6a73a@suse.de>

On 6/20/19 3:36 AM, Ming Lei wrote:
> On Tue, Jun 18, 2019@12:10:25PM +0200, Hannes Reinecke wrote:
>> When resetting the controller there is no point whatsoever to
>> have a scan run in parallel; we cannot access the controller and
> 
> scan won't be run in parallel, because .scan_work is embedded in
> 'struct nvme_ctrl' which is per-HBA.
> 
Wrong. We do.
Not sure why having it embedded in the controller structure might
prevent this from happening; both reset and scan are embedded, but
running on different queues:

void nvme_queue_scan(struct nvme_ctrl *ctrl)
{
	/*
	 * Only new queue scan work when admin and IO queues are both alive
	 */
	if (ctrl->state == NVME_CTRL_LIVE)
		queue_work(nvme_wq, &ctrl->scan_work);
}
EXPORT_SYMBOL_GPL(nvme_queue_scan);

int nvme_reset_ctrl(struct nvme_ctrl *ctrl)
{
	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
		return -EBUSY;
	if (!queue_work(nvme_reset_wq, &ctrl->reset_work))
		return -EBUSY;
	return 0;
}
EXPORT_SYMBOL_GPL(nvme_reset_ctrl);

So there's nothing stopping them to run in parallel.

>> we cannot tell which devices are present and which not.
>> Additionally we'll run a scan after reset anyway.
>> So flush existing scans before reconnecting, ensuring to
>> short-circuit the scan workqueue function if the controller state
>> isn't live to avoid lockups.
> 
> This way may cause dead-lock.
> 
> 1) nvme_revalidate_disk() might freeze queue in flush context, however
> any in-flight requests won't be completed until reset is done, so
> deadlock may be caused by flushing scans in reset context.
> 
Which is why I'm checking the controller state; I've observed the
deadlock plenty of times before introducing the controller state check.

> 2) sync IO may be involved in revalidate_disk() which is called in
> scan context, so deadlock is caused for same reason with 1).
> 
I/O during revalidate_disk() is protected by the state check, too, so we
won't be issuing any I/O during resetting.

To be precise: any I/O in flight when reset is triggered will be
terminated, and any subsequent I/O is short-circuited by the state check.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N?rnberg)
