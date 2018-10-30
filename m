From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 30 Oct 2018 10:43:40 -0700
Subject: [PATCH v2 0/4] traffic based keep alive support (TP 4024)
Message-ID: <20181030174344.20171-1-sagi@grimberg.me>

Traffic Based Keep Alive TP (4024) was ratified recently. The technical
proposal introduces a mode where keep alive commands may be omitted
based on the presence of admin or io traffic during the keep alive timeout
period. The rational is that normal command execution is sufficient
indication of host, controller and transport health so the keep alive command
is redundant.

Moreover, There is no way to guarantee in the various transports that a
keep alive command will not be starved by heavy traffic, causing the
keep alive timeout to expire. There were a number bug reports on
linux nvme community on this exact issue.

The implementation simply a controller-wide indicator that is cleared
upon reset of the keep alive timer and set when a command (target) or
completion (host) is processed. When the keep alive timer expires, we
check if any command/completion were processed, we restart the keep
alive timer even if a keep alive command was not executed.

Changes from v1:
- omit comp_seen update for controllers that don't support keep alive

Sagi Grimberg (4):
  nvme: introduce ctrl attributes enumeration
  nvmet: support for traffic based keep-alive
  nvme-core: cache controller attributes
  nvme-core: support traffic based keep-alive based on controller
    support

 drivers/nvme/host/core.c        | 14 ++++++++++++++
 drivers/nvme/host/nvme.h        |  2 ++
 drivers/nvme/target/admin-cmd.c |  3 ++-
 drivers/nvme/target/core.c      | 12 ++++++++++++
 drivers/nvme/target/nvmet.h     |  2 ++
 include/linux/nvme.h            |  5 +++++
 6 files changed, 37 insertions(+), 1 deletion(-)

-- 
2.17.1
