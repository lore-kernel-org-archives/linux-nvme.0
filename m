From: bart.vanassche@sandisk.com (Bart Van Assche)
Date: Mon, 1 Aug 2016 08:09:59 -0700
Subject: [PATCH v3] nvmet-rdma: Correctly handle RDMA device hot removal
In-Reply-To: <7b8cc595-a33c-99e6-8490-161f83c2c489@sandisk.com>
References: <1469967347-20466-1-git-send-email-sagi@grimberg.me>
 <20160801111530.GB16474@lst.de>
 <7b8cc595-a33c-99e6-8490-161f83c2c489@sandisk.com>
Message-ID: <c4aafeaf-0988-239d-e072-96b231f4d23f@sandisk.com>

On 08/01/16 07:44, Bart Van Assche wrote:
> On 08/01/16 04:15, Christoph Hellwig wrote:
>> This looks reasonable to me, but a little question below:
>>
>>> @@ -1442,7 +1491,8 @@ static void nvmet_rdma_remove_port(struct
>>> nvmet_port *port)
>>>  {
>>>      struct rdma_cm_id *cm_id = port->priv;
>>>
>>> -    rdma_destroy_id(cm_id);
>>> +    if (cm_id)
>>> +        rdma_destroy_id(cm_id);
>>>  }
>>
>> How is ->remove_port synchronized vs the RDMA/CM event handler?
>
> rdma_destroy_id() waits until active RDMA/CM callbacks have finished. Is
> that sufficient or is further synchronization needed?

(replying to my own e-mail)

Please ignore my e-mail. I just realized that Christoph's question was 
about synchronization of nvmet_rdma_remove_port() versus the RDMA/CM 
event handler instead of just rdma_destroy_id().

Bart.
