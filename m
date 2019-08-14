From: logang@deltatee.com (Logan Gunthorpe)
Date: Wed, 14 Aug 2019 10:59:44 -0600
Subject: [PATCH v7 03/14] nvmet: add return value to
 nvmet_add_async_event()
In-Reply-To: <9bb2966a-0d7c-a492-7628-37916a941cfb@mellanox.com>
References: <20190801234514.7941-1-logang@deltatee.com>
 <20190801234514.7941-4-logang@deltatee.com>
 <9bb2966a-0d7c-a492-7628-37916a941cfb@mellanox.com>
Message-ID: <f83cacb8-de44-05b9-dfbc-73e1d5ed02e2@deltatee.com>



On 2019-08-14 8:26 a.m., Max Gurtovoy wrote:
> 
> On 8/2/2019 2:45 AM, Logan Gunthorpe wrote:
>> From: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
>>
>> Change the return value for nvmet_add_async_event().
>>
>> This change is needed for the target passthru code to generate async
>> events.
> 
> As a stand alone commit it's not clear what is the purpose of it.
> 
> Please add some extra explanation in the commit message.
> 
> Also better to use integer as return value if the return value should
> reflect return code.

Thanks for the Review, Max. I'll queue up these changes for v8.

Logan
