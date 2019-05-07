From: james.smart@broadcom.com (James Smart)
Date: Tue, 7 May 2019 09:56:44 -0700
Subject: [PATCH nvme-cli rfc 3/5] fabrics: allow discover to address
 discovery controller by persistent name
In-Reply-To: <28e1e9a8-671d-e3ff-6111-7561e0f56fa9@suse.de>
References: <20190504000456.3888-1-jsmart2021@gmail.com>
 <20190504000456.3888-4-jsmart2021@gmail.com>
 <28e1e9a8-671d-e3ff-6111-7561e0f56fa9@suse.de>
Message-ID: <1154a16f-222e-7a28-96c0-3a22052e2bef@broadcom.com>

On 5/7/2019 12:13 AM, Hannes Reinecke wrote:
> On 5/4/19 2:04 AM, James Smart wrote:
>> To support discovery (connect/connect-all) to operate against a
>> persistent discovery controller, let the discovery controller to
>> be specified by its device node name rather than new connection
>> attributes.
>>
>> Also centralize extraction of controller instance from the controller
>> name to a common helper.
>>
>> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
>> Signed-off-by: James Smart <jsmart2021 at gmail.com>
>> ---
>> Patch originated from Sagi in an RFC
>> fix merge issue
>> fix contoller->controller
>> add cfg.device check for "none"
>> ---
>> ? fabrics.c | 35 +++++++++++++++++++++++++----------
>> ? 1 file changed, 25 insertions(+), 10 deletions(-)
>>
> Actually, I would rather scan existing controllers, and use the first 
> one that matches the arguments.
> With the current design we would have different calling sequences, 
> depending on whether it's the first call (which create the 
> controller), or any subsequent call.
> If we were looking up the existing controller from the arguments we 
> could be using the same commandline throughout.
>

Well, this is where we're at odds.? We need to decide if we should 
create another full controller instance when the event occurs, which is 
what FC does today (can have multiple running concurrently), or whether 
we want to reuse the persistent one. I would think implementers of the 
persistent discovery controller would want you to reuse it and not have 
to support more concurrent discovery controller instances.? The "reuse" 
case is why passing the --device arg makes it very straight forward.? We 
could always have the utility get the addressing info and look at 
existing controller and decide to use an existing one - I assume we 
would only select persistent ones in order to avoid delete race 
conditions, but seems like a lot of work for what the AEN already 
knows.? I do have a little concern that there's always a window from 
when the event is posted to when the /dev devicename is opened, which 
allows for the device name to be terminated and possibly reused for 
something else, but I guess we're willing to live with this.

And as for "not scanning" when you connect to the persistent discovery 
controller, and instead acting off of a pseudo-AEN posted to udev - it's 
I nice premise, but I'm not sure what it buys you. At best, it's a 
difference in how you connect to the persistent controller - e.g. 
"--connect" vs "--connect-all". Given all the logic is there and present 
with connect-all, I don't know why you wouldn't just use it.? We can 
always decide to post additional AENs in the kernel if needed (and there 
will always be races of multiple AEN's kicking off multiple rescans 
concurrently).

-- james
