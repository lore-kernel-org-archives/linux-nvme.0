From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 26 Apr 2019 12:10:41 -0700
Subject: [PATCH nvme-cli rfc 0/6] Support discovery log change events
In-Reply-To: <f4594084-4f2a-33ca-77b4-d7075bbb12af@broadcom.com>
References: <20190223023257.21227-1-sagi@grimberg.me>
 <d4012891-8bc7-00cf-ab96-7828270d25af@suse.de>
 <e7423c76-6425-4020-2074-b977fc87866f@grimberg.me>
 <d1742744-1109-e7e8-3586-fca6556c803b@broadcom.com>
 <d7bbfc2a-92ea-315d-bbd6-cd3847449f7b@grimberg.me>
 <3b524b54-8f13-24f5-4367-34a4d02c59b3@broadcom.com>
 <5c64286b-3fbf-9dfe-ef8a-3f72e630f11d@broadcom.com>
 <a4f8ca74-7777-9e80-3209-ef9ce27ad2d8@suse.de>
 <44f637f2-0c0d-cef4-05b3-c5e67ec907bb@grimberg.me>
 <f0e112f7-0db5-4928-0859-8b3b6b797432@grimberg.me>
 <9d0e3080-baa7-6f55-2548-097523bb3a83@suse.de>
 <03163041-9b14-3662-edb8-1d69f20f681f@grimberg.me>
 <f4594084-4f2a-33ca-77b4-d7075bbb12af@broadcom.com>
Message-ID: <2a08f760-0aeb-d788-3210-72ec9d6eb9bc@grimberg.me>


>> Now, I'm suggesting to support discovery change log events by allowing
>> the user to setup a persistent discovery controller and have the kernel
>> fire to userspace discovery change log events over that controller.
>>
>> Any comments/feedback/alternatives on _this_?
> 
> I think it's fine, and we should be able to merge possibly what the AEN 
> event looks like and the FC event.? The Events are pretty much the same 
> between FC and the AEN -> go perform a connect-all against the indicated 
> discovery controller.?? What is different is how do you identify the 
> discovery controller, and if you are re-using an an existing controller, 
> how would that connect-all occur if it doesn't create a new discovery 
> controller instance.? For how to identify the discovery controller, it 
> could be: a) by full discovery-log-based-address fields? (not all must 
> be present; e.g. FC);? b) by /dev/nvme? name of the persistent discovery 
> controller (e.g. the AEN); or c) a derivation of the /dev/nvme? name 
> (aka (b)) by using (a) to see if a persistent controller exists at that 
> location.
> Am I getting a little off base ?

Not at all,

Given that FC does not need a persistent discovery controller to get the
event, its fine that it will create a temporary discovery controller.
Given that FC and IP do different things, we can separate them. But what
I wanted to understand, is if I export a second subsystem on the same
FC port, will it generate an FC event?

The only thing we need to make sure works is when FC also has a
persistent discovery controller and it will see both FC events and
nvme discovery log change events (not sure its a valid use-case at all
though). I don't see how that could break because if I understand
correctly it will see two events and worst case will fail to connect
duplicate controller quietly which is fine I guess...


> I agree - we don't need to address is how does one initially create the 
> persistent discovery controller.

Exactly, we can worry about that afterwards, once we have a TP in place.
