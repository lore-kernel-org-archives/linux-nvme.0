From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 1 Aug 2019 07:28:28 -0700
Subject: [PATCH V2 0/5] blk-mq: wait until completed req's complete fn is
 run
In-Reply-To: <944c6735-f03e-c055-33d8-fe7f9a760b8a@kernel.dk>
References: <20190724034843.10879-1-ming.lei@redhat.com>
 <20190730004525.GB28708@ming.t460p>
 <7eeb2e89-a056-456a-8be3-6edbda83b7bc@grimberg.me>
 <944c6735-f03e-c055-33d8-fe7f9a760b8a@kernel.dk>
Message-ID: <4788e1e5-6874-c510-5fa9-f07c98ec42e5@grimberg.me>


>>> Hello Jens, Chritoph and Guys,
>>>
>>> Ping on this fix.
>>
>> Given that this is nvme related, we could feed
>> it to jens from the nvme tree.
>> Applying to nvme-5.4 tree for now, if Jens picks
>> it up, we'll drop it.
> 
> It's on my top of list to review, I'd like to take it through
> the block tree though. I think that makes the most sense.

No problem at all. removing it from the nvme tree.
