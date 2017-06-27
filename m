From: axboe@kernel.dk (Jens Axboe)
Date: Tue, 27 Jun 2017 08:16:49 -0600
Subject: [PATCH 9/9] nvme: add support for streams and directives
In-Reply-To: <20170627141115.GA2541@infradead.org>
References: <1498004526-4543-1-git-send-email-axboe@kernel.dk>
 <1498004526-4543-10-git-send-email-axboe@kernel.dk>
 <20170626095907.GG14057@infradead.org>
 <d2dcae41-d0b2-71a7-a63d-b7ef25ae47d2@kernel.dk>
 <20170627141115.GA2541@infradead.org>
Message-ID: <ba468c95-40e0-41e7-0eb5-f5b4b70d3e3e@kernel.dk>

On 06/27/2017 08:11 AM, Christoph Hellwig wrote:
> On Mon, Jun 26, 2017@07:56:22AM -0600, Jens Axboe wrote:
>>>  - do we even need the < 4 streams fallback now that they are global
>>>    instead of per-ns instead of just disabling the feature for now?
>>
>> Maybe the device only supports 2? or 3?
> 
> My crystal ball indicates that those are unlikely too see the
> light.  IFF we need to handle them we can still add code for it.

But we have to handle it, not doing so would be fragile. So our
options are:

1) Keep the stream_mappings[] array. It's simple, and it'll work
   for any number of streams.

2) Kill stream_mappings[] and just do the MOD again.

I'd strongly lean towards #1. I don't have a lot of faith in
crystal balls.

-- 
Jens Axboe
