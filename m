From: hch@lst.de (Christoph Hellwig)
Date: Wed, 13 Mar 2019 18:54:54 +0100
Subject: [PATCH 01/17] nvme: add get-feature to admin cmds tracer
In-Reply-To: <20190313175510.20725-1-hch@lst.de>
References: <20190313175510.20725-1-hch@lst.de>
Message-ID: <20190313175510.20725-2-hch@lst.de>

From: Max Gurtovoy <maxg@mellanox.com>

This will print get-feature cmd in more informative way. For example,
run "nvme get-feature /dev/nvme0 -n 1 -f 0x9 -c 10" will trace:

 nvme-3907  [008] ....  1763.635054: nvme_setup_cmd: nvme0: qid=0, cmdid=6, nsid=1, flags=0x0, meta=0x0, cmd=(nvme_admin_get_features fid=0x9 sel=0x0 cdw11=0xa)
<idle>-0     [001] d.h.  1763.635112: nvme_sq: nvme0: qid=0, head=27, tail=27
<idle>-0     [008] ..s.  1763.635121: nvme_complete_rq: nvme0: qid=0, cmdid=6, res=10, retries=0, flags=0x2, status=0

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/trace.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/nvme/host/trace.c b/drivers/nvme/host/trace.c
index 58456de78bb2..5f24ea7a28eb 100644
--- a/drivers/nvme/host/trace.c
+++ b/drivers/nvme/host/trace.c
@@ -50,7 +50,19 @@ static const char *nvme_trace_admin_identify(struct trace_seq *p, u8 *cdw10)
 	return ret;
 }
 
+static const char *nvme_trace_admin_get_features(struct trace_seq *p,
+						 u8 *cdw10)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+	u8 fid = cdw10[0];
+	u8 sel = cdw10[1] & 0x7;
+	u32 cdw11 = get_unaligned_le32(cdw10 + 4);
+
+	trace_seq_printf(p, "fid=0x%x sel=0x%x cdw11=0x%x", fid, sel, cdw11);
+	trace_seq_putc(p, 0);
 
+	return ret;
+}
 
 static const char *nvme_trace_read_write(struct trace_seq *p, u8 *cdw10)
 {
@@ -101,6 +113,8 @@ const char *nvme_trace_parse_admin_cmd(struct trace_seq *p,
 		return nvme_trace_create_cq(p, cdw10);
 	case nvme_admin_identify:
 		return nvme_trace_admin_identify(p, cdw10);
+	case nvme_admin_get_features:
+		return nvme_trace_admin_get_features(p, cdw10);
 	default:
 		return nvme_trace_common(p, cdw10);
 	}
-- 
2.20.1
