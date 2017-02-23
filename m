From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 23 Feb 2017 12:16:02 +0200
Subject: [GIT PULL] nvme patches for 4.11
In-Reply-To: <c9ae134c-47dd-3a34-16da-8d53b6ef6e96@kernel.dk>
References: <1487791916-25599-1-git-send-email-sagi@grimberg.me>
 <6e829c66-8ebf-9aff-a14f-8031ba891876@kernel.dk>
 <d6ec5d30-84d6-706b-cfc9-1927619b585e@kernel.dk>
 <12639552.D9MSj1FbeR@buzzard>
 <c9ae134c-47dd-3a34-16da-8d53b6ef6e96@kernel.dk>
Message-ID: <27c18733-658d-7804-f948-d17173adf06a@grimberg.me>


>> Urgs, I don't know what went wrong with the pull request from Sagi, but at
>> least the change in there I authored is fundamently different from what I
>> submitted!
>>
>> Looking at git://git.infradead.org/nvme.git nvme-4.11, instead of my original
>> patch adding a device ID for another NVMe controller for MacBooks, this branch
>> replaces the original entry! That'd be a regression for all MacBook8,1 out
>> there!
>>
>> See http://git.kernel.dk/cgit/linux-block/commit/?h=for-linus&id=4f6cc1c29b0b5d3a964d5ad0cbe7c48e6c44686f
>> vs. http://lists.infradead.org/pipermail/linux-nvme/2017-February/008323.html
>>
>> How do we get that fixed?
>
> Beats me how that happened, Sagi? Sagi is the one that applied it. This
> is the commit in the nvme tree:
>
> http://git.infradead.org/nvme.git/commitdiff/918896679f5ca6ee3462aadaaee53049635769c9?hp=1792eac722b0ab651e9eb543114e929dadb1f613

Thats odd, not sure how that happened. it applied cleanly for me.

I'll do it again just to understand if something went wrong.

Thanks for catching this Daniel.

> I will fix it up in my tree...

Thanks Jens.
