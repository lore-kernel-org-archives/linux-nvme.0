From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 11 Oct 2017 13:02:16 +0300
Subject: [PATCH v2 1/7] nvme core: allow controller RESETTING to
 RECONNECTING transition
In-Reply-To: <20171004082813.GA23467@infradead.org>
References: <20170927045046.22238-1-jsmart2021@gmail.com>
 <20170927045046.22238-2-jsmart2021@gmail.com>
 <20171004082813.GA23467@infradead.org>
Message-ID: <7b5f52d2-66ec-bdd8-de72-0bbb4cc2166b@grimberg.me>


>> Allow controller state transition : RESETTING to RECONNECTING
>>
>> Transport will typically transition from LIVE->RESETTING when
>> initially performing a reset or recovering from an error. Adding
>> this transition allows a transport to transition to RECONNECTING
>> when it checks/waits for connectivity then creates new transport
>> connections and reinits the controller.
> 
> Looks fine for now, although we really need to move to a common
> state machine..

Agree, will work on it,

> Reviewed-by: Christoph Hellwig <hch at lst.de>

Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
