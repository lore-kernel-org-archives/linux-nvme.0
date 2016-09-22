From: kirubak@zadarastorage.com (Kirubakaran Kaliannan)
Date: Thu, 22 Sep 2016 14:23:13 +0530
Subject: NVMf (NVME over fabrics) Performance
In-Reply-To: <044931a9-2c5a-c33f-3d44-6009fc96297e@grimberg.me>
References: <c53316925d9da9f13925a29674533f2e@mail.gmail.com>
 <044931a9-2c5a-c33f-3d44-6009fc96297e@grimberg.me>
Message-ID: <96b893e9c10252baddbbf761294e4794@mail.gmail.com>

Hi Saig,

Thanks for the suggestion, here is what I have (re)tried

1. Both target and initiator is not blocked by CPU (CPU is atleast 70% idle,
and load is distributed across 16 CPU's)
2. Yes, irqbalancer is running.
3. register_always is true already, I have upgraded to 4.8.rc7.
4. added the fix that you suggested

Still, the max IOPS (for NULL device) that I get is 600 with NVMf !!

Thanks
-kiru

-----Original Message-----
From: Sagi Grimberg [mailto:sagi@grimberg.me]
Sent: Wednesday, September 21, 2016 11:48 PM
To: Kirubakaran Kaliannan; linux-nvme at lists.infradead.org
Subject: Re: NVMf (NVME over fabrics) Performance

> Hi All,

Hey Kiru,

> I am working on measuring the NVMf (with Mellanox ConnectX-3
> pro(40Gps) and Intel P3600) performance numbers on my 2 servers with
> 32 CPU each (64GB RAM).
>
> These are the numbers I am getting from IOPS perspective for Read, and
> for 4K size I/O?s
>
> 1 NULL block-devices using NVMf = 600K
> 2 NULL block-device using NVMf = 600k (not growing linearly per
> device)

Can you recognize if any side is blocked by CPU (it shouldn't).

Are all cores active in the target system?

is irqbalancer running?

Do you have register_always modparam turned on in nvme-rdma? Can you try
without it?

> 1 Intel NVME device through NVMf= 450K
> 2 Intel NVME device through NVMf = 470K (There is no increase in IOPs
> beyond 500K by adding more devices)

Can you try the latest code in 4.8-rc7?

As a second experiment can you try this patch applied (submitted to
linux-rdma lately)?
---
  drivers/infiniband/core/device.c | 3 +--
  1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/device.c
b/drivers/infiniband/core/device.c
index 760ef603a468..15f4bdf89fe1 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -999,8 +999,7 @@ static int __init ib_core_init(void)
  		return -ENOMEM;

  	ib_comp_wq = alloc_workqueue("ib-comp-wq",
-			WQ_UNBOUND | WQ_HIGHPRI | WQ_MEM_RECLAIM,
-			WQ_UNBOUND_MAX_ACTIVE);
+			WQ_HIGHPRI | WQ_MEM_RECLAIM | WQ_SYSFS, 0);
  	if (!ib_comp_wq) {
  		ret = -ENOMEM;
  		goto err;
--
