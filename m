From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 5 Oct 2016 20:40:24 +0300
Subject: [PATCH v2 7/7] [RFC] nvme: Fix a race condition
In-Reply-To: <ff412bfb-548c-c4fc-5180-78ede8a19ef2@sandisk.com>
References: <f153ee47-e599-c333-92b0-d5da475012f3@sandisk.com>
 <ff412bfb-548c-c4fc-5180-78ede8a19ef2@sandisk.com>
Message-ID: <08fab9f6-f928-4cec-b616-317a52361557@grimberg.me>


> Avoid that nvme_queue_rq() is still running when nvme_stop_queues()
> returns. Untested.
>
> Signed-off-by: Bart Van Assche <bart.vanassche at sandisk.com>
> Cc: Keith Busch <keith.busch at intel.com>
> Cc: Christoph Hellwig <hch at lst.de>
> Cc: Sagi Grimberg <sagi at grimberg.me>

Bart this looks really good! and possibly fixes an issue
I've been chasing with fabrics a while ago. I'll take it
for testing but you can add my:

Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
