From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 12 May 2019 08:02:12 -0700
Subject: [PATCH nvme-cli rfc 3/5] fabrics: allow discover to address
 discovery controller by persistent name
In-Reply-To: <f51f039e-24f2-d01f-2ae1-9f86c99e00e2@suse.de>
References: <20190504000456.3888-1-jsmart2021@gmail.com>
 <20190504000456.3888-4-jsmart2021@gmail.com>
 <28e1e9a8-671d-e3ff-6111-7561e0f56fa9@suse.de>
 <1154a16f-222e-7a28-96c0-3a22052e2bef@broadcom.com>
 <f51f039e-24f2-d01f-2ae1-9f86c99e00e2@suse.de>
Message-ID: <1d20139f-e451-0597-a7b1-5f4afedc38fe@grimberg.me>


> My concern here is that it'll be quite hard to use the --device argument
> from within the udev event; the event itself doesn't specify the device,
> making it really hard to use them in the first place.
> Precisely due to the race issues you mentioned.
> 
> But now it becomes a be quirky; we need to have the persistent 
> connection to get the AENs (ie we do have a device node), but we cannot 
> use them from the uevent, and have to create a new one.
> 
> So this is my issue here: _if_ we have a persistent connection which 
> generates AENs, we should be using the very same connection to get the 
> discovery information in the connect-all call.
> 
> Which means we probably have to update the discovery AEN uevents to 
> include a device name; then the uevent will carry the information, and 
> the presence of the device in the uevent will tell us whether to use the 
> persistent connection or not.

thats fine...
