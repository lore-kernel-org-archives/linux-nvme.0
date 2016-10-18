From: nisha.miller420@gmail.com (Nisha Miller)
Date: Tue, 18 Oct 2016 09:55:20 -0700
Subject: Weirdness with discard cmd and get log pages
In-Reply-To: <20161014231932.GA19846@localhost.localdomain>
References: <CAG3=cOkxyNq3heevOOpOMcezTsEktPfsoWAEVjWdTA28KgVwAg@mail.gmail.com>
 <20161013161519.GE17823@localhost.localdomain>
 <CAG3=cOmGVdQXDvNuzeW2hgfYi7nASGvfgirU__hE5VJnSWue4w@mail.gmail.com>
 <20161013231808.GG17823@localhost.localdomain>
 <20161014174421.GB19383@localhost.localdomain>
 <CAG3=cOmZpmE=OXJr9cqu75-c7XQ8upeCBFUhsakn_3ts=zPkXg@mail.gmail.com>
 <20161014231932.GA19846@localhost.localdomain>
Message-ID: <CAG3=cO=_O6_Xgv-cAWzUi_w3E1bCf0yVFw4JCsN1ATU72d6Hpg@mail.gmail.com>

On Fri, Oct 14, 2016@4:19 PM, Keith Busch <keith.busch@intel.com> wrote:
>
> The nvme-cli doesn't align every buffer on page boundaries, so many of
> these passthru commands require PRP2. Is your device using this correctly
> on non-RW commands?

Hi Keith,

since the data transfer size is less than 4K from get log pages and
DSM, won't PRP2 be invalid?

thanks
Nisha
