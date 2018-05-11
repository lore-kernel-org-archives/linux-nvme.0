From: Sriram.Popuri@netapp.com (Popuri, Sriram)
Date: Fri, 11 May 2018 08:22:19 +0000
Subject: [PATCH 5/5] nvme: ANA base support
In-Reply-To: <20180511095025.55f1bfc8@pentland.suse.de>
References: <20180504112845.38820-1-hare@suse.de>
 <20180504112845.38820-6-hare@suse.de>
 <1525892598.30724.276.camel@localhost.localdomain>
 <CAGYjvj0Mk0MFAfUEApOOyQ9Prm3CvGcZH14PJzDQT2+Qc+w81w@mail.gmail.com>
 <20180511095025.55f1bfc8@pentland.suse.de>
Message-ID: <BN7PR06MB4033848E5802B8C1DB59573F929F0@BN7PR06MB4033.namprd06.prod.outlook.com>

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
> 
> 
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

[Sriram] That?s precisely the reason I suggested MDTS. Target would only give you back the size in MDTS and you can't read beyond MDTS since the spec doesn't allow you to read at some offset.

Curiously, we should be able to use the LPOL and LPOU setting when the RGO bit is set, ie when we're just enumerating ANA groups.

[Sriram] I second that and I did suggest this to Fred sometime back.

A quick calculation there reveals that the max size for the ANA log page with the RGO bit set is about 2M (65535 descriptors * 32 bytes per descriptor + 16 byte header), which probably is a bit unwieldy to use directly.

So this makes it a bit awkward to handle; we first have to get the ANA log with the RGO bit set and a default size, then (possibly) re-issue the ANA log with the RGO bit set and the correct size, then calculate the actual size of the ANA log, and _then_ retrieve the full ANA log.

[Sriram] Unfortunately you can't get the correct size with the method above because the spec says if RGO=1, num_nsid field is 0. So you can't figure out the full size of log page.

My, you don't really believe in making things easy for the programmer ...

Fred: if you ever plan for a revisited ANA spec, _please_ change this.
Make the currently reserved field in the ANA log page header a max nsid count (ie store the maximum number of NSIDs per ANA group here).
With that we have a max length of the ANA log page, and would have to retrieve the log page only twice, not three times.

Cheers,

Hannes
