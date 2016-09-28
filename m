From: james_p_freyensee@linux.intel.com (Jay Freyensee)
Date: Wed, 28 Sep 2016 16:49:43 -0700
Subject: [PATCH 3/4] nvme-cli: Add nvme-connect.txt shell for fill in
In-Reply-To: <1475106584-14961-1-git-send-email-james_p_freyensee@linux.intel.com>
References: <1475106584-14961-1-git-send-email-james_p_freyensee@linux.intel.com>
Message-ID: <1475106584-14961-4-git-send-email-james_p_freyensee@linux.intel.com>

nvme-discover documentation refers to nvme-connect,
so add a starter file for nvme-connect for fill
in by a generous soul :-).

Signed-off-by: Jay Freyensee <james_p_freyensee at linux.intel.com>
---
 Documentation/nvme-connect.txt | 89 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)
 create mode 100644 Documentation/nvme-connect.txt

diff --git a/Documentation/nvme-connect.txt b/Documentation/nvme-connect.txt
new file mode 100644
index 0000000..18338cb
--- /dev/null
+++ b/Documentation/nvme-connect.txt
@@ -0,0 +1,89 @@
+nvme-connect(1)
+==============
+
+NAME
+----
+nvme-connect - Connect to an NVMe-over-Fabrics subsystem.
+
+SYNOPSIS
+--------
+[verse]
+'nvme connect'	[device]
+		[--transport=<trtype>  | -t <trtype>]
+		[--traddr=<traddr>     | -a <traddr>]
+		[--trsvcid=<trsvcid>   | -s <trsvcid>]
+		[--hostnqn=<hostnqn>   | -q <hostnqn>]
+		[--nqn=<subnqn>        | -n <subnqn>]
+		[--nr-io-queues=<#>    | -i <#>]
+		[--keep-alive-tmo=<#>  | -k <#>]
+		[--reconnect-delay=<#> | -c <#>]
+
+DESCRIPTION
+-----------
+TBD (note 'device' is optional)
+
+BACKGROUND
+----------
+TBD
+
+OPTIONS
+-------
+-t <trtype>::
+--transport=<trtype>::
+	TBD
+
+-a <traddr>::
+--traddr=<traddr>::
+	TBD
+
+-s <trsvcid>::
+--trsvcid=<trsvcid>::
+	TBD
+ 
+-q <hostnqn>::
+--hostnqn=<hostnqn>::
+	TBD
+
+-n <subnqn>::
+--nqn=<subnqn>::
+	TBD
+
+-i <#>::
+--nr-io-queues<#>::
+	TBD
+
+-k <#>::
+--keep-alive-tmo=<#>::
+	TBD
+
+-c <#>::
+--reconnect-delay=<#>::
+	TBD
+
+EXAMPLES
+--------
+* TBD
++
+------------
+# nvme connect... 
+------------
+
+SEE ALSO
+--------
+nvme-discover(1)
+
+AUTHORS
+-------
+This was co-written by mailto:james.p.freyensee at intel.com[Jay Freyensee]
+and mailto:hch at lst.de[Christoph Hellwig]
+for mailto:keith.busch at intel.com[Keith Busch].
+
+REPORTING BUGS
+--------------
+Patches and issues for 'connect' should be submitted to the
+Linux kernel email list mailto:linux-nvme at lists.infradead.org[linux-nvme]
+before merging to https://github.com/linux-nvme/nvme-cli.
+
+NVME
+----
+Part of the nvme-user suite
-- 
2.7.4
