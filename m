From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 12 Jan 2017 13:13:30 +0200
Subject: [PATCH nvme-cli v3 3/3] Documentation: Add entry for gen-hostnqn
In-Reply-To: <1484219610-18370-1-git-send-email-sagi@grimberg.me>
References: <1484219610-18370-1-git-send-email-sagi@grimberg.me>
Message-ID: <1484219610-18370-4-git-send-email-sagi@grimberg.me>

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 Documentation/nvme-gen-hostnqn.txt | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/nvme-gen-hostnqn.txt

diff --git a/Documentation/nvme-gen-hostnqn.txt b/Documentation/nvme-gen-hostnqn.txt
new file mode 100644
index 000000000000..6d5346face5c
--- /dev/null
+++ b/Documentation/nvme-gen-hostnqn.txt
@@ -0,0 +1,29 @@
+nvme-gen-hostnqn(1)
+===================
+
+NAME
+----
+nvme-gen-hostnqn - Generate a host NVMe Qualified Name
+
+SYNOPSIS
+--------
+[verse]
+'nvme gen-hostnqn'
+
+DESCRIPTION
+-----------
+Generate a random host NQN in the form:
+nqn.2014-08.org.nvmexpress:NVMf:uuid:1b4e28ba-2fa1-11d2-883f-0016d3cca427
+and prints it to stdout.
+
+OPTIONS
+-------
+No options needed
+
+EXAMPLES
+--------
+nvme gen-hostnqn
+
+NVME
+----
+Part of the nvme-user suite
-- 
2.7.4
