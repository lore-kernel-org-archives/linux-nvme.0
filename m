From: nisha.miller420@gmail.com (Nisha Miller)
Date: Thu, 13 Oct 2016 11:18:43 -0700
Subject: Weirdness with discard cmd and get log pages
In-Reply-To: <20161013161519.GE17823@localhost.localdomain>
References: <CAG3=cOkxyNq3heevOOpOMcezTsEktPfsoWAEVjWdTA28KgVwAg@mail.gmail.com>
 <20161013161519.GE17823@localhost.localdomain>
Message-ID: <CAG3=cOmGVdQXDvNuzeW2hgfYi7nASGvfgirU__hE5VJnSWue4w@mail.gmail.com>

On Thu, Oct 13, 2016@9:15 AM, Keith Busch <keith.busch@intel.com> wrote:
> On Thu, Oct 13, 2016@08:46:30AM -0700, Nisha Miller wrote:
>> In the case of discard command, we are able to fetch the first two
>> ranges (i.e 16 bytes/range x 2) correctly using DMA. But any ranges
>> after that contain just junk data. For example, if we try to fetch 4
>> ranges, ranges 1-2 are valid but ranges 3-4 contain junk.
>
> How did you set up a discard command with more than one range? The
> standard discard path to the driver allows only one.

Yes, that is what I noticed too. I used the nvme-cli command like this:

nvme dsm /dev/nvme0n1 -a 0,0,0,0 --blocks=4,5,6,7 --slbs=100,200,300,400 --ad

This turns up as nvme_user_cmd in the driver, which calls
nvme_map_user_pages to setup the SG list.

Nisha
