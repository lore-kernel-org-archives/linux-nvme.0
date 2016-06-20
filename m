From: sagigrim@gmail.com (Sagi Grimberg)
Date: Mon, 20 Jun 2016 09:55:17 +0300
Subject: [PATCH 2/2] [RFC] nvme: enable asynchronous events notification
 by default
In-Reply-To: <1466184075-10471-3-git-send-email-gpiccoli@linux.vnet.ibm.com>
References: <1466184075-10471-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <1466184075-10471-3-git-send-email-gpiccoli@linux.vnet.ibm.com>
Message-ID: <57679355.6000303@gmail.com>


> Asynchronous events notification currently is disabled by default;
> to enable it, one should issue a set-feature command through
> nvme-cli userspace application. The tool also allows disabling
> these events once they're enable, as per user desire.
>
> This patch makes the asynchronous events notification enabled by
> default; to do so, we submit the set-feature command from the
> driver, in the end of nvme_reset_work() routine. This way, the
> feature is enabled on the driver initialization and after resets,
> in case they happen.

AEN was already enabled by default in:

commit f866fc4282a81673ef973ad54c68235a3263b42e
Author: Christoph Hellwig <hch at lst.de>
Date:   Tue Apr 26 13:52:00 2016 +0200

     nvme: move AER handling to common code

     The transport driver still needs to do the actual submission, but 
all the
     higher level code can be shared.

     Signed-off-by: Christoph Hellwig <hch at lst.de>
     Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
     Signed-off-by: Jens Axboe <axboe at fb.com>

(Assuming you have at least a single queue).
