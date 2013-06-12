From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Tue, 11 Jun 2013 20:09:24 -0700
Subject: [PULL REQUEST] NVMe driver fixes
In-Reply-To: <20130611210414.GN8211@linux.intel.com>
References: <20130611210414.GN8211@linux.intel.com>
Message-ID: <CA+55aFztTY8gGh=eLD65QuaUA8dpKxXqJbQimV+7PnbWqMDyzw@mail.gmail.com>

On Tue, Jun 11, 2013@2:04 PM, Matthew Wilcox <willy@linux.intel.com> wrote:
>
> The following bugfixes have been accumulating for the last few weeks, and
> it would be nice if they could be in 3.10.

So I'm not in the least sure I should bother with the whole nvme thing.

It's after -rc5, and this pattern of "stuff comes in quite late in the
merge window, and then even later in the rc series" is getting really
tiresome.

I'm getting a strong signal of "this driver isn't something people
bother to actually maintain". Do you even have access to hardware by
now? I've gotten all of four pull requests for this driver if I look
at the logs correctly, and of those four pull requests one was after
an rc7, and now this is after an rc5.

Simple question: is it worth the bother?

                 Linus
