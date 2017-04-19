From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 19 Apr 2017 12:44:50 +0300
Subject: [PATCH] nvmet: convert from kmap to nvmet_copy_from_sgl
In-Reply-To: <20170419093826.GB10632@linux-x5ow.site>
References: <1492558335-2845-1-git-send-email-logang@deltatee.com>
 <3cf1fbf9-8b1d-4acb-e680-87efa5ca7c6d@mellanox.com>
 <20170419093826.GB10632@linux-x5ow.site>
Message-ID: <6dfa2fbf-78e6-2c7b-f6e3-c765fe5015c2@mellanox.com>



On 4/19/2017 12:38 PM, Johannes Thumshirn wrote:
> On Wed, Apr 19, 2017@12:33:09PM +0300, Max Gurtovoy wrote:
>> Hi Logan,
>>
>> On 4/19/2017 2:32 AM, Logan Gunthorpe wrote:
>>> This is safer as it doesn't rely on the data being stored in
>>> a single page in an sgl.
>>>
>>> It also aids our effort to start phasing out users of sg_page. See [1].
>>>
>>> For this we kmalloc some memory, copy to it and free at the end. Note:
>>> we can't allocate this memory on the stack as the kbuild test robot
>>> reports some frame size overflows on i386.
>>>
>>> [1] https://lwn.net/Articles/720053/
>>>
>>> Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
>>> Cc: Christoph Hellwig <hch at lst.de>
>>> Cc: Sagi Grimberg <sagi at grimberg.me>
>>> ---
>>> drivers/nvme/target/fabrics-cmd.c | 32 +++++++++++++++++++++++++-------
>>> 1 file changed, 25 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
>>> index 8bd022af..2e0ab10 100644
>>> --- a/drivers/nvme/target/fabrics-cmd.c
>>> +++ b/drivers/nvme/target/fabrics-cmd.c
>>> @@ -122,7 +122,15 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
>>> 	struct nvmet_ctrl *ctrl = NULL;
>>> 	u16 status = 0;
>>>
>>> -	d = kmap(sg_page(req->sg)) + req->sg->offset;
>>> +	d = kmalloc(sizeof(*d), GFP_KERNEL);
>>
>> I'd prefer removing the dynamic allocation and use d on the stack to
>> simplify the code.
>> Any thoughts ?
>
> Hi Max,
>
> Pasting from above:
>
>>> we can't allocate this memory on the stack as the kbuild test robot
>>> reports some frame size overflows on i386.

Thanks Johannes, I missed that comment.

Looks good,

Reviewed-by: Max Gurtovoy <maxg at mellanox.com>

>
>
