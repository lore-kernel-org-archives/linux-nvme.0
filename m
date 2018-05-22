From: keith.busch@intel.com (Keith Busch)
Date: Tue, 22 May 2018 16:03:24 -0600
Subject: [PATCHv2 0/8] nvme timeout fixes v2
Message-ID: <20180522220332.9244-1-keith.busch@intel.com>

While some substantial changes to the blk-mq's timeout handling are
under consideration, the following should be compatible with existing
implementation, and current proposals for the future.

v1 -> v2:

  Reverse the sync/disable sequence on nvme reset in case a request was
  prevented from completing in the timeout work, then unconditionally
  disable the device to reclaim any remaining outstanding tags.

  Ensure we're not incorrectly clearing the new queue freeze flag.

  Do not start IO queues within the CONNECTING state. The queues will be
  started after entering the LIVE state.

  Fixed the ratelimit to the intended print.

  A new fix for a very unlikely race where an IO was blocked from
  completing prior to a reset, timing out yet again in CONNECTING state.

  A fix for a failed controller recovery that could leave queues quiesced
  when trying to unbind the driver.

  Whitespace fixes

Keith Busch (8):
  nvme: Sync request queues on reset
  nvme-pci: Fix queue freeze criteria on reset
  nvme: Move all IO out of controller reset
  nvme: Allow reset from CONNECTING state
  nvme-pci: Attempt reset retry for IO failures
  nvme-pci: Rate limit the nvme timeout warnings
  nvme-pci: End IO requests immediately in CONNECTING state
  nvme-pci: Ensure queues are not quiesced on dead controller

 drivers/nvme/host/core.c |  24 +++++++++-
 drivers/nvme/host/nvme.h |   2 +
 drivers/nvme/host/pci.c  | 117 +++++++++++++++++++++++++++++++++--------------
 3 files changed, 106 insertions(+), 37 deletions(-)

-- 
2.14.3
