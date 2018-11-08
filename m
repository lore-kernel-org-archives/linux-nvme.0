From: maxg@mellanox.com (Max Gurtovoy)
Date: Thu, 8 Nov 2018 10:20:00 +0200
Subject: [PATCH] nvme-rdma: Don't fail the controller if only part of the
 queues fail to connect
In-Reply-To: <20181107090751.GA25759@lst.de>
References: <1541349434-31640-1-git-send-email-israelr@mellanox.com>
 <fa4ec36d-29e5-3cbd-742e-33c617d0f82e@broadcom.com>
 <67c9a957-1b61-2632-396c-3c410f6729fa@mellanox.com>
 <20181107090751.GA25759@lst.de>
Message-ID: <0c0b1ada-c1b2-2f27-098b-ca1859fcd485@mellanox.com>


On 11/7/2018 11:07 AM, Christoph Hellwig wrote:
> On Tue, Nov 06, 2018@01:10:27PM +0200, Max Gurtovoy wrote:
>>> This sounds odd.?? Why aren't you concerned that io queues are not
>>> connecting ?? Are there any log messages hinting at the failures ? any
>>> way someone looking at the controller knows how many queues were actually
>>> created ? ? I would assume any failure is significant and should be
>>> visible, and it's worthwhile knowing whether this is a consistent failure
>>> or a random failure. and what the failure was.
>> This may happen (well it happened in the past, and fixed in the block
>> layer) in case there are offline cpu's or some other reason that some queue
>> is unmapped.
>>
>> I prefer not to relay on the block layer to ensure us 100% mapping and
>> prefer be safe in our ULP.
> How do we ensure we ensure any potential new block layer bug returns
> -EXDEV so that your handling kicks in?

well we can't ensure that. Are you suggesting to do the handling for 
each failure ?

I guess we'll need this anyway for older kernels that don't have the fix 
for offline cpu mapping.
