From: snitzer@redhat.com (Mike Snitzer)
Date: Wed, 13 Jan 2016 14:51:37 -0500
Subject: [PATCH v3 07/12] md: suspend i/o during runtime
 blk_integrity_unregister
In-Reply-To: <CAPcyv4ieU0EjB=i1sxs8QGisNyygYoqcx5rvkE_f7Q9Kp-j9Vg@mail.gmail.com>
References: <20151021171921.6456.1646.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20151021172001.6456.95293.stgit@dwillia2-desk3.amr.corp.intel.com>
 <874mei8bu8.fsf@notabene.neil.brown.name>
 <CAPcyv4i8ynO8xjyML86k2cM-djvvKvSAS-dgR2XcaUwhgYC0dg@mail.gmail.com>
 <87y4bu6uox.fsf@notabene.neil.brown.name>
 <CAPcyv4ieU0EjB=i1sxs8QGisNyygYoqcx5rvkE_f7Q9Kp-j9Vg@mail.gmail.com>
Message-ID: <20160113195137.GA3896@redhat.com>

On Wed, Jan 13 2016 at 12:11am -0500,
Dan Williams <dan.j.williams@intel.com> wrote:

> On Tue, Jan 12, 2016@7:10 PM, NeilBrown <neilb@suse.com> wrote:
> > On Wed, Jan 13 2016, Dan Williams wrote:
> >
> >> On Tue, Jan 12, 2016@6:14 PM, NeilBrown <neilb@suse.com> wrote:
> >>> On Thu, Oct 22 2015, Dan Williams wrote:
> >>>
> >>>> Synchronize pending i/o against a change in the integrity profile to
> >>>> avoid the possibility of spurious integrity errors.  Given linear_add()
> >>>> is suspending the mddev before manipulating the mddev, do the same for
> >>>> the other personalities.
> >>>>
> >>>> Acked-by: NeilBrown <neilb at suse.com>
> >>>> Signed-off-by: Dan Williams <dan.j.williams at intel.com>
> >>>> ---
> >>>>  drivers/md/md.c        |    1 +
> >>>>  drivers/md/multipath.c |    2 ++
> >>>>  drivers/md/raid1.c     |    2 ++
> >>>>  drivers/md/raid10.c    |    2 ++
> >>>>  4 files changed, 7 insertions(+)
> >>>>
> >>>
> >>>> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> >>>> index 7c99a4037715..6f0ec107996a 100644
> >>>> --- a/drivers/md/raid10.c
> >>>> +++ b/drivers/md/raid10.c
> >>>> @@ -1736,7 +1736,9 @@ static int raid10_add_disk(struct mddev *mddev, struct md_rdev *rdev)
> >>>>               rcu_assign_pointer(p->rdev, rdev);
> >>>>               break;
> >>>>       }
> >>>> +     mddev_suspend(mddev);
> >>>>       md_integrity_add_rdev(rdev, mddev);
> >>>> +     mddev_resume(mddev);
> >>>>       if (mddev->queue && blk_queue_discard(bdev_get_queue(rdev->bdev)))
> >>>>               queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, mddev->queue);
> >>>>
> >>>
> >>> Hi Dan,
> >>>
> >>> Somewhat belatedly I am testing this code, and it deadlocks.  Which is
> >>> obvious once I think about it.
> >>>
> >>> raid10_add_disk() is called from
> >>>   raid10d -> md_check_recovery -> remove_and_add_spares
> >>>
> >>> so this call to mddev_suspend() will block raid10d until all pending IO
> >>> completes.  But raid10d might be needed to complete some IO -
> >>> particularly in the case of errors.  I don't know exactly what is
> >>> deadlocking in my test, but it doesn't surprise me that something does.
> >>
> >> Ugh.
> >>
> >>> Can you explain in more detail what needs to be synchronised here?  If
> >>> the synchronisation doesn't happen, what can do wrong?
> >>> Because I cannot imagine what this might actually be protecting against.
> >>
> >> My thinking is that if the integrity profile changes while i/o is in
> >> flight we can get spurious errors.  For example when enabling
> >> integrity a checksum for in-flight commands will be missing, so wait
> >> for those to complete.
> >
> > Who/what adds that checksum?  The filesystem?
> > mddev_suspend() doesn't stop the filesystem from submitting requests.
> > It just stops them from getting into md.  So when mddev_resume()
> > completes, old requests can arrive.
> 
> The block layer generates the checksum when the bio is queued.
> 
> You're right the suspend does nothing to protect against the integrity
> generated for the array.

MD and DM are _not_ using the Linux block layer's ability to generate
protection information metadata (via bio_integrity_generate).  As such
they are only providing pass-through of upper layer application
generated protection information (DIX).

A bit more explanation:
bio-based MD and DM's cloning of protection information causes their
cloned bios to have bio->bi_integrity -- as such the underlying
request-based driver skips bio_integrity_generate() via
blk_integrity_prep() (because blk_queue_bio()'s call to
bio_integrity_enabled() returns false for MD and DM's cloned bios).

> > If stability of the integrity profile is important, then we presumably
> > need to make sure it never changes (while the array is active - or at
> > least while it is mounted).  So don't accept drives which don't support
> > the current profile.  Also don't upgrade the profile just because all
> > current devices support some new feature.
> >
> > Maybe the array should have a persistent knowledge of what profile it
> > has and only accept devices which match?
> > Or maybe integrity should be completely disabled on arrays which can
> > hot-add devices (so support it on RAID0 and LINEAR, but not on
> > RAID1/4/5/6/10).
> 
> For -stable I'll develop an immediate fix that disallows live changes
> of the integrity similar to DM.
> 
> However, given no filesystem is sending down app tags, I'm wondering
> why md has integrity enabled at the array level in the first place?
> Is this just future preparation for eventual filesystem enabling?
> Otherwise, the integrity handling for each component device is
> sufficient.  I'm probably missing something.

AFAIK, Oracle DB is the only application known to be using DIX.
