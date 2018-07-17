From: hch@lst.de (Christoph Hellwig)
Date: Tue, 17 Jul 2018 15:50:07 +0200
Subject: Q: Status of ANA patches
In-Reply-To: <01b035fe-72cb-72c8-daa4-00d416815550@suse.de>
References: <0426d517-4c6e-022d-5d42-d1f22053ed1a@suse.de>
 <20180629120303.GA22270@lst.de>
 <01b035fe-72cb-72c8-daa4-00d416815550@suse.de>
Message-ID: <20180717135007.GA17263@lst.de>

On Tue, Jul 17, 2018@03:42:06PM +0200, Hannes Reinecke wrote:
> So, just submitted a blktest to check the basic functionality via
> nvme-loop, including path failover.

Thanks!

> And send some fixes for issues found during development of the said test :-)

Yes, that's why we need tests.

> 
> If you can think of anything else which should be tested please let me
> know, I'm happy to write up a testcase for that.
> 
> But what's next, then?
> Will you fold the patches into the main patchset?
> Or should they be kept separate?
> Should I be doing it (if you are too busy)?

Pretty busy this week, so for now just send incremental patches if needed.
I'll try to fold your fixes, try the test suite (and maybe add some
of the bits I did test manually to it) and prepare a merge candidate
for next week.
