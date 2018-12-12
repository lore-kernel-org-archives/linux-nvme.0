From: james.smart@broadcom.com (James Smart)
Date: Wed, 12 Dec 2018 11:15:33 -0800
Subject: [PATCH v2 0/5] implement nvmf read/write queue maps
In-Reply-To: <be43de64-eb4b-c116-85f2-8c5d5a62e3c1@grimberg.me>
References: <20181211233519.9350-1-sagi@grimberg.me>
 <477ef7e7-bc81-5c27-84ba-27c75989bdc4@broadcom.com>
 <be43de64-eb4b-c116-85f2-8c5d5a62e3c1@grimberg.me>
Message-ID: <ea1c9217-c9dc-082b-dbc9-45b98e5d467c@broadcom.com>



On 12/12/2018 9:58 AM, Sagi Grimberg wrote:
>
>> Sagi,
>>
>> What other wins are there for this split ?
>>
>> I'm considering whether its worthwhile for fc as well, but the hol 
>> issue doesn't exist with fc. What else is being resolved ?
>
> I've pondered it myself, which is why I didn't add it to fc as well
> (would have been easy enough I think). I guess that with this the
> user can limit writes compared to read by assigning less queues as
> jens suggested in his patches...

not enough to interest me.? I also would prefer to not require more 
queues - it only increases the oversubscription requirements on the 
target, which is already a major issue on real shared subsystems.

Thanks

-- james
