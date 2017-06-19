From: hch@lst.de (Christoph Hellwig)
Date: Mon, 19 Jun 2017 11:57:48 +0200
Subject: track subsystem relationships and shared namespaces V2
Message-ID: <20170619095754.4602-1-hch@lst.de>

Hi all,

this set adds the first bits of required infrastructure for proper
multipath support in the NVMe driver.  It tracks if multiple controllers
belong to the same subsystem, and if they do which namespaces on the
controller refer to the same data.  As part of that it validates a lot
of the restrictions in the NVMe spec related to these facts.

Btw, qemu is a perfect way to create controllers with the same NQN
that fail these checks, as it allows you to specify the same serial
number for multiple controllers, and never sets the required CMIC
bit for multi-controller subsystems.

Changes since V1:
 - don't hardcode offsets in nvme_init_subnqn
 - rename __nvme_find_subsystem to __nvme_find_get_subsystem
 - rename nvme_ns_link_siblings and move the list_add out of it
