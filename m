From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon,  8 Aug 2016 14:57:56 +0300
Subject: [PATCH v2 nvme-cli 0/4] Useful fabrics patches
Message-ID: <1470657480-5868-1-git-send-email-sagi@grimberg.me>

Hey Keith,

Changes from v1:
- Fixed review comments from Christoph
- Added a patch to take hostnqn from a default conf file if it
  exists (and a hostnqn param wasn't given, patches by Jay and Roy)

Sagi Grimberg (4):
  fabrics: Allow ipv6 address resolution
  fabrics: stringify discover output.
  fabrics: Allow discover params to come from a conf file
  fabrics: Take the hostnqn parameter from a conf file if not given

 common.h  |   2 +
 fabrics.c | 229 +++++++++++++++++++++++++++++++++++++++++++++++++-------------
 2 files changed, 184 insertions(+), 47 deletions(-)

-- 
1.9.1
