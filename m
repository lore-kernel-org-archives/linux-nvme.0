From: keith.busch@intel.com (Keith Busch)
Date: Tue, 9 Jan 2018 10:05:39 -0700
Subject: [PATCH] nvme: Add weighted-round-robin arbitration support
In-Reply-To: <ec6f0d2f-2751-0a29-7762-7a32830e0fcc@samsung.com>
References: <CGME20180104150334epcas1p14579a6ab7bcf1b6ce326d0bce89c91e1@epcas1p1.samsung.com>
 <1515078129-4041-1-git-send-email-joshi.k@samsung.com>
 <20180104173804.GA7007@localhost.localdomain>
 <ec6f0d2f-2751-0a29-7762-7a32830e0fcc@samsung.com>
Message-ID: <20180109170539.GE15154@localhost.localdomain>

On Tue, Jan 09, 2018@07:20:58PM +0530, Kanchan Joshi wrote:
> It seems to me that some sort of differentiation (among tasks of various
> classes) during tag allocation is required to handle this. Perhaps, static
> division of available tags into 4 priority classes needs to be done in block
> layer.

Yes, I was thinking either some kind priorty based tag reservation, or
possibly entirely different hctx's for each priority. The block layer
currently doesn't provide this kind of separation, but it was mentioned
the latter might be appropriate for hipri/polled IO, so maybe that idea
can extend to WRR.
