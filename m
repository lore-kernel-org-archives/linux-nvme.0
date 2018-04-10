From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue, 10 Apr 2018 10:51:10 +0200
Subject: [PATCH nvme-cli] Documentation: add manpage entry for connect's
 --ctrl-loss-tmo setting
Message-ID: <20180410085110.21112-1-jthumshirn@suse.de>

When adding nvme connect's --ctrl-loss-tmo flag we forgot to update
the manpage accordingly.

Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
Reported-by: Matt Schulte <matt.schulte at netapp.com>
---
 Documentation/nvme-connect.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/nvme-connect.txt b/Documentation/nvme-connect.txt
index a746a3a721ed..af78b2a8238f 100644
--- a/Documentation/nvme-connect.txt
+++ b/Documentation/nvme-connect.txt
@@ -19,6 +19,7 @@ SYNOPSIS
 		[--queue-size=<#>         | -Q <#>]
 		[--keep-alive-tmo=<#>     | -k <#>]
 		[--reconnect-delay=<#>    | -c <#>]
+		[--ctrl-loss-tmo=<#>      | -l <#>]
 
 DESCRIPTION
 -----------
@@ -88,6 +89,10 @@ OPTIONS
 	Overrides the default delay (in seconds) before reconnect is attempted
 	after a connect loss.
 
+-l <#>::
+--ctrl-loss-tmo=<#>::
+	Overrides the default controller loss timeout period (in seconds).
+
 EXAMPLES
 --------
 * Connect to a subsystem named nqn.2014-08.com.example:nvme:nvm-subsystem-sn-d78432
-- 
2.16.2
