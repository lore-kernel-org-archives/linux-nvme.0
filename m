From: hare@suse.de (Hannes Reinecke)
Date: Sat, 28 Oct 2017 15:34:39 +0200
Subject: [PATCH] nvme_fc auto-connect scripts
In-Reply-To: <352f980c-2422-f917-a551-99bedf27e0ab@broadcom.com>
References: <20171009201032.2018-1-jsmart2021@gmail.com>
 <e542bb4d-946f-a080-5701-f8019fdbc752@suse.de>
 <352f980c-2422-f917-a551-99bedf27e0ab@broadcom.com>
Message-ID: <f0300e47-e219-19f9-1495-a662f9062b4d@suse.de>

On 10/27/2017 07:50 PM, James Smart wrote:
> On 10/27/2017 12:48 AM, Hannes Reinecke wrote:
>> On 10/09/2017 10:10 PM, James Smart wrote:
>>> Sagi recently posted a "one-shot" call to nvme-connect via a systemd
>>> script. FC has no problems operating with it assuming all the required
>>> connect fields are present (host_traddr required).
>>>
>>> However FC is a bit more dynamic, and we've built up scripts that can
>>> be triggered whenever a new FC remote port with a discovery subsytem is
>>> detected. Whenever such a port is detected (by registration of the
>>> remoteport with the nvme_fc transport by the lldd), the transport
>>> generates a udev event.? A udev rule is created that parses the event
>>> information into the FC remote port (traddr) that supports a discovery
>>> subsystem and the FC host port that is connected to the FC remote port
>>> (host_traddr). The rule then invokes an instance-based systemd service
>>> to perform a "nvme connect-all" with the traddr and host-traddr info.
>>>
>>> To resolve some issues seen by discovery of remote ports before the udev
>>> service was running and where the events were not replayed, there is an
>>> additional systemd service that runs once and invokes a script which
>>> locates the FC host ports on the system, looks for any connected FC
>>> remote ports with discovery subsystems, and invokes a connect-all for
>>> them.? The FC port information is specific to lpfc attributes currently,
>>> but when the shared transport is in place, they will be common.
>>>
>>> I don't claim to be a systemd expert, so comments are certainly welcome.
>>>
>> In general I'm not in favour of calling 'systemctl start' from a udev
>> rule; this typically will cause systemd to rearrange the internal
>> dependency chain, and might trigger various services to be enabled or
>> disabled.
>>
>> The 'normal' flow of events is:
>>
>> kernel device -> uevent -> udev rules -> systemd services
>>
>> ie for the autoconnect it would be _far_ better if we could have an
>> event per NVMe lport device, as then we could call 'connect' on the
>> lport device.
>>
>> So a better workflow would be to have the 'discovery' event trigger a
>> 'change' (or 'add'?) event on the lports, and then we could have
>> per-lport udev rules triggering the actualy connect.
>>
>> Let's see if I can come up with something along these lines.
>>
>> Cheers,
>>
>> Hannes
> 
> I'm certainly open to better options. udev/systemd is far from nice.?
> However, what I did has quite a bit of precedence.
> 
> I have no idea what you would scan on by just an lport. It's not enough
> for nvme-cli. You must have the lport and the rport information, which
> is passed via the udev event info and which must also be passed to nvme
> connect-all
> 
Oh, I know that.
What I would prefer is to have a single udev rule per nvme connection,
containing both lport and rport information.
That would relieve us of having additional configuration, and we can
enable/disable connection by just having that udev rule.
This works pretty well; we're doing it exactly the same way on S/390 for
the network and zfcp connections.
So if we have that then we only need to know when the lport/rport
combination is ready; once that is done we can call the udev rule.
Ideally we'll be getting an event containing both of these informations,
then udev will be selecting the correct rule automatically.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
