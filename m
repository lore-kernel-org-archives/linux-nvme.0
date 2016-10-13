From: keith.busch@intel.com (Keith Busch)
Date: Thu, 13 Oct 2016 12:15:19 -0400
Subject: Weirdness with discard cmd and get log pages
In-Reply-To: <CAG3=cOkxyNq3heevOOpOMcezTsEktPfsoWAEVjWdTA28KgVwAg@mail.gmail.com>
References: <CAG3=cOkxyNq3heevOOpOMcezTsEktPfsoWAEVjWdTA28KgVwAg@mail.gmail.com>
Message-ID: <20161013161519.GE17823@localhost.localdomain>

On Thu, Oct 13, 2016@08:46:30AM -0700, Nisha Miller wrote:
> In the case of discard command, we are able to fetch the first two
> ranges (i.e 16 bytes/range x 2) correctly using DMA. But any ranges
> after that contain just junk data. For example, if we try to fetch 4
> ranges, ranges 1-2 are valid but ranges 3-4 contain junk.

How did you set up a discard command with more than one range? The
standard discard path to the driver allows only one.
