From: jsmart2021@gmail.com (James Smart)
Date: Wed, 29 Nov 2017 16:47:29 -0800
Subject: [PATCH 0/4] nvme_fcloop: abort and isr context changes
Message-ID: <20171130004733.19330-1-jsmart2021@gmail.com>

This patch set provides the following:
- fixes abort race conditions
- reworks the add/remove port so that lldd deregistrations can take place
- reworks the fcloop driver so that IN_ISR feature flags aren't needed
- fixes a bunch of race conditions brought out by the IN_ISR changes.


James Smart (4):
  nvme_fcloop: fix abort race condition
  nvme_fcloop: disassocate local port structs
  nvme_fcloop: rework to remove xxx_IN_ISR feature flags
  nvme_fcloop: refactor host/target io job access

 drivers/nvme/target/fcloop.c | 244 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 196 insertions(+), 48 deletions(-)

-- 
2.13.1
