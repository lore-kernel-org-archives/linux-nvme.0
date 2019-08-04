From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sun,  4 Aug 2019 16:50:50 +0900
Subject: [PATCH 4/4] nvmet: trace: parse Get LBA Status command in detail
In-Reply-To: <20190804075050.14642-1-minwoo.im.dev@gmail.com>
References: <20190804075050.14642-1-minwoo.im.dev@gmail.com>
Message-ID: <20190804075050.14642-5-minwoo.im.dev@gmail.com>

Four different fields are in CDWs of Get LBA Status command which means
it would be great if we can see in detail when tracing in target side
also.

Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 drivers/nvme/target/trace.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/nvme/target/trace.c b/drivers/nvme/target/trace.c
index 6af11d493271..1373a3c67962 100644
--- a/drivers/nvme/target/trace.c
+++ b/drivers/nvme/target/trace.c
@@ -33,6 +33,22 @@ static const char *nvmet_trace_admin_get_features(struct trace_seq *p,
 	return ret;
 }
 
+static const char *nvmet_trace_get_lba_status(struct trace_seq *p,
+					     u8 *cdw10)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+	u64 slba = get_unaligned_le64(cdw10);
+	u32 mndw = get_unaligned_le32(cdw10 + 8);
+	u16 rl = get_unaligned_le16(cdw10 + 12);
+	u8 atype = cdw10[15];
+
+	trace_seq_printf(p, "slba=0x%llx, mndw=0x%x, rl=0x%x, atype=%u",
+			slba, mndw, rl, atype);
+	trace_seq_putc(p, 0);
+
+	return ret;
+}
+
 static const char *nvmet_trace_read_write(struct trace_seq *p, u8 *cdw10)
 {
 	const char *ret = trace_seq_buffer_ptr(p);
@@ -80,6 +96,8 @@ const char *nvmet_trace_parse_admin_cmd(struct trace_seq *p,
 		return nvmet_trace_admin_identify(p, cdw10);
 	case nvme_admin_get_features:
 		return nvmet_trace_admin_get_features(p, cdw10);
+	case nvme_admin_get_lba_status:
+		return nvmet_trace_get_lba_status(p, cdw10);
 	default:
 		return nvmet_trace_common(p, cdw10);
 	}
-- 
2.17.1
