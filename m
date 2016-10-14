From: keith.busch@intel.com (Keith Busch)
Date: Fri, 14 Oct 2016 19:19:33 -0400
Subject: Weirdness with discard cmd and get log pages
In-Reply-To: <CAG3=cOmZpmE=OXJr9cqu75-c7XQ8upeCBFUhsakn_3ts=zPkXg@mail.gmail.com>
References: <CAG3=cOkxyNq3heevOOpOMcezTsEktPfsoWAEVjWdTA28KgVwAg@mail.gmail.com>
 <20161013161519.GE17823@localhost.localdomain>
 <CAG3=cOmGVdQXDvNuzeW2hgfYi7nASGvfgirU__hE5VJnSWue4w@mail.gmail.com>
 <20161013231808.GG17823@localhost.localdomain>
 <20161014174421.GB19383@localhost.localdomain>
 <CAG3=cOmZpmE=OXJr9cqu75-c7XQ8upeCBFUhsakn_3ts=zPkXg@mail.gmail.com>
Message-ID: <20161014231932.GA19846@localhost.localdomain>

On Fri, Oct 14, 2016@02:33:49PM -0700, Nisha Miller wrote:
> My problem is that I need to make it work on Kernel 2.6.33. For now,
> since blkdiscard and fstrim send only 1 range I'm ok with current
> support for discard cmd.
> 
> However I need to fix the issue for get log pages. Are there any known
> issues with mapping user buffers in older linux-nvme drivers?

I'm pretty sure it works. I tested on a RHEL 6.6 (a 2.6.32 fork), and
I can read all the log pages without issue.

The nvme-cli doesn't align every buffer on page boundaries, so many of
these passthru commands require PRP2. Is your device using this correctly
on non-RW commands?
