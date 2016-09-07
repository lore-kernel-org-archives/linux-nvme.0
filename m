From: axboe@fb.com (Jens Axboe)
Date: Wed, 7 Sep 2016 08:53:38 -0600
Subject: [PATCH] nvme: Don't suspend admin queue that wasn't created
In-Reply-To: <1473194353-2472-1-git-send-email-krisman@linux.vnet.ibm.com>
References: <1473194353-2472-1-git-send-email-krisman@linux.vnet.ibm.com>
Message-ID: <464cc78c-1409-3d88-508e-d47fb0f5cfbe@fb.com>

On 09/06/2016 02:39 PM, Gabriel Krisman Bertazi wrote:
> This fixes a regression in my previous commit c21377f8366c ("nvme:
> Suspend all queues before deletion"), which provoked an Oops in the
> removal path when removing a device that became IO incapable very early
> at probe (i.e. after a failed EEH recovery).
>
> Turns out, if the error occurred very early at the probe path, before
> even configuring the admin queue, we might try to suspend the
> uninitialized admin queue, accessing bad memory.
>
> Fixes: c21377f8366c ("nvme: Suspend all queues before deletion")
> Signed-off-by: Gabriel Krisman Bertazi <krisman at linux.vnet.ibm.com>

Applied for 4.8, thanks.

-- 
Jens Axboe
