From: keith.busch@intel.com (Keith Busch)
Date: Wed, 10 Jan 2018 16:57:03 -0700
Subject: [PATCH] nvme: Add weighted-round-robin arbitration support
In-Reply-To: <00249810-fdad-9398-1469-03944e8f6164@samsung.com>
References: <CGME20180104150334epcas1p14579a6ab7bcf1b6ce326d0bce89c91e1@epcas1p1.samsung.com>
 <1515078129-4041-1-git-send-email-joshi.k@samsung.com>
 <20180104173804.GA7007@localhost.localdomain>
 <ec6f0d2f-2751-0a29-7762-7a32830e0fcc@samsung.com>
 <20180109170539.GE15154@localhost.localdomain>
 <00249810-fdad-9398-1469-03944e8f6164@samsung.com>
Message-ID: <20180110235702.GK15154@localhost.localdomain>

On Wed, Jan 10, 2018@08:57:19PM +0530, Kanchan Joshi wrote:
> Different hctx sounds good, and can be used for both polled IO and WRR
> (somewhat more resource-heavy for WRR though). May I know if that work is in
> progress already.

As far as I know, no one has anything developed in this area yet, or at
least not to the point of sharing. 

> It seems NVMe driver does not have to do much in that scheme-of-things,
> while block layer takes most of the load.

Yep, that's the idea. Just need to see if anyone comes up with
something. ;)
