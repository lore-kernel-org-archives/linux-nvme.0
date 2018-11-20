From: james.smart@broadcom.com (James Smart)
Date: Tue, 20 Nov 2018 10:12:14 -0800
Subject: [PATCHv3 0/3] nvme: NUMA locality for fabrics
In-Reply-To: <20181120094140.GA7742@lst.de>
References: <20181102095641.28504-1-hare@suse.de>
 <20181116081241.GA14072@lst.de>
 <c6b0e0f8-f22c-65b6-3657-1f078b0803e2@suse.de>
 <20181116082359.GB14269@lst.de>
 <58a66fee-0185-6ab4-3fe1-797d15d9badb@grimberg.me>
 <cc741191-12f3-91b0-df93-b6239f482aeb@suse.de> <20181120094140.GA7742@lst.de>
Message-ID: <e5c7ddfb-08d6-f133-d55d-41e3df965404@broadcom.com>



On 11/20/2018 1:41 AM, Christoph Hellwig wrote:
> On Tue, Nov 20, 2018@07:12:47AM +0100, Hannes Reinecke wrote:
>> Fully agreed here.
>> It all comes down to the link latency.
>> If the link latency is the main bottleneck multipathing will benefit from
>> round-robin (or any I/O scheduler, for that matter).
> It still makes a lot more sense to try to have queues with an affinity
> to a given path rather than doing round robin IFF you care about latency.
>
> If you latency sucks anyway round robing makes sense.  But why do you
> use nvme on such a horrible interconnect anyway?

you really need to resurvey what enterprises are using and what is being 
achieved now days.? I hope this prejudice doesn't show up in maintainership.


>
>> And this it not just relevant for 'legacy' hardware; I've seen a
>> performance benefit on a 32G FC setup, which is pretty much state of the
>> art currently.
> Well, FC is legacy no matter which link speed.
>

legacy - but still supporting the new and proven enterprise storage 
technologies; real and large interoperable fabrics; lots of mgmt tools; 
huge existing device base; and features that other technologies do not 
have without special add-ons. Sometimes the 
grass-is-always-greener-over-there doesn't pan out...

Thanks

-- james
