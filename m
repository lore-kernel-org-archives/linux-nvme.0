From: willy@linux.intel.com (Matthew Wilcox)
Date: Tue, 2 Apr 2013 11:05:06 -0400
Subject: [nvme:master 2/5] drivers/block/nvme-core.c:933:35: sparse:
 restricted __le16 degrades to integer
In-Reply-To: <20130331011820.GA9311@localhost>
References: <5156e3de.VW1Ru50htkFg0hP3%fengguang.wu@intel.com>
 <20130331011820.GA9311@localhost>
Message-ID: <20130402150506.GM4671@linux.intel.com>

On Sun, Mar 31, 2013@09:18:20AM +0800, Fengguang Wu wrote:
> Greetings,
> 
> FYI, here are some sparse warnings in
> 
> tree:   git://git.infradead.org/users/willy/linux-nvme master

Thanks, Fengguang!  I hadn't noticed these before because you need to
build with CF="-D__CHECK_ENDIAN__" on the command line.  There's some
real bugs here.

> >> drivers/block/nvme-core.c:933:35: sparse: restricted __le16 degrades to integer
> >> drivers/block/nvme-core.c:933:66: sparse: incorrect type in initializer (different base types)
>    drivers/block/nvme-core.c:933:66:    expected restricted __le16 [usertype] status
>    drivers/block/nvme-core.c:933:66:    got int

A real bug.  It only shows up on big-endian though, and I don't have
any big-endian machines with PCIe slots.

> >> drivers/block/nvme-core.c:1224:21: sparse: incorrect type in assignment (different base types)
>    drivers/block/nvme-core.c:1224:21:    expected restricted __le32 [addressable] [assigned] [usertype] dsmgmt
>    drivers/block/nvme-core.c:1224:21:    got restricted __le16 [usertype] <noident>

A real bug; I was converting dsmgmt as if it were a 16-bit type when
it's a 32-bit type.

> >> drivers/block/nvme-core.c:1225:21: sparse: incorrect type in assignment (different base types)
>    drivers/block/nvme-core.c:1225:21:    expected restricted __le32 [addressable] [assigned] [usertype] reftag
>    drivers/block/nvme-core.c:1225:21:    got unsigned int [unsigned] [addressable] [usertype] reftag
> >> drivers/block/nvme-core.c:1226:21: sparse: incorrect type in assignment (different base types)
>    drivers/block/nvme-core.c:1226:21:    expected restricted __le16 [addressable] [assigned] [usertype] apptag
>    drivers/block/nvme-core.c:1226:21:    got unsigned short [unsigned] [addressable] [usertype] apptag
> >> drivers/block/nvme-core.c:1227:22: sparse: incorrect type in assignment (different base types)
>    drivers/block/nvme-core.c:1227:22:    expected restricted __le16 [addressable] [assigned] [usertype] appmask
>    drivers/block/nvme-core.c:1227:22:    got unsigned short [unsigned] [addressable] [usertype] appmask

Just mismatched types.

> >> drivers/block/nvme-core.c:1266:26: sparse: incorrect type in assignment (different base types)
>    drivers/block/nvme-core.c:1266:26:    expected unsigned int [unsigned] <noident>
>    drivers/block/nvme-core.c:1266:26:    got restricted __le32 [usertype] <noident>
> >> drivers/block/nvme-core.c:1267:26: sparse: incorrect type in assignment (different base types)
>    drivers/block/nvme-core.c:1267:26:    expected unsigned int [unsigned] <noident>
>    drivers/block/nvme-core.c:1267:26:    got restricted __le32 [usertype] <noident>
> >> drivers/block/nvme-core.c:1268:27: sparse: incorrect type in assignment (different base types)
>    drivers/block/nvme-core.c:1268:27:    expected unsigned int [unsigned] <noident>
>    drivers/block/nvme-core.c:1268:27:    got restricted __le32 [usertype] <noident>
> >> drivers/block/nvme-core.c:1269:27: sparse: incorrect type in assignment (different base types)
>    drivers/block/nvme-core.c:1269:27:    expected unsigned int [unsigned] <noident>
>    drivers/block/nvme-core.c:1269:27:    got restricted __le32 [usertype] <noident>
> >> drivers/block/nvme-core.c:1270:27: sparse: incorrect type in assignment (different base types)
>    drivers/block/nvme-core.c:1270:27:    expected unsigned int [unsigned] <noident>
>    drivers/block/nvme-core.c:1270:27:    got restricted __le32 [usertype] <noident>
> >> drivers/block/nvme-core.c:1271:27: sparse: incorrect type in assignment (different base types)
>    drivers/block/nvme-core.c:1271:27:    expected unsigned int [unsigned] <noident>
>    drivers/block/nvme-core.c:1271:27:    got restricted __le32 [usertype] <noident>
> >> drivers/block/nvme-core.c:1272:27: sparse: incorrect type in assignment (different base types)
>    drivers/block/nvme-core.c:1272:27:    expected unsigned int [unsigned] <noident>
>    drivers/block/nvme-core.c:1272:27:    got restricted __le32 [usertype] <noident>
> >> drivers/block/nvme-core.c:1273:27: sparse: incorrect type in assignment (different base types)
>    drivers/block/nvme-core.c:1273:27:    expected unsigned int [unsigned] <noident>
>    drivers/block/nvme-core.c:1273:27:    got restricted __le32 [usertype] <noident>

Also mismatched types.  I'll commit the following fix:


diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index a89f7db..da72dea 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -875,7 +875,7 @@ static void nvme_cancel_ios(struct nvme_queue *nvmeq, bool timeout)
 		void *ctx;
 		nvme_completion_fn fn;
 		static struct nvme_completion cqe = {
-			.status = cpu_to_le16(NVME_SC_ABORT_REQ) << 1,
+			.status = cpu_to_le16(NVME_SC_ABORT_REQ << 1),
 		};
 
 		if (timeout && !time_after(now, info[cmdid].timeout))
@@ -1166,7 +1166,7 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 	c.rw.slba = cpu_to_le64(io.slba);
 	c.rw.length = cpu_to_le16(io.nblocks);
 	c.rw.control = cpu_to_le16(io.control);
-	c.rw.dsmgmt = cpu_to_le16(io.dsmgmt);
+	c.rw.dsmgmt = cpu_to_le32(io.dsmgmt);
 	c.rw.reftag = io.reftag;
 	c.rw.apptag = io.apptag;
 	c.rw.appmask = io.appmask;
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index aa57503..ae07e5d 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -207,11 +207,11 @@ struct nvme_common_command {
 	__u8			flags;
 	__u16			command_id;
 	__le32			nsid;
-	__u32			cdw2[2];
+	__le32			cdw2[2];
 	__le64			metadata;
 	__le64			prp1;
 	__le64			prp2;
-	__u32			cdw10[6];
+	__le32			cdw10[6];
 };
 
 struct nvme_rw_command {
@@ -227,9 +227,9 @@ struct nvme_rw_command {
 	__le16			length;
 	__le16			control;
 	__le32			dsmgmt;
-	__le32			reftag;
-	__le16			apptag;
-	__le16			appmask;
+	__u32			reftag;
+	__u16			apptag;
+	__u16			appmask;
 };
 
 enum {
