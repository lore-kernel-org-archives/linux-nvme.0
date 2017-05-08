From: axboe@fb.com (Jens Axboe)
Date: Sun, 7 May 2017 19:53:33 -0600
Subject: [PATCH] lightnvm: remove unused rq parameter of
 nvme_nvm_rqtocmd() to kill warning
In-Reply-To: <1494166484-11363-1-git-send-email-geert@linux-m68k.org>
References: <1494166484-11363-1-git-send-email-geert@linux-m68k.org>
Message-ID: <5bc0bd5f-4eb5-5975-4700-071b78047917@fb.com>

On 05/07/2017 08:14 AM, Geert Uytterhoeven wrote:
> With gcc 4.1.2:

Wow, that's ancient.

>     drivers/nvme/host/lightnvm.c: In function ?nvme_nvm_submit_io?:
>     drivers/nvme/host/lightnvm.c:498: warning: ?rq? is used uninitialized in this function
> 
> Indeed, since commit 2e13f33a2464fc3a ("lightnvm: create cmd before
> allocating request"), the request is passed to nvme_nvm_rqtocmd() before
> it is allocated.
> 
> Fortunately, as of commit 91276162de9476b8 ("lightnvm: refactor end_io
> functions for sync"), nvme_nvm_rqtocmd () no longer uses the passed
> request, so this warning is a false positive.
> 
> Drop the unused parameter to clean up the code and kill the warning.

Thanks, applied.

-- 
Jens Axboe
