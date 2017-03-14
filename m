From: yizhan@redhat.com (Yi Zhang)
Date: Tue, 14 Mar 2017 21:22:14 +0800
Subject: nvmet: race condition while CQE are getting processed
 concurrently with the DISCONNECTED event
In-Reply-To: <ca954cbb-19a9-b061-982f-6ac98d4546fc@grimberg.me>
References: <CY1PR12MB07747089AFFCB6115BBCF5ECBC210@CY1PR12MB0774.namprd12.prod.outlook.com>
 <7c08d54c-7a2d-74dd-79df-807113b032c3@grimberg.me>
 <33bffca1-f632-e2b2-3377-32fce207ac07@redhat.com>
 <ca954cbb-19a9-b061-982f-6ac98d4546fc@grimberg.me>
Message-ID: <48530c09-3e8f-b468-3c15-5137be9bb13e@redhat.com>


On 03/13/2017 04:05 PM, Sagi Grimberg wrote:
>> Hi Sagi
>
> Hi Yi,
>
>> With this patch, issue[1] cannot be reproduced, but I still can
>> reproduce issue[2]. thanks
>>
>> [1]
>>
>> kernel NULL pointer on nvmet with stress
>> rescan_controller/reset_controller test during I/O
>>
>> [2]
>> mlx4_core 0000:07:00.0: swiotlb buffer is full and OOM observed during
>> stress test on reset_controller
>
> So this particular issue seems to do with the fact that the target is
> attacked with reset attempts. The controller teardown happens
> asynchronously and waits for safe termination while re-establishments
> are allowed immediately.
>
> I think we need to somehow figure out what is our max allowed active
> controllers and simply refuse controller establishment if we exceeded
> this number. The tricky part is to understand what this magic number
> is?
>
> Question, does the test in [2] complete eventually? or is this a fatal
> error?
Hi Sagi
If I don't stop the reset_controller operation on client side, it will 
finally got one fatal error since the operation will eat memory 
continuously on target side.

Thanks
Yi
