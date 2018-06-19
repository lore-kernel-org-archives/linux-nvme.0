From: swise@opengridcomputing.com (Steve Wise)
Date: Tue, 19 Jun 2018 09:41:52 -0500
Subject: [PATCH v4 0/3] NVMF/RDMA 16K Inline Support
In-Reply-To: <6cec6138-60ab-6072-d4d8-6536b4ec08d7@mellanox.com>
References: <cover.1528219321.git.swise@opengridcomputing.com>
 <4f16cd07-015e-d1cf-f8fd-069c460ee2a6@opengridcomputing.com>
 <3f3b2259-b41b-59bd-c7b6-b5102849aec4@opengridcomputing.com>
 <20180619054056.GB23184@lst.de>
 <6cec6138-60ab-6072-d4d8-6536b4ec08d7@mellanox.com>
Message-ID: <09ac252f-9240-3087-08fe-e25a01a60dd7@opengridcomputing.com>

Hey Max,


On 6/19/2018 4:21 AM, Max Gurtovoy wrote:
>
>
> On 6/19/2018 8:40 AM, Christoph Hellwig wrote:
>> On Mon, Jun 18, 2018@10:18:18AM -0500, Steve Wise wrote:
>>>
>>>
>>> On 6/18/2018 9:49 AM, Steve Wise wrote:
>>>> Hey Christoph,? will you merge patches 2 and 3 for -next?? I think
>>>> they're ready.?? I also have a nvmetcli patch I can send out for using
>>>> param_inline_data_size.
>>>>
>>>>
>>>
>>> Or I can rebase on 4.18-rc1 and resend...
>>
>> Yes, please do.? I'd also like to see at least an ACK from one or our
>> RDMA low level experts.
>>
>
> Actually I was debugging it offline with Steve and sent him some fix
> that is included in this version.
> Please re-send a rebased version and I'll review it.
>

Should I add a Tested-by line for you?

> I realy would like to see numbers before/after this patch like Parav did:
> http://lists.infradead.org/pipermail/linux-nvme/2017-February/008059.html
>

Given the logic is pretty much the same, I would think those results
will stand.? But I can run some of these numbers and add it to the patch
comment (or cover letter, whichever is appropriate).


Steve.
