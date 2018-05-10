From: hare@suse.de (Hannes Reinecke)
Date: Thu, 10 May 2018 15:40:33 +0200
Subject: [PATCH 5/5] nvme: ANA base support
In-Reply-To: <CAGYjvj0Mk0MFAfUEApOOyQ9Prm3CvGcZH14PJzDQT2+Qc+w81w@mail.gmail.com>
References: <20180504112845.38820-1-hare@suse.de>
 <20180504112845.38820-6-hare@suse.de>
 <1525892598.30724.276.camel@localhost.localdomain>
 <CAGYjvj0Mk0MFAfUEApOOyQ9Prm3CvGcZH14PJzDQT2+Qc+w81w@mail.gmail.com>
Message-ID: <46db4cc8-7d66-b9ba-a092-093aa4305a28@suse.de>

On 05/10/2018 10:28 AM, Sriram Popuri wrote:
> Hi,
> 
>  ? I work for NetApp and leading efforts to add ANA support for our 
> NVMe/FC target. So me and my team are excited with this patch.So thanks 
> for working on this!
> We had some spec comments, but John M, Fred K and others have already 
> raised it. We have few more comments looking at the overall solution. 
> Please consider addressing the following:
> 
>  1. Ana log size
> 
> + size_t ana_log_size = 4096;
> 
> This is hard coded. Don?t you expect to have a larger log page? Looks 
> like the number of ANA groups will be restricted to around 113 assuming 
> one namespace identifier per ana group.
> 
> Can we have a larger ana_log_size? Maybe it should be MDTS?
> 
Yeah, 'tis a bit of a cheeky implementation.
I'll see to make it configurable.

>  2. Sanity check after reading ana log page
> 
> There should be a sanity check to make sure the log page is read 
> completely. A check to see if all the ana groups are read and all the 
> num nsids(for the last group) are read otherwise states on few namespace 
> paths will be stale.
> 
Well; this basically is the same issue we had with ALUA on the SCSI 
side. What _are_ the correct actions if the ANA log page couldn't be 
read properly?
Sure, one could to a retry, but even that will be exhausted after some 
iterations. What then?
Fail the controller?
-> probably not the best of options; after all, ANA support is optional.
Set the paths to failed?
-> Again, probably not the best of ideas as the path itself might be 
operational.
So for now it's probably best to just leave the states as they are and 
wait for the situation to resolve itself.

>  3. ANATT not used.
> 
> Didn't see anatt honored. Is there a plan to do that in future?
> 
> Looks like you retry forever if there is any path related error.
> 
True. What we _could_ to is to move the paths to a tentative 
'non-optimized' state, and see if the I/O succeeds. If it fails we 
should be getting an appropriate status code, and should be able to set 
the path status accordingly.
We will not get a notification for the optimized path, but then 
something went wrong on the array, so we don't know the correct status.

Maybe this would be the best solution:

1.) If the ANA log fails set all paths to an invalid ANA state (eg 0), 
thus allowing I/O to continue. If the I/O comes back with an ANA status 
code like 'inaccessible' or 'persistent loss' (or even 'transitioning', 
use that to update the status. Then schedule an ANA log read at a later 
time (eg 1 seconds later or somesuch).
2.) If the paths are in 'transitioning' retry I/O until ANATT.
If we get an AEN signalling a state change or ANATT expired submit an 
ANA log page read to update the ANA state. If that fails, continue at 1.


> Let's say there are two paths ANA Optimized and other path ANA 
> Inaccessible and then the ANA optimized path is transitioning to ANA 
> Inaccessible.
> 
> If my understanding is correct, this is what happens:
> 
> * Linux gets back ANA Transition.
> 
> * The current controller is reset.
> 
> * IO will be requeued or failover to other path regardless of the other 
> path being still Inaccessible (or even Persistent loss).
> 
> * nvme_find_path will return null so the IO is requeued again.
> 
> * This state continues till the target completes an AER(?)
> 
> Can it go forever?
> 
The entire idea here is that the controller does _not_ need to be reset; 
yes, we've returned with an status, but this actually is expected, and 
shouldn't cause the controller to be reset.
Obviously we need to update the ANA state on all paths before attempting 
a failover; otherwise we're running against a not-yet-updated path in eg 
inaccessible and would not be able to issue I/O.

>  4. Controller reset on path related errors
> 
> Looks like any path related errors will result in controller reset. This 
> looks bad as path change for a single namespace will result in 
> controller reset.? Didn?t see any special handling for path related 
> errors. Should that happen as controller reset is a bigger hammer for 
> these errors?
> 
For 'normal' path state change errors like 'ANA inaccessible' we 
shouldn't reset the controller; but we'll need to run some tests here 
how the system actually behaves.

>  5. Path related error handling
> 
> Again on the same lines as above. All path related errors fall in one 
> category as of now (BLK_STS_IOERR). Handling of persistent loss or ANA 
> inaccessible or ANA transition should be according to the spec.
> 
Yeah, that's actually wrong. I've got a patch reclassifying ANA errors 
as path errors, which hopefully resolves this.

>  6. Detecting host ANA support.
> 
> Didn?t see good way for target to know if host is ANA complaint or not 
> in the spec itself. One way we can negotiate ANA support is through set 
> features(0Bh). That helps targets to know whether its ok to return ANA 
> path related errors or complete AERs with ANA change notice.
> 
> Is there a plan to implement set features (0Bh) to negotiate 
> asynchronous event configuration?
> 
Well. Yes, obviously we should be registering for ANA AENs; might be 
that the current code doesn't do it as the linux target implementation 
is somewhat lazy in that respect.

Cheers,

Hannes
