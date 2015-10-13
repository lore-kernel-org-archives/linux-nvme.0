From: dan.j.williams@intel.com (Williams, Dan J)
Date: Tue, 13 Oct 2015 01:53:34 +0000
Subject: Block integrity registration update
In-Reply-To: <1444696266.9780.13.camel@intel.com>
References: <B58D82457FDA0744A320A2FC5AC253B93CBE5758@fmsmsx104.amr.corp.intel.com>
 <1444683912-7140-1-git-send-email-martin.petersen@oracle.com>
 <1444696266.9780.13.camel@intel.com>
Message-ID: <1444701214.9780.23.camel@intel.com>

On Mon, 2015-10-12@17:31 -0700, Dan J Williams wrote:
> On Mon, 2015-10-12@17:05 -0400, Martin K. Petersen wrote:
> > As requested, here's the integrity registration update for 4.4. Only
> > delta is patch 5 which retains the non-PI metadata check as requested by
> > Keith as well as the DM rework by Mike. I rebased on top of
> > block/for-4.4/drivers to accommodate the NVMe shuffle.
> > 
> > [PATCH 1/5] block: Move integrity kobject to struct gendisk
> > [PATCH 2/5] block: Consolidate static integrity profile properties
> > [PATCH 3/5] block: Reduce the size of struct blk_integrity
> > [PATCH 4/5] block: Export integrity data interval size in sysfs
> > [PATCH 5/5] block: Inline blk_integrity in struct gendisk
> > 
> 
> I'm triggering the oops below with the libnvdimm unit tests when running
> these on top of block.git#for-4.4/drivers...

A little tracing reveals:

[   35.116011]    ndctl-2226    3.... 37126789us : blk_integrity_unregister: pmem1s: from: nvdimm_namespace_detach_btt [nd_btt]
[   35.116011]    ndctl-2226    3.... 37185506us : bio_integrity_endio: pmem1s
[   35.116011]    <...>-302     3.... 37185560us : bio_integrity_process: pmem1s

...i.e. that we're destroying the integrity profile while i/o is still
in flight.  As far as I can see any driver that calls
blk_integrity_unregister() before blk_cleanup_queue() can hit this.  

However, with the change to static allocation I'm not sure why a driver
would ever need to call blk_integrity_unregister() in its shutdown path.
It seems this would only be necessary for disabling integrity at run
time, but it can only do it safely when the queue is known to be idle.

Is there a way to solve this without the generic blk_freeze_queue()
implementation? [1].  The immediate fix for libnvdimm is to just stop
calling blk_integrity_unregister().

[1]: https://lists.01.org/pipermail/linux-nvdimm/2015-October/002388.html
