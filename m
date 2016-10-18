From: keith.busch@intel.com (Keith Busch)
Date: Tue, 18 Oct 2016 13:08:21 -0400
Subject: Weirdness with discard cmd and get log pages
In-Reply-To: <CAG3=cO=_O6_Xgv-cAWzUi_w3E1bCf0yVFw4JCsN1ATU72d6Hpg@mail.gmail.com>
References: <CAG3=cOkxyNq3heevOOpOMcezTsEktPfsoWAEVjWdTA28KgVwAg@mail.gmail.com>
 <20161013161519.GE17823@localhost.localdomain>
 <CAG3=cOmGVdQXDvNuzeW2hgfYi7nASGvfgirU__hE5VJnSWue4w@mail.gmail.com>
 <20161013231808.GG17823@localhost.localdomain>
 <20161014174421.GB19383@localhost.localdomain>
 <CAG3=cOmZpmE=OXJr9cqu75-c7XQ8upeCBFUhsakn_3ts=zPkXg@mail.gmail.com>
 <20161014231932.GA19846@localhost.localdomain>
 <CAG3=cO=_O6_Xgv-cAWzUi_w3E1bCf0yVFw4JCsN1ATU72d6Hpg@mail.gmail.com>
Message-ID: <20161018170820.GB25479@localhost.localdomain>

On Tue, Oct 18, 2016@09:55:20AM -0700, Nisha Miller wrote:
> since the data transfer size is less than 4K from get log pages and
> DSM, won't PRP2 be invalid?

No, that would only be true if PRP1's offset was 0, and you're not
guaranteed that.
