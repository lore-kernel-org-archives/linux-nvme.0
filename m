From: bkenward@solarflare.com (Bert Kenward)
Date: Fri, 10 Mar 2017 11:30:00 +0000
Subject: [PATCH RFC 0/4] nvme-fabrics: TCP transport
Message-ID: <ecf773d2-beb9-51db-0ddf-3942e598a581@solarflare.com>

Experimental proof of concept NVMe Fabrics transport over TCP, intended
to provide good performance over any network.

Initial performance tests using both ramdisks and NVMe SSDs show latency
and throughput broadly comparable to a RoCE transport. Further optimisation
is needed, but we welcome input and feedback on our approach and goal of
adding a TCP transport to the NVMe Fabrics specification.

Using this requires a modified version of the nvme-cli tool, available at
https://github.com/solarflarecommunications/nvme-cli/

IPv6 support is not yet implemented, but will be added using Sagi's new
inet_pton_with_scope.

Bert Kenward (2):
  nvme-fabrics: add target support for TCP transport
  nvme-fabrics: add tcp to trtype list for configfs

Ripduman Sohan (2):
  nvme-fabrics: add TCP as valid NVMe transport type
  nvme-fabrics: add host support for TCP transport

 drivers/nvme/host/Kconfig      |   14 +
 drivers/nvme/host/Makefile     |    3 +
 drivers/nvme/host/tcp.c        | 1616 ++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/target/Kconfig    |   12 +
 drivers/nvme/target/Makefile   |    2 +
 drivers/nvme/target/configfs.c |   10 +
 drivers/nvme/target/tcp.c      | 1186 +++++++++++++++++++++++++++++
 include/linux/nvme.h           |    1 +
 8 files changed, 2844 insertions(+)
 create mode 100644 drivers/nvme/host/tcp.c
 create mode 100644 drivers/nvme/target/tcp.c

-- 
2.7.4
