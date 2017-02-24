From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Fri, 24 Feb 2017 13:09:31 -0800
Subject: NVMe IO error due to abort..
In-Reply-To: <CA+55aFwA+=ojRqcydxa-6ZGqHo+YJqEQqaa9w6HpKtYPmsN+jw@mail.gmail.com>
References: <CA+55aFy+b3W+F7jv9HSqs1UTrkUCKdGjTLUrdmiggG9Y6BApMQ@mail.gmail.com>
 <CA+55aFxpdWPL3=X1gop4jeCk7JQpT4KMvaUq2aAeSfNNW6N=kg@mail.gmail.com>
 <CA+55aFwA+=ojRqcydxa-6ZGqHo+YJqEQqaa9w6HpKtYPmsN+jw@mail.gmail.com>
Message-ID: <CA+55aFzb8uLKbYaAdGHkJzRfSSqzr3irh0EOQ5NTO4Noeb8htw@mail.gmail.com>

On Fri, Feb 24, 2017 at 1:02 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> And it was just after the kernel compile finished.

Timing-wise, it might be the IO flushing after the biggest final link
or something. Still, that's really not all that heavy IO, but it might
trigger something.

Maybe it's even the same use-after-free with md that Bart has seen.
That's new to this merge window, isn't it?

                    Linus
