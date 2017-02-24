From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Fri, 24 Feb 2017 13:55:39 -0800
Subject: NVMe IO error due to abort..
In-Reply-To: <7cc18f03-935e-c053-8752-1c42b711f441@kernel.dk>
References: <CA+55aFy+b3W+F7jv9HSqs1UTrkUCKdGjTLUrdmiggG9Y6BApMQ@mail.gmail.com>
 <CA+55aFxpdWPL3=X1gop4jeCk7JQpT4KMvaUq2aAeSfNNW6N=kg@mail.gmail.com>
 <CA+55aFwA+=ojRqcydxa-6ZGqHo+YJqEQqaa9w6HpKtYPmsN+jw@mail.gmail.com>
 <CA+55aFzb8uLKbYaAdGHkJzRfSSqzr3irh0EOQ5NTO4Noeb8htw@mail.gmail.com>
 <18390BD4-644C-40DD-A6FF-E8327962D5F2@kernel.dk>
 <7cc18f03-935e-c053-8752-1c42b711f441@kernel.dk>
Message-ID: <CA+55aFw8=Xh=GS0KJzYKcV612EtWOvCMkfZe7H3vGT8W7AYmwQ@mail.gmail.com>

On Fri, Feb 24, 2017@1:35 PM, Jens Axboe <axboe@kernel.dk> wrote:
>
> And below is the branch info. I was going to send this in pretty soon
> anyway, but lets see what happens.
>
>   git://git.kernel.dk/linux-block.git for-linus

Can you give me an overview of this all for the merge message. Might
as well merge this properly regardless.

I'm currently just building things in a loop on the old Fedora kernel,
just to verify stability (I had already pruned away my own 4.10 kernel
due to the earlier "git bisect" I did on that machine due to the
touchpad issue earlier in the merge window, so I'm using the distro
kernel just to verify that it really isn't any new hw issue).

I'm pretty sure the hw is fine, but I'll do that a bit more, before I
go back to current head of git for testing.

But that means I might as well just have this all already merged
(which I do on my main desktop that has so far not shown any signs of
this issue).

                   Linus
