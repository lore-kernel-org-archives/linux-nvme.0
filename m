From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 10 Jul 2017 14:41:28 +0300
Subject: I/O Errors due to keepalive timeouts with NVMf RDMA
In-Reply-To: <20170710113353.GG5105@linux-x5ow.site>
References: <20170707094838.GD16648@linux-x5ow.site>
 <a34f03ac-4306-ba87-e6f4-fc29bfd80828@grimberg.me>
 <2b758039-5957-96b5-bf30-5cbb5515fe9c@suse.de>
 <6eff23f4-1bb7-3c64-6916-987f4b38ae78@mellanox.com>
 <20170710091054.GD5105@linux-x5ow.site>
 <a940a9ea-c090-6620-a080-eb7cf6140ad3@grimberg.me>
 <20170710102049.GF5105@linux-x5ow.site>
 <77c7d11c-bd67-8663-cc10-da3af8bfcd22@grimberg.me>
 <20170710113353.GG5105@linux-x5ow.site>
Message-ID: <ebc9dccc-ce68-f5f3-3e24-372b2cd7f44b@grimberg.me>

> Host:
> [353698.784927] nvme nvme0: creating 44 I/O queues.
> [353699.572467] nvme nvme0: new ctrl: NQN
> "nqn.2014-08.org.nvmexpress:NVMf:uuid:c36f2c23-354d-416c-95de-f2b8ec353a82",
> addr 1.1.1.2:4420
> [353960.804750] nvme nvme0: SEND for CQE 0xffff88011c0cca58 failed with status
> transport retry counter exceeded (12)

Exhausted retries, wow... That is really strange...

Host sent the keep-alive and it never made it to the host, the HCA
retried for 7+ times and gave up.

Are you running with a switch? which one? is the switch experience
higher ingress?

> [353960.840895] nvme nvme0: Reconnecting in 10 seconds...
> [353960.853582] blk_update_request: I/O error, dev nvme0n1, sector 14183280
> [353960.869599] blk_update_request: I/O error, dev nvme0n1, sector 32251848
> [353960.869601] blk_update_request: I/O error, dev nvme0n1, sector 3500872
> [353960.869602] blk_update_request: I/O error, dev nvme0n1, sector 3266216
> [353960.869603] blk_update_request: I/O error, dev nvme0n1, sector 12926288
> [353960.869607] blk_update_request: I/O error, dev nvme0n1, sector 27661040
> [353960.869609] blk_update_request: I/O error, dev nvme0n1, sector 32564280
> [353960.869610] blk_update_request: I/O error, dev nvme0n1, sector 12912072
> [353960.869611] blk_update_request: I/O error, dev nvme0n1, sector 16570728
> [353960.869613] blk_update_request: I/O error, dev nvme0n1, sector 33096144
> [353961.036738] nvme0n1: detected capacity change from 68719476736 to
> -67526893324191744
> [353961.055986] Buffer I/O error on dev nvme0n1, logical block 0, async page
> read
> [353961.073360] Buffer I/O error on dev nvme0n1, logical block 0, async page
> read
> [353961.090572] Buffer I/O error on dev nvme0n1, logical block 0, async page
> read
> [353961.090575] ldm_validate_partition_table(): Disk read failed.
> [353961.090578] Buffer I/O error on dev nvme0n1, logical block 0, async page
> read
> [353961.090582] Buffer I/O error on dev nvme0n1, logical block 0, async page
> read
> [353961.090585] Buffer I/O error on dev nvme0n1, logical block 0, async page
> read
> [353961.090589] Buffer I/O error on dev nvme0n1, logical block 0, async page
> read
> [353961.090593] Buffer I/O error on dev nvme0n1, logical block 0, async page
> read
> [353961.090598] Buffer I/O error on dev nvme0n1, logical block 3, async page
> read
> [353961.090602] Buffer I/O error on dev nvme0n1, logical block 0, async page
> read
> [353961.090607]  nvme0n1: unable to read partition table
> [353973.021283] nvme nvme0: rdma_resolve_addr wait failed (-104).
> [353973.048717] nvme nvme0: Failed reconnect attempt 1
> [353973.060073] nvme nvme0: Reconnecting in 10 seconds...
> [353983.101337] nvme nvme0: rdma_resolve_addr wait failed (-104).
> [353983.128739] nvme nvme0: Failed reconnect attempt 2
> [353983.140280] nvme nvme0: Reconnecting in 10 seconds...
> [353993.181354] nvme nvme0: rdma_resolve_addr wait failed (-104).
> [353993.208714] nvme nvme0: Failed reconnect attempt 3
> [353993.208716] nvme nvme0: Reconnecting in 10 seconds...
> [354003.229292] nvme nvme0: rdma_resolve_addr wait failed (-104).
> [354003.256712] nvme nvme0: Failed reconnect attempt 4
> [354003.268189] nvme nvme0: Reconnecting in 10 seconds...
> [354013.309211] nvme nvme0: rdma_resolve_addr wait failed (-104).
> [354013.336695] nvme nvme0: Failed reconnect attempt 5
> [354013.348043] nvme nvme0: Reconnecting in 10 seconds...
> [354023.389262] nvme nvme0: rdma_resolve_addr wait failed (-104).
> [354023.416682] nvme nvme0: Failed reconnect attempt 6
> [354023.428021] nvme nvme0: Reconnecting in 10 seconds...

And why aren't you able to reconnect?

Something smells mis-configured here...
