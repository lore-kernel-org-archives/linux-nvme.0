From: keith.busch@intel.com (Keith Busch)
Date: Mon, 22 Jan 2018 14:30:25 -0700
Subject: Report long suspend times of NVMe devices (mostly
 firmware/device issues)
In-Reply-To: <9e398971-762d-bb1a-f798-bf0b18cb5b6b@molgen.mpg.de>
References: <9e398971-762d-bb1a-f798-bf0b18cb5b6b@molgen.mpg.de>
Message-ID: <20180122213024.GR12043@localhost.localdomain>

On Mon, Jan 22, 2018@10:02:12PM +0100, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> Benchmarking the ACPI S3 suspend and resume times with `sleepgraph.py
> -config config/suspend-callgraph.cfg` [1], shows that the NVMe disk SAMSUNG
> MZVKW512HMJP-00000 in the TUXEDO Book BU1406 takes between 0.3 and 1.4
> seconds, holding up the suspend cycle.
> 
> The time is spent in `nvme_shutdown_ctrl()`.
> 
> ### Linux 4.14.1-041401-generic
> 
> > nvme @ 0000:04:00.0 {nvme} async_device (Total Suspend: 1439.299 ms Total Resume: 19.865 ms)
> 
> ### Linux 4.15-rc9
> 
> > nvme @ 0000:04:00.0 {nvme} async_device (Total Suspend: 362.239 ms Total Resume: 19.897 m
> It?d be useful, if the Linux kernel logged such issues visibly to the user,
> so that the hardware manufacturer can be contacted to fix the device
> (probably the firmware).
> 
> In my opinion anything longer than 200 ms should be reported similar to [2],
> and maybe worded like below.
> 
> > NVMe took more than 200 ms to do suspend routine
> 
> What do you think?

The nvme spec guides toward longer times than that. I don't see the
point of warning users about things operating within spec.
