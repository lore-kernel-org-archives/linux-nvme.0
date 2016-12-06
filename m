From: axboe@kernel.dk (Jens Axboe)
Date: Tue, 6 Dec 2016 08:07:22 -0700
Subject: [GIT PULL] nvme fabrics patches for 4.10
In-Reply-To: <81f35340-759e-b134-296f-60b832cccf12@grimberg.me>
References: <1480888926-19235-1-git-send-email-sagi@grimberg.me>
 <6d35084f-f7e2-28bc-9a2b-740af461f02e@kernel.dk>
 <81f35340-759e-b134-296f-60b832cccf12@grimberg.me>
Message-ID: <9edf5563-c359-44de-60c1-dadccb6e839b@kernel.dk>

On 12/06/2016 02:03 AM, Sagi Grimberg wrote:
> 
> 
>>> Hey Jens,
>>>
>>> The major addition here is the nvme FC transport implementation
>>> from James.
>>>
>>> What else:
>>> - some cleanups and memory leak fixes in the host side fabrics code from Bart
>>> - possible rcu violation fix from Sasha
>>> - logging change from Max
>>> - small include cleanup
>>>
>>> Please pull from:
>>>
>>>   git://git.infradead.org/nvme-fabrics.git nvmf-4.10
>>
>> Ehm no. This isn't based on my 4.10 branch, hence I get a ton of
>> unrelated commits if I pull this in. Please rebase this on top of
>> 4.10/block first, thanks.
> 
> Sorry for that,
> 
> I updated nvmf-4.10 to apply on top of for-4.10/block.

Much better - pulled it in for 4.10, thanks.

-- 
Jens Axboe
