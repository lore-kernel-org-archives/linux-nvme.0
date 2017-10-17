From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue, 17 Oct 2017 10:48:38 +0200
Subject: [PATCH nvme-cli] fabrics: also set queue_size and nr_io_queues on
 connect-all connects
Message-ID: <20171017084838.6827-1-jthumshirn@suse.de>

Although nvme connect-all -Q does set the queue_size parameter for the initial
discovery connection, it does not set it for the subsequent connections to the
discovered targets.

An
yields the following:

write(3, "nqn=nqn.2014-08.org.nvmexpress.d"..., 180) = 180
 | 00000  6e 71 6e 3d 6e 71 6e 2e  32 30 31 34 2d 30 38 2e  nqn=nqn.2014-08. |
 | 00010  6f 72 67 2e 6e 76 6d 65  78 70 72 65 73 73 2e 64  org.nvmexpress.d |
 | 00020  69 73 63 6f 76 65 72 79  2c 74 72 61 6e 73 70 6f  iscovery,transpo |
 | 00030  72 74 3d 72 64 6d 61 2c  74 72 61 64 64 72 3d 31  rt=rdma,traddr=1 |
 | 00040  2e 31 2e 31 2e 33 2c 74  72 73 76 63 69 64 3d 34  .1.1.3,trsvcid=4 |
 | 00050  34 32 30 2c 68 6f 73 74  6e 71 6e 3d 6e 71 6e 2e  420,hostnqn=nqn. |
 | 00060  32 30 31 34 2d 30 38 2e  6f 72 67 2e 6e 76 6d 65  2014-08.org.nvme |
 | 00070  78 70 72 65 73 73 3a 4e  56 4d 66 3a 75 75 69 64  xpress:NVMf:uuid |
 | 00080  3a 64 34 35 32 39 37 64  34 2d 38 38 62 31 2d 34  :d45297d4-88b1-4 |
 | 00090  34 65 63 2d 61 37 36 33  2d 61 61 30 37 32 39 35  4ec-a763-aa07295 |
 | 000a0  36 34 32 37 33 0a 2c 71  75 65 75 65 5f 73 69 7a  64273.,queue_siz |
 | 000b0  65 3d 36 34                                       e=64             |
write(3, "1", 1)                        = 1
 | 00000  31                                                1                |
write(3, "nqn=nvmf-test,hostnqn=nqn.2014-0"..., 139) = 139
 | 00000  6e 71 6e 3d 6e 76 6d 66  2d 74 65 73 74 2c 68 6f  nqn=nvmf-test,ho |
 | 00010  73 74 6e 71 6e 3d 6e 71  6e 2e 32 30 31 34 2d 30  stnqn=nqn.2014-0 |
 | 00020  38 2e 6f 72 67 2e 6e 76  6d 65 78 70 72 65 73 73  8.org.nvmexpress |
 | 00030  3a 4e 56 4d 66 3a 75 75  69 64 3a 64 34 35 32 39  :NVMf:uuid:d4529 |
 | 00040  37 64 34 2d 38 38 62 31  2d 34 34 65 63 2d 61 37  7d4-88b1-44ec-a7 |
 | 00050  36 33 2d 61 61 30 37 32  39 35 36 34 32 37 33 0a  63-aa0729564273. |
 | 00060  2c 74 72 61 6e 73 70 6f  72 74 3d 72 64 6d 61 2c  ,transport=rdma, |
 | 00070  74 72 61 64 64 72 3d 31  2e 31 2e 31 2e 33 2c 74  traddr=1.1.1.3,t |
 | 00080  72 73 76 63 69 64 3d 34  34 32 30                 rsvcid=4420      |
+++ exited with 0 +++

So set the size parameter requested needed as well and while we're add it also
propagate the nr_io_queues down.

Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
---
 fabrics.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fabrics.c b/fabrics.c
index 4871e1759ed0..5dec9f4fab17 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -633,6 +633,20 @@ static int connect_ctrl(struct nvmf_disc_rsp_page_entry *e)
 		p += len;
 	}
 
+	if (cfg.queue_size) {
+		len = sprintf(p, ",queue_size=%s", cfg.queue_size);
+		if (len < 0)
+			return -EINVAL;
+		p += len;
+	}
+
+	if (cfg.nr_io_queues) {
+		len = sprintf(p, ",nr_io_queues=%s", cfg.nr_io_queues);
+		if (len < 0)
+			return -EINVAL;
+		p += len;
+	}
+
 	switch (e->trtype) {
 	case NVMF_TRTYPE_LOOP: /* loop */
 		len = sprintf(p, ",transport=loop");
@@ -835,6 +849,7 @@ int discover(const char *desc, int argc, char **argv, bool connect)
 		{"hostnqn",     'q', "LIST", CFG_STRING, &cfg.hostnqn,     required_argument, "user-defined hostnqn (if default not used)" },
 		{"hostid",      'I', "LIST", CFG_STRING, &cfg.hostid,      required_argument, "user-defined hostid (if default not used)"},
 		{"queue-size",  'Q', "LIST", CFG_STRING, &cfg.queue_size,  required_argument, "number of io queue elements to use (default 128)" },
+		{"nr-io-queues",'i', "LIST", CFG_STRING, &cfg.nr_io_queues,required_argument, "number of io queues to use (default is core count)" },
 		{"raw",         'r', "LIST", CFG_STRING, &cfg.raw,         required_argument, "raw output file" },
 		{NULL},
 	};
-- 
2.13.6
