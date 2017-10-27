From: axboe@kernel.dk (Jens Axboe)
Date: Fri, 27 Oct 2017 08:25:47 -0600
Subject: [PATCH 0/3] centralize transport not ready request check
In-Reply-To: <20171027061127.GA30853@infradead.org>
References: <1508847922-26699-1-git-send-email-sagi@grimberg.me>
 <20171027061127.GA30853@infradead.org>
Message-ID: <7cff5a68-cec9-ef1f-201d-f98c631137b4@kernel.dk>

On 10/27/2017 12:11 AM, Christoph Hellwig wrote:
> I like this a lot, but the big question is how we get this in as
> we have a 4.14 change in this area.  Either we'll have a self-conflict
> for 4.15, or we jus tdelay this to be pulled into 4.15 just after
> -rc1?

I can just setup a post-merge branch, which will become a for-linus
branch that I'll send in during the merge window as well.

-- 
Jens Axboe
