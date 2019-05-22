From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 22 May 2019 19:39:44 +0300
Subject: [PATCH 0/9] Add Subsystem/Ctrl/Namespace relations
Message-ID: <1558543193-24752-1-git-send-email-maxg@mellanox.com>

This patchset introduce few small bug fixes for memory leaks, improve
coding style, improve code readability and mainly focus on the "nvme list-subsys"
command. This command will show the whole NVM subsystem list (same as "nvme list"
does for namespaces).
The patchset ends with adding namespaces entry per each ctrl in the system.
Actually, at first stage, we'll print only the namespace handle (nvme0n1 for
example). Later on, we can add more attribute per demand (uuid, nguid, capacity,
etc...).

Max Gurtovoy (9):
  nvme: update list-ns nsid option
  nvme: update description for "nvme list" command
  fabrics: Fix memory leak of subsys list
  nvme-print: fix json object memory leak
  nvme: fix coding style issue
  nvme: update list-subsys command to show the entire list
  nvme-print: Introduce show_nvme_ctrl helper
  nvme-print: Rename "Paths" --> "Ctrls" for json output in list-subsys
  nvme: Retrieve namespaces during list-subsys cmd

 fabrics.c    |   6 +-
 nvme-print.c |  51 +++++++----
 nvme.c       | 274 +++++++++++++++++++++++------------------------------------
 nvme.h       |   9 +-
 4 files changed, 150 insertions(+), 190 deletions(-)

-- 
1.8.3.1
