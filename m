From: ming.lei@redhat.com (Ming Lei)
Date: Thu, 20 Jun 2019 09:36:51 +0800
Subject: [PATCH 2/2] nvme: flush scan_work when resetting controller
In-Reply-To: <20190618101025.78840-3-hare@suse.de>
References: <20190618101025.78840-1-hare@suse.de>
 <20190618101025.78840-3-hare@suse.de>
Message-ID: <20190620013650.GB31179@ming.t460p>

On Tue, Jun 18, 2019@12:10:25PM +0200, Hannes Reinecke wrote:
> When resetting the controller there is no point whatsoever to
> have a scan run in parallel; we cannot access the controller and

scan won't be run in parallel, because .scan_work is embedded in
'struct nvme_ctrl' which is per-HBA.

> we cannot tell which devices are present and which not.
> Additionally we'll run a scan after reset anyway.
> So flush existing scans before reconnecting, ensuring to
> short-circuit the scan workqueue function if the controller state
> isn't live to avoid lockups.

This way may cause dead-lock.

1) nvme_revalidate_disk() might freeze queue in flush context, however
any in-flight requests won't be completed until reset is done, so
deadlock may be caused by flushing scans in reset context.

2) sync IO may be involved in revalidate_disk() which is called in
scan context, so deadlock is caused for same reason with 1).


Thanks,
Ming
