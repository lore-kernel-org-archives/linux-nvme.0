From: luto@kernel.org (Andy Lutomirski)
Date: Sat, 13 May 2017 05:27:55 -0700
Subject: [PATCH] nvme: Change our APST table to be no more aggressive than
 Intel RSTe
In-Reply-To: <ddc5be5d81966effaf73e3cee54330c351bc8169.1494561654.git.luto@kernel.org>
References: <ddc5be5d81966effaf73e3cee54330c351bc8169.1494561654.git.luto@kernel.org>
Message-ID: <CALCETrXLhbiGTmeMDFjYAAwMi2PSK38cy1Z8UEPKxOWJz55wyQ@mail.gmail.com>

On Thu, May 11, 2017@9:06 PM, Andy Lutomirski <luto@kernel.org> wrote:
> It seems like RSTe is much more conservative with transition timing
> that we are.  According to Mario, RSTe programs APST to transition from
> active states to the first idle state after 60ms and, thereafter, to
> 1000 * the exit latency of the target state.

Bad news, folks: this appears to be merely more stable, not all the way stable:

https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1678184/comments/65

I maintain my hypothesis that no one ever validated these disks and
that the very conservative parameters set by RSTe merely make it rare
to trigger the bug.  But maybe something else is going on.
