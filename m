From: s90752@hotmail.com (Ching-Chiao Chang)
Date: Tue, 4 Dec 2018 22:27:26 +0000
Subject: Whenever running nvme discover command, syslog shows warning
 messages
In-Reply-To: <4fb9c4fc-e5ce-2238-fbcf-1fdd6da10e23@broadcom.com>
References: <CY4PR1301MB2008564EA917C4FE4D63298585D20@CY4PR1301MB2008.namprd13.prod.outlook.com>
 <bdd5f3c7-8173-dd63-3a47-df87a9c2d14c@broadcom.com>
 <7a1a884d-5be0-064a-0865-51bca20ba919@grimberg.me>
 <CY4PR1301MB200823FB5DF08223456D9D1F85D30@CY4PR1301MB2008.namprd13.prod.outlook.com>,
 <4fb9c4fc-e5ce-2238-fbcf-1fdd6da10e23@broadcom.com>
Message-ID: <BN6PR1301MB2001C46B2AA0738A52AEDD6885AF0@BN6PR1301MB2001.namprd13.prod.outlook.com>

Hi,
It is not test case, we would like to run nvme discover in loop in an initiator, and whenever there is an NVMe volume can be attached, the the initiator can discover it and connect it automatically.

On the other hand, could I know why do the following logs shows when?running?nvme discover???what do the logs represent?
sqsize 128 > ctrl maxcmd 1, clamping down
new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery", addr 10.10.0.4:4420
Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"

Thank you?very much.



From: James Smart <james.smart@broadcom.com>
Sent: Saturday, December 1, 2018 2:48 AM
To: Ching-Chiao Chang; Sagi Grimberg; linux-nvme at lists.infradead.org
Subject: Re: Whenever running nvme discover command, syslog shows warning messages
?
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
>?? 
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
