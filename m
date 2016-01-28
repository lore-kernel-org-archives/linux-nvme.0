From: nab@linux-iscsi.org (Nicholas A. Bellinger)
Date: Wed, 27 Jan 2016 20:41:43 -0800
Subject: [LSF/MM TOPIC] NVMe target support
Message-ID: <1453956103.6746.195.camel@haakon3.risingtidesystems.com>

Hi lsf-pc & Co,

I'd like to propose a NVMe target discussion topic for LSF/MM 2016.

My interest wrt NVMe target drivers is specifically around using shared
infrastructure with existing TCM backend drivers (IBLOCK, FILEIO,
RAMDISK), and how se_device->dev_group configfs symlinks can be
associated with NVMe target driver ports following HCH's WIP code.
Also, there is still a vendor need around some type of NVMe backend
driver (eg: target_core_nvme) for exposing + mapping NVMe-HI queues to
front-end fabric driver RDMA queues.

Beyond the back-end driver discussion, our target_core_fabric_configfs.c
logic for exposing a common user-space ABI has served LIO target drivers
well over the last 10 upstream fabrics, plus other out-of-tree and WIP
drivers.  The design has never once had to break userspace ABI
compatibility, and the only user-visible addition to original design
was allowing network portal attributes to be exposed by fabrics for
iser-target + iscsit_transport friends.

I think one of the more interesting questions is going to be around how
NVMe-over-Fabrics (NVMe_OF) + vhost-nvme will end up using
target_core_fabric_configfs.c code.  What struct config_groups from
target_core_fabric_configfs.c can be common across both SCSI target and
NVMe controller export..?

The folks for such a discussion would include:

   Christoph Hellwig, Hannes Reinecke, Dave Minturn, Sagi Grimberg,
   Ming Lin, Roland Dreier and Mike Christie.

Thank you,

--nab
