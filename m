From: jianchao.w.wang@oracle.com (jianchao.wang)
Date: Tue, 23 Jan 2018 16:16:48 +0800
Subject: do_IRQ: 5.33 No irq handler for vector
Message-ID: <06696605-9696-b906-02ca-9ac426722318@oracle.com>

Hi all

I got the log following:
[  446.908030] do_IRQ: 5.33 No irq handler for vector

When did the following test:
loop fio job
size=256m
rw=randread
bs=4k
ioengine=libaio
iodepth=64
direct=1
numjobs=16
filename=/dev/nvme0n1

and
 
while true
do
    echo 1 > /sys/block/nvme0n1/device/reset_controller 
    sleep 1
done

The 33 is the vector used by nvmeq2~nvme8 (8 cpus on my machine)

When the error log is printed out,  the reset_work is sleeping at
nvme_dev_disable
  ->nvme_disable_io_queues
    -> wait_for_completion_io_timeout

In theory, the irq should have been masked by 
nvme_suspend_queue
  -> pci_free_irq
    -> __free_irq //if no other irq_action
      -> irq_shutdown
        -> __irq_disable
          -> mask_irq
            -> pci_msi_mask_irq

Why it is still there ?

Thanks
Jianchao
