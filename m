From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 18 Jun 2019 10:41:51 -0700
Subject: [PATCH 2/2] nvme: flush scan_work when resetting controller
In-Reply-To: <20190618101025.78840-3-hare@suse.de>
References: <20190618101025.78840-1-hare@suse.de>
 <20190618101025.78840-3-hare@suse.de>
Message-ID: <36c093c6-9fea-aa2f-affe-70957e0c5b1b@grimberg.me>


> When resetting the controller there is no point whatsoever to
> have a scan run in parallel;

There is also no point of trying to prevent it.

> we cannot access the controller and
> we cannot tell which devices are present and which not.
> Additionally we'll run a scan after reset anyway.
> So flush existing scans before reconnecting, ensuring to
> short-circuit the scan workqueue function if the controller state
> isn't live to avoid lockups.

What is this fixing? can we get a detailed description?

These ctrl->state conditions sprayed around that are not barriered
by anything do not prevent any scan to run in parallel with resets.

Also, do note that resets will unquiesce the admin queue right away
and not when the reset completes (rdma, tcp, fc). The only exception
is pci that will unquiesce as soon as the reset fails.

So can you please clarify the problem?
