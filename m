From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Fri, 24 Feb 2017 12:56:52 -0800
Subject: NVMe IO error due to abort..
In-Reply-To: <CA+55aFy+b3W+F7jv9HSqs1UTrkUCKdGjTLUrdmiggG9Y6BApMQ@mail.gmail.com>
References: <CA+55aFy+b3W+F7jv9HSqs1UTrkUCKdGjTLUrdmiggG9Y6BApMQ@mail.gmail.com>
Message-ID: <CA+55aFxpdWPL3=X1gop4jeCk7JQpT4KMvaUq2aAeSfNNW6N=kg@mail.gmail.com>

On Fri, Feb 24, 2017 at 12:39 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> But it wasn't some unclean shutdown, it turned out to be an IO error
> on shutdown:

I take that "on shutdown" part back.

It was close to when I ended up rebooting (which was unrelated to the
IO error - I didn't notice that IO error until several boots later),
but it seems to have been a couple of minutes before.

So it might have been during my compiling the kernel, although looking
at the logs the error actually seems to have affected the chrome
browser database file, because there are "Cookie sqlite error XYZ"
messages in the system log right after the kernel error messages.

Maybe triggered by something like flush command associated with fsync
on the sqlite file, while there was a fair amount of disk activity
from the kernel build?

I dunno. My logs have nothing like this happening before on this
machine, which together with the lack of smart errors from the disk is
why I'd be inclined to blame something new during this merge window.

                   Linus
