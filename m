From: vthakkar1994@gmail.com (Vaishali Thakkar)
Date: Tue, 23 Dec 2014 17:52:47 +0530
Subject: [PATCH] Drivers: block: Introduce use of put_unaligned_be64
Message-ID: <20141223122247.GA3122@vaishali-Ideapad-Z570>

This patch introduces the use of function put_unaligned_be64.

This is done using Coccinelle and semantic patch used for this is
as follows:

// <smpl>
@sizeb64@
typedef u64, __be64, uint64_t;
{u64,__be64,uint64_t} e64;
position p,p64;
expression len,e;
@@

len = \(8\|sizeof(u64)\|sizeof(__be64)\|sizeof(uint64_t)\|sizeof(e64)\)
... when != len = e
memcpy at p64(...,len)

@othersizeb64 exists@
position p != sizeb64.p,pbad;
expression len,e,e1;
@@

len at p = e1
... when != len = e
memcpy at pbad(...,len)

@o@
identifier tmp;
expression ptr;
expression y,e;
{u64,__be64,uint64_t} e64;
type T;
position p,sizeb64.p64,p1 != othersizeb64.pbad;
@@

- tmp = cpu_to_be64(y);

  <+... when != tmp
(
- memcpy(ptr, (T)&tmp, \(8\|sizeof(u64)\|sizeof(__be64)\|sizeof(uint64_t)\|sizeof(e64)\));
+ put_unaligned_be64(y,ptr);
|
- memcpy at p64@p1(ptr, (T)&tmp, ...);
+ put_unaligned_be64(y,ptr);
|
- memcpy at p(ptr, (T)&tmp, ...);
+ put_unaligned_be64(y,ptr);
)
  ...+>
? tmp = e

@script:python@
p << o.p;
@@

print "dangerous second argument in %s:%s" % (p[0].file,p[0].line)

@@ type T; identifier o.tmp; @@

- T tmp;
...when != tmp
//</smpl>

Signed-off-by: Vaishali Thakkar <vthakkar1994 at gmail.com>
---
 drivers/block/nvme-scsi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/block/nvme-scsi.c b/drivers/block/nvme-scsi.c
index a4cd6d6..94abb8a 100644
--- a/drivers/block/nvme-scsi.c
+++ b/drivers/block/nvme-scsi.c
@@ -43,7 +43,7 @@
 #include <linux/types.h>
 #include <scsi/sg.h>
 #include <scsi/scsi.h>
-
+#include <linux/unaligned/access_ok.h>
 
 static int sg_version_num = 30534;	/* 2 digits for each component */
 
@@ -1417,7 +1417,6 @@ static void nvme_trans_fill_read_cap(u8 *response, struct nvme_id_ns *id_ns,
 	u64 rlba;
 	u8 prot_en;
 	u8 p_type_lut[4] = {0, 0, 1, 2};
-	__be64 tmp_rlba;
 	__be32 tmp_rlba_32;
 	__be32 tmp_len;
 
@@ -1434,9 +1433,8 @@ static void nvme_trans_fill_read_cap(u8 *response, struct nvme_id_ns *id_ns,
 		memcpy(response, &tmp_rlba_32, sizeof(u32));
 		memcpy(&response[4], &tmp_len, sizeof(u32));
 	} else {
-		tmp_rlba = cpu_to_be64(rlba);
 		tmp_len = cpu_to_be32(lba_length);
-		memcpy(response, &tmp_rlba, sizeof(u64));
+		put_unaligned_be64(rlba, response);
 		memcpy(&response[8], &tmp_len, sizeof(u32));
 		response[12] = (p_type_lut[id_ns->dps & 0x3] << 1) | prot_en;
 		/* P_I_Exponent = 0x0 | LBPPBE = 0x0 */
-- 
1.9.1
