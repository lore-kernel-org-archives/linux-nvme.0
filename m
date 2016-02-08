From: hare@suse.de (Hannes Reinecke)
Date: Mon, 8 Feb 2016 08:26:25 +0100
Subject: complete boot failure in 4.5-rc1 caused by nvme: make SG_IO
 support optional
In-Reply-To: <1454861040.2329.4.camel@HansenPartnership.com>
References: <1454783624.2809.6.camel@HansenPartnership.com>
 <20160207092241.GA15331@lst.de>
 <1454861040.2329.4.camel@HansenPartnership.com>
Message-ID: <56B84321.3010308@suse.de>

On 02/07/2016 05:04 PM, James Bottomley wrote:
> On Sun, 2016-02-07@10:22 +0100, Christoph Hellwig wrote:
>> Keith said it should be on by default, and I promised him to change
>> it once we run into problems, which I guess this counts as.
>>
>> But just curious:  what distro are you using?  Upstream systemd
>> explicitly rejected using scsi_id for NVMe here:
>>
>> 	https://github.com/systemd/systemd/issues/1453
>>
>> and all my test systems don't do this either.
> 
> This was SUSE (in my case, openSUSE Leap).  I just checked the source
> package; they patch the by-id rules back in for NVME:
> 
> # PATCH-FIX-SUSE 1101-rules-persistent-device-names-for-NVMe-devices.patch (bsc#944132)
> Patch1101:      1101-rules-persistent-device-names-for-NVMe-devices.patch
> 
> The bugzilla is giving access denied for bug id 944132, so it's likely
> some proprietary vendor problem.  The patch has no preamble, so it's
> hard to tell what they were thinking.
> 
They didn't think at all. That abovementioned bug just states 'by-id
symlinks for NVMe drives are missing'.
And they fixed it by add the respective rules (using sg_inq) to udev.

There's no mentioning of any NVMe specific sysfs attributes whatsoever.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
