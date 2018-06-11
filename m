From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Mon, 11 Jun 2018 20:12:01 +0000
Subject: [PATCH V2] nvmet: allow file backed ns to use cache
In-Reply-To: <BN6PR04MB12037F7CBB662391A352B0CD867B0@BN6PR04MB1203.namprd04.prod.outlook.com>
References: <20180531140700.13708-1-chaitanya.kulkarni@wdc.com>,
 <20180606122939.GA13398@lst.de>,
 <BN6PR04MB12037F7CBB662391A352B0CD867B0@BN6PR04MB1203.namprd04.prod.outlook.com>
Message-ID: <BN6PR04MB1203A2CAD12C4635D60ACD6986780@BN6PR04MB1203.namprd04.prod.outlook.com>

Christoph, ping?



From: Chaitanya Kulkarni
Sent: Thursday, June 7, 2018 6:47 PM
To: Christoph Hellwig
Cc: linux-nvme at lists.infradead.org; keith.busch at intel.com; sagi at grimberg.me
Subject: Re: [PATCH V2] nvmet: allow file backed ns to use cache
?  

Hi Christoph,

Thanks for the comments. I think we can get rid of the ns enable/disable and make the mode switch more transparent.

What do you think of the following patch?

I was able to run the fio in the background and switch the mode biffered_io <-> direct_io transparently.
Also, I could see the performance difference consistently between mode switch on nvme_loop.




diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index d3f3b3ec4d1a..a3ee3f137b8c 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -407,11 +407,36 @@ static ssize_t nvmet_ns_enable_store(struct config_item *item,
?
?CONFIGFS_ATTR(nvmet_ns_, enable);
?
+static ssize_t nvmet_ns_buffered_io_show(struct config_item *item, char *page)
+{
+ return sprintf(page, "%d\n",
+ atomic_read(&to_nvmet_ns(item)->buffered_io));
+}
+
+static ssize_t nvmet_ns_buffered_io_store(struct config_item *item,
+ const char *page, size_t count)
+{
+ struct nvmet_ns *ns = to_nvmet_ns(item);
+ bool buffered_io;
+ int ret = 0;
+
+ if (strtobool(page, &buffered_io))
+ return -EINVAL;
+
+ if (ns->file)
+ atomic_set(&ns->buffered_io, buffered_io == true ? 1 : 0);
+
+ return ret ? ret : count;
+}
+
+CONFIGFS_ATTR(nvmet_ns_, buffered_io);
+
?static struct configfs_attribute *nvmet_ns_attrs[] = {
? &nvmet_ns_attr_device_path,
? &nvmet_ns_attr_device_nguid,
? &nvmet_ns_attr_device_uuid,
? &nvmet_ns_attr_enable,
+ &nvmet_ns_attr_buffered_io,
? NULL,
?};
?
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index a03da764ecae..22f36b32ff2e 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -437,6 +437,7 @@ struct nvmet_ns *nvmet_ns_alloc(struct nvmet_subsys *subsys, u32 nsid)
? ns->nsid = nsid;
? ns->subsys = subsys;
? uuid_gen(&ns->uuid);
+ atomic_set(&ns->buffered_io, 0);
?
? return ns;
?}
diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 8c42b3a8c420..2cbb3a21bbb9 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -13,13 +13,26 @@
?#define NVMET_MAX_MPOOL_BVEC 16
?#define NVMET_MIN_MPOOL_OBJ 16
?
+static inline struct file *nvmet_file_get_handle(struct nvmet_req *req)
+{
+ if (atomic_read(&req->ns->buffered_io) == 1)
+ return req->ns->file_cache;
+
+ return req->ns->file;
+}
+
?void nvmet_file_ns_disable(struct nvmet_ns *ns)
?{
? if (ns->file) {
+ flush_workqueue(ns->file_wq);
+ destroy_workqueue(ns->file_wq);
+ ns->file_wq = NULL;
? mempool_destroy(ns->bvec_pool);
? ns->bvec_pool = NULL;
? kmem_cache_destroy(ns->bvec_cache);
? ns->bvec_cache = NULL;
+ fput(ns->file_cache);
+ ns->file_cache = NULL;
? fput(ns->file);
? ns->file = NULL;
? }
@@ -27,17 +40,25 @@ void nvmet_file_ns_disable(struct nvmet_ns *ns)
?
?int nvmet_file_ns_enable(struct nvmet_ns *ns)
?{
- int ret;
+ int flags = O_RDWR | O_LARGEFILE;
? struct kstat stat;
+ int ret;
?
- ns->file = filp_open(ns->device_path,
- O_RDWR | O_LARGEFILE | O_DIRECT, 0);
+ ns->file = filp_open(ns->device_path, flags | O_DIRECT, 0);
? if (IS_ERR(ns->file)) {
? pr_err("failed to open file %s: (%ld)\n",
? ns->device_path, PTR_ERR(ns->file));
? return PTR_ERR(ns->file);
? }
?
+ ns->file_cache = filp_open(ns->device_path, flags, 0);
+ if (IS_ERR(ns->file_cache)) {
+ pr_err("failed to open file handle caching %s: (%ld)\n",
+ ns->device_path, PTR_ERR(ns->file_cache));
+ fput(ns->file);
+ return PTR_ERR(ns->file_cache);
+ }
+
? ret = vfs_getattr(&ns->file->f_path,
? &stat, STATX_SIZE, AT_STATX_FORCE_SYNC);
? if (ret)
@@ -62,6 +83,13 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
? goto err;
? }
?
+ ns->file_wq = alloc_workqueue("nvmet-file",
+ WQ_UNBOUND_MAX_ACTIVE | WQ_MEM_RECLAIM, 0);
+ if (!ns->file_wq) {
+ ret = -ENOMEM;
+ goto err;
+ }
+
? return ret;
?err:
? ns->size = 0;
@@ -98,9 +126,10 @@ static ssize_t nvmet_file_submit_bvec(struct nvmet_req *req, loff_t pos,
?
? iov_iter_bvec(&iter, ITER_BVEC | rw, req->f.bvec, nr_segs, count);
?
+ ki_flags |= atomic_read(&req->ns->buffered_io) == 1 ? 0 : IOCB_DIRECT;
? iocb->ki_pos = pos;
- iocb->ki_filp = req->ns->file;
- iocb->ki_flags = IOCB_DIRECT | ki_flags;
+ iocb->ki_filp = nvmet_file_get_handle(req);
+ iocb->ki_flags = ki_flags;
?
? ret = call_iter(iocb, &iter);
?
@@ -189,12 +218,26 @@ static void nvmet_file_execute_rw(struct nvmet_req *req)
? nvmet_file_submit_bvec(req, pos, bv_cnt, total_len);
?}
?
+static void nvmet_file_buffered_io_work(struct work_struct *w)
+{
+ struct nvmet_req *req = container_of(w, struct nvmet_req, f.work);
+
+ nvmet_file_execute_rw(req);
+}
+
+static void nvmet_file_execute_rw_buffered_io(struct nvmet_req *req)
+{
+ INIT_WORK(&req->f.work, nvmet_file_buffered_io_work);
+ queue_work(req->ns->file_wq, &req->f.work);
+}
+
?static void nvmet_file_flush_work(struct work_struct *w)
?{
? struct nvmet_req *req = container_of(w, struct nvmet_req, f.work);
+ struct file *f = nvmet_file_get_handle(req);
? int ret;
?
- ret = vfs_fsync(req->ns->file, 1);
+ ret = vfs_fsync(f, 1);
?
? nvmet_req_complete(req, ret < 0 ? NVME_SC_INTERNAL | NVME_SC_DNR : 0);
?}
@@ -207,6 +250,7 @@ static void nvmet_file_execute_flush(struct nvmet_req *req)
?
?static void nvmet_file_execute_discard(struct nvmet_req *req)
?{
+ struct file *f = nvmet_file_get_handle(req);
? int mode = FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE;
? struct nvme_dsm_range range;
? loff_t offset;
@@ -219,7 +263,7 @@ static void nvmet_file_execute_discard(struct nvmet_req *req)
? break;
? offset = le64_to_cpu(range.slba) << req->ns->blksize_shift;
? len = le32_to_cpu(range.nlb) << req->ns->blksize_shift;
- ret = vfs_fallocate(req->ns->file, mode, offset, len);
+ ret = vfs_fallocate(f, mode, offset, len);
? if (ret)
? break;
? }
@@ -255,6 +299,7 @@ static void nvmet_file_write_zeroes_work(struct work_struct *w)
? struct nvmet_req *req = container_of(w, struct nvmet_req, f.work);
? struct nvme_write_zeroes_cmd *write_zeroes = &req->cmd->write_zeroes;
? int mode = FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE;
+ struct file *f = nvmet_file_get_handle(req);
? loff_t offset;
? loff_t len;
? int ret;
@@ -263,7 +308,7 @@ static void nvmet_file_write_zeroes_work(struct work_struct *w)
? len = (((sector_t)le16_to_cpu(write_zeroes->length) + 1) <<
? req->ns->blksize_shift);
?
- ret = vfs_fallocate(req->ns->file, mode, offset, len);
+ ret = vfs_fallocate(f, mode, offset, len);
? nvmet_req_complete(req, ret < 0 ? NVME_SC_INTERNAL | NVME_SC_DNR : 0);
?}
?
@@ -280,7 +325,10 @@ u16 nvmet_file_parse_io_cmd(struct nvmet_req *req)
? switch (cmd->common.opcode) {
? case nvme_cmd_read:
? case nvme_cmd_write:
- req->execute = nvmet_file_execute_rw;
+ if (atomic_read(&req->ns->buffered_io) == 0)
+ req->execute = nvmet_file_execute_rw;
+ else
+ req->execute = nvmet_file_execute_rw_buffered_io;
? req->data_len = nvmet_rw_len(req);
? return 0;
? case nvme_cmd_flush:
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 480dfe10fad9..7b5ea2e5512c 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -59,12 +59,15 @@ struct nvmet_ns {
? struct percpu_ref ref;
? struct block_device *bdev;
? struct file *file;
+ struct file *file_cache;
? u32  nsid;
? u32  blksize_shift;
? loff_t  size;
? u8  nguid[16];
? uuid_t  uuid;
?
+ atomic_t buffered_io;
+ struct workqueue_struct *file_wq;
? bool  enabled;
? struct nvmet_subsys *subsys;
? const char *device_path;
--?
2.14.1



  
From: Christoph Hellwig <hch@lst.de>
Sent: Wednesday, June 6, 2018 5:29:39 AM
To: Chaitanya Kulkarni
Cc: linux-nvme at lists.infradead.org; hch at lst.de; keith.busch at intel.com; sagi at grimberg.me
Subject: Re: [PATCH V2] nvmet: allow file backed ns to use cache
? 
 
> +???? if (ns->file && ns->buffered_io != buffered_io) {
> +???????????? nvmet_ns_disable(ns);
> +???????????? ns->buffered_io = buffered_io;
> +???????????? ret = nvmet_ns_enable(ns);
> +???? }

This section should be under subsys->lock to protect against
concurrent modification.? For which we'd need to move the locking
out of nvmet_ns_disable/nvmet_ns_enable into the existing callers,
which should probably be a prep patch for this one.


> -???? int ret;
> +???? int flags = O_RDWR | O_LARGEFILE | ns->buffered_io ? 0 : O_DIRECT;
>??????? struct kstat stat;
> +???? int ret;

Cosmetic, but I'd prefer:

??????? int flags = O_RDWR | O_LARGEFILE;

??????? if (!ns->buffered_io)
??????????????? flags |= O_DIRECT;

>? 
> -???? ns->file = filp_open(ns->device_path,
> -???????????????????? O_RDWR | O_LARGEFILE | O_DIRECT, 0);
> +???? ns->file = filp_open(ns->device_path, flags, 0);


> @@ -97,6 +111,7 @@ static ssize_t nvmet_file_submit_bvec(struct nvmet_req *req, loff_t pos,
>??????? iocb->ki_pos = pos;
>??????? iocb->ki_filp = req->ns->file;
>??????? iocb->ki_flags = IOCB_DIRECT | ki_flags;
> +???? iocb->ki_flags = ki_flags | req->ns->buffered_io ? 0 : IOCB_DIRECT;

I'd rather use iocb_flags() here, e.g.

??????? iocb->ki_flags = ki_flags | iocb_flags(ns->file);

>? static void nvmet_file_execute_flush(struct nvmet_req *req)
>? {
> +???? if (req->ns->buffered_io)
> +???????????? flush_workqueue(req->ns->file_wq);

No needed.? NVMe Flush doesn't affect in-flight commands.? Quote from
the spec:

? The flush applies to all commands completed prior to the submission of the
? Flush command. The controller may also flush additional data and/or
? metadata from any namespace.

Otherwise this looks fine.
     
