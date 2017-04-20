From: axboe@kernel.dk (Jens Axboe)
Date: Thu, 20 Apr 2017 17:30:23 -0600
Subject: [PATCH v3 0/2] nvme APST quirk updates, take two
In-Reply-To: <cover.1492720361.git.luto@kernel.org>
References: <cover.1492720361.git.luto@kernel.org>
Message-ID: <cea93058-eb0f-b8cc-0fe3-08f39e7cf04b@kernel.dk>

On 04/20/2017 02:37 PM, Andy Lutomirski wrote:
> Hi Jens-
> 
> These are just the quirk updates, split out.  The patches are
> unchanged.
> 
> I think that, even if we want to apply a broader quirk for 4.11, we
> should still apply these so that we can cleanly revert the broader
> quirk later.  IOW, let's get the known regressions fixed before we
> get too excited about the unknown regressions.

Applied - and I agree, we should still do this and if we do a
default-off type of patch, then we can easily revert that one
on its own for 4.12.

-- 
Jens Axboe
