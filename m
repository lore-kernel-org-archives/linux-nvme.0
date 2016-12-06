From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 6 Dec 2016 11:03:04 +0200
Subject: [GIT PULL] nvme fabrics patches for 4.10
In-Reply-To: <6d35084f-f7e2-28bc-9a2b-740af461f02e@kernel.dk>
References: <1480888926-19235-1-git-send-email-sagi@grimberg.me>
 <6d35084f-f7e2-28bc-9a2b-740af461f02e@kernel.dk>
Message-ID: <81f35340-759e-b134-296f-60b832cccf12@grimberg.me>



>> Hey Jens,
>>
>> The major addition here is the nvme FC transport implementation
>> from James.
>>
>> What else:
>> - some cleanups and memory leak fixes in the host side fabrics code from Bart
>> - possible rcu violation fix from Sasha
>> - logging change from Max
>> - small include cleanup
>>
>> Please pull from:
>>
>>   git://git.infradead.org/nvme-fabrics.git nvmf-4.10
>
> Ehm no. This isn't based on my 4.10 branch, hence I get a ton of
> unrelated commits if I pull this in. Please rebase this on top of
> 4.10/block first, thanks.

Sorry for that,

I updated nvmf-4.10 to apply on top of for-4.10/block.
