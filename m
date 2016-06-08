From: sagi@lightbits.io (Sagi Grimberg)
Date: Wed, 8 Jun 2016 15:11:52 +0300
Subject: [PATCH v2] NVMe: Add controller state for scheduling resets
In-Reply-To: <20160608120329.GA20526@infradead.org>
References: <1464729484-14424-1-git-send-email-keith.busch@intel.com>
 <575808AC.2030004@lightbits.io> <20160608120329.GA20526@infradead.org>
Message-ID: <57580B88.4000904@lightbits.io>


>> Is my understanding correct? Do you think that we should modify the
>> loop and rdma drivers to do async reset as well?
>>
>> This also makes the different transport behave differently at the moment
>> which is something we should strive to avoid...
>
> Don't worry, I have an almost ready patch series to pull this change
> it in, it actually helps for fabrics as well.

OK, I'll be waiting to see it then :)
