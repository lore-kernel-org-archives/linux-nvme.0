From: james.smart@broadcom.com (James Smart)
Date: Tue, 8 May 2018 08:12:04 -0700
Subject: [PATCH 6/7] nvme_fc: fix nulling of queue data on reconnect
In-Reply-To: <20180508080513.41014470@pentland.suse.de>
References: <20180508001214.8951-1-jsmart2021@gmail.com>
 <20180508001214.8951-7-jsmart2021@gmail.com>
 <20180508080513.41014470@pentland.suse.de>
Message-ID: <51c8214b-0ce5-c8c0-f7be-156750baadbc@broadcom.com>


On 5/7/2018 11:05 PM, Hannes Reinecke wrote:
> On Mon,  7 May 2018 17:12:13 -0700
> "James Smart" <jsmart2021@gmail.com> wrote:
>
>> @@ -1879,6 +1879,7 @@ nvme_fc_free_queue(struct nvme_fc_queue *queue)
>>   	 */
>>   
>>   	queue->connection_id = 0;
>> +	atomic_set(&queue->csn, 1);
>>   }
>>   
> Huh? What is that doing here?
> Doesn't seem to be related to the remaining patchset.
> Or am I missing something here?

The init_queue calls would normally "init" the structure and set the csn 
back to 1, but it also cleared too much other state as well. Thus they 
were removed. The "free" routine remains, so this CSN setting is a 
"reinit'ing" of the structure - just like zeroing the connection id.

-- james
