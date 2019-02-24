From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 24 Feb 2019 14:33:12 -0800
Subject: [PATCH nvme-cli rfc 0/6] Support discovery log change events
In-Reply-To: <d4012891-8bc7-00cf-ab96-7828270d25af@suse.de>
References: <20190223023257.21227-1-sagi@grimberg.me>
 <d4012891-8bc7-00cf-ab96-7828270d25af@suse.de>
Message-ID: <e7423c76-6425-4020-2074-b977fc87866f@grimberg.me>


> Hmm.
> 
> Last time I've posted the autoconnect scripts you said you'd rather have 
> them updated to be useful for generic discovery events.
> So what happened to that?

I would like to have a single event, but the one difference is that
the discovery log page events come on a discovery controller and in
the fc case we don't have such a controller (the NVME_INSTANCE env).

If we can resolve this difference we can unite and have a single udev
handler for both...

> As it stands (and as posted here) these scripts are pretty much 
> independent on the remaining series as they react to the existent FC 
> NVMe uevents.

Well at least the nvmf-connect at .service is shared...

> And the one thing which I patently dislike about those scripts is this 
> utterly weird interface.
> Problem here is that abstract systemd services (ie those ending with an 
> '@' sign) can pass exactly _one_ argument, namely that one following the 
> '@' sign.
> But for nvme we need to pass in several arguments, one for each 
> command-line parameter.
> 
> The way it's solved nowadays is to insert a 'tab' character (\t) between 
> each argument, use the combined string as parameter to the systemd 
> service, and call 'echo' to split the parameters again.
> Shudder.

Can't say I like it either...

> What I really want to do here is to add a '--dry-run' option to 
> nvme-cli, which then would instruct nvme-cli to _not_ write the final 
> string to the ioctl interface but rather to stdout.
> This string will not contain any spaces, and have each argument (minus 
> any leading dashes) concatenated by commas.
> So it should be possible to use this string as argument for the systemd 
> service.
> Then we only need to complementary call --argstr to accept this string 
> for nvme-cli, re-parse it into the internal structure, and continue with 
> the operation.
> 
> I do have some patches, but still need to polish them off (and possibly 
> test them :-) before sending.

Not sure if that is any better, but lets see patches...
