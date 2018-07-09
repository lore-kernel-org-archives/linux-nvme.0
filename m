From: byi@connect.ust.hk (Bairen YI)
Date: Mon, 9 Jul 2018 04:06:05 +0000
Subject: NVMe over Fabrics I/O Error with RDMA/RXE
Message-ID: <4F63AE27-CBFD-4429-8BF9-ADEE946A9DB7@connect.ust.hk>

Hi all,

I am testing NVMe over Fabrics on a Linux 4.15 VM (latest Ubuntu 18.04 LTS, unmodified kernel), with an NVMe card and SoftRoCE (RXE) as transport. 

It works just fine for the client connecting NVMeof target. However, it reports I/O error and timeout when read/write to the target over RXE.

NVMeof target demsg:

[  207.924912] rdma_rxe: loaded
[  207.974258] rdma_rxe: set rxe0 active
[  207.974259] rdma_rxe: added rxe0 to ens5
[  208.136753] RPC: Registered named UNIX socket transport module.
[  208.136754] RPC: Registered udp transport module.
[  208.136755] RPC: Registered tcp transport module.
[  208.136755] RPC: Registered tcp NFSv4.1 backchannel transport module.
[  208.221549] RPC: Registered rdma transport module.
[  208.221550] RPC: Registered rdma backchannel transport module.
[  814.714362] nvmet: adding nsid 10 to subsystem nvmeof
[  883.716604] nvmet_rdma: enabling port 1 (10.140.0.2:4420)

NVMeof client demsg:

[  210.410272] rdma_rxe: loaded
[  210.438950] rdma_rxe: set rxe0 active
[  210.438951] rdma_rxe: added rxe0 to ens4
[  210.575369] RPC: Registered named UNIX socket transport module.
[  210.575370] RPC: Registered udp transport module.
[  210.575371] RPC: Registered tcp transport module.
[  210.575371] RPC: Registered tcp NFSv4.1 backchannel transport module.
[  210.623886] RPC: Registered rdma transport module.
[  210.623887] RPC: Registered rdma backchannel transport module.
[  914.043768] nvme nvme0: creating 4 I/O queues.
[  914.049079] nvme nvme0: new ctrl: NQN "nvmeof", addr 10.140.0.2:4420

After an `fio` benchmarking command, the client reports error:

fio: io_u error on file /dev/nvme0n1: Input/output error: read offset=19457638400, buflen=65536
fio: io_u error on file /dev/nvme0n1: Input/output error: read offset=59311718400, buflen=65536
fio: io_u error on file /dev/nvme0n1: Input/output error: read offset=283416395776, buflen=65536
fio: io_u error on file /dev/nvme0n1: Input/output error: read offset=310615080960, buflen=65536
fio: io_u error on file /dev/nvme0n1: Input/output error: read offset=170021748736, buflen=65536
fio: io_u error on file /dev/nvme0n1: Input/output error: read offset=215924080640, buflen=65536
fio: io_u error on file /dev/nvme0n1: Input/output error: read offset=271643115520, buflen=65536
fio: io_u error on file /dev/nvme0n1: Input/output error: read offset=302967488512, buflen=65536
fio: io_u error on file /dev/nvme0n1: Input/output error: read offset=346368442368, buflen=65536
fio: io_u error on file /dev/nvme0n1: Input/output error: read offset=373731688448, buflen=65536
fio: io_u error on file /dev/nvme0n1: Input/output error: read offset=230237929472, buflen=65536
fio: io_u error on file /dev/nvme0n1: Input/output error: read offset=218070908928, buflen=65536
fio: pid=1963, err=5/file:io_u.c:1756, func=io_u error, error=Input/output error
fio: pid=1956, err=5/file:io_u.c:1756, func=io_u error, error=Input/output error
fio: io_u error on file /dev/nvme0n1: Input/output error: read offset=369396809728, buflen=65

NVMeof target dmesg:

[  814.714362] nvmet: adding nsid 10 to subsystem nvmeof
[  883.716604] nvmet_rdma: enabling port 1 (10.140.0.2:4420)
[  916.450484] nvmet: creating controller 1 for subsystem nvmeof for NQN nqn.2014-08.org.nvmexpress:uuid:2f1af066-4ffe-4c77-aa5e-5a062ae3f561.
[  916.456273] nvmet: adding queue 1 to ctrl 1.
[  916.456413] nvmet: adding queue 2 to ctrl 1.
[  916.456566] nvmet: adding queue 3 to ctrl 1.
[  916.456689] nvmet: adding queue 4 to ctrl 1.
[ 1004.436366] nvmet_rdma: freeing queue 1
[ 1004.436619] nvmet_rdma: freeing queue 2
[ 1004.436825] nvmet_rdma: freeing queue 3
[ 1004.437534] nvmet_rdma: freeing queue 4
[ 1004.452101] nvmet_rdma: freeing queue 0
[ 1014.685771] nvmet: creating controller 1 for subsystem nvmeof for NQN nqn.2014-08.org.nvmexpress:uuid:2f1af066-4ffe-4c77-aa5e-5a062ae3f561.
[ 1014.690580] nvmet: adding queue 1 to ctrl 1.
[ 1014.690862] nvmet: adding queue 2 to ctrl 1.
[ 1014.691208] nvmet: adding queue 3 to ctrl 1.
[ 1014.691348] nvmet: adding queue 4 to ctrl 1.

NVMeof client dmesg:

[  914.043768] nvme nvme0: creating 4 I/O queues.
[  914.049079] nvme nvme0: new ctrl: NQN "nvmeof", addr 10.140.0.2:4420
[ 1001.936366] nvme nvme0: I/O 1 QID 3 timeout, reset controller
[ 1001.936386] print_req_error: I/O error, dev nvme0c1n1, sector 38003200
[ 1001.943222] nvme nvme0: I/O 2 QID 3 timeout, reset controller
[ 1001.943225] print_req_error: I/O error, dev nvme0c1n1, sector 115843200
[ 1001.950312] nvme nvme0: I/O 3 QID 3 timeout, reset controller
[ 1001.950400] print_req_error: I/O error, dev nvme0c1n1, sector 591733376
[ 1001.958740] nvme nvme0: I/O 4 QID 3 timeout, reset controller
[ 1001.958750] print_req_error: I/O error, dev nvme0c1n1, sector 676500864
[ 1001.967384] nvme nvme0: I/O 5 QID 3 timeout, reset controller
[ 1001.967389] print_req_error: I/O error, dev nvme0c1n1, sector 553547648
[ 1001.975602] nvme nvme0: I/O 6 QID 3 timeout, reset controller
[ 1001.975606] print_req_error: I/O error, dev nvme0c1n1, sector 606670080
[ 1001.983731] nvme nvme0: I/O 7 QID 3 timeout, reset controller
[ 1001.983735] print_req_error: I/O error, dev nvme0c1n1, sector 721478144
[ 1001.991889] nvme nvme0: I/O 65 QID 3 timeout, reset controller
[ 1001.991892] print_req_error: I/O error, dev nvme0c1n1, sector 332073728
[ 1002.000104] nvme nvme0: I/O 66 QID 3 timeout, reset controller
[ 1002.000107] print_req_error: I/O error, dev nvme0c1n1, sector 421726720
[ 1002.008453] nvme nvme0: I/O 67 QID 3 timeout, reset controller
[ 1002.008457] print_req_error: I/O error, dev nvme0c1n1, sector 530552960
[ 1002.016657] nvme nvme0: I/O 68 QID 3 timeout, reset controller
[ 1002.016669] nvme nvme0: I/O 69 QID 3 timeout, reset controller
[ 1002.016672] nvme nvme0: I/O 70 QID 3 timeout, reset controller
[ 1002.016682] nvme nvme0: I/O 71 QID 3 timeout, reset controller
[ 1002.016691] nvme nvme0: I/O 72 QID 3 timeout, reset controller
[ 1002.016699] nvme nvme0: I/O 73 QID 3 timeout, reset controller
[ 1002.016702] nvme nvme0: I/O 74 QID 3 timeout, reset controller
[ 1002.016714] nvme nvme0: I/O 75 QID 3 timeout, reset controller
[ 1002.016721] nvme nvme0: I/O 76 QID 3 timeout, reset controller
[ 1002.016726] nvme nvme0: I/O 78 QID 3 timeout, reset controller
[ 1002.016729] nvme nvme0: I/O 79 QID 3 timeout, reset controller
[ 1002.016732] nvme nvme0: I/O 80 QID 3 timeout, reset controller
[ 1002.016737] nvme nvme0: I/O 82 QID 3 timeout, reset controller
[ 1002.016742] nvme nvme0: I/O 83 QID 3 timeout, reset controller
[ 1002.016745] nvme nvme0: I/O 86 QID 3 timeout, reset controller
[ 1002.016752] nvme nvme0: I/O 88 QID 3 timeout, reset controller
[ 1002.016757] nvme nvme0: I/O 90 QID 3 timeout, reset controller
[ 1002.016761] nvme nvme0: I/O 91 QID 3 timeout, reset controller
[ 1002.016764] nvme nvme0: I/O 92 QID 3 timeout, reset controller
[ 1002.016772] nvme nvme0: I/O 93 QID 3 timeout, reset controller
[ 1002.016776] nvme nvme0: I/O 94 QID 3 timeout, reset controller
[ 1002.016779] nvme nvme0: I/O 95 QID 3 timeout, reset controller
[ 1002.016783] nvme nvme0: I/O 96 QID 3 timeout, reset controller
[ 1002.016787] nvme nvme0: I/O 97 QID 3 timeout, reset controller
[ 1002.016791] nvme nvme0: I/O 98 QID 3 timeout, reset controller
[ 1002.016797] nvme nvme0: I/O 99 QID 3 timeout, reset controller
[ 1002.016801] nvme nvme0: I/O 100 QID 3 timeout, reset controller
[ 1002.016804] nvme nvme0: I/O 101 QID 3 timeout, reset controller
[ 1002.016810] nvme nvme0: I/O 102 QID 3 timeout, reset controller
[ 1002.016816] nvme nvme0: I/O 103 QID 3 timeout, reset controller
[ 1002.016822] nvme nvme0: I/O 104 QID 3 timeout, reset controller
[ 1002.016826] nvme nvme0: I/O 105 QID 3 timeout, reset controller
[ 1002.016829] nvme nvme0: I/O 106 QID 3 timeout, reset controller
[ 1002.016836] nvme nvme0: I/O 107 QID 3 timeout, reset controller
[ 1002.016843] nvme nvme0: I/O 108 QID 3 timeout, reset controller
[ 1002.016849] nvme nvme0: I/O 109 QID 3 timeout, reset controller
[ 1002.016855] nvme nvme0: I/O 110 QID 3 timeout, reset controller
[ 1002.016858] nvme nvme0: I/O 111 QID 3 timeout, reset controller
[ 1002.016865] nvme nvme0: I/O 112 QID 3 timeout, reset controller
[ 1002.016868] nvme nvme0: I/O 113 QID 3 timeout, reset controller
[ 1002.016874] nvme nvme0: I/O 114 QID 3 timeout, reset controller
[ 1002.016878] nvme nvme0: I/O 115 QID 3 timeout, reset controller
[ 1002.016882] nvme nvme0: I/O 116 QID 3 timeout, reset controller
[ 1002.016887] nvme nvme0: I/O 117 QID 3 timeout, reset controller
[ 1002.016891] nvme nvme0: I/O 118 QID 3 timeout, reset controller
[ 1002.016898] nvme nvme0: I/O 119 QID 3 timeout, reset controller
[ 1002.016902] nvme nvme0: I/O 120 QID 3 timeout, reset controller
[ 1002.016907] nvme nvme0: I/O 121 QID 3 timeout, reset controller
[ 1002.016910] nvme nvme0: I/O 122 QID 3 timeout, reset controller
[ 1002.016914] nvme nvme0: I/O 123 QID 3 timeout, reset controller
[ 1002.016919] nvme nvme0: I/O 124 QID 3 timeout, reset controller
[ 1002.016924] nvme nvme0: I/O 125 QID 3 timeout, reset controller
[ 1002.016928] nvme nvme0: I/O 126 QID 3 timeout, reset controller
[ 1002.024449] block nvme0n1: no path available - requeuing I/O
[ 1002.040643] nvme nvme0: Reconnecting in 10 seconds...
[ 1012.274698] nvme nvme0: creating 4 I/O queues.
[ 1012.279370] nvme nvme0: Successfully reconnected (1 attempts)
[ 1012.331792] nvme0c1n1: detected capacity change from 0 to 402653184000

Does NVMeof support over RXE or other software RDMA (like SoftiWarp) now?

Best,
Bairen Yi
