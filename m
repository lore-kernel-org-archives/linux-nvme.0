From: philip.yang@huawei.com (y00223423)
Date: Fri, 10 Mar 2017 09:52:45 +0800
Subject: [PATCH] nvme-cli: list-ns: fix docs to fit the function
Message-ID: <1489110765-9052-1-git-send-email-philip.yang@huawei.com>

From: Guan Junxiong <guanjunxiong@huawei.com>

the list_ns function implements two command line options but the help document only shows the first option which is the given namespace-id , leaving the second option which is all namesapces out.
---
 Documentation/nvme-list-ns.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/nvme-list-ns.txt b/Documentation/nvme-list-ns.txt
index 13a12d6..1a4b5f1 100644
--- a/Documentation/nvme-list-ns.txt
+++ b/Documentation/nvme-list-ns.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'nvme list-ns' <device> [--namespace-id=<nsid> | -n <nsid>]
-
+                        [--all | -a ]
 DESCRIPTION
 -----------
 For the NVMe device given, sends an identify command for namespace list
@@ -29,6 +29,10 @@ OPTIONS
 --namespace-id=<nsid>::
 	Retrieve the identify list structure starting with the given nsid.
 
+-a ::
+--all::
+	Retrieve the identify list structure for all the namespace
+
 EXAMPLES
 --------
 No examples yet.
-- 
2.6.4.windows.1
