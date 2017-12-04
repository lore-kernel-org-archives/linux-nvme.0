From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon,  4 Dec 2017 11:24:33 +0200
Subject: [PATCH rfc 0/2] Support read-only subsystem critical warning
Message-ID: <20171204092435.20000-1-sagi@grimberg.me>

In case a subsystem enters a read-only mode, the host shall issue
a smart log page request and check the read-only bit in the critical
warning section. In case its set, it shall set all the controller
namespaces in read-only mode (or set the namespaces in read-write in
case its cleared).

The nvmet implements emulation of this to exercise the host (might
also be useful for other use-cases as well though). Add a configfs
knob to trigger read-only subsystem critical event. Also when the
host connects to a read-only subsystem, and AER is queued to notify
the host on the critical warning.

Note that the spec does not refer to the scenario of fabrics connecting
to an already read-only subsystem so the behavior I implemented is what I
thought was most suitable. Also, the spec does not define (at least from
what I found) what happens if a subsystem moves out from read-only state,
so again, the behavior I implemented is what I found to be suitable.

Sagi Grimberg (2):
  nvme: support smart read-only critical warning event
  nvmet: expose option to emulate a nvm subsystem in read-only mode

 drivers/nvme/host/core.c          | 51 +++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/multipath.c     |  4 +++
 drivers/nvme/host/nvme.h          |  2 ++
 drivers/nvme/target/admin-cmd.c   |  3 +++
 drivers/nvme/target/configfs.c    | 34 ++++++++++++++++++++++++++
 drivers/nvme/target/core.c        |  2 +-
 drivers/nvme/target/fabrics-cmd.c |  3 +++
 drivers/nvme/target/io-cmd.c      |  8 +++++-
 drivers/nvme/target/nvmet.h       |  3 +++
 9 files changed, 108 insertions(+), 2 deletions(-)

-- 
2.14.1
