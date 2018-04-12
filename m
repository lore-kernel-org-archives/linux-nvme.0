From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 12 Apr 2018 15:31:12 +0300
Subject: [PATCH v1 0/5] Fix keep-alive mechanism for fabrics
In-Reply-To: <8b508b8c-8b35-7d88-5557-d003108b00ff@mellanox.com>
References: <1523380689-17151-1-git-send-email-maxg@mellanox.com>
 <512640d9-9e1d-5e52-d7be-5d8203381023@grimberg.me>
 <c9ba5346-667c-7e6e-6b79-22f3152dfc50@mellanox.com>
 <1c36f016-5b58-038f-8938-cd9deb15a205@grimberg.me>
 <ed15449d-8991-2bcd-a381-54727eaef241@mellanox.com>
 <d1a93c20-e8d7-8ef4-1e22-a6ea1fed724b@grimberg.me>
 <8b508b8c-8b35-7d88-5557-d003108b00ff@mellanox.com>
Message-ID: <92be194f-09e9-2ee5-aab3-ba090c2d2b8f@grimberg.me>


>>>>> TBKA will work as nop-in/out in iSCSI AKAIK. But again, it will no 
>>>>> solve the issue I described above.
>>>>
>>>> Yes it will, fabrics connect is a traffic indication and will reset the
>>>> keep alive timer.
>>>
>>> Very good. But it will reset a KA timer that is not even started (in 
>>> the initiator) ?
>>
>> No, host indication of traffic is completions, so the completion would 
>> reset it.
> 
> I meant that in the current host implementation (that starts KA timer 
> after IO queues connection establishment) there will be nothing to reset 
> during io queues connection establishment and completions.

Its not exactly a reset, its more like a check without a keep alive
timeout interval. You can read the updates when the proposal
is ratified (and the code).
