From: axboe@kernel.dk (Jens Axboe)
Date: Mon, 26 Jun 2017 07:56:22 -0600
Subject: [PATCH 9/9] nvme: add support for streams and directives
In-Reply-To: <20170626095907.GG14057@infradead.org>
References: <1498004526-4543-1-git-send-email-axboe@kernel.dk>
 <1498004526-4543-10-git-send-email-axboe@kernel.dk>
 <20170626095907.GG14057@infradead.org>
Message-ID: <d2dcae41-d0b2-71a7-a63d-b7ef25ae47d2@kernel.dk>

On 06/26/2017 03:59 AM, Christoph Hellwig wrote:
> Looks mostly good,
> 
> but two nit-picks:
> 
>  - can we keep a module option to disable streams, or in fact for
>    now maybe to explicitly enable it?  I expect this to be interesting
>    at least for the first devices that implement it.  Also given that
>    it needs to be explicitly enabled I would expect some overhead of
>    just enabling it when never used

Fine with me, I can add the 'streams' parameter back, but just default
it to false.

>  - do we even need the < 4 streams fallback now that they are global
>    instead of per-ns instead of just disabling the feature for now?

Maybe the device only supports 2? or 3?

-- 
Jens Axboe
