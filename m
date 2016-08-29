From: luto@kernel.org (Andy Lutomirski)
Date: Mon, 29 Aug 2016 02:25:43 -0700
Subject: [PATCH 0/3] nvme power saving
Message-ID: <cover.1472462539.git.luto@kernel.org>

Hi all-

Here's v1 of the APST patch set.  The biggest bikesheddable thing (I
think) is the scaling factor.  I currently have it hardcoded so that
we wait 50x the total latency before entering a power saving state.
On my Samsung 950, this means we enter state 3 (70mW, 0.5ms entry
latency, 5ms exit latency) after 275ms and state 4 (5mW, 2ms entry
latency, 22ms exit latency) after 1200ms.  I have the default max
latency set to 25ms.

FWIW, in practice, the latency this introduces seems to be well
under 22ms, but my benchmark is a bit silly and I might have
measured it wrong.  I certainly haven't observed a slowdown just
using my laptop.

Andy Lutomirski (3):
  nvme/scsi: Remove power management support
  nvme: Pass pointers, not dma addresses, to nvme_get/set_features()
  nvme: Enable autonomous power state transitions

 drivers/nvme/host/core.c | 199 +++++++++++++++++++++++++++++++++++++++++++++--
 drivers/nvme/host/nvme.h |  10 ++-
 drivers/nvme/host/scsi.c |  80 ++-----------------
 include/linux/nvme.h     |   6 ++
 4 files changed, 211 insertions(+), 84 deletions(-)

-- 
2.7.4
