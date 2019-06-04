From: hch@lst.de (Christoph Hellwig)
Date: Tue, 4 Jun 2019 21:05:02 +0200
Subject: [Suspected-Phishing]Re: [PATCH] Revert "nvme-rdma: remove
 redundant reference between ib_device and tagset"
In-Reply-To: <288d4db3-ca7e-c60f-b7ac-5a6ff2771235@grimberg.me>
References: <20190603231159.17034-1-sagi@grimberg.me>
 <b98d3c8f-85ee-06f2-b47a-a3e04261c0d1@grimberg.me>
 <F4E18075-01AA-443B-BF43-23A4BA80C10C@intel.com>
 <d2a20c0f-092d-28ca-3365-1fb5df2cb816@mellanox.com>
 <b4a79dfe-ffc8-0571-9f54-cf5b98c21500@mellanox.com>
 <251f83e0-75f1-ef0b-2747-8ae09f038ce8@grimberg.me>
 <cb21c45b-2ffc-107b-172a-d9f653e90402@mellanox.com>
 <288d4db3-ca7e-c60f-b7ac-5a6ff2771235@grimberg.me>
Message-ID: <20190604190501.GB28398@lst.de>

On Tue, Jun 04, 2019@08:55:56AM -0700, Sagi Grimberg wrote:
>
>>>> James,
>>>>
>>>> can you test the attached patch (without the revert) ?
>>>
>>> Max, I think that its pretty late for this change for 5.2,
>>> I'm leaning towards reverting the offending patch for 5.2-rc and
>>> getting this into 5.3
>>
>> are you sure ?
>>
>> we're only at rc3..
>
> This is beyond a bug fix, its a behavior change, with possible other
> implications. This is really something that is merge window material
> I think. I would rather let it sit for nvme-5.3 for a while before
> we merge it.
>
> Christoph, do you have a different preference?

The original patch from Max fixed a serious issue, so I'd prefer not
to revert it, especially as we are only at rc3.  That assumes we
can agree on a fix in the next couple of days.
