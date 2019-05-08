From: james.smart@broadcom.com (James Smart)
Date: Wed, 8 May 2019 12:31:27 -0700
Subject: [PATCH nvme-cli rfc 3/5] fabrics: allow discover to address
 discovery controller by persistent name
In-Reply-To: <f51f039e-24f2-d01f-2ae1-9f86c99e00e2@suse.de>
References: <20190504000456.3888-1-jsmart2021@gmail.com>
 <20190504000456.3888-4-jsmart2021@gmail.com>
 <28e1e9a8-671d-e3ff-6111-7561e0f56fa9@suse.de>
 <1154a16f-222e-7a28-96c0-3a22052e2bef@broadcom.com>
 <f51f039e-24f2-d01f-2ae1-9f86c99e00e2@suse.de>
Message-ID: <3f84d637-4d04-45e1-ce49-59238c2aaea8@broadcom.com>



On 5/7/2019 11:10 PM, Hannes Reinecke wrote:
> On 5/7/19 6:56 PM, James Smart wrote:
>>
>> Well, this is where we're at odds.? We need to decide if we should 
>> create another full controller instance when the event occurs, which 
>> is what FC does today (can have multiple running concurrently), or 
>> whether we want to reuse the persistent one. I would think 
>> implementers of the persistent discovery controller would want you to 
>> reuse it and not have to support more concurrent discovery controller 
>> instances.? The "reuse" case is why passing the --device arg makes it 
>> very straight forward.? We could always have the utility get the 
>> addressing info and look at existing controller and decide to use an 
>> existing one - I assume we would only select persistent ones in order 
>> to avoid delete race conditions, but seems like a lot of work for 
>> what the AEN already knows.? I do have a little concern that there's 
>> always a window from when the event is posted to when the /dev 
>> devicename is opened, which
>> allows for the device name to be terminated and possibly reused for 
>> something else, but I guess we're willing to live with this.
>>
> My concern here is that it'll be quite hard to use the --device argument
> from within the udev event; the event itself doesn't specify the device,
> making it really hard to use them in the first place.
> Precisely due to the race issues you mentioned.

uevent does specify the device (the --device argument). I don't know 
about hard - simply build up a string with "nvme" + ctrl instance # ? ? 
 ? example: nvme5

>
> But now it becomes a be quirky; we need to have the persistent 
> connection to get the AENs (ie we do have a device node), but we 
> cannot use them from the uevent, and have to create a new one.

?? not sure I follow. You seemed to say - we won't attempt to use the 
existing device and would create a new one.

>
> So this is my issue here: _if_ we have a persistent connection which 
> generates AENs, we should be using the very same connection to get the 
> discovery information in the connect-all call.
>
> Which means we probably have to update the discovery AEN uevents to 
> include a device name; then the uevent will carry the information, and 
> the presence of the device in the uevent will tell us whether to use 
> the persistent connection or not.
>

I thought that's what we said.? We're dealing with a persistent 
controller that was created at some time that eventually generates an 
AEN. And the current proposal is for the AEN to generate a udev event 
that will contain --device=nvme<instance#> (corresponding to the 
persistent controller) which will do a connect-all.? The cli, seeing the 
device argument will skip trying to create a controller and instead open 
the device and then resume normal connect-all scanning/processing.? We 
are in agreement on this ?

Which leaves:
a) how does the persistent controller get created in the first place:? 
which I answer with admin scripting, manual action, or transport event 
generation.
and
b) if performing a connect-all, and a discovery log was read with a 
discovery controller as a log entry, how should the cli know whether to 
create the controller as persistent or not:? which I proposed that it be 
one of the following: a) it doesn't, only manual actions/scripting would 
set the parameter; b) the new defaults file processing can figure out 
that it needs to add the argument; or c) we change the default action 
when connecting to a discovery controller to look at the KAS field to 
see if kato is supported, and if so, always enable the persistent option 
(in which case, no --persistent argument is necessary).

-- james
