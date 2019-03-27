From: sashal@kernel.org (Sasha Levin)
Date: Wed, 27 Mar 2019 14:00:48 +0000
Subject: [PATCH 1/2] nvme: target: fix nvmet_file_init_bvec()
In-Reply-To: <20190325100708.24172-2-ming.lei@redhat.com>
References: <20190325100708.24172-2-ming.lei@redhat.com>
Message-ID: <20190327140049.E30112075E@mail.kernel.org>

Hi,

[This is an automated email]

This commit has been processed because it contains a "Fixes:" tag,
fixing commit: .

The bot has tested the following trees: v5.0.4, v4.19.31, v4.14.108, v4.9.165, v4.4.177, v3.18.137.

v5.0.4: Build OK!
v4.19.31: Failed to apply! Possible dependencies:
    50a909db36f2 ("nvmet: use IOCB_NOWAIT for file-ns buffered I/O")

v4.14.108: Failed to apply! Possible dependencies:
    1b72b71facce ("nvmet: fix file discard return status")
    50a909db36f2 ("nvmet: use IOCB_NOWAIT for file-ns buffered I/O")
    543c09c89fdc ("nvmet: Fix nvmet_execute_write_zeroes sector count")
    55eb942eda2c ("nvmet: add buffered I/O support for file backed ns")
    618cff4285dc ("nvmet: remove duplicate NULL initialization for req->ns")
    7756f72ccd43 ("nvmet: Change return code of discard command if not supported")
    9c891c139894 ("nvmet: check fileio lba range access boundaries")
    d5eff33ee6f8 ("nvmet: add simple file backed ns support")
    e454d122e228 ("nvmet: kill nvmet_inline_bio_init")
    e929f06d9eaa ("nvmet: constify struct nvmet_fabrics_ops")
    ea435e1b9392 ("block: add a poll_fn callback to struct request_queue")

v4.9.165: Failed to apply! Possible dependencies:
    297e3d854784 ("blk-throttle: make throtl_slice tunable")
    4151dd9a58c6 ("nvmet: Fixed avoided printing nvmet: twice in error logs.")
    4e4cbee93d56 ("block: switch bios to blk_status_t")
    778f067c185c ("nvme: add semicolon in nvme_command setting")
    87760e5eef35 ("block: hook up writeback throttling")
    986994a27587 ("nvme: Use CNS as 8-bit field and avoid endianness conversion")
    9e234eeafbe1 ("blk-throttle: add a simple idle detection")
    cf43e6be865a ("block: add scalable completion tracking of requests")
    d5eff33ee6f8 ("nvmet: add simple file backed ns support")
    e806402130c9 ("block: split out request-only flags into a new namespace")
    fbbaf700e7b1 ("block: trace completion of all bios.")

v4.4.177: Failed to apply! Possible dependencies:
    1c63dc66580d ("nvme: split a new struct nvme_ctrl out of struct nvme_dev")
    21d34711e1b5 ("nvme: split command submission helpers out of pci.c")
    2d79c7dc8fe5 ("admin-cmd: Added smart-log command support.")
    3a85a5de29ea ("nvme-loop: add a NVMe loopback host driver")
    4151dd9a58c6 ("nvmet: Fixed avoided printing nvmet: twice in error logs.")
    540c801c65eb ("NVMe: Implement namespace list scanning")
    6f3b0e8bcf3c ("blk-mq: add a flags parameter to blk_mq_alloc_request")
    986994a27587 ("nvme: Use CNS as 8-bit field and avoid endianness conversion")
    a07b4970f464 ("nvmet: add a generic NVMe target")
    d5eff33ee6f8 ("nvmet: add simple file backed ns support")
    fa60682677c5 ("nvme: use symbolic constants for CNS values")

v3.18.137: Failed to apply! Possible dependencies:
    062261be4e39 ("nvme: Replace rcu_assign_pointer() with RCU_INIT_POINTER()")
    1d0906246095 ("NVMe: Mismatched host/device page size support")
    302c6727e5eb ("NVMe: Fix filesystem sync deadlock on removal")
    57dacad5f228 ("nvme: move to a new drivers/nvme/host directory")
    5905535610fc ("NVMe: Correctly handle IOCTL_SUBMIT_IO when cpus > online queues")
    5940c8578fe7 ("NVMe: Clear QUEUE_FLAG_STACKABLE")
    6fccf9383b28 ("NVMe: Async event request")
    7963e521811e ("NVMe: Passthrough IOCTL for IO commands")
    7be50e93fbc2 ("NVMe: Fix nvmeq waitqueue entry initialization")
    9dbbfab7d541 ("NVMe: Do not over allocate for discard requests")
    a07b4970f464 ("nvmet: add a generic NVMe target")
    a4aea5623d4a ("NVMe: Convert to blk-mq")
    a96d4f5c2da6 ("NVMe: Reference count pci device")
    aee4b9bd4505 ("nvmem: Add to MAINTAINERS for nvmem framework")
    b4ff9c8ddb6f ("NVMe: Translate NVMe status to errno")
    d5eff33ee6f8 ("nvmet: add simple file backed ns support")
    dece45855a8b ("NFC: nxp-nci: Add support for NXP NCI chips")
    f435c2825b4c ("NVMe: Call nvme_free_queue directly")


How should we proceed with this patch?

--
Thanks,
Sasha
