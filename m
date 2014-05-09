From: roland@kernel.org (Roland Dreier)
Date: Fri, 9 May 2014 11:08:09 -0700
Subject: [Ksummit-discuss] [CORE TOPIC] Device error handling / reporting
 / isolation
In-Reply-To: <CAFhKne9pHJzsxt8JemvogCRWywU5Z3e2-_JtC9Z9un+RvVP7XQ@mail.gmail.com>
References: <1399552623.17118.22.camel@i7.infradead.org>
 <CAG4TOxNJxWLWSZYW313XATtCpV+SM9WrYFJ-V+0Pf-yryLh67g@mail.gmail.com>
 <CAFhKne9pHJzsxt8JemvogCRWywU5Z3e2-_JtC9Z9un+RvVP7XQ@mail.gmail.com>
Message-ID: <CAG4TOxNMeQ0Opooin2nAKRGg_EDoPso4U+MZuuSPs=Jg8RjAWg@mail.gmail.com>

On Fri, May 9, 2014@10:58 AM, Matthew Wilcox <willy6545@gmail.com> wrote:
> I'm hearing a bunch of FUD around NVMe hotplug but precious little in the
> way of bug reports! Keith Busch has been doing a stellar job of fixing up
> the bugs that he's found, but I have seen precisely zero hotplug bugs
> reported to the NVMe mailing list. So put up or shut up.

Fair enough, not trying to spread FUD here.  The issues we've seen so
far have been more around platforms not configured to report PCIe
errors properly vs. the NVMe driver itself.

 - R.
