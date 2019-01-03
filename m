From: sashal@kernel.org (Sasha Levin)
Date: Thu, 03 Jan 2019 18:14:43 +0000
Subject: [PATCH v2] nvmet-rdma: fix null dereference under heavy load
In-Reply-To: <20190103103336.6343-1-rajur@chelsio.com>
References: <20190103103336.6343-1-rajur@chelsio.com>
Message-ID: <20190103181444.5705F2073D@mail.kernel.org>

Hi,

[This is an automated email]

This commit has been processed because it contains a "Fixes:" tag,
fixing commit: .

The bot has tested the following trees: v4.20.0, v4.19.13, v4.14.91, v4.9.148, v4.4.169, v3.18.131, 

v4.20.0: Failed to apply! Possible dependencies:
    ad1f824948e4 ("nvmet-rdma: Add unlikely for response allocated check")

v4.19.13: Failed to apply! Possible dependencies:
    ad1f824948e4 ("nvmet-rdma: Add unlikely for response allocated check")

v4.14.91: Failed to apply! Possible dependencies:
    ad1f824948e4 ("nvmet-rdma: Add unlikely for response allocated check")

v4.9.148: Failed to apply! Possible dependencies:
    ad1f824948e4 ("nvmet-rdma: Add unlikely for response allocated check")

v4.4.169: Failed to apply! Possible dependencies:
    3a85a5de29ea ("nvme-loop: add a NVMe loopback host driver")
    748ff8408f8e ("nvmet-rdma: Fix missing dma sync to nvme data structures")
    8407879c4e0d ("nvmet-rdma: fix possible bogus dereference under heavy load")
    8d61413db604 ("nvmet-rdma: Fix a possible uninitialized variable dereference")
    8f000cac6e7a ("nvmet-rdma: add a NVMe over Fabrics RDMA target driver")
    a07b4970f464 ("nvmet: add a generic NVMe target")
    ad1f824948e4 ("nvmet-rdma: Add unlikely for response allocated check")

v3.18.131: Failed to apply! Possible dependencies:
    062261be4e39 ("nvme: Replace rcu_assign_pointer() with RCU_INIT_POINTER()")
    1d0906246095 ("NVMe: Mismatched host/device page size support")
    302c6727e5eb ("NVMe: Fix filesystem sync deadlock on removal")
    57dacad5f228 ("nvme: move to a new drivers/nvme/host directory")
    5905535610fc ("NVMe: Correctly handle IOCTL_SUBMIT_IO when cpus > online queues")
    5940c8578fe7 ("NVMe: Clear QUEUE_FLAG_STACKABLE")
    6fccf9383b28 ("NVMe: Async event request")
    7963e521811e ("NVMe: Passthrough IOCTL for IO commands")
    7be50e93fbc2 ("NVMe: Fix nvmeq waitqueue entry initialization")
    8f000cac6e7a ("nvmet-rdma: add a NVMe over Fabrics RDMA target driver")
    9dbbfab7d541 ("NVMe: Do not over allocate for discard requests")
    a07b4970f464 ("nvmet: add a generic NVMe target")
    a4aea5623d4a ("NVMe: Convert to blk-mq")
    a96d4f5c2da6 ("NVMe: Reference count pci device")
    aee4b9bd4505 ("nvmem: Add to MAINTAINERS for nvmem framework")
    b4ff9c8ddb6f ("NVMe: Translate NVMe status to errno")
    dece45855a8b ("NFC: nxp-nci: Add support for NXP NCI chips")
    f435c2825b4c ("NVMe: Call nvme_free_queue directly")


How should we proceed with this patch?

--
Thanks,
Sasha
