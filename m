From: hare@suse.de (Hannes Reinecke)
Date: Tue, 21 Aug 2018 08:30:54 +0200
Subject: [PATCH 2/2] nvme-connect: parse 'nvme_info' sysfs attribute for
 fc transport
In-Reply-To: <3868e631-add5-bbe3-6e11-ebb687fb1e4a@broadcom.com>
References: <20180820103407.92783-1-hare@suse.de>
 <20180820103407.92783-3-hare@suse.de>
 <3868e631-add5-bbe3-6e11-ebb687fb1e4a@broadcom.com>
Message-ID: <d43b1181-995e-9b61-75c3-288422b5fd02@suse.de>

On 08/20/2018 06:23 PM, James Smart wrote:
> On 8/20/2018 3:34 AM, Hannes Reinecke wrote:
>> The 'nvme_info' sysfs attribute for the SCSI host already contains
>> all relevant information to issue a NVMe discovery. So for those
>> cases we could use that information to format a discovery command
>> and don't have to specify a discovery.conf file.
>>
>> This patch adds the infrastructure for parsing the information in
>> the 'nvme_info' sysfs attribute and uses that information to attempt
>> to connect to the discovery controller on that transport address.
>>
>> The user can select this feature by using 'nvme discover -t fc'.
>>
>> Signed-off-by: Hannes Reinecke <hare at suse.com>
>> ---
>> ? Documentation/nvme-discover.txt |?? 5 ++
>> ? fabrics.c?????????????????????? | 193
>> +++++++++++++++++++++++++++++++++++++++-
>> ? 2 files changed, 197 insertions(+), 1 deletion(-)
> 
> Well....?? I know it probably works well, but it was not in the
> direction I was going.
> 
> Here's my issues:
> 1. the nvme_info sysfs parameter is not part of any transport and is a
> lpfc-specific attribute. So adding this into nvmecli concerns me. I
> don't know that lpfc has even considered the text format sufficient for
> being an "api" that can be called by "nvmecli" - meaning I don't know
> that it will pass the backward-compatibility tests.
> 2. What you are looking for is unnecessary: The patch to repost
> connectivity events has been post. Christoph just needs to review it
> again. I'll repost.
> 3. I also don't like parsing scsi stuff in the nvme cli. If we really
> need to pull fc-isms from it, then we should start the work for moving
> the fc transport out of scsi and into it's own layer that binds with
> scsi and nvme.? But I'd rather finish the fixes in nvme cli to address
> async connections, retries while controller being reconnected to, etc -
> that all enable the simple udev script.
> 
Well, _actually_ I sort-of-expected this response :-)
It was primarily a reminder to folks that there are open issues where we
need to look into.
(And actually I'm waiting for TP8002 to be ratified, as this implements
quite some key logic I'd need...)

My plan here is as follows:

- Implement an 'async-connect' option to nvme-cli, which would instruct
the kernel code to _not_ wait for the connect/reconnect workqueue
function but rather return immediately.
- Implement a workqueue function for the discovery controller to
retrieve the discovery log page, store it in a sysfs attribute, and send
an uevent for each found subsystem NQN.
- Invoke this workqueue whenever 'nvme discover' is called with the
async-connect option enabled.

With this we have the following workflow:

1. FC-NVMe posts an uevent whenever an FC-NVMe target port has been found
2. A udev rule parses this event and calls 'nvme discover
--async-connect' to the target address of these ports
3. The 'discovery' workqueue function retrieves the discovery log page
and issues uevents for each found subsystem NQN
4. A udev rule parses this event and calls 'nvme connect
--async-connect' for each of these events

The first step is actually optional; we can invoke 'nvme discover
--async-connect' even manually from a systemd service during boot up.
Which has the nice advantage of working for RDMA, too.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
