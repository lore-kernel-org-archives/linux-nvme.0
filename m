From: Frederick.Knight@netapp.com (Knight, Frederick)
Date: Fri, 11 May 2018 16:24:54 +0000
Subject: [PATCH 5/5] nvme: ANA base support
In-Reply-To: <BN7PR06MB4033F43ADC37F7428092EA5A929F0@BN7PR06MB4033.namprd06.prod.outlook.com>
References: <20180504112845.38820-1-hare@suse.de>
 <20180504112845.38820-6-hare@suse.de>
 <1525892598.30724.276.camel@localhost.localdomain>
 <CAGYjvj0Mk0MFAfUEApOOyQ9Prm3CvGcZH14PJzDQT2+Qc+w81w@mail.gmail.com>
 <20180511095025.55f1bfc8@pentland.suse.de>
 <BN7PR06MB4033848E5802B8C1DB59573F929F0@BN7PR06MB4033.namprd06.prod.outlook.com>
 <BN7PR06MB4033F43ADC37F7428092EA5A929F0@BN7PR06MB4033.namprd06.prod.outlook.com>
Message-ID: <DM6PR06MB3833FC89EF4F0E4C9C209B95F19F0@DM6PR06MB3833.namprd06.prod.outlook.com>

FK> INLINE

-----Original Message-----
From: Popuri, Sriram 
Sent: Friday, May 11, 2018 4:36 AM
To: Popuri, Sriram <Sriram.Popuri at netapp.com>; Hannes Reinecke <hare at suse.de>; Sriram Popuri <sgpopuri at gmail.com>
Cc: Knight, Frederick <Frederick.Knight at netapp.com>; linux-nvme at lists.infradead.org; emilne at redhat.com; Meneghini, John <John.Meneghini at netapp.com>
Subject: RE: [PATCH 5/5] nvme: ANA base support

Small corrections inline.

Regards,
~Sriram
-----Original Message-----
From: Linux-nvme <linux-nvme-bounces@lists.infradead.org> On Behalf Of Popuri, Sriram
Sent: Friday, May 11, 2018 1:52 PM
To: Hannes Reinecke <hare at suse.de>; Sriram Popuri <sgpopuri at gmail.com>
Cc: Knight, Frederick <Frederick.Knight at netapp.com>; linux-nvme at lists.infradead.org; emilne at redhat.com; Meneghini, John <John.Meneghini at netapp.com>
Subject: RE: [PATCH 5/5] nvme: ANA base support

My comments inline with tag "[Sriram]".

Regards,
~Sriram

-----Original Message-----
From: Hannes Reinecke <hare@suse.de>
Sent: Friday, May 11, 2018 1:20 PM
To: Sriram Popuri <sgpopuri at gmail.com>
Cc: emilne at redhat.com; linux-nvme at lists.infradead.org; Popuri, Sriram <Sriram.Popuri at netapp.com>; Knight, Frederick <Frederick.Knight at netapp.com>; Meneghini, John <John.Meneghini at netapp.com>
Subject: Re: [PATCH 5/5] nvme: ANA base support

On Thu, 10 May 2018 13:58:05 +0530
Sriram Popuri <sgpopuri@gmail.com> wrote:

> Hi,
> 
>   I work for NetApp and leading efforts to add ANA support for our 
> NVMe/FC target. So me and my team are excited with this patch.So 
> thanks for working on this!
> We had some spec comments, but John M, Fred K and others have already 
> raised it. We have few more comments looking at the overall solution.
> Please consider addressing the following:

[] FK> All spec comments that were raised were addressed.  There were no outstanding comments at the time the spec was approved (or now for that matter).

>    1. Ana log size
> 
> +             size_t ana_log_size = 4096;
> 
> This is hard coded. Don?t you expect to have a larger log page? Looks 
> like the number of ANA groups will be restricted to around 113 
> assuming one namespace identifier per ana group.
> 
> Can we have a larger ana_log_size? Maybe it should be MDTS?
> 
After revisiting the ANA Base protocol this indeed is a good question.
The spec explicitly has:

If the RGO bit is cleared to ?0? in Command Dword 10, then the LPOL field in Command Dword 12 and the LPOU field in Command Dword 13 of the Get Log Page command should be cleared to zero.
Note: Clearing the RGO bit to ?0? and setting either the LPOL field or the LPOU field to a non-zero value may return a log page that the host is unable to parse.

Which I would interpret that we _have_ to use a buffer of the correct size to retrieve the entire information.

[] FK> NO, you don't "have_to".  LPOL and LPOU are fine to use when RGO=1 (if you are getting a fixed definition data structure, then you a priory know where things are, and therefore, what offset to use to get to where you want to get).  If however, RGO=0, then the definition of the data structure is variable (the contents of offset X+n is dependent on the contents of the n bytes that come before X).  If RGO=0, the number of NSID values in each group can change (at any time), and therefore, change where things are - and therefore change the offset value you need to use - to get where you think you should be getting.  BUT, if you want to risk it, or if you've invented a unique new algorithm to find stuff in that variable structure - go for it - it is just a "should".

[Sriram] That?s precisely the reason I suggested MDTS. Target would only give you back at max the size in MDTS and you can't read beyond MDTS if the log size is larger since the spec doesn't allow you to read at some offset. So the targets have to restrict the config to be able to adjust the log page within MDTS (bad, but that?s how it is today).

[] FK> Wrong.  With RGO=1, it is fine to use the offset fields to work your way through a long log page.

Curiously, we should be able to use the LPOL and LPOU setting when the RGO bit is set, ie when we're just enumerating ANA groups.

[] FK> That is the way it was designed.

A quick calculation there reveals that the max size for the ANA log page with the RGO bit set is about 2M (65535 descriptors * 32 bytes per descriptor + 16 byte header), which probably is a bit unwieldy to use directly.

[] FK> You missed the MNAN field in that calculation.  The buffer only needs to be large enough to hold the maximum number of NSID values, not up to the maximum NSID value - you don't need to reserve space for a whole bunch of values that are never used.

So this makes it a bit awkward to handle; we first have to get the ANA log with the RGO bit set and a default size, then (possibly) re-issue the ANA log with the RGO bit set and the correct size, then calculate the actual size of the ANA log, and _then_ retrieve the full ANA log.

[] FK> Again, you missed the MNAN field - just use that, and do it once.

[Sriram] Unfortunately you can't get the correct size with the method above because the spec says if RGO=1, num_nsid field is 0. So you can't figure out the full size of log page.

My, you don't really believe in making things easy for the programmer ...

[] FK> This was agreed to by all the people on the call (which included some host programmers).

Fred: if you ever plan for a revisited ANA spec, _please_ change this.
Make the currently reserved field in the ANA log page header a max nsid count (ie store the maximum number of NSIDs per ANA group here).
With that we have a max length of the ANA log page, and would have to retrieve the log page only twice, not three times.

[] FK> You already have that with the MNAN field.

[Sriram] I second that and I did suggest this to Fred sometime back.

[] FK> Which is why we added the MNAN field.

Cheers,

Hannes
_______________________________________________
Linux-nvme mailing list
Linux-nvme at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
