From: ckulkarnilinux@gmail.com (chaitany kulkarni)
Date: Wed, 9 May 2018 20:59:39 -0700
Subject: [PATCH V3] nvmet: add simple file backed ns support
In-Reply-To: <5ed5899b-e0be-aa94-ea5f-6f8220bf38db@grimberg.me>
References: <20180508053829.406-1-chaitanya.kulkarni@wdc.com>
 <5ed5899b-e0be-aa94-ea5f-6f8220bf38db@grimberg.me>
Message-ID: <CAK0tqimM8W5DHfg=UbvHdTKCNsM3cqqqDZYMnLkVK=EC06Qv-A@mail.gmail.com>

Thanks for the comments Sagi, I'll update and send the patch, for
"call_[write|read]_iter()",
I removed it in this version since it was one of the review comment on V1.

Also for bvec_alloc() we have to maintain the mempool_t, can we not
add more members
when we can get away with kmalloc_array()?

Do you see any performance advantage/difference when using
bvec_alloc() vs kmalloc_array()?


On Wed, May 9, 2018@7:53 AM, Sagi Grimberg <sagi@grimberg.me> wrote:
> Chaitanya, this looks good. couple of comments below
>
>> This patch adds simple file backed namespace support for
>> NVMeOF target.
>>
>> In current implementation NVMeOF supports block
>> device backed namespaces on the target side.
>> With this implementation regular file(s) can be used to
>> initialize the namespace(s) via target side configfs
>> interface.
>>
>> For admin smart log command on the target side, we only use
>> block device backed namespaces to compute target
>> side smart log.
>>
>> We isolate the code for each ns handle type
>> (file/block device) and add wrapper routines to manipulate
>> the respective ns handle types.
>>
>> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
>
>
> ...
>
>> +static void nvmet_ns_dev_disable(struct nvmet_ns *ns)
>> +{
>> +       if (ns->bdev) {
>> +               blkdev_put(ns->bdev, FMODE_WRITE | FMODE_READ);
>> +               ns->bdev = NULL;
>> +       } else if (ns->file) {
>> +               fput(ns->file);
>> +               ns->file = NULL;
>> +       } else
>> +               pr_err("invalid ns handle\n");
>
>
> WARN_ON_ONCE()
>
>> @@ -513,6 +574,8 @@ bool nvmet_req_init(struct nvmet_req *req, struct
>> nvmet_cq *cq,
>>         req->transfer_len = 0;
>>         req->rsp->status = 0;
>>         req->ns = NULL;
>> +       req->bvec = NULL;
>> +       memset(&req->iocb, 0, sizeof(req->iocb));
>
>
> Can we clear this just for file IO?
>
>> +static void nvmet_execute_rw_file(struct nvmet_req *req)
>> +{
>> +       loff_t pos;
>> +       ssize_t len = 0, ret;
>> +       int bv_cnt = 0;
>> +       struct iov_iter iter;
>> +       struct sg_page_iter sg_pg_iter;
>> +       int rw = req->cmd->rw.opcode == nvme_cmd_write ? WRITE : READ;
>> +       u32 nr_bvec = DIV_ROUND_UP(req->data_len, PAGE_SIZE);
>
>
> Not a must, but some people (including me) prefer an upside-down christmas
> tree arrangement.
>
>> +
>> +       req->bvec = req->inline_bvec;
>> +       if (nr_bvec > NVMET_MAX_INLINE_BIOVEC) {
>> +               req->bvec = kmalloc_array(nr_bvec, sizeof(struct bio_vec),
>> +                               GFP_KERNEL);
>
>
> bvec_alloc()?
>
>
>> +               if (!req->bvec)
>> +                       goto out;
>> +       }
>> +
>> +       for_each_sg_page(req->sg, &sg_pg_iter, req->sg_cnt, 0) {
>> +               req->bvec[bv_cnt].bv_page =
>> sg_page_iter_page(&sg_pg_iter);
>> +               req->bvec[bv_cnt].bv_offset = sg_pg_iter.sg->offset;
>> +               req->bvec[bv_cnt].bv_len = PAGE_SIZE -
>> sg_pg_iter.sg->offset;
>> +               len += req->bvec[bv_cnt].bv_len;
>> +               bv_cnt++;
>> +       }
>> +
>> +       if (len != req->data_len)
>> +               goto free;
>> +
>> +       iov_iter_bvec(&iter, ITER_BVEC | rw, req->bvec, bv_cnt, len);
>> +       pos = le64_to_cpu(req->cmd->rw.slba) << req->ns->blksize_shift;
>> +       req->iocb.ki_pos = pos;
>> +       req->iocb.ki_filp = req->ns->file;
>> +       req->iocb.ki_flags = IOCB_DIRECT;
>> +       req->iocb.ki_complete = nvmet_file_io_complete;
>> +
>> +       if (req->cmd->rw.opcode == nvme_cmd_write) {
>> +               if (req->cmd->rw.control & cpu_to_le16(NVME_RW_FUA))
>> +                       req->iocb.ki_flags |= IOCB_DSYNC;
>> +               ret = req->ns->file->f_op->write_iter(&req->iocb, &iter);
>
>
> call_write_iter()?
>
>> +       } else
>> +               ret = req->ns->file->f_op->read_iter(&req->iocb, &iter);
>
>
> call_read_iter()?
>
>> +
>> +       if (ret != -EIOCBQUEUED)
>> +               nvmet_file_io_complete(&req->iocb, ret, 0);
>> +       return;
>> +free:
>> +       kfree(req->bvec);
>> +out:
>> +       nvmet_req_complete(req, NVME_SC_INTERNAL | NVME_SC_DNR);
>> +}
>> +
>>   static void nvmet_execute_flush(struct nvmet_req *req)
>>   {
>>         struct bio *bio = &req->inline_bio;
>> @@ -102,6 +166,23 @@ static void nvmet_execute_flush(struct nvmet_req
>> *req)
>>         submit_bio(bio);
>>   }
>>   +static void nvmet_flush_work_file(struct work_struct *work)
>> +{
>> +       int ret;
>> +       struct nvmet_req *req;
>> +
>> +       req = container_of(work, struct nvmet_req, flush_work);
>> +
>> +       ret = vfs_fsync(req->ns->file, 1);
>> +
>> +       nvmet_req_complete(req, ret);
>
>
> We need nvme status code here.
>
>
>> +}
>> +
>> +static void nvmet_execute_flush_file(struct nvmet_req *req)
>> +{
>> +       schedule_work(&req->flush_work);
>> +}
>> +
>>   static u16 nvmet_discard_range(struct nvmet_ns *ns,
>>                 struct nvme_dsm_range *range, struct bio **bio)
>>   {
>> @@ -163,6 +244,43 @@ static void nvmet_execute_dsm(struct nvmet_req *req)
>>         }
>>   }
>>   +static void nvmet_execute_discard_file(struct nvmet_req *req)
>> +{
>> +       struct nvme_dsm_range range;
>> +       int mode = FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE;
>> +       loff_t offset;
>> +       loff_t len;
>> +       int i, ret;
>> +
>> +       for (i = 0; i <= le32_to_cpu(req->cmd->dsm.nr); i++) {
>> +               if (nvmet_copy_from_sgl(req, i * sizeof(range), &range,
>> +                                       sizeof(range)))
>> +                       break;
>> +               offset = le64_to_cpu(range.slba) <<
>> req->ns->blksize_shift;
>> +               len = le32_to_cpu(range.nlb) << req->ns->blksize_shift;
>> +               ret = vfs_fallocate(req->ns->file, mode, offset, len);
>> +               if (ret)
>> +                       break;
>> +       }
>> +
>> +       nvmet_req_complete(req, ret < 0 ? NVME_SC_INTERNAL | NVME_SC_DNR :
>> 0);
>> +}
>> +
>> +static void nvmet_execute_dsm_file(struct nvmet_req *req)
>> +{
>> +       switch (le32_to_cpu(req->cmd->dsm.attributes)) {
>> +       case NVME_DSMGMT_AD:
>> +               nvmet_execute_discard_file(req);
>> +               return;
>> +       case NVME_DSMGMT_IDR:
>> +       case NVME_DSMGMT_IDW:
>> +       default:
>> +               /* Not supported yet */
>> +               nvmet_req_complete(req, 0);
>> +               return;
>> +       }
>> +}
>> +
>>   static void nvmet_execute_write_zeroes(struct nvmet_req *req)
>>   {
>>         struct nvme_write_zeroes_cmd *write_zeroes =
>> &req->cmd->write_zeroes;
>> @@ -189,6 +307,22 @@ static void nvmet_execute_write_zeroes(struct
>> nvmet_req *req)
>>         }
>>   }
>>   +static void nvmet_execute_write_zeroes_file(struct nvmet_req *req)
>> +{
>> +       struct nvme_write_zeroes_cmd *write_zeroes =
>> &req->cmd->write_zeroes;
>> +       loff_t offset;
>> +       loff_t len;
>> +       int mode = FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE;
>> +       int ret;
>> +
>> +       offset = le64_to_cpu(write_zeroes->slba) <<
>> req->ns->blksize_shift;
>> +       len = (((sector_t)le32_to_cpu(write_zeroes->length) + 1) <<
>> +                       req->ns->blksize_shift);
>> +
>> +       ret = vfs_fallocate(req->ns->file, mode, offset, len);
>> +       nvmet_req_complete(req, ret < 0 ? NVME_SC_INTERNAL | NVME_SC_DNR :
>> 0);
>> +}
>> +
>
>
> ALl the above should be async I think..
>
>
>>   u16 nvmet_parse_io_cmd(struct nvmet_req *req)
>>   {
>>         struct nvme_command *cmd = req->cmd;
>> @@ -207,20 +341,33 @@ u16 nvmet_parse_io_cmd(struct nvmet_req *req)
>>         switch (cmd->common.opcode) {
>>         case nvme_cmd_read:
>>         case nvme_cmd_write:
>> -               req->execute = nvmet_execute_rw;
>> +               if (req->ns->file)
>> +                       req->execute = nvmet_execute_rw_file;
>> +               else
>> +                       req->execute = nvmet_execute_rw;
>>                 req->data_len = nvmet_rw_len(req);
>>                 return 0;
>>         case nvme_cmd_flush:
>> -               req->execute = nvmet_execute_flush;
>> +               if (req->ns->file) {
>> +                       req->execute = nvmet_execute_flush_file;
>> +                       INIT_WORK(&req->flush_work,
>> nvmet_flush_work_file);
>> +               } else
>> +                       req->execute = nvmet_execute_flush;
>>                 req->data_len = 0;
>>                 return 0;
>>         case nvme_cmd_dsm:
>> -               req->execute = nvmet_execute_dsm;
>> +               if (req->ns->file)
>> +                       req->execute = nvmet_execute_dsm_file;
>> +               else
>> +                       req->execute = nvmet_execute_dsm;
>>                 req->data_len = (le32_to_cpu(cmd->dsm.nr) + 1) *
>>                         sizeof(struct nvme_dsm_range);
>>                 return 0;
>>         case nvme_cmd_write_zeroes:
>> -               req->execute = nvmet_execute_write_zeroes;
>> +               if (req->ns->file)
>> +                       req->execute = nvmet_execute_write_zeroes_file;
>> +               else
>> +                       req->execute = nvmet_execute_write_zeroes;
>>                 return 0;
>>         default:
>>                 pr_err("unhandled cmd %d on qid %d\n", cmd->common.opcode,
>
>
> I support separating parse too.
>
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
