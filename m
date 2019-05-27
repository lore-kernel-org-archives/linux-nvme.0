From: maxg@mellanox.com (Max Gurtovoy)
Date: Mon, 27 May 2019 13:01:41 +0300
Subject: [PATCH v3 0/9] Add Subsystem/Ctrl/Namespace relations (nvme-cli)
Message-ID: <1558951310-31066-1-git-send-email-maxg@mellanox.com>

This patchset introduce few small bug fixes for memory leaks, improve
coding style, improve code readability and mainly focus on the "nvme list-subsys"
command. This command will show the whole NVM subsystem list (same as "nvme list"
does for namespaces).
The patchset ends with adding namespaces entry per each ctrl in the system.
Actually, at first stage, we'll print only the namespace handle (nvme0n1 for
example). Later on, we can add more attribute per demand (uuid, nguid, capacity,
etc...).

Changes from V2:
 - Added one more Reviewed-by sign (thanks Minwoo Im)
 - Added debug print for invalid nsid (proposed by Kenneth)
 - Updated the output for native NVMe multipath device to print "head" instead
   of hidden devices (proposed by Keith and Christopth)

Changes from V1:
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
 nvme-print.c |  52 ++++++----
 nvme.c       | 305 ++++++++++++++++++++++++++---------------------------------
 nvme.h       |   9 +-
 4 files changed, 181 insertions(+), 191 deletions(-)

-- 
1.8.3.1
