From: sashal@kernel.org (Sasha Levin)
Date: Fri, 29 Mar 2019 14:17:05 +0000
Subject: [PATCH] nvmet: fix building bvec from sg list
In-Reply-To: <20190327090722.15836-1-ming.lei@redhat.com>
References: <20190327090722.15836-1-ming.lei@redhat.com>
Message-ID: <20190329141705.EF6CD2184C@mail.kernel.org>

Hi,

[This is an automated email]

This commit has been processed because it contains a "Fixes:" tag,
fixing commit: 3a85a5de29ea nvme-loop: add a NVMe loopback host driver.

The bot has tested the following trees: v5.0.5, v4.19.32, v4.14.109, v4.9.166.

v5.0.5: Build OK!
v4.19.32: Failed to apply! Possible dependencies:
    50a909db36f2 ("nvmet: use IOCB_NOWAIT for file-ns buffered I/O")

v4.14.109: Failed to apply! Possible dependencies:
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

v4.9.166: Failed to apply! Possible dependencies:
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


How should we proceed with this patch?

--
Thanks,
Sasha
