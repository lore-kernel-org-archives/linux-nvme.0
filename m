From: nisha.miller420@gmail.com (Nisha Miller)
Date: Thu, 13 Oct 2016 08:46:30 -0700
Subject: Weirdness with discard cmd and get log pages
Message-ID: <CAG3=cOkxyNq3heevOOpOMcezTsEktPfsoWAEVjWdTA28KgVwAg@mail.gmail.com>

Hi,

We are running the stock nvme driver on Centos 7.2 with kernel 3.19.8
and we are seeing some weirdness with get log pages and discard cmd.
In the driver, both these calls setup a SG list for DMA.

In the case of discard command, we are able to fetch the first two
ranges (i.e 16 bytes/range x 2) correctly using DMA. But any ranges
after that contain just junk data. For example, if we try to fetch 4
ranges, ranges 1-2 are valid but ranges 3-4 contain junk.

In the case of get log pages, its even worse. A lot of the data we DMA
to driver/host is mostly junk. And this changes based on how much data
is DMA'd.

Note that DMA for read/write works perfectly.

In our FW, when we fetch data using DMA, we always fetch in multiples
of 32 bytes due to alignment constraints.

Is there something we are missing here that could be causing these problems?

TIA
Nisha Miller
