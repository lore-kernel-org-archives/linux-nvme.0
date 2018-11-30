From: james.smart@broadcom.com (James Smart)
Date: Fri, 30 Nov 2018 10:48:55 -0800
Subject: Whenever running nvme discover command, syslog shows warning
 messages
In-Reply-To: <CY4PR1301MB200823FB5DF08223456D9D1F85D30@CY4PR1301MB2008.namprd13.prod.outlook.com>
References: <CY4PR1301MB2008564EA917C4FE4D63298585D20@CY4PR1301MB2008.namprd13.prod.outlook.com>
 <bdd5f3c7-8173-dd63-3a47-df87a9c2d14c@broadcom.com>
 <7a1a884d-5be0-064a-0865-51bca20ba919@grimberg.me>
 <CY4PR1301MB200823FB5DF08223456D9D1F85D30@CY4PR1301MB2008.namprd13.prod.outlook.com>
Message-ID: <4fb9c4fc-e5ce-2238-fbcf-1fdd6da10e23@broadcom.com>

but that's not normal, sounds like a test case.?? I wouldn't want to 
lose a debuggable situation in the field because your test case made it 
chatty.

On 11/29/2018 6:40 PM, Ching-Chiao Chang wrote:
> The reason I would like to avoid those messages is that when we put the nvme discover command in a loop, it generates a tons of those messages is syslog.
>
>
>
> Thanks.
>
>
> From: Sagi Grimberg <sagi at grimberg.me>
> Sent: Friday, November 30, 2018 9:34 AM
> To: James Smart; Ching-Chiao Chang; linux-nvme at lists.infradead.org
> Subject: Re: Whenever running nvme discover command, syslog shows warning messages
>   
>
>> no there's not - currently.
>>
>> I find them worthwhile to see, as it hints at what the admin or
>> scripting is doing, as well as giving hints on when nvme? names may be
>> reallocated. I would not remove them for normal storage controllers.
>> Perhaps a discovery controller could be filtered out, but I still find
>> it useful.
> We can filter it out for discovery controllers... I'm pretty indifferent
> about it...
