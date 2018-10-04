From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu,  4 Oct 2018 14:23:23 -0700
Subject: [PATCH rfc 0/3] add support to discovery async event notifications
Message-ID: <20181004212328.30205-1-sagi@grimberg.me>

In order to support discovery AENs we need to have two things:
1. Support long lived discovery controller sessions that would allow to
   receive discovery AENs. This means we need to specify kato in connect

2. Support discovery log change events. The choice here is to simply fire
   a udev event and let userspace to:
   1. issue an updated discovery log page via our discovery controller (1)
   2. connect to every new subsystem/port that exists in the system.

This patch set was developed against the nvmet support patch set from Jay.

nvme-cli patches are also included in this series.

the udev rule that ultimately achieves dynamic discovery enumeration (TP 8002)
is:

SUBSYSTEM=="nvme", ACTION=="change", \
  RUN+="/usr/sbin/nvme connect-all --device=nvme$env{NVME_INSTANCE} --transport=$env{NVME_TRTYPE} \
  --traddr=$env{NVME_TRADDR} --trsvcid=$env{NVME_TRSVCID} & disown

Sagi Grimberg (3):
  nvme-fabrics: allow discovery subsystems accept a kato
  nvme: enable aen also for discovery controllers
  nvme: fire discovery log page change events to userspace

 drivers/nvme/host/core.c    | 36 +++++++++++++++++++++++++++++++++---
 drivers/nvme/host/fabrics.c | 16 +++-------------
 2 files changed, 36 insertions(+), 16 deletions(-)

-- 
2.17.1
