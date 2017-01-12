From: sbates@raithlin.com (Stephen Bates)
Date: Wed, 11 Jan 2017 23:09:13 -0600
Subject: [LSF/MM TOPIC][LSF/MM ATTEND] IO completion polling for block drivers
Message-ID: <7742bcaf65d9f4dc3c0dfede53a85b84.squirrel@webmail.raithlin.com>

Hi

I'd like to discuss the ongoing work in the kernel to enable high priority
IO via polling for completion in the blk-mq subsystem.

Given that iopoll only really makes sense for low-latency, low queue depth
environments (i.e. down below 10-20us) I'd like to discuss which drivers
we think will need/want to be upgraded (aside from NVMe ;-)).

I'd also be interested in discussing how best to enable and disable
polling. In the past some of us have pushed for a "big hammer" to turn
polling on for a given device or HW queue [1]. I'd like to discuss this
again as well as looking at other methods above and beyond the preadv2
system call and the HIPRI flag.

Finally I'd like to discuss some of the recent work to improve the
heuristics around when to poll and when not to poll. I'd like to see if we
can come up with more optimal balance between CPU load and average
completion times [2].

Stephen Bates

[1] http://marc.info/?l=linux-block&m=146307410101827&w=2
[2] http://marc.info/?l=linux-block&m=147803441801858&w=2
