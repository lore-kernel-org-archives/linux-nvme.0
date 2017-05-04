From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 4 May 2017 13:46:02 +0300
Subject: [PATCH] nvmet: release the sq ref on rdma read errors
In-Reply-To: <20170504085631.GA5584@lst.de>
References: <CAN9s3O597CB9d2BoPx1gL5a7NnqhxrXYMhE==Q3E8+BoDxRFiQ@mail.gmail.com>
 <01cb01d2c446$20cd83a0$62688ae0$@attalasystems.com>
 <01d601d2c446$b087cb90$119762b0$@attalasystems.com>
 <da2ec86f-3c22-30a0-0e9b-f4c0fdf5eabb@grimberg.me>
 <00d6f8bf-07bd-03ca-3060-fd3def1ef1d7@grimberg.me>
 <20170504085631.GA5584@lst.de>
Message-ID: <5e0ca611-97d8-8884-abc3-c0f3b6172a21@grimberg.me>


>> While it is true that we need to drop the reference on
>> the nvmet_sq, there is no point in queuing a response
>> message because the rdma qp is in error state and the response
>> will never make it to the host.
>
> Yeah.
>
>> I think we should explicitly drop the sq reference and release
>> the rsp and avoid triggering the TX path, and provide a detailed
>> comment on why we are doing this. Maybe a nicer way to do this,
>> is to introduce a nvme_req_uninit() that would take care of
>> it in the right layer (that is nvmet core).
>
> Agreed.

Vijay, care to respin the fix?
