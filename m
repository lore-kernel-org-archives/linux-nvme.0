From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 18 Apr 2018 14:59:51 -0400
Subject: [PATCH 00/19] nvmet: add support for file backed namespaces
Message-ID: <20180418190011.3973-1-chaitanya.kulkarni@wdc.com>

Hi,

This patch series implements the file backed namespaces
support for the NVMeOF target.

In current implementation NVMeOF supports block
device backed namespaces on the target side.
With this implementation regular file(s) can be used to
initialize the namespace(s). This approach provides host more
control to create and manage namespaces on target side without
using configfs interface but using tools such as nvme-cli on the
host side.

Structure of the path-series:-

This patch series is divided into two parts. The first
part (0001-0009 patches) implements the file backed
namespaces with existing target side configfs namespace
creation model. In the second part of the series
we implement the code for host side NVMe Namespace
management commands such as nvme-create-ns/nvme-delete-ns.

Example:-

Following example demonstrates how to configure
newly introduced file backed subsystem to create file backed ns:-

1. Target side configuration:-

1.1 Create a subsystem under newly introduced direcotry "fs"
# mkdir /sys/kernel/config/nvmet/fs/file
1.2 Initialize the mount_path attributes where all the backend
    files are created
# echo -n "/mnt/nvme0n1/" > /sys/kernel/config/nvmet/fs/file/attr_mount_path
1.3 Create and initialize the port
# mkdir /sys/kernel/config/nvmet/ports/1/
# echo -n "loop" > /sys/kernel/config/nvmet/ports/1/addr_trtype
# echo -n 1 > /sys/kernel/config/nvmet/fs/file/attr_allow_any_host
# ln -s /sys/kernel/config/nvmet/fs/file /sys/kernel/config/nvmet/ports/1/subsystems/
1.4 Following is the example of the configfs structure after initialization:-

	/sys/kernel/config/nvmet/
		|-- fs
		|   |-- file
		|       |-- allowed_hosts
		|       |-- attr_allow_any_host
		|       |-- attr_mount_path
		|       |-- attr_serial
		|       |-- attr_version
		|-- hosts
		|-- ports
		|   |-- 1
		|       |-- addr_adrfam
		|       |-- addr_traddr
		|       |-- addr_treq
		|       |-- addr_trsvcid
		|       |-- addr_trtype
		|       |-- referrals
		|       |-- subsystems
		|           |-- file -> ../../../../nvmet/fs/file
		|-- subsystems

Note :- We format NVMe SSD with XFS file system to initialize the "mount_path".

2. Host side configuration:-

2.1 Connect to the file backed subsystem
# echo  "transport=loop,nqn=file" > /dev/nvme-fabrics
2.2 Create and list ns on the host:-
# nvme create-ns /dev/nvme1 --nsze=204800000 --ncap=204800000 --flbas=9
create-ns: Success, created nsid:1
2.3 Delete Namespace
# nvme delete-ns /dev/nvme1 -n 1

3. Performance Numbers:-

We collect the performance numbers by configuring the target side
in different modes where target port is configured in "nvme_loop" mode:-

1. Use NVMe PCIe SSD as a block device (default Block device mode).
2. Use File backed NS with O_DIRECT.
3. USe File backed NS with O_SYNC.

I ran simple random read fio, following is the performance comparison:-

				Bandwidth (MB/s)

Iteration 	Block	|	File O_DIRECT	|	File O_SYNC
	1.	2383	|		2655	|		3115
	2.	2380	|		2775	|		3145
	3.	2500	|		2838	|		3176


				IOPS (k)

Iteration 	Block	|	File O_DIRECT	|	File O_SYNC
	1.	610	|		680	|		797
	2.	609	|		710	|		805
	3.	640	|		726	|		813


				Average Latency (usec)

Iteration 	Block	|	File O_DIRECT	|	File O_SYNC
	1.	155	|		139	|		119
	2.	155	|		133	|		118
	3.	148	|		130	|		116

For the first review, I kept the code isolated, I'll aggregate
some of the patches in next version.

For simplicity right now backend file naming is associated with
ctrl-id, for the next version we can get rid of the ctrl-id
dependency, use subsys-nqn to create directory hierarchy
under the "mount_path". With that change, it will be easier to implement
the persistent subsystem structure for file backed subsystem(s)
along with dynamic controller creation as long as the file system is
preserved and "mount_path" is intact.

Chaitanya Kulkarni (20):
  nvmet: add block device guard for smart-log
  nvmet: add a wrapper for ns handlers
  nvmet: add structure members for file I/O
  nvmet: initialize file handle and req fields
  nvmet: add NVMe I/O command handlers for file
  nvmet: add new members for sync file I/O
  nvmet: add sync I/O configfs attr for ns
  nvmet: configure file backed ns for sync IO
  nvmet: use workqueue for sync I/O
  nvmet: isolate id ctrl/ns field initialization
  nvmet: introduce new members for ns-mgmt
  nvmet: add a configfs entry for subsys mount path
  nvmet: initialize new ns and subsys members
  nvmet: add and restructure ns mgmt helpers
  fs: export kern_path_locked() to reuse the code
  nvmet: add ns-mgmt command handlers
  nvmet: override identify for file backed ns
  nvmet: allow host to configure sync vs direct IO
  nvmet: add check for ctrl processing paused status
  nvmet: use processing paused state for VWC

 drivers/nvme/target/admin-cmd.c | 423 +++++++++++++++++++++++++++++++++++++---
 drivers/nvme/target/configfs.c  | 105 +++++++++-
 drivers/nvme/target/core.c      | 168 ++++++++++++++--
 drivers/nvme/target/io-cmd.c    | 165 +++++++++++++++-
 drivers/nvme/target/nvmet.h     |  21 ++
 fs/namei.c                      |   1 +
 6 files changed, 838 insertions(+), 45 deletions(-)

--
2.14.1
