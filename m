From: hch@lst.de (Christoph Hellwig)
Date: Thu, 15 Jun 2017 18:34:56 +0200
Subject: track subsystem relationships and shared namespaces
Message-ID: <20170615163502.10548-1-hch@lst.de>

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
