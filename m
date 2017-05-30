From: krisman@collabora.co.uk (Gabriel Krisman Bertazi)
Date: Tue, 30 May 2017 16:52:14 -0300
Subject: [PATCH] blk-mq: Take tagset lock when updaing hw queues
In-Reply-To: <1496169551-26868-1-git-send-email-keith.busch@intel.com> (Keith
 Busch's message of "Tue, 30 May 2017 14:39:11 -0400")
References: <1496169551-26868-1-git-send-email-keith.busch@intel.com>
Message-ID: <87fufmm8b5.fsf@dilma.collabora.co.uk>

Keith Busch <keith.busch at intel.com> writes:

> The tagset lock needs to be held when iterating the tag_list, so a
> lockdep assert was added when updating number of hardware queues. The
> drivers calling this API, however, were unaware of the new requirement,
> so are failing the assertion.
>
> This patch takes the lock within the blk-mq function so the drivers do
> not have to be modified in order to be safe.
>
> Fixes: 705cda97e ("blk-mq: Make it safe to use RCU to iterate over blk_mq_tag_set.tag_list")
>
> Reported-by: Gabriel Krisman Bertazi <krisman at collabora.co.uk>
> Reviewed-by: Bart Van Assche <Bart.VanAssche at sandisk.com>
> Signed-off-by: Keith Busch <keith.busch at intel.com>

I know it is already applied but, FWIW, I can confirm it fixed the issue
in our CI.  Feel free to add:

Tested-by: Gabriel Krisman Bertazi <krisman at collabora.co.uk>

Thanks again, Keith.

-- 
Gabriel Krisman Bertazi
