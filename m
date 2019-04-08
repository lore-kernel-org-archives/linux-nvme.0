From: maxg@mellanox.com (Max Gurtovoy)
Date: Mon, 8 Apr 2019 19:59:58 +0300
Subject: [PATCH 1/2] nvmet-rdma: remove p2p_client initialization from
 fast-path
In-Reply-To: <fdc2f41f-dfe7-b790-8ab5-deb875e6a5c2@deltatee.com>
References: <1554737999-26459-1-git-send-email-maxg@mellanox.com>
 <6fc5a921-6440-5375-7e21-a000ae98b07d@deltatee.com>
 <d2227a0e-e2a2-e6a1-8f83-c2470bd96371@mellanox.com>
 <fdc2f41f-dfe7-b790-8ab5-deb875e6a5c2@deltatee.com>
Message-ID: <cc049213-82cd-6340-b732-e8c4c116c0b2@mellanox.com>


On 4/8/2019 7:35 PM, Logan Gunthorpe wrote:
>
> On 2019-04-08 10:26 a.m., Max Gurtovoy wrote:
>> On 4/8/2019 7:04 PM, Logan Gunthorpe wrote:
>>> On 2019-04-08 9:39 a.m., Max Gurtovoy wrote:
>>>> Initialize it during command allocation.
>>> It would be nice to hear some justification for this change in the
>>> commit message, but the change itself appears to be fine to me:
>> well, it's written in the subject and it's pretty small change so there
>> is not much to say about it.
>>
>> Just set this ptr once instead of every IO.
> But is this just an optimization-without-measuring from code review? Or
> did I actually cause a measurable performance regression? What actually
> prompted the change?

The first one :)

I don't think that one assignment can cause a regression but I also 
think the we shouldn't do redundant operations on the fast path.

These can accumulate in the future..


>
> Just to be clear: I'm fine with the change and am happy it's being done;
> I'd just prefer to see more detail in the commit message.

I guess it's possible.

Lets get a review for the second patch and I'll send V2.


>
> Thanks,
>
> Logan
