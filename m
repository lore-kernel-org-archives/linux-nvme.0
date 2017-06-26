From: axboe@kernel.dk (Jens Axboe)
Date: Mon, 26 Jun 2017 12:00:41 -0600
Subject: [PATCH 9/9] nvme: add support for streams and directives
In-Reply-To: <yq17ezy4oxp.fsf@oracle.com>
References: <1498004526-4543-1-git-send-email-axboe@kernel.dk>
 <1498004526-4543-10-git-send-email-axboe@kernel.dk>
 <20170626095907.GG14057@infradead.org> <yq17ezy4oxp.fsf@oracle.com>
Message-ID: <c8c7e2c6-4ced-14d0-d7d9-a91de7e73673@kernel.dk>

On 06/26/2017 11:52 AM, Martin K. Petersen wrote:
> 
> Christoph,
> 
>>  - can we keep a module option to disable streams, or in fact for
>>    now maybe to explicitly enable it?  I expect this to be interesting
>>    at least for the first devices that implement it.  Also given that
>>    it needs to be explicitly enabled I would expect some overhead of
>>    just enabling it when never used
> 
> Yeah, based on my experiments we'll need to drive this as an opt-in
> feature for now. Short term the module option is OK. Once more devices
> start materializing we probably need a white/blacklist/quirk scheme.

Completely agree. Might even need quirks for stream allocations too,
for instance. But let's hope we can keep it clean.

-- 
Jens Axboe
