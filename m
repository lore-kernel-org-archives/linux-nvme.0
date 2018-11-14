From: hare@suse.de (Hannes Reinecke)
Date: Wed, 14 Nov 2018 08:24:05 +0100
Subject: multipath-tools: add ANA support for NVMe device
In-Reply-To: <20181113161838.GC9827@localhost.localdomain>
References: <1541657381-7452-1-git-send-email-lijie34@huawei.com>
 <2691abf6733f791fb16b86d96446440e4aaff99f.camel@suse.com>
 <20181112215323.GA7983@redhat.com>
 <20181113161838.GC9827@localhost.localdomain>
Message-ID: <d8c35b13-ee5a-e4ee-847a-2bacf788825a@suse.de>

On 11/13/18 5:18 PM, Keith Busch wrote:
> On Mon, Nov 12, 2018@04:53:23PM -0500, Mike Snitzer wrote:
>> On Mon, Nov 12 2018 at 11:23am -0500,
>> Martin Wilck <mwilck@suse.com> wrote:
>>
>>> Hello Lijie,
>>>
>>> On Thu, 2018-11-08@14:09 +0800, lijie wrote:
>>>> Add support for Asynchronous Namespace Access as specified in NVMe
>>>> 1.3
>>>> TP 4004. The states are updated through reading the ANA log page.
>>>>
>>>> By default, the native nvme multipath takes over the nvme device.
>>>> We can pass a false to the parameter 'multipath' of the nvme-core.ko
>>>> module,when we want to use multipath-tools.
>>>
>>> Thank you for the patch. It looks quite good to me. I've tested it with
>>> a Linux target and found no problems so far.
>>>
>>> I have a few questions and comments inline below.
>>>
>>> I suggest you also have a look at detect_prio(); it seems to make sense
>>> to use the ana prioritizer for NVMe paths automatically if ANA is
>>> supported (with your patch, "detect_prio no" and "prio ana" have to be
>>> configured explicitly). But that can be done in a later patch.
>>
>> I (and others) think it makes sense to at least triple check with the
>> NVMe developers (now cc'd) to see if we could get agreement on the nvme
>> driver providing the ANA state via sysfs (when modparam
>> nvme_core.multipath=N is set), like Hannes proposed here:
>> http://lists.infradead.org/pipermail/linux-nvme/2018-November/020765.html
>>
>> Then the userspace multipath-tools ANA support could just read sysfs
>> rather than reinvent harvesting the ANA state via ioctl.
> 
> I'd prefer not duplicating the log page parsing. Maybe nvme's shouldn't
> even be tied to CONFIG_NVME_MULTIPATH so that the 'multipath' param
> isn't even an issue.
>   
My argument here is that _ANA_ support should not be tied to the NVME 
native multipathing at all.

Whether or not ANA is present is a choice of the target implementation; 
the host has _zero_ influence on this. It may argue all it wants and 
doesn't even have to implement multipathing. But in the end if the 
target declares a path as 'inaccessible' the path _is_ inaccessible to 
the host. Even it that particular host doesn't implement or activate 
multipathing.
(You wouldn't believe how often I had this discussion with our QA team 
for ALUA ...)

Whether or not _multipathing_ is used is a _host_ implementation, and is 
actually independent on ANA support; linux itself proved the point here 
as we supported (symmetric) multipathing far longer than we had an ANA 
implementation.

So personally I don't see why the 'raw' ANA support (parsing log pages, 
figuring out path states etc) needs to be tied in with native NVMe 
multipathing. _Especially_ not as my patch really is trivial.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
