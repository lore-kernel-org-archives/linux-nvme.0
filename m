From: Bart.VanAssche@wdc.com (Bart Van Assche)
Date: Thu, 22 Feb 2018 00:53:59 +0000
Subject: NVMeOF I/O errors
Message-ID: <1519260838.4060.23.camel@wdc.com>

Hello,

If I try to run I/O after having connected the NVMeOF initiator to the NVMeOF
target driver over the rdma_rxe driver then I/O errors appear:

# dd if=/dev/nvme0n1 of=/dev/null iflag=direct
dd: error reading '/dev/nvme0n1': Input/output error
52816+0 records in
52816+0 records out
27041792 bytes (27 MB, 26 MiB) copied, 39.9407 s, 677 kB/s


From the kernel log:

nvmet_rdma:nvmet_rdma_find_get_device: nvmet_rdma: added rxe0.
nvmet_rdma:nvmet_rdma_create_queue_ib: nvmet_rdma: nvmet_rdma_create_queue_ib: max_cqe= 511 max_sge= 32 sq_size = 257 cm_id= 000000009780ce6e
nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: established (9): status 0 id 000000006208c3e7
nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma: established (9): status 0 id 000000009780ce6e
nvmet: adding queue 1 to ctrl 1.
nvmet: adding queue 2 to ctrl 1.
nvmet: adding queue 3 to ctrl 1.
nvmet: adding queue 4 to ctrl 1.
nvme nvme0: Successfully reconnected (1 attempts)

The configuration of the target is as follows:

# (cd /sys/kernel/config/nvmet/ && find -type f|xargs grep -aH .)       
./ports/1/addr_trtype:rdma
./ports/1/addr_trsvcid:7777
./ports/1/addr_traddr:192.168.122.76
./ports/1/addr_treq:not specified
./ports/1/addr_adrfam:ipv4
./subsystems/nvme-test/namespaces/1/enable:1
./subsystems/nvme-test/namespaces/1/device_uuid:9059f87a-fa85-4e81-8da7-328163dabdf1
./subsystems/nvme-test/namespaces/1/device_nguid:00000000-0000-0000-0000-000000000000
./subsystems/nvme-test/namespaces/1/device_path:/dev/ram0
./subsystems/nvme-test/attr_serial:fa1e888a1fcc1dd7
./subsystems/nvme-test/attr_version:1.3
./subsystems/nvme-test/attr_allow_any_host:1

This happens both with kernel versions v4.15.4 and v4.16-rc2. Has anyone seen
something similar?

Thanks,

Bart.
