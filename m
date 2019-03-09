From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 8 Mar 2019 18:18:31 -0800
Subject: [PATCH nvme-cli rfc 0/6] Support discovery log change events
In-Reply-To: <e7423c76-6425-4020-2074-b977fc87866f@grimberg.me>
References: <20190223023257.21227-1-sagi@grimberg.me>
 <d4012891-8bc7-00cf-ab96-7828270d25af@suse.de>
 <e7423c76-6425-4020-2074-b977fc87866f@grimberg.me>
Message-ID: <e63d50f4-7994-a4d9-1fcd-8544eb26f215@grimberg.me>


>> What I really want to do here is to add a '--dry-run' option to 
>> nvme-cli, which then would instruct nvme-cli to _not_ write the final 
>> string to the ioctl interface but rather to stdout.
>> This string will not contain any spaces, and have each argument (minus 
>> any leading dashes) concatenated by commas.
>> So it should be possible to use this string as argument for the 
>> systemd service.
>> Then we only need to complementary call --argstr to accept this string 
>> for nvme-cli, re-parse it into the internal structure, and continue 
>> with the operation.
>>
>> I do have some patches, but still need to polish them off (and 
>> possibly test them :-) before sending.
> 
> Not sure if that is any better, but lets see patches...

Hannes,

Did you get around to looking into this?

I didn't get any feedback from others on this btw, would be
good to know what people think assuming we do want to support
discovery change log events...
