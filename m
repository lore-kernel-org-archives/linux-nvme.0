From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 18 Oct 2018 23:30:59 -0700
Subject: [PATCH 4/4] nvme-core: support traffic based keep-alive based on
 controller support
In-Reply-To: <20181019060049.GA27902@lst.de>
References: <20180928011537.30069-1-sagi@grimberg.me>
 <20180928011537.30069-5-sagi@grimberg.me> <20181017070545.GA23049@lst.de>
 <2e1cba3c-a391-8c45-5987-0ba5317a6a19@grimberg.me>
 <20181019060049.GA27902@lst.de>
Message-ID: <83393deb-9b8e-53b5-a75a-385a792c9086@grimberg.me>


>>>> +	nvme_req(req)->ctrl->comp_seen = true;
>>>
>>> shouldn't we only do this for controllers with keep a live support?
>>
>> What is the harm setting it anyways? Would it be better to condition it
>> on keep alive support instead?
> 
> This writes to a cache line in the controller on every I/O completion.
> And while it isn't an atomic it isn't exactly going to help scalability,

Yea, this was why I placed it in the front of nvme_ctrl with hope that
that nvme_ctrl located right behind variables accessed in the hot path..

> so I'd rather have a branch before it, which will be predicted not taken
> for controllers that don't have the feature (aka at least every PCIe
> controller on the planet)

That would induce a read access a variable (kas) deeper in nvme_ctrl
which is "colder"... I don't mind doing it, just wanted to raise the
trade-off. We can also keep a cached copy of kas in the drivers
representations if it becomes a problem...
