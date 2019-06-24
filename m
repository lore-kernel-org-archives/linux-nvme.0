From: bvanassche@acm.org (Bart Van Assche)
Date: Mon, 24 Jun 2019 13:05:20 -0700
Subject: [PATCH nvme-cli 2/3] nvme-cli: Restore RHEL 7 compatibility
In-Reply-To: <20190624200521.28191-1-bvanassche@acm.org>
References: <20190624200521.28191-1-bvanassche@acm.org>
Message-ID: <20190624200521.28191-3-bvanassche@acm.org>

With glibc version 2.24 and before the endianness conversion macros
return a value with an incorrect type. Avoid that this causes the
nvme-cli build to fail on e.g. RHEL 7. A side effect of this patch
is that it allows sparse to verify the type of the endianness
conversion functions.

See also https://sourceware.org/bugzilla/show_bug.cgi?id=16458

Cc: Mikhail Skorzhinskii <mskorzhinskiy at solarflare.com>
Cc: Minwoo Im <minwoo.im.dev at gmail.com>
Reported-by: Mikhail Skorzhinskii <mskorzhinskiy at solarflare.com>
Fixes: e68409e447b2 ("Remove superfluous casts")
Signed-off-by: Bart Van Assche <bvanassche at acm.org>
---
 nvme.h | 38 +++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/nvme.h b/nvme.h
index a149005a0425..f059db864128 100644
--- a/nvme.h
+++ b/nvme.h
@@ -119,19 +119,31 @@ struct nvme_bar_cap {
 #define __force
 #endif
 
-#define cpu_to_le16(x) \
-	((__force __le16)htole16(x))
-#define cpu_to_le32(x) \
-	((__force __le32)htole32(x))
-#define cpu_to_le64(x) \
-	((__force __le64)htole64(x))
-
-#define le16_to_cpu(x) \
-	le16toh((__force __u16)(x))
-#define le32_to_cpu(x) \
-	le32toh((__force __u32)(x))
-#define le64_to_cpu(x) \
-	le64toh((__force __u64)(x))
+static inline __le16 cpu_to_le16(uint16_t x)
+{
+	return (__force __le16)htole16(x);
+}
+static inline __le32 cpu_to_le32(uint32_t x)
+{
+	return (__force __le32)htole32(x);
+}
+static inline __le64 cpu_to_le64(uint64_t x)
+{
+	return (__force __le64)htole64(x);
+}
+
+static inline uint16_t le16_to_cpu(__le16 x)
+{
+	return le16toh((__force __u16)x);
+}
+static inline uint32_t le32_to_cpu(__le32 x)
+{
+	return le32toh((__force __u32)x);
+}
+static inline uint64_t le64_to_cpu(__le64 x)
+{
+	return le64toh((__force __u64)x);
+}
 
 #define MAX_LIST_ITEMS 256
 struct list_item {
-- 
2.22.0.410.gd8fdbe21b5-goog
