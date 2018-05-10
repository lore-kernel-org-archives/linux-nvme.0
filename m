From: sgpopuri@gmail.com (Sriram Popuri)
Date: Thu, 10 May 2018 14:46:38 +0530
Subject: [PATCH 5/5] nvme: ANA base support
In-Reply-To: <1525892598.30724.276.camel@localhost.localdomain>
References: <20180504112845.38820-1-hare@suse.de>
 <20180504112845.38820-6-hare@suse.de>
 <1525892598.30724.276.camel@localhost.localdomain>
Message-ID: <CAGYjvj2Kty5+w9rKdNHyChQDwB-Cy3iTGOkfM8jTFpDQCRSjcQ@mail.gmail.com>

Hi,

  I work for NetApp and leading efforts to add ANA support for our
NVMe/FC target. So me and my team are excited with this patch.So
thanks for working on this!
We had some spec comments, but John M, Fred K and others have already
raised it. We have few more comments looking at the overall solution.
Please consider addressing the following:

1) Ana log size
+             size_t ana_log_size = 4096;

This is hard coded. Don?t you expect to have a larger log page? Looks
like the number of ANA groups will be restricted to around 113
assuming one namespace identifier per ana group.
Can we have a larger ana_log_size? Maybe it should be MDTS?

2) Sanity check after reading ana log page
There should be a sanity check to make sure the log page is read
completely. A check to see if all the ana groups are read and all the
num nsids(for the last group) are read otherwise states on few
namespace paths will be stale.

3) ANATT not used.
Didn't see anatt honored. Is there a plan to do that in future?
Looks like you retry forever if there is any path related error.
Let's say there are two paths ANA Optimized and other path ANA
Inaccessible and then the ANA optimized path is transitioning to ANA
Inaccessible.
If my understanding is correct, this is what happens:
* Linux gets back ANA Transition.
* The current controller is reset.
* IO will be re-queued or failover to other path regardless of the
other path being still Inaccessible (or even Persistent loss).
* nvme_find_path will return null so the IO is re-queued again.
* This state continues till the target completes an AER(?)
Can it go forever?

4) Controller reset on path related errors
Looks like any path related errors will result in controller reset.
This looks bad as path change for a single namespace will result in
controller reset.  Didn?t see any special handling for path related
errors. Should that happen as controller reset is a bigger hammer for
these errors?

5) Path related error handling
Again on the same lines as above. All path related errors fall in one
category as of now (BLK_STS_IOERR). Handling of persistent loss or ANA
inaccessible or ANA transition should be according to the spec.

6) Detecting host ANA support.
Didn?t see good way for target to know if host is ANA complaint or not
in the spec itself. One way we can negotiate ANA support is through
set features(0Bh). That helps targets to know whether its ok to return
ANA path related errors or complete AERs with ANA change notice.
Is there a plan to implement set features (0Bh) to negotiate
asynchronous event configuration?

Regards,
~Sriram

On Thu, May 10, 2018@12:33 AM, Ewan D. Milne <emilne@redhat.com> wrote:
> On Fri, 2018-05-04@13:28 +0200, Hannes Reinecke wrote:
>> Add ANA support to the nvme host. If ANA is supported the state
>> and the group id are displayed in new sysfs attributes 'ana_state' and
>> 'ana_group'.
>>
>> Signed-off-by: Hannes Reinecke <hare at suse.com>
>> ---
>>  drivers/nvme/host/core.c      | 123 +++++++++++++++++++++++++++++++++++++++++-
>>  drivers/nvme/host/multipath.c |  12 ++++-
>>  drivers/nvme/host/nvme.h      |   3 ++
>>  3 files changed, 136 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> ...
>> +static void nvme_ana_change_work(struct work_struct *work)
>> +{
>> +     struct nvme_ctrl *ctrl = container_of(work,
>> +                             struct nvme_ctrl, ana_change_work);
>> +
>> +     if (ctrl->state != NVME_CTRL_LIVE)
>> +             return;
>> +
>> +     down_read(&ctrl->namespaces_rwsem);
>> +     nvme_get_full_ana_log(ctrl);
>> +     up_read(&ctrl->namespaces_rwsem);
>> +}
>> +
>
> Do we really want to be holding the semaphore while performing the
> command to get the log page, particularly in a fabric environment?
> Or would it be sufficient to hold it after the log page is fetched
> and we are iterating over the ctrl->namespaces list in
> nvme_get_full_ana_log()?
>
> (BTW, nvme_get_full_ana_log() has the same issue w/error returned
> from nvme_get_log() as nvme_get_ana_log()).
>
> -Ewan
>
>
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
