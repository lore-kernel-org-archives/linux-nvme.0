From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 15 Mar 2019 13:38:34 -0700
Subject: [PATCH nvme-cli rfc 0/6] Support discovery log change events
In-Reply-To: <a4f8ca74-7777-9e80-3209-ef9ce27ad2d8@suse.de>
References: <20190223023257.21227-1-sagi@grimberg.me>
 <d4012891-8bc7-00cf-ab96-7828270d25af@suse.de>
 <e7423c76-6425-4020-2074-b977fc87866f@grimberg.me>
 <d1742744-1109-e7e8-3586-fca6556c803b@broadcom.com>
 <d7bbfc2a-92ea-315d-bbd6-cd3847449f7b@grimberg.me>
 <3b524b54-8f13-24f5-4367-34a4d02c59b3@broadcom.com>
 <5c64286b-3fbf-9dfe-ef8a-3f72e630f11d@broadcom.com>
 <a4f8ca74-7777-9e80-3209-ef9ce27ad2d8@suse.de>
Message-ID: <44f637f2-0c0d-cef4-05b3-c5e67ec907bb@grimberg.me>


> I do have some quite fundamental problem with discovery log change events:
> - The initial discovery is still unsolved, ie we have to know the 
> transport address before we can even get to those events

I understand your concern, but its completely irrelevant to this.
This is a building block to automate the entire sequence, but
the fact that we don't have it all automated doesn't mean we should
not support discovery log change AENs.

For root discovery automation, we can talk about bringing a tpar
with a prototype.

> - More crucially, we don't get these events when we to the first 
> connection, requiring us to have the initial call to 'connect-all' on a 
> separate way.

Again, this is initial root discovery, which is irrelevant to discovery
log change events.

> - We don't have any indication if a new subsystem has been created; once 
> a subsystem a new subsystem on another port is created it's anyones 
> guess if that'll show up on the particular discovery controller

What? the event is on the port level, every port/subsystem softlink will
trigger a discovery log change event. Its not anyones guess, its pretty
deterministic given that you have discovery controller connected to the
port.

> Especially the second point is most vexing; we could get around this by 
> requiring the discovery controller to send AENs on the initial connect
> (well, actually as soon as the AENs are enabled), but I guess that'll 
> require a change to the spec ...

Why? with a script to auto-connect or root discovery automation this is 
no longer an issue (not sure how much this is an issue right now).
