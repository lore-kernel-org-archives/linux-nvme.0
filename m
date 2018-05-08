From: hare@suse.de (Hannes Reinecke)
Date: Tue, 8 May 2018 17:28:46 +0200
Subject: [PATCH 6/7] nvme_fc: fix nulling of queue data on reconnect
In-Reply-To: <51c8214b-0ce5-c8c0-f7be-156750baadbc@broadcom.com>
References: <20180508001214.8951-1-jsmart2021@gmail.com>
 <20180508001214.8951-7-jsmart2021@gmail.com>
 <20180508080513.41014470@pentland.suse.de>
 <51c8214b-0ce5-c8c0-f7be-156750baadbc@broadcom.com>
Message-ID: <059cabb0-6f78-a65e-bd75-1f857259a4c8@suse.de>

On 05/08/2018 05:12 PM, James Smart wrote:
> 
> On 5/7/2018 11:05 PM, Hannes Reinecke wrote:
>> On Mon,? 7 May 2018 17:12:13 -0700
>> "James Smart" <jsmart2021@gmail.com> wrote:
>>
>>> @@ -1879,6 +1879,7 @@ nvme_fc_free_queue(struct nvme_fc_queue *queue)
>>> ?????? */
>>> ????? queue->connection_id = 0;
>>> +??? atomic_set(&queue->csn, 1);
>>> ? }
>> Huh? What is that doing here?
>> Doesn't seem to be related to the remaining patchset.
>> Or am I missing something here?
> 
> The init_queue calls would normally "init" the structure and set the csn 
> back to 1, but it also cleared too much other state as well. Thus they 
> were removed. The "free" routine remains, so this CSN setting is a 
> "reinit'ing" of the structure - just like zeroing the connection id.
> 
Thanks for the clarification.

Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
