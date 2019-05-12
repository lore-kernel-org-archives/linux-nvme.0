From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 12 May 2019 08:00:57 -0700
Subject: [PATCH nvme-cli rfc 3/5] fabrics: allow discover to address
 discovery controller by persistent name
In-Reply-To: <1154a16f-222e-7a28-96c0-3a22052e2bef@broadcom.com>
References: <20190504000456.3888-1-jsmart2021@gmail.com>
 <20190504000456.3888-4-jsmart2021@gmail.com>
 <28e1e9a8-671d-e3ff-6111-7561e0f56fa9@suse.de>
 <1154a16f-222e-7a28-96c0-3a22052e2bef@broadcom.com>
Message-ID: <8253dfc5-0782-94a7-11fa-972d0d7657ef@grimberg.me>


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
> knows.

It seems backwards to instantiate a new discovery controller when you
already have a usable one...

>? I do have a little concern that there's always a window from 
> when the event is posted to when the /dev devicename is opened, which 
> allows for the device name to be terminated and possibly reused for 
> something else, but I guess we're willing to live with this.

Lets start by defining the expected behavior in this case. I would
expect that it will execute the discovery if an the device node exists
and fail if it something else.

If the discovery device node went away - we should not make an effort
to connect according to the discovery log page by definition (if the
device node was deleted then discovery log change events are not
interesting).

So we could have discover validate traddr/trsvcid if --device was given
but still use the existing device node.
