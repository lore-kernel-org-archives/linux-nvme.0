From: mskorzhinskiy@solarflare.com (Mikhail Skorzhinskii)
Date: Wed, 21 Nov 2018 16:03:57 +0300
Subject: [PATCH 0/2] nvme-tcp: protection from misbehaving link partners
Message-ID: <cover.1542805437.git.mskorzhinskiy@solarflare.com>

This patch sequence are about to fix a few minor kernel crashes and memory
corruptions that was spot on a few stress test runs with misbehvaing link
partners.

patches 1-2 prevents these awkward crashes and corruptions

Mikhail Skorzhinskii (2):
  nvmet-tcp: add protection for already completed requests on h2c path
  nvme-tcp: add protection against target sending more then maxr2t

 drivers/nvme/host/tcp.c   | 19 ++++++++++++++++++-
 drivers/nvme/target/tcp.c | 19 +++++++++++++++++--
 include/linux/nvme-tcp.h  |  3 +++
 3 files changed, 38 insertions(+), 3 deletions(-)

-- 
2.16.4
