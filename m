From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 23 Feb 2017 12:10:51 +0200
Subject: [GIT PULL] nvme patches for 4.11
In-Reply-To: <d6ec5d30-84d6-706b-cfc9-1927619b585e@kernel.dk>
References: <1487791916-25599-1-git-send-email-sagi@grimberg.me>
 <6e829c66-8ebf-9aff-a14f-8031ba891876@kernel.dk>
 <d6ec5d30-84d6-706b-cfc9-1927619b585e@kernel.dk>
Message-ID: <999f7a11-6b18-b5df-a08f-fcf6a6d5dc21@grimberg.me>


> A few issues with this:
>
> - It throws a merge conflict. No big deal, that was easy enough
>   to fix up.
>
> - What is this based on? Looks like some version of my for-next,
>   but ends up duplicating 4 patches from me. I don't remember
>   if I rebased my for-next this time around, but I often do. It's
>   not a stable branch like the for-4.xx/topic branches.

I rebased on top of for-4.11/block, although looking again git log
--decorate shows its on top of for-4.11/review. Looks like I typo'ed
git rebase...

> - Out of 22 patches, one commit reverts another commit. That should
>   just have been squashed.

Correct, missed that.

> I ended up simply fixing all of that up, and generating the patches
> and applying. Otherwise the whole history would have been a mess.

Thanks Jens, sorry for the extra work.
