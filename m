From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 6 Aug 2017 18:06:38 -0700
Subject: Flush warning
In-Reply-To: <016301d30c86$e7034ae0$b509e0a0$@opengridcomputing.com>
References: <016301d30c86$e7034ae0$b509e0a0$@opengridcomputing.com>
Message-ID: <9bc142de-b8ba-acb6-5ea1-2ccdbb578655@grimberg.me>

> Hey guys,

Hey Steve,

> We're seeing a WARNING happening when running an fio test on a single NVMF
> attached ramdisk over iw_cxgb4.  While the fio test is running, the NVMF host is
> also killing the controller via writing to
> /sys/block/nvme*/device/reset_controller.  Here is the script:
> 
> ----
> [root at trinitycraft ~]# cat fio_issue.sh
> num=0
> 
> fio --rw=randrw --name=random --norandommap --ioengine=libaio --size=400m
> --group_reporting --exitall --fsync_on_close=1 --invalidate=1 --direct=1
> --filename=/dev/nvme0n1 --time_based --runtime=30 --iodepth=32 --numjobs=8
> --unit_base=1 --bs=4k --kb_base=1000 &
> 
> sleep 2
> while [ $num -lt 30 ]
> do
>          echo 1 >/sys/block/nvme0n1/device/reset_controller
>          [ $? -eq 1 ] && echo "reset_controller operation failed: $num" && exit 1
>          ((num++))
>          sleep 0.5
> done
> -----
> 
> The WARNING seems to be due to nvmet_rdma_queue_connect() calling
> flush_scheduled_work() while in the upcall from the RDMA_CM.  It I running on
> the iw_cm event workqueue, which is created with WQ_MEM_RECLAIM set.  I'm not
> sure what this WARNING is telling me.  Does the iw_cm workqueue NOT need
> WQ_MEM_RECLAIM set?  Or is there some other issue with the nvmet/rdma code doing
> work flushing in the iw_cm workq context?

This flush is designed to prevent nvmet-rdma from having too much
inflight resources in case of a high pace of controller teardown and
establishment (like you trigger in your test).

queue teardowns are run on system_wq, does iw_cm needs memory
reclamation protection?
