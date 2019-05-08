From: hare@suse.de (Hannes Reinecke)
Date: Wed, 8 May 2019 08:10:33 +0200
Subject: [PATCH nvme-cli rfc 3/5] fabrics: allow discover to address
 discovery controller by persistent name
In-Reply-To: <1154a16f-222e-7a28-96c0-3a22052e2bef@broadcom.com>
References: <20190504000456.3888-1-jsmart2021@gmail.com>
 <20190504000456.3888-4-jsmart2021@gmail.com>
 <28e1e9a8-671d-e3ff-6111-7561e0f56fa9@suse.de>
 <1154a16f-222e-7a28-96c0-3a22052e2bef@broadcom.com>
Message-ID: <f51f039e-24f2-d01f-2ae1-9f86c99e00e2@suse.de>

On 5/7/19 6:56 PM, James Smart wrote:
> On 5/7/2019 12:13 AM, Hannes Reinecke wrote:
>> On 5/4/19 2:04 AM, James Smart wrote:
>>> To support discovery (connect/connect-all) to operate against a
>>> persistent discovery controller, let the discovery controller to
>>> be specified by its device node name rather than new connection
>>> attributes.
>>>
>>> Also centralize extraction of controller instance from the controller
>>> name to a common helper.
>>>
>>> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
>>> Signed-off-by: James Smart <jsmart2021 at gmail.com>
>>> ---
>>> Patch originated from Sagi in an RFC
>>> fix merge issue
>>> fix contoller->controller
>>> add cfg.device check for "none"
>>> ---
>>> ? fabrics.c | 35 +++++++++++++++++++++++++----------
>>> ? 1 file changed, 25 insertions(+), 10 deletions(-)
>>>
>> Actually, I would rather scan existing controllers, and use the first 
>> one that matches the arguments.
>> With the current design we would have different calling sequences, 
>> depending on whether it's the first call (which create the 
>> controller), or any subsequent call.
>> If we were looking up the existing controller from the arguments we 
>> could be using the same commandline throughout.
>>
> 
> Well, this is where we're at odds.? We need to decide if we should 
> create another full controller instance when the event occurs, which is 
> what FC does today (can have multiple running concurrently), or whether 
> we want to reuse the persistent one. I would think implementers of the 
> persistent discovery controller would want you to reuse it and not have 
> to support more concurrent discovery controller instances.? The "reuse" 
> case is why passing the --device arg makes it very straight forward.? We 
> could always have the utility get the addressing info and look at 
> existing controller and decide to use an existing one - I assume we 
> would only select persistent ones in order to avoid delete race 
> conditions, but seems like a lot of work for what the AEN already 
> knows.? I do have a little concern that there's always a window from 
> when the event is posted to when the /dev devicename is opened, which
> allows for the device name to be terminated and possibly reused for 
> something else, but I guess we're willing to live with this.
> 
My concern here is that it'll be quite hard to use the --device argument
from within the udev event; the event itself doesn't specify the device,
making it really hard to use them in the first place.
Precisely due to the race issues you mentioned.

But now it becomes a be quirky; we need to have the persistent 
connection to get the AENs (ie we do have a device node), but we cannot 
use them from the uevent, and have to create a new one.

So this is my issue here: _if_ we have a persistent connection which 
generates AENs, we should be using the very same connection to get the 
discovery information in the connect-all call.

Which means we probably have to update the discovery AEN uevents to 
include a device name; then the uevent will carry the information, and 
the presence of the device in the uevent will tell us whether to use the 
persistent connection or not.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare at suse.de                              +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N?rnberg)
