From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 13 Mar 2017 10:05:53 +0200
Subject: nvmet: race condition while CQE are getting processed
 concurrently with the DISCONNECTED event
In-Reply-To: <33bffca1-f632-e2b2-3377-32fce207ac07@redhat.com>
References: <CY1PR12MB07747089AFFCB6115BBCF5ECBC210@CY1PR12MB0774.namprd12.prod.outlook.com>
 <7c08d54c-7a2d-74dd-79df-807113b032c3@grimberg.me>
 <33bffca1-f632-e2b2-3377-32fce207ac07@redhat.com>
Message-ID: <ca954cbb-19a9-b061-982f-6ac98d4546fc@grimberg.me>

> Hi Sagi

Hi Yi,

> With this patch, issue[1] cannot be reproduced, but I still can
> reproduce issue[2]. thanks
>
> [1]
>
> kernel NULL pointer on nvmet with stress
> rescan_controller/reset_controller test during I/O
>
> [2]
> mlx4_core 0000:07:00.0: swiotlb buffer is full and OOM observed during
> stress test on reset_controller

So this particular issue seems to do with the fact that the target is
attacked with reset attempts. The controller teardown happens
asynchronously and waits for safe termination while re-establishments
are allowed immediately.

I think we need to somehow figure out what is our max allowed active
controllers and simply refuse controller establishment if we exceeded
this number. The tricky part is to understand what this magic number
is?

Question, does the test in [2] complete eventually? or is this a fatal
error?
