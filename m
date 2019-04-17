From: kbusch@kernel.org (Keith Busch)
Date: Wed, 17 Apr 2019 09:55:12 -0600
Subject: [PATCH V6 9/9] nvme: hold request queue's refcount in ns's whole
 lifetime
In-Reply-To: <20190417034410.31957-10-ming.lei@redhat.com>
References: <20190417034410.31957-1-ming.lei@redhat.com>
 <20190417034410.31957-10-ming.lei@redhat.com>
Message-ID: <20190417155511.GA6005@localhost.localdomain>

On Tue, Apr 16, 2019@08:44:10PM -0700, Ming Lei wrote:
> Hennes reported the following kernel oops:
> 
>     There is a race condition between namespace rescanning and
>     controller reset; during controller reset all namespaces are
>     quiesed vie nams_stop_ctrl(), and after reset all namespaces
>     are unquiesced again.
>     When namespace scanning was active by the time controller reset
>     was triggered the rescan code will call nvme_ns_remove(), which
>     then will cause a kernel crash in nvme_start_ctrl() as it'll trip
>     over uninitialized namespaces.
> 
> Patch "blk-mq: free hw queue's resource in hctx's release handler"
> should make this issue quite difficult to trigger. However it can't
> kill the issue completely becasue pre-condition of that patch is to
> hold request queue's refcount before calling block layer API, and
> there is still a small window between blk_cleanup_queue() and removing
> the ns from the controller namspace list in nvme_ns_remove().
> 
> Hold request queue's refcount until the ns is freed, then the above race
> can be avoided completely. Given the 'namespaces_rwsem' is always held
> to retrieve ns for starting/stopping request queue, this lock can prevent
> namespaces from being freed.

This looks good to me.

Reviewed-by: Keith Busch <keith.busch at intel.com>
