From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Fri, 24 Feb 2017 13:02:43 -0800
Subject: NVMe IO error due to abort..
In-Reply-To: <CA+55aFxpdWPL3=X1gop4jeCk7JQpT4KMvaUq2aAeSfNNW6N=kg@mail.gmail.com>
References: <CA+55aFy+b3W+F7jv9HSqs1UTrkUCKdGjTLUrdmiggG9Y6BApMQ@mail.gmail.com>
 <CA+55aFxpdWPL3=X1gop4jeCk7JQpT4KMvaUq2aAeSfNNW6N=kg@mail.gmail.com>
Message-ID: <CA+55aFwA+=ojRqcydxa-6ZGqHo+YJqEQqaa9w6HpKtYPmsN+jw@mail.gmail.com>

On Fri, Feb 24, 2017 at 12:56 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I dunno. My logs have nothing like this happening before on this
> machine, which together with the lack of smart errors from the disk is
> why I'd be inclined to blame something new during this merge window.

.. and literally within a minute of sending that email, it happened again.

And it was just after the kernel compile finished.

I think I'll go back to an older kernel and make sure I don't have
that mq-deadline enabled.

                 Linus
