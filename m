From: james_p_freyensee@linux.intel.com (Jay Freyensee)
Date: Fri, 29 Jul 2016 13:38:39 -0700
Subject: [PATCH v2] nvme-cli: user-defined hostnqn option for discover
In-Reply-To: <1469824719-7378-1-git-send-email-james_p_freyensee@linux.intel.com>
References: <1469824719-7378-1-git-send-email-james_p_freyensee@linux.intel.com>
Message-ID: <1469824719-7378-2-git-send-email-james_p_freyensee@linux.intel.com>

The nvme-cli will always use the default hostnqn
in /dev/nvme-fabrics  for the discovery query, even though
both the NVMe Target and NVMe Host rdma implementations allow
user-defined hostnqn naming.

For example, this is the current, somewhat broken behavior if you
used your own hostnqn provision naming on the NVMe kernel target:

nvme discover /dev/nvme-fabrics  -t rdma --traddr=192.168.1.3 --trsvcid=4420

in dmesg:
[591910.025779] nvme nvme0: Connect Invalid Data Parameter, hostnqn "nqn.2014-08.org.nvmexpress:NVMf:uuid:a2d7752c-a31b-477a-a003-31a5e1c424a9"

New, fixed behavior introduced by this patch:

[root at fedora23-fabrics-host1 nvme-cli]# nvme discover  -t rdma --traddr=192.168.1.3 --trsvcid=4420 --hostnqn=host1-rogue-nqn

Discovery Log Number of Records 1, Generation counter 10
=====Discovery Log Entry 0======
trtype:  ipv4
adrfam:  rdma
nqntype: 2
treq:    0
portid:  1
trsvcid: 4420
subnqn:  nullside-nqn
traddr:  192.168.1.3
rdma_prtype: 0
rdma_qptype: 0
rdma_cms:    0
rdma_pkey: 0x0000
[root at fedora23-fabrics-host1 nvme-cli]#


Signed-off-by: Jay Freyensee <james_p_freyensee at linux.intel.com>
Signed-off-by: Roy Shterman <roysh at mellanox.com>
Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
---

changes since v1:
  tags, patch formatting, no functionality change

changes since v0:
  changed short 'h' option to 'q'

 fabrics.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fabrics.c b/fabrics.c
index 3666a01..41a80df 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -49,6 +49,7 @@ struct config {
 	char *transport;
 	char *traddr;
 	char *trsvcid;
+	char *hostnqn;
 	char *raw;
 	char *device;
 } cfg = { 0 };
@@ -395,6 +396,14 @@ static int build_options(char *argstr, int max_len)
 		max_len -= len;
 	}
 
+	if (cfg.hostnqn) {
+		len = snprintf(argstr, max_len, ",hostnqn=%s", cfg.hostnqn);
+		if (len < 0)
+			return -EINVAL;
+		argstr += len;
+		max_len -= len;
+	}
+
 	return 0;
 }
 
@@ -525,6 +534,8 @@ int discover(const char *desc, int argc, char **argv, bool connect)
 			"transport address" },
 		{"trsvcid", 's', "LIST", CFG_STRING, &cfg.trsvcid, required_argument,
 			"transport service id (e.g. IP port)" },
+		{"hostnqn", 'q', "LIST", CFG_STRING, &cfg.hostnqn, required_argument,
+			"user-defined hostnqn (if default not used)" },
 		{"raw", 'r', "LIST", CFG_STRING, &cfg.raw, required_argument,
 			"raw output file" },
 		{0},
-- 
2.4.3
