From: hare@suse.de (Hannes Reinecke)
Date: Wed, 20 Feb 2019 07:52:00 +0100
Subject: [PATCH 2/2] nvme: protect against race condition in
 nvme_validate_ns()
In-Reply-To: <20190219195433.GE16341@localhost.localdomain>
References: <20190219121358.57975-1-hare@suse.de>
 <20190219121358.57975-3-hare@suse.de>
 <5f600cbc-eab7-0c72-5ecf-50a12180082c@grimberg.me>
 <20190219195433.GE16341@localhost.localdomain>
Message-ID: <3a377511-6eb9-32f7-3d98-8667ac5ae80d@suse.de>

On 2/19/19 8:54 PM, Keith Busch wrote:
> On Tue, Feb 19, 2019@11:44:41AM -0800, Sagi Grimberg wrote:
>> On 2/19/19 4:13 AM, Hannes Reinecke wrote:
>>> When subsystems are rapidly reconfigured (or sending out several AENs)
>>> we might end up in a situation where several instances of nvme_scan_work()
>>> are running. Each of which might be trying to register the same nsid,
>>> so nvme_find_get_ns() in nvme_validate_ns() will return 0 for both,
>>> resulting in a crash in nvme_alloc_ns() as both are registering a
>>> gendisk with the same name.
>>
>> Wouldn't it be better to serialize nvme_scan_work such that it doesn't
>> run multiple times in parallel?
> 
> Doesn't the work queue already serialize individual ctrl's scan_work?
> 
> There is also a recently added mutex to synchronize scan work with
> command effects handling, which would force an nvme_ctrl's scan_work to
> be serialized:
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e7ad43c3eda6a1690c4c3c341f95dc1c6898da83
> 
Ah. Hmm.
Probably.
And indeed, the tests were done without this patch.
I'll check if that patch is sufficient.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
