From: luto@kernel.org (Andy Lutomirski)
Date: Thu, 15 Sep 2016 22:24:18 -0700
Subject: [PATCH v3 0/3] nvme power saving
Message-ID: <cover.1474002926.git.luto@kernel.org>

Hi all-

Here's v3 of the APST patch set.  The biggest bikesheddable thing (I
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

This time around, I changed the names of parameters after Jay
Frayensee got confused by the first try.  Now they are:

 - ps_max_latency_us in sysfs: actually controls it.
 - nvme_core.default_ps_max_latency_us: sets the default.

Yeah, they're mouthfuls, but they should be clearer now.

Changes from v2:
 - Rename the parameters.

Changes from v1:
 - Get rid of feature buffer alignment warnings.
 - Change the error message if NPSS is bogus.
 - Rename apst_max_latency_ns to apst_max_latency_us because module params
   don't like u64 or unsigned long long and I wanted to make it fit more
   comfortably in a ulong module param.  (And the nanoseconds were useless.)
 - Add a module parameter for the default max latency.

Andy Lutomirski (3):
  nvme/scsi: Remove power management support
  nvme: Pass pointers, not dma addresses, to nvme_get/set_features()
  nvme: Enable autonomous power state transitions

 drivers/nvme/host/core.c | 184 ++++++++++++++++++++++++++++++++++++++++++++---
 drivers/nvme/host/nvme.h |  10 ++-
 drivers/nvme/host/scsi.c |  80 ++-------------------
 include/linux/nvme.h     |   6 ++
 4 files changed, 196 insertions(+), 84 deletions(-)

-- 
2.7.4
