From: sshah@solarflare.com (Shradha Shah)
Date: Wed, 29 Aug 2018 10:53:45 +0100
Subject: [PATCH 0/3] TLS initiator side implementation
Message-ID: <697ba799-b8b4-c7b5-734d-09e898295a4f@solarflare.com>

This is the patch series for initiator side TLS implementation.

At alloc_queue time, the kernel will send a netlink message to
the user space process to perform the TLS handshake, which in
turn will reply back with a KTLS socket.

Each queue uses this newly created KTLS socket for its communication.

The TLS handshake uses PSK authorization. I have just chosen a random
value of key and hint but this will be replaced with the correct NQN
once the target implementation is complete.

This is version 1 of this patch series and addresses all the issue
reported on the previous patch series which was a RFC patch series.

Shradha Shah (3):
  nvme-tcp: TLS encryption support-Introduce boolean flag in the header
    file
  nvme-tcp: TLS encrytion support using netlink sockets
  User mode server and client code

 drivers/nvme/host/fabrics.c       |   8 +-
 drivers/nvme/host/fabrics.h       |   3 +
 drivers/nvme/host/nvme.h          |   2 +
 drivers/nvme/host/tcp.c           | 154 +++++++++++++++++--
 include/uapi/linux/nvme_netlink.h |  43 ++++++
 tls/Makefile                      |  12 ++
 tls/client.c                      | 308 ++++++++++++++++++++++++++++++++++++++
 tls/server.c                      | 183 ++++++++++++++++++++++
 8 files changed, 703 insertions(+), 10 deletions(-)
 create mode 100644 include/uapi/linux/nvme_netlink.h
 create mode 100644 tls/Makefile
 create mode 100644 tls/client.c
 create mode 100644 tls/server.c

-- 
2.14.4
