From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 19 Nov 2018 14:11:11 -0800
Subject: [PATCH v4 0/4] Support SQ flow control disabled mode (TP 8005)
Message-ID: <20181119221116.23749-1-sagi@grimberg.me>

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
controller based on this capability, we use it to have our host to connect
with sq flow control disabled if the controller supports it, otherwise the
host connects normally as its doing today.

A nvme-cli patch is also attached sent together with the series. This
patch is handling a fallback if it works with a host that does not
support disable_sqflow but the target does support it.

Changes from v3:
- reworked sq flow control support in nvmet based on hch suggestion
- added disable_sqflow option to nvme-cli connect
- fixed nvme-cli connect-all fallback to stay compatible if the fabrics
  driver does not support disable_sqflow flag.

Changes from v2:
- fix nested if condition in nvmet_update_sq_head
- introduce meaningful define for fabrics secure channel mask
- added explicit disable_sqflow flag in nvme-cli

Changes from v1:
- changed define names (disable_sqflow) as hannes suggested
- changed the mode to not be used by default and keep the existing
  behavior, the host will only try to disable sq flow control when
  userspace asked it to.
- added nvme-cli patch that adds --disable-sqflow if the controller
  exposes support.

Sagi Grimberg (4):
  nvmet: support fabrics sq flow control
  nvmet: don't override treq upon modification.
  nvmet: expose support for fabrics SQ flow control disable in treq
  nvme: disable fabrics SQ flow control when asked by the user

 drivers/nvme/host/fabrics.c       | 13 ++++++++++++-
 drivers/nvme/host/fabrics.h       |  2 ++
 drivers/nvme/target/configfs.c    | 12 ++++++++----
 drivers/nvme/target/core.c        | 22 +++++++++++++---------
 drivers/nvme/target/fabrics-cmd.c |  6 ++++++
 drivers/nvme/target/nvmet.h       |  1 +
 include/linux/nvme.h              | 13 ++++++++++---
 7 files changed, 52 insertions(+), 17 deletions(-)

-- 
2.17.1
