From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 6 Nov 2016 23:33:44 +0200
Subject: [PATCH v1] nvmet-rdma: don't forget to delete a queue from the
 list of connection failed
In-Reply-To: <20161106192944.GA18397@lst.de>
References: <1478453448-17520-1-git-send-email-sagi@grimberg.me>
 <20161106192944.GA18397@lst.de>
Message-ID: <d3557d0b-c696-a380-d9a2-3a21b9744c77@grimberg.me>


>> In case we accepted a queue connection and it failed, we might not
>> remove the queue from the list until we unload and clean it up.
>> We should delete it from the queue list on the relevant handler.
>
> I think for this to work we'll also need to initialize
> ->queue_list when allocating the queue.

Not really because we'll only manipulate the queue_list if we accept
which means that it's in the list, nvmet_rdma_queue_connect() failures
won't ever see nvmet_rdma_queue_connect_fail(). But I can add it for
good measures...
