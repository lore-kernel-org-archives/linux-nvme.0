From: axboe@kernel.dk (Jens Axboe)
Date: Thu, 20 Apr 2017 10:13:28 -0600
Subject: [PATCH v2 0/2] nvme APST quirk updates, take two
In-Reply-To: <cover.1492704577.git.luto@kernel.org>
References: <cover.1492704577.git.luto@kernel.org>
Message-ID: <9cd43193-af6b-2cb1-3951-5fa569bf1f31@kernel.dk>

On 04/20/2017 10:11 AM, Andy Lutomirski wrote:
> Hi Jens-
> 
> These are just the quirk updates, split out.  The patches are
> unchanged.
> 
> I think that, even if we want to apply a broader quirk for 4.11, we
> should still apply these so that we can cleanly revert the broader
> quirk later.  IOW, let's get the known regressions fixed before we
> get too excited about the unknown regressions.

This looks good to me, and 4.11 appropriate. I'll expedite this
through the block tree, if Keith/Sagi/Christoph agrees on this
being the right approach for 4.11.

-- 
Jens Axboe
