From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 20 Nov 2018 01:11:56 -0800
Subject: [PATCH 6/7] block: make blk_poll() take a parameter on whether to
 spin or not
In-Reply-To: <04b6015e-2949-750d-01a0-640373b406ea@kernel.dk>
References: <20181117214354.822-1-axboe@kernel.dk>
 <20181117214354.822-7-axboe@kernel.dk> <20181119080544.GF9622@infradead.org>
 <04b6015e-2949-750d-01a0-640373b406ea@kernel.dk>
Message-ID: <5caad4a6-d9af-df12-1eed-6d2c9906457f@grimberg.me>


>> This opportunistic poll is pretty bogus now as we never set the HIPRI
>> flag and it should probably be removed in a prep patch.  We should then
>> later try to use a scheme similar to your aio polling for the nvme
>> target as well.
> 
> I'll kill it in a pre-patch.

Agreed..
