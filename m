From: hare@suse.de (Hannes Reinecke)
Date: Fri, 14 Dec 2018 08:47:20 +0100
Subject: [PATCH 4/4] block: expose devt for GENHD_FL_HIDDEN disks
In-Reply-To: <20181213152532.GA5321@calabresa>
References: <20181206164812.30925-1-cascardo@canonical.com>
 <20181206164812.30925-5-cascardo@canonical.com>
 <b3ef062d-3bc3-fdf8-f395-31d1822a3192@suse.de> <20181213143218.GA8723@lst.de>
 <20181213152532.GA5321@calabresa>
Message-ID: <35acb1b3-77f5-29cf-b92d-5171f4ad6450@suse.de>

On 12/13/18 4:25 PM, Thadeu Lima de Souza Cascardo wrote:
> On Thu, Dec 13, 2018@03:32:18PM +0100, Christoph Hellwig wrote:
>> On Thu, Dec 13, 2018@10:18:40AM +0100, Hannes Reinecke wrote:
>>> Welll ... this is not just 'lsblk', but more importantly this will force
>>> udev to create _block_ device nodes for the hidden devices, essentially
>>> 'unhide' them.
>>>
>>> Is this what we want?
>>> Christoph?
>>> I thought the entire _point_ of having hidden devices is that the are ...
>>> well ... hidden ...
>>
>> Yes, that is why I really don't like the last two patches.
>>
>> And I've checked back - lsblk actually works just fine at the moment.
>> But it turns out once we create the slave links it stops working,
>> which is a really good argument against the first two patches, which
>> would otherwise seem nice..
> 
> Which is why I have sent the "paths/" patchset in the first place. Because I
> did some homework and read the previous discussion about this, and how lsblk
> failure to behave with slave links led to the revert of the slaves/holders
> patch by Dr. Hannes.
> 
But you haven't answered my question:

Why can't we patch 'lsblk' to provide the required information even with 
the current sysfs layout?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
