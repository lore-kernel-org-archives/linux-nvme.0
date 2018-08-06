From: axboe@kernel.dk (Jens Axboe)
Date: Mon, 6 Aug 2018 08:34:02 -0600
Subject: nvme updates for 4.19
In-Reply-To: <20180806073100.GA11515@infradead.org>
References: <20180804084354.GA26103@infradead.org>
 <df1c976e-8ea7-ba14-d1d2-caf8511de527@kernel.dk>
 <20180805073305.GA31663@infradead.org>
 <da7f8241-cd79-ff46-21a2-71b282bc1a57@kernel.dk>
 <20180806073100.GA11515@infradead.org>
Message-ID: <a679bea1-6732-71bc-c943-778a75ac9e02@kernel.dk>

On 8/6/18 1:31 AM, Christoph Hellwig wrote:
> On Sun, Aug 05, 2018@08:27:22AM -0600, Jens Axboe wrote:
>> Right, the change is fine, it's just fighting a similar change
>> in a different branch. I did fix it up (picked in the original change
>> first), please double check at your convenience.
> 
> The merge looks good.  Given that you've changed the head anyway I'd
> also be happy to give you a version of the ANA commit without that
> change..

Let's just leave it as-is for now, I pulled in -rc6 to ensure that I
would resolve the conflict instead of introducing it to Linus.

-- 
Jens Axboe
