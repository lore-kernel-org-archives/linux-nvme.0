From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Fri, 24 Feb 2017 16:47:18 -0800
Subject: NVMe IO error due to abort..
In-Reply-To: <CA+55aFx77v1cOVZOiPCWP-LgK0w_AVL+3-G-xsC8nkp7ze_HQQ@mail.gmail.com>
References: <CA+55aFy+b3W+F7jv9HSqs1UTrkUCKdGjTLUrdmiggG9Y6BApMQ@mail.gmail.com>
 <CA+55aFxpdWPL3=X1gop4jeCk7JQpT4KMvaUq2aAeSfNNW6N=kg@mail.gmail.com>
 <CA+55aFwA+=ojRqcydxa-6ZGqHo+YJqEQqaa9w6HpKtYPmsN+jw@mail.gmail.com>
 <CA+55aFzb8uLKbYaAdGHkJzRfSSqzr3irh0EOQ5NTO4Noeb8htw@mail.gmail.com>
 <18390BD4-644C-40DD-A6FF-E8327962D5F2@kernel.dk>
 <7cc18f03-935e-c053-8752-1c42b711f441@kernel.dk>
 <CA+55aFw8=Xh=GS0KJzYKcV612EtWOvCMkfZe7H3vGT8W7AYmwQ@mail.gmail.com>
 <38e75ee9-e20a-3a64-c570-c780cb593958@kernel.dk>
 <b8efa7ec-be2b-cb26-9fff-e3f1c5412719@kernel.dk>
 <CA+55aFx77v1cOVZOiPCWP-LgK0w_AVL+3-G-xsC8nkp7ze_HQQ@mail.gmail.com>
Message-ID: <CA+55aFzAJ+v0cMV_EtzcgfuXSQKUPDUV99GFcMg=nFeEzCE3Hg@mail.gmail.com>

On Fri, Feb 24, 2017 at 3:08 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> I may have been able to reproduce it once, but I'm not sure how easily
> I'll repro it again, so..

I'm not seeing it with current git and the NOOP scheduler, at least
with a few builds and trying to do what I did to get it to happen last
time.

But I think I'll continue to use this configuration for the rest of
the merge window just to make sure it's stable. I may not have hit the
right trigger for the problem.

                   Linus
