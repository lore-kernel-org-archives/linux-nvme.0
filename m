From: axboe@fb.com (Jens Axboe)
Date: Wed, 19 Nov 2014 20:36:15 -0700
Subject: [PATCH] NVMe: make setup work for devices that don't do INTx
In-Reply-To: <alpine.LNX.2.00.1411191600480.4225@localhost.lm.intel.com>
References: <20141114164926.GC12860@kernel.dk>
 <alpine.LNX.2.00.1411191600480.4225@localhost.lm.intel.com>
Message-ID: <546D61AF.6040403@fb.com>

On 11/19/2014 10:54 AM, Keith Busch wrote:
> On Fri, 14 Nov 2014, Jens Axboe wrote:
>> The setup/probe part currently relies on INTx being there and
>> working, that's not always the case. For devices that don't
>> advertise INTx, enable a single MSIx vector early on and disable
>> it again before we ask for our full range of queue vecs.
>
> Acked-by: Keith Busch <keith.busch at intel.com>
>
> I have an early sample platform that has the same behavior. I thought
> it was just a buggy prototype, but the h/w makers tell me it's designed
> that way.

I believe they are correct :-)

Thanks for the ack, I'll add this to the 3.19 mix. Did you take a look 
at the other two trivial patches?

-- 
Jens Axboe
