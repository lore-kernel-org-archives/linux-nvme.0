From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 6 Sep 2017 12:30:20 +0300
Subject: [PATCH v2] nvme-fabrics: Prevent KATO to be set as 0
In-Reply-To: <5be8a934-0695-55fc-0a80-1794cefd6a96@linux.vnet.ibm.com>
References: <20170829220346.19424-1-gpiccoli@linux.vnet.ibm.com>
 <d67a9ef4-8c01-f842-3eed-4ef873c22dfd@grimberg.me>
 <194a3a6e-0936-b5e4-33b4-8b4335e7887b@linux.vnet.ibm.com>
 <5be8a934-0695-55fc-0a80-1794cefd6a96@linux.vnet.ibm.com>
Message-ID: <89ebdefc-6fc7-77ad-d483-ef2befb9815d@grimberg.me>


>> My bad...
>>
>> So, please clarify it to me: do we want to allow a 0 value for KATO? If
>> yes, no piece of code is needed in the target to stop sending keep alives?
>> The way it "works" today (aka my 1st patch), if we set KATO as 0, we get
>> timeout right after connection. When I first set KATO to 0 in my debug,
>> I was expecting to disable keep alives, not getting timeouts heheh
>>
>>
>> So, the purpose of KATO == 0 is to:
>>
>> (a) Get timeouts right after the connection is complete and keep getting
>> them forever? Or...
>>
>> (b) Disable keep alives at all? (and in this case, we need to inform the
>> target to not send keep alives in case of a 0 valued kato).

Its just a simple way to test that the target does comply to the kato
by not sending it a keep-alive and wait for it to teardown the 
controller, seems useful to keep to have a sanity check that it
doesn't break.

So lets go with (a)
