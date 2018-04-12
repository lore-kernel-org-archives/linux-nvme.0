From: tiwai@suse.de (Takashi Iwai)
Date: Thu, 12 Apr 2018 13:02:37 +0200
Subject: [PATCH 1/2] Documentation: fix title markers
In-Reply-To: <20180412110238.30717-1-tiwai@suse.de>
References: <20180412110238.30717-1-tiwai@suse.de>
Message-ID: <20180412110238.30717-2-tiwai@suse.de>

The length of the title marker has to be aligned with the previous
line.  This was caught when running asciidoctor, which is more strict
than asciidoc.

Signed-off-by: Takashi Iwai <tiwai at suse.de>

---
 Documentation/nvme-discover.txt          |    2 +-
 Documentation/nvme-huawei-id-ctrl.txt    |    2 +-
 Documentation/nvme-wdc-id-ctrl.txt       |    2 +-
 Documentation/nvme-wdc-purge-monitor.txt |    2 +-
 Documentation/nvme-wdc-purge.txt         |    2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

--- a/Documentation/nvme-discover.txt
+++ b/Documentation/nvme-discover.txt
@@ -1,5 +1,5 @@
 nvme-discover(1)
-==============
+================
 
 NAME
 ----
--- a/Documentation/nvme-huawei-id-ctrl.txt
+++ b/Documentation/nvme-huawei-id-ctrl.txt
@@ -1,5 +1,5 @@
 nvme-huawei-id-ctrl(1)
-=====================
+======================
 
 NAME
 ----
--- a/Documentation/nvme-wdc-id-ctrl.txt
+++ b/Documentation/nvme-wdc-id-ctrl.txt
@@ -1,5 +1,5 @@
 nvme-wdc-id-ctrl(1)
-=====================
+===================
 
 NAME
 ----
--- a/Documentation/nvme-wdc-purge-monitor.txt
+++ b/Documentation/nvme-wdc-purge-monitor.txt
@@ -1,5 +1,5 @@
 nvme-wdc-purge-monitor(1)
-==========================
+=========================
 
 NAME
 ----
--- a/Documentation/nvme-wdc-purge.txt
+++ b/Documentation/nvme-wdc-purge.txt
@@ -1,5 +1,5 @@
 nvme-wdc-purge(1)
-==================
+=================
 
 NAME
 ----
