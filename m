From: nab@linux-iscsi.org (Nicholas A. Bellinger)
Date: Wed,  8 Jun 2016 03:34:19 +0000
Subject: [RFC 0/2] nvme/loop: Add support for controllers-per-port model
Message-ID: <1465356861-4321-1-git-send-email-nab@linux-iscsi.org>

From: Nicholas Bellinger <nab@linux-iscsi.org>

Hi again folks,

So building on the nvmet/configfs-ng WIP posted yesterday:

http://marc.info/?l=linux-scsi&m=146528147018404&w=2

This series adds support for nvme/loop to utilize a nvme host
controller per nvmet_port, instead of a single hardcoded entry
for nvmet_port pointer access in nvme_loop_queue_rq().

It uses a struct device model following what we've done in
drivers/target/loopback to allow multiple host controllers
to co-exist under configfs, and is driven by the nvmet_port
configfs enable attribute.

Which means that any arbitary number of nvme-loop controllers
can now exist, and each nvmet_subsystem->ports_group can
enable/disable it's own loopback controller!

Here is how it looks in action for controller id 1 + 2:

root at scsi-mq:/sys/kernel/config/nvmet/subsystems# tree -if .
./nqn.2003-01.org.linux-iscsi.NVMf.newsilicon
./nqn.2003-01.org.linux-iscsi.NVMf.newsilicon/namespaces
./nqn.2003-01.org.linux-iscsi.NVMf.newsilicon/namespaces/1
./nqn.2003-01.org.linux-iscsi.NVMf.newsilicon/namespaces/1/ramdisk1 -> ../../../../../target/core/rd_mcp_2/ramdisk1
./nqn.2003-01.org.linux-iscsi.NVMf.newsilicon/ports
./nqn.2003-01.org.linux-iscsi.NVMf.newsilicon/ports/loop
./nqn.2003-01.org.linux-iscsi.NVMf.newsilicon/ports/loop/addr_adrfam
./nqn.2003-01.org.linux-iscsi.NVMf.newsilicon/ports/loop/addr_portid
./nqn.2003-01.org.linux-iscsi.NVMf.newsilicon/ports/loop/addr_traddr
./nqn.2003-01.org.linux-iscsi.NVMf.newsilicon/ports/loop/addr_treq
./nqn.2003-01.org.linux-iscsi.NVMf.newsilicon/ports/loop/addr_trsvcid
./nqn.2003-01.org.linux-iscsi.NVMf.newsilicon/ports/loop/addr_trtype
./nqn.2003-01.org.linux-iscsi.NVMf.newsilicon/ports/loop/enable
./nqn.2003-01.org.linux-iscsi.NVMf.skylake-ep
./nqn.2003-01.org.linux-iscsi.NVMf.skylake-ep/namespaces
./nqn.2003-01.org.linux-iscsi.NVMf.skylake-ep/namespaces/1
./nqn.2003-01.org.linux-iscsi.NVMf.skylake-ep/namespaces/1/ramdisk0 -> ../../../../../target/core/rd_mcp_1/ramdisk0
./nqn.2003-01.org.linux-iscsi.NVMf.skylake-ep/ports
./nqn.2003-01.org.linux-iscsi.NVMf.skylake-ep/ports/loop
./nqn.2003-01.org.linux-iscsi.NVMf.skylake-ep/ports/loop/addr_adrfam
./nqn.2003-01.org.linux-iscsi.NVMf.skylake-ep/ports/loop/addr_portid
./nqn.2003-01.org.linux-iscsi.NVMf.skylake-ep/ports/loop/addr_traddr
./nqn.2003-01.org.linux-iscsi.NVMf.skylake-ep/ports/loop/addr_treq
./nqn.2003-01.org.linux-iscsi.NVMf.skylake-ep/ports/loop/addr_trsvcid
./nqn.2003-01.org.linux-iscsi.NVMf.skylake-ep/ports/loop/addr_trtype
./nqn.2003-01.org.linux-iscsi.NVMf.skylake-ep/ports/loop/enable

# cat /proc/partitions              
major minor  #blocks  name

 259        0    4194304 nvme0n1
 259        1      65535 nvme1n1
 259        2      65535 nvme2n1

Comments..?

--nab

Nicholas Bellinger (2):
  nvme-fabrics: Add nvmf_get_default_host helper
  nvme/loop: Add support for controller-per-port model

 drivers/nvme/host/fabrics.c |  13 +++-
 drivers/nvme/host/fabrics.h |   1 +
 drivers/nvme/target/loop.c  | 183 +++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 177 insertions(+), 20 deletions(-)

-- 
1.9.1
