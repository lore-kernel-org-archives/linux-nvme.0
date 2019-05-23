From: maxg@mellanox.com (Max Gurtovoy)
Date: Thu, 23 May 2019 12:00:49 +0300
Subject: [PATCH v2 0/9] Add Subsystem/Ctrl/Namespace relations (nvme-cli)
Message-ID: <1558602058-29434-1-git-send-email-maxg@mellanox.com>

This patchset introduce few small bug fixes for memory leaks, improve
coding style, improve code readability and mainly focus on the "nvme list-subsys"
command. This command will show the whole NVM subsystem list (same as "nvme list"
does for namespaces).
The patchset ends with adding namespaces entry per each ctrl in the system.
Actually, at first stage, we'll print only the namespace handle (nvme0n1 for
example). Later on, we can add more attribute per demand (uuid, nguid, capacity,
etc...).

Changes from v1:
 - Added Reviewed-by sign (thanks Minwoo Im)
 - Added check for invalid nsid (proposed by Minwoo Im)
 - Fixed the output for native NVMe multipath

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
 nvme-print.c |  52 +++++++----
 nvme.c       | 281 ++++++++++++++++++++++++-----------------------------------
 nvme.h       |   9 +-
 4 files changed, 158 insertions(+), 190 deletions(-)

-- 
1.8.3.1
