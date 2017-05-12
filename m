From: Mario.Limonciello@dell.com (Mario.Limonciello@dell.com)
Date: Fri, 12 May 2017 14:34:45 +0000
Subject: [PATCH] nvme: Change our APST table to be no more aggressive than
 Intel RSTe
In-Reply-To: <CALCETrUVb8KqOOzW7fXDWCyCiXj6jpPm-w=XZ-FXrh_rfdDkJQ@mail.gmail.com>
References: <ddc5be5d81966effaf73e3cee54330c351bc8169.1494561654.git.luto@kernel.org>
 <1494597516613.95190@Dell.com>,
 <CALCETrUVb8KqOOzW7fXDWCyCiXj6jpPm-w=XZ-FXrh_rfdDkJQ@mail.gmail.com>
Message-ID: <1494599685838.3433@Dell.com>

>Yes, mostly.  I've written the patch, but I was planning to target it
>at 4.12 or 4.13 but not -stable.  It's mostly just a cleanup and has
>no real power saving benefit since the RSTe timeouts are so absurdly
>conservative that I doubt PS4 will happen in practical usage.  
OK.

>Perhaps
>in suspend-to-idle?  (For suspend-to-idle, I suspect we should really
>be using D3 instead.  Do we already do that?)

Well I think this will depend upon what the SSD "will" support.  
There isn't good documentation for how Linux "should" handle 
suspend-to-idle with disks yet, so the best you can follow is 
what Microsoft publicly mentions for Modern Standby. [1]

"Akin to AHCI PCIe SSDs, NVMe SSDs need to provide the host with a 
non-operational power state that is comparable to DEVSLP (<5mW draw, 
<100ms exit latency) in order to allow the host to perform appropriate
transitions into Modern Standby. Should the NVMe SSD not expose 
such a non-operational power state, autonomous power state 
transitions (APST) is the only other option to enter Modern 
Standby successfully.

Note that in the absence of DEVSLP or a comparable NVMe 
non-operational power state, the host can make no guarantees 
on the device?s power draw. In this case, if you observe 
non-optimal power consumption by the device/system, you 
will have to work with your device vendor to determine the cause."

Something important to consider though is that Microsoft keeps
more of the OS actually running during Modern Standby but
has deep control of what applications and kernel threads are
allowed to do.  For Linux I think that D3 is most likely going to
provide the best power for these disks.

[1] https://msdn.microsoft.com/en-us/windows/hardware/commercialize/design/device-experiences/part-selection#ssd-storage
