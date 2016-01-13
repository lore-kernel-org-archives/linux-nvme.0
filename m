From: dan.j.williams@intel.com (Dan Williams)
Date: Tue, 12 Jan 2016 18:24:49 -0800
Subject: [PATCH v3 07/12] md: suspend i/o during runtime
 blk_integrity_unregister
In-Reply-To: <874mei8bu8.fsf@notabene.neil.brown.name>
References: <20151021171921.6456.1646.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20151021172001.6456.95293.stgit@dwillia2-desk3.amr.corp.intel.com>
 <874mei8bu8.fsf@notabene.neil.brown.name>
Message-ID: <CAPcyv4i8ynO8xjyML86k2cM-djvvKvSAS-dgR2XcaUwhgYC0dg@mail.gmail.com>

On Tue, Jan 12, 2016@6:14 PM, NeilBrown <neilb@suse.com> wrote:
> On Thu, Oct 22 2015, Dan Williams wrote:
>
>> Synchronize pending i/o against a change in the integrity profile to
>> avoid the possibility of spurious integrity errors.  Given linear_add()
>> is suspending the mddev before manipulating the mddev, do the same for
>> the other personalities.
>>
>> Acked-by: NeilBrown <neilb at suse.com>
>> Signed-off-by: Dan Williams <dan.j.williams at intel.com>
>> ---
>>  drivers/md/md.c        |    1 +
>>  drivers/md/multipath.c |    2 ++
>>  drivers/md/raid1.c     |    2 ++
>>  drivers/md/raid10.c    |    2 ++
>>  4 files changed, 7 insertions(+)
>>
>
>> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
>> index 7c99a4037715..6f0ec107996a 100644
>> --- a/drivers/md/raid10.c
>> +++ b/drivers/md/raid10.c
>> @@ -1736,7 +1736,9 @@ static int raid10_add_disk(struct mddev *mddev, struct md_rdev *rdev)
>>               rcu_assign_pointer(p->rdev, rdev);
>>               break;
>>       }
>> +     mddev_suspend(mddev);
>>       md_integrity_add_rdev(rdev, mddev);
>> +     mddev_resume(mddev);
>>       if (mddev->queue && blk_queue_discard(bdev_get_queue(rdev->bdev)))
>>               queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, mddev->queue);
>>
>
> Hi Dan,
>
> Somewhat belatedly I am testing this code, and it deadlocks.  Which is
> obvious once I think about it.
>
> raid10_add_disk() is called from
>   raid10d -> md_check_recovery -> remove_and_add_spares
>
> so this call to mddev_suspend() will block raid10d until all pending IO
> completes.  But raid10d might be needed to complete some IO -
> particularly in the case of errors.  I don't know exactly what is
> deadlocking in my test, but it doesn't surprise me that something does.

Ugh.

> Can you explain in more detail what needs to be synchronised here?  If
> the synchronisation doesn't happen, what can do wrong?
> Because I cannot imagine what this might actually be protecting against.

My thinking is that if the integrity profile changes while i/o is in
flight we can get spurious errors.  For example when enabling
integrity a checksum for in-flight commands will be missing, so wait
for those to complete.
