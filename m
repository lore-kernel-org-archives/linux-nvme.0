From: gpiccoli@linux.vnet.ibm.com (Guilherme G. Piccoli)
Date: Tue, 5 Sep 2017 09:53:01 -0300
Subject: [PATCH v2] nvme-fabrics: Prevent KATO to be set as 0
In-Reply-To: <194a3a6e-0936-b5e4-33b4-8b4335e7887b@linux.vnet.ibm.com>
References: <20170829220346.19424-1-gpiccoli@linux.vnet.ibm.com>
 <d67a9ef4-8c01-f842-3eed-4ef873c22dfd@grimberg.me>
 <194a3a6e-0936-b5e4-33b4-8b4335e7887b@linux.vnet.ibm.com>
Message-ID: <5be8a934-0695-55fc-0a80-1794cefd6a96@linux.vnet.ibm.com>

Ping?

Sorry to bother BTW Sagi!

Thanks,


Guilherme

On 08/30/2017 09:55 AM, Guilherme G. Piccoli wrote:
> On 08/30/2017 06:55 AM, Sagi Grimberg wrote:
>>
>>> Since the debug feature of setting KATO to 0 is not working
>>> anymore, remove it from code. If user sets it to 0, default
>>> value will be explicitly used.
>>
>> Why not allowing it? its pretty useful for testing.
>>
> 
> Okay, so I misinterpreted your last message.
> 
> My understanding was that since the condition was added in some point of
> time, the possibility of KATO being set to 0 was "indirectly" dropped
> and your suggestion was to _drop it officially_.
> 
> My bad...
> 
> So, please clarify it to me: do we want to allow a 0 value for KATO? If
> yes, no piece of code is needed in the target to stop sending keep alives?
> The way it "works" today (aka my 1st patch), if we set KATO as 0, we get
> timeout right after connection. When I first set KATO to 0 in my debug,
> I was expecting to disable keep alives, not getting timeouts heheh
> 
> 
> So, the purpose of KATO == 0 is to:
> 
> (a) Get timeouts right after the connection is complete and keep getting
> them forever? Or...
> 
> (b) Disable keep alives at all? (and in this case, we need to inform the
> target to not send keep alives in case of a 0 valued kato).
> 
> Thanks in advance,
> 
> 
> Guilherme
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> https://urldefense.proofpoint.com/v2/url?u=http-3A__lists.infradead.org_mailman_listinfo_linux-2Dnvme&d=DwICAg&c=jf_iaSHvJObTbx-siA1ZOg&r=JNsEpjN-AKdNDGXVjcVd1PT1_7ZCB_y_oCbTTJnWaYY&m=nEcjZMh5qfdije9oLG9947mjYG382gLZUZ3Pt6otzoc&s=XNrF6NkOC2uJSNRcC1LESJT2hNYUG6NFJrNFIbseEAk&e= 
> 
