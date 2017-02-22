From: axboe@kernel.dk (Jens Axboe)
Date: Wed, 22 Feb 2017 15:16:37 -0700
Subject: [GIT PULL] nvme patches for 4.11
In-Reply-To: <12639552.D9MSj1FbeR@buzzard>
References: <1487791916-25599-1-git-send-email-sagi@grimberg.me>
 <6e829c66-8ebf-9aff-a14f-8031ba891876@kernel.dk>
 <d6ec5d30-84d6-706b-cfc9-1927619b585e@kernel.dk>
 <12639552.D9MSj1FbeR@buzzard>
Message-ID: <c9ae134c-47dd-3a34-16da-8d53b6ef6e96@kernel.dk>

On 02/22/2017 03:10 PM, Daniel Roschka wrote:
> On Wednesday, 22. February 2017, 20:41:11 CET you wrote:
>> A few issues with this:
>>
>> - It throws a merge conflict. No big deal, that was easy enough
>>   to fix up.
>>
>> - What is this based on? Looks like some version of my for-next,
>>   but ends up duplicating 4 patches from me. I don't remember
>>   if I rebased my for-next this time around, but I often do. It's
>>   not a stable branch like the for-4.xx/topic branches.
>>
>> - Out of 22 patches, one commit reverts another commit. That should
>>   just have been squashed.
>>
>> I ended up simply fixing all of that up, and generating the patches
>> and applying. Otherwise the whole history would have been a mess.
> 
> Urgs, I don't know what went wrong with the pull request from Sagi, but at 
> least the change in there I authored is fundamently different from what I 
> submitted!
> 
> Looking at git://git.infradead.org/nvme.git nvme-4.11, instead of my original 
> patch adding a device ID for another NVMe controller for MacBooks, this branch 
> replaces the original entry! That'd be a regression for all MacBook8,1 out 
> there!
> 
> See http://git.kernel.dk/cgit/linux-block/commit/?h=for-linus&id=4f6cc1c29b0b5d3a964d5ad0cbe7c48e6c44686f
> vs. http://lists.infradead.org/pipermail/linux-nvme/2017-February/008323.html
> 
> How do we get that fixed?

Beats me how that happened, Sagi? Sagi is the one that applied it. This
is the commit in the nvme tree:

http://git.infradead.org/nvme.git/commitdiff/918896679f5ca6ee3462aadaaee53049635769c9?hp=1792eac722b0ab651e9eb543114e929dadb1f613

I will fix it up in my tree...

-- 
Jens Axboe
