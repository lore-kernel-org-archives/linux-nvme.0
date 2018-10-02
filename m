From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon,  1 Oct 2018 17:14:18 -0700
Subject: [PATCH rfc 0/4] Support SQ flow control disabled mode (TP 8005)
Message-ID: <20181002001422.9111-1-sagi@grimberg.me>

Technical proposal 8005 adds a mode where sq head pointer updates can be
omitted based on the controller capability. When a host connects to
a controller it can request it to turn off SQ flow control (e.g. omit
sq head pointer updates). If the controller supports it, it returns
0xffff sq_head in the connect capsule response cqe.

Supporting this mode in nvmet means we can skip an atomic update in
the data path so we don't mind. Note that the host side still ignores
sq head pointer updates and flow controls based on completion accounting
alone. This TP at least gives us a mode that it is compliant.

When a controller implementation comes along that relies on sq head pointer
updates to flow control the host, we will probably need to address that, but
until then, we can start by micro-optimizing nvmet.

nvmet also exposes this capability in transport requirement field in the
discovery lof entry for host implementations that may want to talk to a
controller based on this capability, but the Linux host will always attempt
to set it in the connect.

A follow up nvme-cli parser for this will follow this series.

Sagi Grimberg (4):
  nvmet: support fabrics sq flow control
  nvmet: don't override treq upon modification.
  nvmet: expose support for fabrics SQ flow control disable in treq
  nvme: Ask for fabrics SQ flow control disable by default

 drivers/nvme/host/fabrics.c       |  6 ++++++
 drivers/nvme/target/configfs.c    | 11 ++++++----
 drivers/nvme/target/core.c        | 34 ++++++++++++++++++++-----------
 drivers/nvme/target/fabrics-cmd.c |  8 +++++++-
 drivers/nvme/target/nvmet.h       |  3 ++-
 include/linux/nvme.h              | 11 +++++++---
 6 files changed, 52 insertions(+), 21 deletions(-)

-- 
2.17.1
