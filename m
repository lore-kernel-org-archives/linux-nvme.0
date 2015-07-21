From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Tue, 21 Jul 2015 02:02:58 -0400
Subject: [PATCH 4/5] block: Export integrity data interval size in sysfs
In-Reply-To: <1437458579-18706-1-git-send-email-martin.petersen@oracle.com>
References: <20150716091957.GA18310@infradead.org>
 <1437458579-18706-1-git-send-email-martin.petersen@oracle.com>
Message-ID: <1437458579-18706-5-git-send-email-martin.petersen@oracle.com>

The size of the data interval was not exported in the sysfs integrity
directory. Export it so that userland apps can tell whether the interval
is different from the device's logical block size.

Signed-off-by: Martin K. Petersen <martin.petersen at oracle.com>
---
 Documentation/ABI/testing/sysfs-block |  7 +++++++
 block/blk-integrity.c                 | 14 ++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-block b/Documentation/ABI/testing/sysfs-block
index 8df003963d99..a61f1e2165ee 100644
--- a/Documentation/ABI/testing/sysfs-block
+++ b/Documentation/ABI/testing/sysfs-block
@@ -60,6 +60,13 @@ Description:
 		Indicates whether a storage device is capable of storing
 		integrity metadata. Set if the device is T10 PI-capable.
 
+What:		/sys/block/<disk>/integrity/data_interval_bytes
+Date:		July 2015
+Contact:	Martin K. Petersen <martin.petersen at oracle.com>
+Description:
+		Describes the number of data bytes which are protected
+		by one integrity tuple. Typically the device's logical
+		block size.
 
 What:		/sys/block/<disk>/integrity/write_generate
 Date:		June 2008
diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index 70ba9389d0dd..16d5a15d632a 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -286,6 +286,14 @@ static ssize_t integrity_tag_size_show(struct blk_integrity *bi, char *page)
 		return sprintf(page, "0\n");
 }
 
+static ssize_t integrity_interval_show(struct blk_integrity *bi, char *page)
+{
+	if (bi != NULL)
+		return sprintf(page, "%u\n", 1 << bi->interval_exp);
+	else
+		return sprintf(page, "0\n");
+}
+
 static ssize_t integrity_verify_store(struct blk_integrity *bi,
 				      const char *page, size_t count)
 {
@@ -340,6 +348,11 @@ static struct integrity_sysfs_entry integrity_tag_size_entry = {
 	.show = integrity_tag_size_show,
 };
 
+static struct integrity_sysfs_entry integrity_interval_entry = {
+	.attr = { .name = "data_interval_bytes", .mode = S_IRUGO },
+	.show = integrity_interval_show,
+};
+
 static struct integrity_sysfs_entry integrity_verify_entry = {
 	.attr = { .name = "read_verify", .mode = S_IRUGO | S_IWUSR },
 	.show = integrity_verify_show,
@@ -360,6 +373,7 @@ static struct integrity_sysfs_entry integrity_device_entry = {
 static struct attribute *integrity_attrs[] = {
 	&integrity_format_entry.attr,
 	&integrity_tag_size_entry.attr,
+	&integrity_interval_entry.attr,
 	&integrity_verify_entry.attr,
 	&integrity_generate_entry.attr,
 	&integrity_device_entry.attr,
-- 
2.4.3
