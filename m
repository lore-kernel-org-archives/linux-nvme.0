From: hare@suse.de (Hannes Reinecke)
Date: Thu, 24 May 2018 16:18:14 +0200
Subject: [PATCH 0/3] nvme: fix stuck discovery
Message-ID: <20180524141817.127576-1-hare@suse.de>

Hi all,

when the user manages to abort a 'nvme discover' the resulting discovery
controller is never removed, as it will try to reconnect for ever.
And as the 'duplicate_connect' option is not given any further attempt
will be returned with -EALREADY.

This patchset fixes this issue by a) disabling reconnection attempts
and b) allowing for duplicate connections on the discovery controller.

As usual, comments and reviews are welcome.

Hannes Reinecke (3):
  nvme: centralize discovery controller defaults
  nvme: avoid reconnection for the discovery controller
  nvme: allow duplicate connections to the discovery controller

 drivers/nvme/host/core.c    |  3 ++-
 drivers/nvme/host/fabrics.c | 12 ++++++++----
 2 files changed, 10 insertions(+), 5 deletions(-)

-- 
2.12.3
