From: logang@deltatee.com (Logan Gunthorpe)
Date: Thu, 25 Jul 2019 12:20:31 -0600
Subject: [PATCH 2/2] nvme-core: Fix deadlock when deleting the ctrl while
 scanning
In-Reply-To: <b501f53b-48e9-87a3-9023-8597ed1efc6d@grimberg.me>
References: <20190718225132.5865-1-logang@deltatee.com>
 <20190718225132.5865-2-logang@deltatee.com>
 <c52f80b1-e154-b11f-a868-e3209e4ccb2d@grimberg.me>
 <6deea9e7-ff3c-e115-b2f2-8914df0b6da7@deltatee.com>
 <dd287560-2cb3-28ab-c22d-fe9f3682c609@grimberg.me>
 <021b5195-9a09-4cc2-064f-940ada9cf764@deltatee.com>
 <b501f53b-48e9-87a3-9023-8597ed1efc6d@grimberg.me>
Message-ID: <25f1903e-2ef1-8dbb-c08b-5dd0d44ba2d2@deltatee.com>



On 2019-07-25 12:16 p.m., Sagi Grimberg wrote:
> 
>> Hey,
>>
>> Sorry for the delay.
>>
>> I tested your patch and it does work. Do you want me to send your change
>> as a full patch? Can I add your signed-off-by?
> 
> I have a patch ready with a proper comment in place. I can send it
> out... Can I get your tested-by and reported-by?

Yup. I can retest once you send the patch and I'll send a test-by then.
For now you can add my reported-by:

Reported-by: Logan Gunthorpe <logang at deltatee.com>

Note: I had to modify your original patch a fair bit so it compiled with
multipath disabled.

Logan
