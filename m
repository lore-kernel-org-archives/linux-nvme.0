From: hare@suse.de (Hannes Reinecke)
Date: Thu,  1 Aug 2019 09:16:42 +0200
Subject: [PATCH 0/2] skip removed namespaces
Message-ID: <20190801071644.66690-1-hare@suse.de>

Hi all,

when traversing the namespaces lists we need to ensure to skip
any namespaces marked as 'REMOVING', as these are about to be
deleted and shouldn't be accessed anymore.

As usual, comments and reviews are welcome.

Hannes Reinecke (2):
  nvme: skip namespaces which are about to be removed
  nvme: do not remove namespaces during reset

 drivers/nvme/host/core.c | 44 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 4 deletions(-)

-- 
2.16.4
