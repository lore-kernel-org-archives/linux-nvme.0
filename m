From: jim.epost@gmail.com (Jim Davis)
Date: Mon, 12 Oct 2015 10:19:29 -0700
Subject: randconfig build error with next-20151012, in drivers/nvme/host/pci.c
Message-ID: <CA+r1Zhi0VpZdiqW3VWEBmNf891VwZjFqTgBgOvreCOxWLELFWg@mail.gmail.com>

Building with the attached random configuration file,

In file included from drivers/nvme/host/pci.c:17:0:
include/linux/blk-mq.h:61:18: error: field ?kobj? has incomplete type
  struct kobject  kobj;
                  ^
include/linux/blk-mq.h:117:2: error: unknown type name ?softirq_done_fn?
  softirq_done_fn  *complete;
  ^
include/linux/blk-mq.h:170:33: warning: ?struct gendisk? declared
inside parameter list
 int blk_mq_register_disk(struct gendisk *);
                                 ^
include/linux/blk-mq.h:170:33: warning: its scope is only this
definition or declaration, which is probably not what you want
include/linux/blk-mq.h:171:36: warning: ?struct gendisk? declared
inside parameter list
 void blk_mq_unregister_disk(struct gendisk *);
                                    ^
include/linux/blk-mq.h: In function ?blk_mq_rq_from_pdu?:
include/linux/blk-mq.h:238:22: error: invalid application of ?sizeof?
to incomplete type ?struct request?
  return pdu - sizeof(struct request);
                      ^
include/linux/blk-mq.h: In function ?blk_mq_rq_to_pdu?:
include/linux/blk-mq.h:242:2: error: invalid use of undefined type
?struct request?
  return rq + 1;
  ^
drivers/nvme/host/pci.c: In function ?nvme_alloc_iod?:
drivers/nvme/host/pci.c:446:22: error: dereferencing pointer to incomplete type
  unsigned size = !(rq->cmd_flags & REQ_DISCARD) ? blk_rq_bytes(rq) :
                      ^
drivers/nvme/host/pci.c:446:2: error: implicit declaration of function
?blk_rq_bytes? [-Werror=implicit-function-declaration]
  unsigned size = !(rq->cmd_flags & REQ_DISCARD) ? blk_rq_bytes(rq) :
  ^
drivers/nvme/host/pci.c:450:8: error: dereferencing pointer to incomplete type
  if (rq->nr_phys_segments <= NVME_INT_PAGES &&
        ^
  LD      drivers/net/can/usb/built-in.o
drivers/nvme/host/pci.c:455:25: error: dereferencing pointer to incomplete type
   iod_init(iod, size, rq->nr_phys_segments,
                         ^
drivers/nvme/host/pci.c:460:28: error: dereferencing pointer to incomplete type
  return __nvme_alloc_iod(rq->nr_phys_segments, size, dev,
                            ^
drivers/nvme/host/pci.c: In function ?req_completion?:
drivers/nvme/host/pci.c:613:3: error: implicit declaration of function
?blk_noretry_request? [-Werror=implicit-function-declaration]
   if (!(status & NVME_SC_DNR || blk_noretry_request(req))
   ^
drivers/nvme/host/pci.c:614:24: error: dereferencing pointer to incomplete type
       && (jiffies - req->start_time) < req->timeout) {
                        ^
drivers/nvme/host/pci.c:614:43: error: dereferencing pointer to incomplete type
       && (jiffies - req->start_time) < req->timeout) {
                                           ^
In file included from include/linux/seqlock.h:35:0,
                 from include/linux/time.h:5,
                 from include/uapi/linux/timex.h:56,
                 from include/linux/timex.h:56,
                 from include/linux/sched.h:19,
                 from include/linux/blkdev.h:4,
                 from drivers/nvme/host/pci.c:16:
drivers/nvme/host/pci.c:618:25: error: dereferencing pointer to incomplete type
    spin_lock_irqsave(req->q->queue_lock, flags);
                         ^
include/linux/spinlock.h:208:34: note: in definition of macro
?raw_spin_lock_irqsave?
   flags = _raw_spin_lock_irqsave(lock); \
                                  ^
drivers/nvme/host/pci.c:618:4: note: in expansion of macro ?spin_lock_irqsave?
    spin_lock_irqsave(req->q->queue_lock, flags);
    ^
drivers/nvme/host/pci.c:619:4: error: implicit declaration of function
?blk_queue_stopped? [-Werror=implicit-function-declaration]
    if (!blk_queue_stopped(req->q))
    ^
drivers/nvme/host/pci.c:619:30: error: dereferencing pointer to incomplete type
    if (!blk_queue_stopped(req->q))
                              ^
drivers/nvme/host/pci.c:620:33: error: dereferencing pointer to incomplete type
     blk_mq_kick_requeue_list(req->q);
                                 ^
drivers/nvme/host/pci.c:621:30: error: dereferencing pointer to incomplete type
    spin_unlock_irqrestore(req->q->queue_lock, flags);
                              ^
drivers/nvme/host/pci.c:625:10: error: dereferencing pointer to incomplete type
   if (req->cmd_type == REQ_TYPE_DRV_PRIV) {
          ^
drivers/nvme/host/pci.c:625:24: error: ?REQ_TYPE_DRV_PRIV? undeclared
(first use in this function)
   if (req->cmd_type == REQ_TYPE_DRV_PRIV) {
                        ^
drivers/nvme/host/pci.c:625:24: note: each undeclared identifier is
reported only once for each function it appears in
drivers/nvme/host/pci.c:633:9: error: dereferencing pointer to incomplete type
  if (req->cmd_type == REQ_TYPE_DRV_PRIV) {
         ^
drivers/nvme/host/pci.c:635:6: error: dereferencing pointer to incomplete type
   req->special = (void *)(uintptr_t)result;
      ^
drivers/nvme/host/pci.c:644:3: error: implicit declaration of function
?rq_data_dir? [-Werror=implicit-function-declaration]
   dma_unmap_sg(nvmeq->dev->dev, iod->sg, iod->nents,
   ^
drivers/nvme/host/pci.c:646:3: error: implicit declaration of function
?blk_integrity_rq? [-Werror=implicit-function-declaration]
   if (blk_integrity_rq(req)) {
   ^
drivers/nvme/host/pci.c: In function ?nvme_submit_priv?:
drivers/nvme/host/pci.c:743:19: error: dereferencing pointer to incomplete type
  memcpy(&cmnd, req->cmd, sizeof(cmnd));
                   ^
drivers/nvme/host/pci.c:744:26: error: dereferencing pointer to incomplete type
  cmnd.rw.command_id = req->tag;
                          ^
drivers/nvme/host/pci.c:745:9: error: dereferencing pointer to incomplete type
  if (req->nr_phys_segments) {
         ^
drivers/nvme/host/pci.c: In function ?nvme_submit_discard?:
drivers/nvme/host/pci.c:767:2: error: implicit declaration of function
?blk_rq_pos? [-Werror=implicit-function-declaration]
  range->slba = cpu_to_le64(nvme_block_nr(ns, blk_rq_pos(req)));
  ^
drivers/nvme/host/pci.c:771:27: error: dereferencing pointer to incomplete type
  cmnd.dsm.command_id = req->tag;
                           ^
drivers/nvme/host/pci.c: In function ?nvme_submit_iod?:
drivers/nvme/host/pci.c:801:9: error: dereferencing pointer to incomplete type
  if (req->cmd_flags & REQ_FUA)
         ^
drivers/nvme/host/pci.c:803:9: error: dereferencing pointer to incomplete type
  if (req->cmd_flags & (REQ_FAILFAST_DEV | REQ_RAHEAD))
         ^
drivers/nvme/host/pci.c:806:9: error: dereferencing pointer to incomplete type
  if (req->cmd_flags & REQ_RAHEAD)
         ^
drivers/nvme/host/pci.c:811:26: error: dereferencing pointer to incomplete type
  cmnd.rw.command_id = req->tag;
                          ^
drivers/nvme/host/pci.c: In function ?nvme_queue_rq?:
drivers/nvme/host/pci.c:852:34: error: dereferencing pointer to incomplete type
  struct nvme_ns *ns = hctx->queue->queuedata;
                                  ^
drivers/nvme/host/pci.c:867:9: error: dereferencing pointer to incomplete type
      req->cmd_type != REQ_TYPE_DRV_PRIV) {
         ^
drivers/nvme/host/pci.c:867:23: error: ?REQ_TYPE_DRV_PRIV? undeclared
(first use in this function)
      req->cmd_type != REQ_TYPE_DRV_PRIV) {
                       ^
drivers/nvme/host/pci.c:877:9: error: dereferencing pointer to incomplete type
  if (req->cmd_flags & REQ_DISCARD) {
         ^
drivers/nvme/host/pci.c:890:16: error: dereferencing pointer to incomplete type
  } else if (req->nr_phys_segments) {
                ^
drivers/nvme/host/pci.c:893:29: error: dereferencing pointer to incomplete type
   sg_init_table(iod->sg, req->nr_phys_segments);
                             ^
drivers/nvme/host/pci.c:894:3: error: implicit declaration of function
?blk_rq_map_sg? [-Werror=implicit-function-declaration]
   iod->nents = blk_rq_map_sg(req->q, req, iod->sg);
   ^
drivers/nvme/host/pci.c:894:33: error: dereferencing pointer to incomplete type
   iod->nents = blk_rq_map_sg(req->q, req, iod->sg);
                                 ^
drivers/nvme/host/pci.c:907:4: error: implicit declaration of function
?blk_rq_count_integrity_sg? [-Werror=implicit-function-declaration]
    if (blk_rq_count_integrity_sg(req->q, req->bio) != 1)
    ^
drivers/nvme/host/pci.c:907:37: error: dereferencing pointer to incomplete type
    if (blk_rq_count_integrity_sg(req->q, req->bio) != 1)
                                     ^
drivers/nvme/host/pci.c:907:45: error: dereferencing pointer to incomplete type
    if (blk_rq_count_integrity_sg(req->q, req->bio) != 1)
                                             ^
drivers/nvme/host/pci.c:911:4: error: implicit declaration of function
?blk_rq_map_integrity_sg? [-Werror=implicit-function-declaration]
    if (blk_rq_map_integrity_sg(
    ^
drivers/nvme/host/pci.c:912:9: error: dereferencing pointer to incomplete type
      req->q, req->bio, iod->meta_sg) != 1)
         ^
drivers/nvme/host/pci.c:912:17: error: dereferencing pointer to incomplete type
      req->q, req->bio, iod->meta_sg) != 1)
                 ^
drivers/nvme/host/pci.c:925:9: error: dereferencing pointer to incomplete type
  if (req->cmd_type == REQ_TYPE_DRV_PRIV)
         ^
drivers/nvme/host/pci.c:927:14: error: dereferencing pointer to incomplete type
  else if (req->cmd_flags & REQ_DISCARD)
              ^
drivers/nvme/host/pci.c:929:14: error: dereferencing pointer to incomplete type
  else if (req->cmd_flags & REQ_FLUSH)
              ^
drivers/nvme/host/pci.c:930:35: error: dereferencing pointer to incomplete type
   nvme_submit_flush(nvmeq, ns, req->tag);
                                   ^
drivers/nvme/host/pci.c: In function ?__nvme_submit_sync_cmd?:
drivers/nvme/host/pci.c:1023:5: error: dereferencing pointer to incomplete type
  req->cmd_type = REQ_TYPE_DRV_PRIV;
     ^
drivers/nvme/host/pci.c:1023:18: error: ?REQ_TYPE_DRV_PRIV? undeclared
(first use in this function)
  req->cmd_type = REQ_TYPE_DRV_PRIV;
                  ^
drivers/nvme/host/pci.c:1024:5: error: dereferencing pointer to incomplete type
  req->cmd_flags |= REQ_FAILFAST_DRIVER;
     ^
drivers/nvme/host/pci.c:1025:5: error: dereferencing pointer to incomplete type
  req->__data_len = 0;
     ^
drivers/nvme/host/pci.c:1026:5: error: dereferencing pointer to incomplete type
  req->__sector = (sector_t) -1;
     ^
drivers/nvme/host/pci.c:1027:5: error: dereferencing pointer to incomplete type
  req->bio = req->biotail = NULL;
     ^
drivers/nvme/host/pci.c:1027:16: error: dereferencing pointer to incomplete type
  req->bio = req->biotail = NULL;
                ^
drivers/nvme/host/pci.c:1029:5: error: dereferencing pointer to incomplete type
  req->timeout = timeout ? timeout : ADMIN_TIMEOUT;
     ^
drivers/nvme/host/pci.c:1031:5: error: dereferencing pointer to incomplete type
  req->cmd = (unsigned char *)cmd;
     ^
drivers/nvme/host/pci.c:1032:5: error: dereferencing pointer to incomplete type
  req->cmd_len = sizeof(struct nvme_command);
     ^
drivers/nvme/host/pci.c:1033:5: error: dereferencing pointer to incomplete type
  req->special = (void *)0;
     ^
drivers/nvme/host/pci.c:1036:3: error: implicit declaration of
function ?blk_rq_map_kern? [-Werror=implicit-function-declaration]
   ret = blk_rq_map_kern(q, req, buffer, bufflen, __GFP_RECLAIM);
   ^
drivers/nvme/host/pci.c:1040:3: error: implicit declaration of
function ?blk_rq_map_user? [-Werror=implicit-function-declaration]
   ret = blk_rq_map_user(q, req, NULL, ubuffer, bufflen, __GFP_RECLAIM);
   ^
drivers/nvme/host/pci.c:1043:12: error: dereferencing pointer to incomplete type
   bio = req->bio;
            ^
drivers/nvme/host/pci.c:1046:2: error: implicit declaration of
function ?blk_execute_rq? [-Werror=implicit-function-declaration]
  blk_execute_rq(req->q, NULL, req, 0);
  ^
drivers/nvme/host/pci.c:1046:20: error: dereferencing pointer to incomplete type
  blk_execute_rq(req->q, NULL, req, 0);
                    ^
drivers/nvme/host/pci.c:1048:3: error: implicit declaration of
function ?blk_rq_unmap_user? [-Werror=implicit-function-declaration]
   blk_rq_unmap_user(bio);
   ^
drivers/nvme/host/pci.c:1050:32: error: dereferencing pointer to incomplete type
   *result = (u32)(uintptr_t)req->special;
                                ^
drivers/nvme/host/pci.c:1051:11: error: dereferencing pointer to incomplete type
  ret = req->errors;
           ^
drivers/nvme/host/pci.c: In function ?nvme_submit_async_admin_req?:
drivers/nvme/host/pci.c:1074:5: error: dereferencing pointer to incomplete type
  req->cmd_flags |= REQ_NO_TIMEOUT;
     ^
drivers/nvme/host/pci.c:1080:27: error: dereferencing pointer to incomplete type
  c.common.command_id = req->tag;
                           ^
drivers/nvme/host/pci.c: In function ?nvme_submit_admin_async_cmd?:
drivers/nvme/host/pci.c:1099:5: error: dereferencing pointer to incomplete type
  req->timeout = timeout;
     ^
drivers/nvme/host/pci.c:1105:30: error: dereferencing pointer to incomplete type
  cmd->common.command_id = req->tag;
                              ^
drivers/nvme/host/pci.c: In function ?nvme_abort_req?:
drivers/nvme/host/pci.c:1287:9: error: dereferencing pointer to incomplete type
      req->tag, nvmeq->qid);
         ^
drivers/nvme/host/pci.c:1306:21: error: dereferencing pointer to incomplete type
  cmd.abort.cid = req->tag;
                     ^
drivers/nvme/host/pci.c:1308:34: error: dereferencing pointer to incomplete type
  cmd.abort.command_id = abort_req->tag;
                                  ^
drivers/nvme/host/pci.c:1313:59: error: dereferencing pointer to incomplete type
  dev_warn(nvmeq->q_dmadev, "Aborting I/O %d QID %d\n", req->tag,
                                                           ^
drivers/nvme/host/pci.c: In function ?nvme_cancel_queue_ios?:
drivers/nvme/host/pci.c:1334:2: error: implicit declaration of
function ?blk_queue_dying? [-Werror=implicit-function-declaration]
  if (blk_queue_dying(req->q))
  ^
drivers/nvme/host/pci.c:1334:25: error: dereferencing pointer to incomplete type
  if (blk_queue_dying(req->q))
                         ^
drivers/nvme/host/pci.c:1341:10: error: dereferencing pointer to incomplete type
       req->tag, nvmeq->qid);
          ^
drivers/nvme/host/pci.c: At top level:
drivers/nvme/host/pci.c:1346:33: error: return type is an incomplete type
 static enum blk_eh_timer_return nvme_timeout(struct request *req,
bool reserved)
                                 ^
drivers/nvme/host/pci.c: In function ?nvme_timeout?:
drivers/nvme/host/pci.c:1351:58: error: dereferencing pointer to incomplete type
  dev_warn(nvmeq->q_dmadev, "Timeout I/O %d QID %d\n", req->tag,
                                                          ^
drivers/nvme/host/pci.c:1362:9: error: ?BLK_EH_RESET_TIMER? undeclared
(first use in this function)
  return BLK_EH_RESET_TIMER;
         ^
drivers/nvme/host/pci.c:1362:2: warning: ?return? with a value, in
function returning void
  return BLK_EH_RESET_TIMER;
  ^
drivers/nvme/host/pci.c: At top level:
drivers/nvme/host/pci.c:1656:2: warning: initialization from
incompatible pointer type
  .timeout = nvme_timeout,
  ^
drivers/nvme/host/pci.c:1656:2: warning: (near initialization for
?nvme_mq_admin_ops.timeout?)
drivers/nvme/host/pci.c:1664:2: warning: initialization from
incompatible pointer type
  .timeout = nvme_timeout,
  ^
drivers/nvme/host/pci.c:1664:2: warning: (near initialization for
?nvme_mq_ops.timeout?)
drivers/nvme/host/pci.c: In function ?nvme_dev_remove_admin?:
drivers/nvme/host/pci.c:1670:3: error: implicit declaration of
function ?blk_cleanup_queue? [-Werror=implicit-function-declaration]
   blk_cleanup_queue(dev->admin_q);
   ^
drivers/nvme/host/pci.c: In function ?nvme_alloc_admin_tags?:
drivers/nvme/host/pci.c:1695:3: error: implicit declaration of
function ?blk_get_queue? [-Werror=implicit-function-declaration]
   if (!blk_get_queue(dev->admin_q)) {
   ^
drivers/nvme/host/pci.c: In function ?nvme_ioctl?:
drivers/nvme/host/pci.c:1909:36: error: dereferencing pointer to incomplete type
  struct nvme_ns *ns = bdev->bd_disk->private_data;
                                    ^
drivers/nvme/host/pci.c: In function ?nvme_free_ns?:
drivers/nvme/host/pci.c:1950:10: error: dereferencing pointer to incomplete type
  ns->disk->private_data = NULL;
          ^
drivers/nvme/host/pci.c:1954:2: error: implicit declaration of
function ?put_disk? [-Werror=implicit-function-declaration]
  put_disk(ns->disk);
  ^
drivers/nvme/host/pci.c: In function ?nvme_open?:
drivers/nvme/host/pci.c:1964:20: error: dereferencing pointer to incomplete type
  ns = bdev->bd_disk->private_data;
                    ^
drivers/nvme/host/pci.c: In function ?nvme_release?:
drivers/nvme/host/pci.c:1976:27: error: dereferencing pointer to incomplete type
  struct nvme_ns *ns = disk->private_data;
                           ^
drivers/nvme/host/pci.c: In function ?nvme_getgeo?:
drivers/nvme/host/pci.c:1985:2: error: implicit declaration of
function ?get_capacity? [-Werror=implicit-function-declaration]
  geo->cylinders = get_capacity(bd->bd_disk) >> 11;
  ^
drivers/nvme/host/pci.c: In function ?nvme_config_discard?:
drivers/nvme/host/pci.c:1991:2: error: implicit declaration of
function ?queue_logical_block_size?
[-Werror=implicit-function-declaration]
  u32 logical_block_size = queue_logical_block_size(ns->queue);
  ^
drivers/nvme/host/pci.c:1992:11: error: dereferencing pointer to incomplete type
  ns->queue->limits.discard_zeroes_data = 0;
           ^
drivers/nvme/host/pci.c:1993:11: error: dereferencing pointer to incomplete type
  ns->queue->limits.discard_alignment = logical_block_size;
           ^
drivers/nvme/host/pci.c:1994:11: error: dereferencing pointer to incomplete type
  ns->queue->limits.discard_granularity = logical_block_size;
           ^
drivers/nvme/host/pci.c:1995:2: error: implicit declaration of
function ?blk_queue_max_discard_sectors?
[-Werror=implicit-function-declaration]
  blk_queue_max_discard_sectors(ns->queue, 0xffffffff);
  ^
drivers/nvme/host/pci.c:1996:2: error: implicit declaration of
function ?queue_flag_set_unlocked?
[-Werror=implicit-function-declaration]
  queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, ns->queue);
  ^
drivers/nvme/host/pci.c:1996:26: error: ?QUEUE_FLAG_DISCARD?
undeclared (first use in this function)
  queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, ns->queue);
                          ^
drivers/nvme/host/pci.c: In function ?nvme_revalidate_disk?:
drivers/nvme/host/pci.c:2001:27: error: dereferencing pointer to incomplete type
  struct nvme_ns *ns = disk->private_data;
                           ^
drivers/nvme/host/pci.c:2036:2: error: implicit declaration of
function ?blk_get_integrity? [-Werror=implicit-function-declaration]
  if (blk_get_integrity(disk) && (ns->pi_type != pi_type ||
  ^
drivers/nvme/host/pci.c:2038:40: error: dereferencing pointer to incomplete type
     bs != queue_logical_block_size(disk->queue) ||
                                        ^
drivers/nvme/host/pci.c:2040:3: error: implicit declaration of
function ?blk_integrity_unregister?
[-Werror=implicit-function-declaration]
   blk_integrity_unregister(disk);
   ^
drivers/nvme/host/pci.c:2043:2: error: implicit declaration of
function ?blk_queue_logical_block_size?
[-Werror=implicit-function-declaration]
  blk_queue_logical_block_size(ns->queue, bs);
  ^
drivers/nvme/host/pci.c:2045:49: error: dereferencing pointer to incomplete type
  if (ns->ms && !blk_get_integrity(disk) && (disk->flags & GENHD_FL_UP) &&
                                                 ^
drivers/nvme/host/pci.c:2045:59: error: ?GENHD_FL_UP? undeclared
(first use in this function)
  if (ns->ms && !blk_get_integrity(disk) && (disk->flags & GENHD_FL_UP) &&
                                                           ^
drivers/nvme/host/pci.c:2050:3: error: implicit declaration of
function ?set_capacity? [-Werror=implicit-function-declaration]
   set_capacity(disk, 0);
   ^
drivers/nvme/host/pci.c: At top level:
drivers/nvme/host/pci.c:2061:21: error: variable ?nvme_fops? has
initializer but incomplete type
 static const struct block_device_operations nvme_fops = {
                     ^
drivers/nvme/host/pci.c:2062:2: error: unknown field ?owner? specified
in initializer
  .owner  = THIS_MODULE,
  ^
In file included from include/linux/linkage.h:6:0,
                 from ./arch/x86/include/asm/cache.h:4,
                 from ./arch/x86/include/asm/segment.h:155,
                 from ./arch/x86/include/asm/ptrace.h:4,
                 from ./arch/x86/include/asm/alternative.h:8,
                 from ./arch/x86/include/asm/bitops.h:16,
                 from include/linux/bitops.h:36,
                 from drivers/nvme/host/pci.c:15:
include/linux/export.h:36:30: warning: excess elements in struct initializer
 #define THIS_MODULE ((struct module *)0)
                              ^
drivers/nvme/host/pci.c:2062:12: note: in expansion of macro ?THIS_MODULE?
  .owner  = THIS_MODULE,
            ^
include/linux/export.h:36:30: warning: (near initialization for ?nvme_fops?)
 #define THIS_MODULE ((struct module *)0)
                              ^
drivers/nvme/host/pci.c:2062:12: note: in expansion of macro ?THIS_MODULE?
  .owner  = THIS_MODULE,
            ^
drivers/nvme/host/pci.c:2063:2: error: unknown field ?ioctl? specified
in initializer
  .ioctl  = nvme_ioctl,
  ^
drivers/nvme/host/pci.c:2063:2: warning: excess elements in struct initializer
drivers/nvme/host/pci.c:2063:2: warning: (near initialization for ?nvme_fops?)
drivers/nvme/host/pci.c:2064:2: error: unknown field ?compat_ioctl?
specified in initializer
  .compat_ioctl = nvme_compat_ioctl,
  ^
drivers/nvme/host/pci.c:2064:2: warning: excess elements in struct initializer
drivers/nvme/host/pci.c:2064:2: warning: (near initialization for ?nvme_fops?)
drivers/nvme/host/pci.c:2065:2: error: unknown field ?open? specified
in initializer
  .open  = nvme_open,
  ^
drivers/nvme/host/pci.c:2065:2: warning: excess elements in struct initializer
drivers/nvme/host/pci.c:2065:2: warning: (near initialization for ?nvme_fops?)
drivers/nvme/host/pci.c:2066:2: error: unknown field ?release?
specified in initializer
  .release = nvme_release,
  ^
drivers/nvme/host/pci.c:2066:2: warning: excess elements in struct initializer
drivers/nvme/host/pci.c:2066:2: warning: (near initialization for ?nvme_fops?)
drivers/nvme/host/pci.c:2067:2: error: unknown field ?getgeo?
specified in initializer
  .getgeo  = nvme_getgeo,
  ^
drivers/nvme/host/pci.c:2067:2: warning: excess elements in struct initializer
drivers/nvme/host/pci.c:2067:2: warning: (near initialization for ?nvme_fops?)
drivers/nvme/host/pci.c:2068:2: error: unknown field ?revalidate_disk?
specified in initializer
  .revalidate_disk= nvme_revalidate_disk,
  ^
drivers/nvme/host/pci.c:2068:2: warning: excess elements in struct initializer
drivers/nvme/host/pci.c:2068:2: warning: (near initialization for ?nvme_fops?)
drivers/nvme/host/pci.c: In function ?nvme_alloc_ns?:
drivers/nvme/host/pci.c:2125:26: error: ?QUEUE_FLAG_NOMERGES?
undeclared (first use in this function)
  queue_flag_set_unlocked(QUEUE_FLAG_NOMERGES, ns->queue);
                          ^
drivers/nvme/host/pci.c:2126:26: error: ?QUEUE_FLAG_NONROT? undeclared
(first use in this function)
  queue_flag_set_unlocked(QUEUE_FLAG_NONROT, ns->queue);
                          ^
drivers/nvme/host/pci.c:2128:11: error: dereferencing pointer to incomplete type
  ns->queue->queuedata = ns;
           ^
drivers/nvme/host/pci.c:2130:2: error: implicit declaration of
function ?alloc_disk_node? [-Werror=implicit-function-declaration]
  disk = alloc_disk_node(0, node);
  ^
drivers/nvme/host/pci.c:2130:7: warning: assignment makes pointer from
integer without a cast
  disk = alloc_disk_node(0, node);
       ^
drivers/nvme/host/pci.c:2142:3: error: implicit declaration of
function ?blk_queue_max_hw_sectors?
[-Werror=implicit-function-declaration]
   blk_queue_max_hw_sectors(ns->queue, dev->max_hw_sectors);
   ^
drivers/nvme/host/pci.c:2143:3: error: implicit declaration of
function ?blk_queue_max_segments?
[-Werror=implicit-function-declaration]
   blk_queue_max_segments(ns->queue,
   ^
drivers/nvme/host/pci.c:2147:3: error: implicit declaration of
function ?blk_queue_chunk_sectors?
[-Werror=implicit-function-declaration]
   blk_queue_chunk_sectors(ns->queue, dev->stripe_size >> 9);
   ^
drivers/nvme/host/pci.c:2149:3: error: implicit declaration of
function ?blk_queue_flush? [-Werror=implicit-function-declaration]
   blk_queue_flush(ns->queue, REQ_FLUSH | REQ_FUA);
   ^
drivers/nvme/host/pci.c:2150:2: error: implicit declaration of
function ?blk_queue_virt_boundary?
[-Werror=implicit-function-declaration]
  blk_queue_virt_boundary(ns->queue, dev->page_size - 1);
  ^
drivers/nvme/host/pci.c:2152:6: error: dereferencing pointer to incomplete type
  disk->major = nvme_major;
      ^
drivers/nvme/host/pci.c:2153:6: error: dereferencing pointer to incomplete type
  disk->first_minor = 0;
      ^
drivers/nvme/host/pci.c:2154:6: error: dereferencing pointer to incomplete type
  disk->fops = &nvme_fops;
      ^
drivers/nvme/host/pci.c:2155:6: error: dereferencing pointer to incomplete type
  disk->private_data = ns;
      ^
drivers/nvme/host/pci.c:2156:6: error: dereferencing pointer to incomplete type
  disk->queue = ns->queue;
      ^
drivers/nvme/host/pci.c:2157:6: error: dereferencing pointer to incomplete type
  disk->driverfs_dev = dev->device;
      ^
drivers/nvme/host/pci.c:2158:6: error: dereferencing pointer to incomplete type
  disk->flags = GENHD_FL_EXT_DEVT;
      ^
drivers/nvme/host/pci.c:2158:16: error: ?GENHD_FL_EXT_DEVT? undeclared
(first use in this function)
  disk->flags = GENHD_FL_EXT_DEVT;
                ^
drivers/nvme/host/pci.c:2159:14: error: dereferencing pointer to incomplete type
  sprintf(disk->disk_name, "nvme%dn%d", dev->instance, nsid);
              ^
drivers/nvme/host/pci.c:2172:2: error: implicit declaration of
function ?add_disk? [-Werror=implicit-function-declaration]
  add_disk(ns->disk);
  ^
drivers/nvme/host/pci.c:2174:10: error: implicit declaration of
function ?bdget_disk? [-Werror=implicit-function-declaration]
   struct block_device *bd = bdget_disk(ns->disk, 0);
          ^
drivers/nvme/host/pci.c:2174:29: warning: initialization makes pointer
from integer without a cast
   struct block_device *bd = bdget_disk(ns->disk, 0);
                             ^
drivers/nvme/host/pci.c:2177:3: error: implicit declaration of
function ?blkdev_get? [-Werror=implicit-function-declaration]
   if (blkdev_get(bd, FMODE_READ, NULL)) {
   ^
drivers/nvme/host/pci.c:2178:4: error: implicit declaration of
function ?bdput? [-Werror=implicit-function-declaration]
    bdput(bd);
    ^
drivers/nvme/host/pci.c:2181:3: error: implicit declaration of
function ?blkdev_reread_part? [-Werror=implicit-function-declaration]
   blkdev_reread_part(bd);
   ^
drivers/nvme/host/pci.c:2182:3: error: implicit declaration of
function ?blkdev_put? [-Werror=implicit-function-declaration]
   blkdev_put(bd, FMODE_READ);
   ^
drivers/nvme/host/pci.c: In function ?nvme_ns_remove?:
drivers/nvme/host/pci.c:2408:3: error: implicit declaration of
function ?blk_set_queue_dying? [-Werror=implicit-function-declaration]
   blk_set_queue_dying(ns->queue);
   ^
drivers/nvme/host/pci.c:2409:14: error: dereferencing pointer to incomplete type
  if (ns->disk->flags & GENHD_FL_UP) {
              ^
drivers/nvme/host/pci.c:2409:24: error: ?GENHD_FL_UP? undeclared
(first use in this function)
  if (ns->disk->flags & GENHD_FL_UP) {
                        ^
drivers/nvme/host/pci.c:2412:3: error: implicit declaration of
function ?del_gendisk? [-Werror=implicit-function-declaration]
   del_gendisk(ns->disk);
   ^
drivers/nvme/host/pci.c: In function ?nvme_scan_namespaces?:
drivers/nvme/host/pci.c:2430:4: error: implicit declaration of
function ?revalidate_disk? [-Werror=implicit-function-declaration]
    if (revalidate_disk(ns->disk))
    ^
drivers/nvme/host/pci.c: In function ?nvme_freeze_queues?:
drivers/nvme/host/pci.c:2777:26: error: dereferencing pointer to incomplete type
   spin_lock_irq(ns->queue->queue_lock);
                          ^
drivers/nvme/host/pci.c:2778:3: error: implicit declaration of
function ?queue_flag_set? [-Werror=implicit-function-declaration]
   queue_flag_set(QUEUE_FLAG_STOPPED, ns->queue);
   ^
drivers/nvme/host/pci.c:2778:18: error: ?QUEUE_FLAG_STOPPED?
undeclared (first use in this function)
   queue_flag_set(QUEUE_FLAG_STOPPED, ns->queue);
                  ^
drivers/nvme/host/pci.c:2779:28: error: dereferencing pointer to incomplete type
   spin_unlock_irq(ns->queue->queue_lock);
                            ^
drivers/nvme/host/pci.c: In function ?nvme_unfreeze_queues?:
drivers/nvme/host/pci.c:2791:3: error: implicit declaration of
function ?queue_flag_clear_unlocked?
[-Werror=implicit-function-declaration]
   queue_flag_clear_unlocked(QUEUE_FLAG_STOPPED, ns->queue);
   ^
drivers/nvme/host/pci.c:2791:29: error: ?QUEUE_FLAG_STOPPED?
undeclared (first use in this function)
   queue_flag_clear_unlocked(QUEUE_FLAG_STOPPED, ns->queue);
                             ^
drivers/nvme/host/pci.c: In function ?nvme_free_dev?:
drivers/nvme/host/pci.c:2895:3: error: implicit declaration of
function ?blk_put_queue? [-Werror=implicit-function-declaration]
   blk_put_queue(dev->admin_q);
   ^
drivers/nvme/host/pci.c: In function ?nvme_init?:
drivers/nvme/host/pci.c:3304:2: error: implicit declaration of
function ?register_blkdev? [-Werror=implicit-function-declaration]
  result = register_blkdev(nvme_major, "nvme");
  ^
drivers/nvme/host/pci.c:3333:2: error: implicit declaration of
function ?unregister_blkdev? [-Werror=implicit-function-declaration]
  unregister_blkdev(nvme_major, "nvme");
  ^
  CC      drivers/net/can/at91_can.o
  LD [M]  drivers/media/dvb-frontends/stb0899.o
In file included from drivers/nvme/host/pci.c:17:0:
include/linux/blk-mq.h: In function ?blk_mq_rq_from_pdu?:
include/linux/blk-mq.h:239:1: warning: control reaches end of non-void
function [-Wreturn-type]
 }
 ^
  LD [M]  drivers/media/dvb-frontends/drxd.o
drivers/nvme/host/pci.c: In function ?nvme_alloc_iod?:
drivers/nvme/host/pci.c:462:1: warning: control reaches end of
non-void function [-Wreturn-type]
 }
 ^


-- 
Jim
-------------- next part --------------
#
# Automatically generated file; DO NOT EDIT.
# Linux/x86 4.3.0-rc5 Kernel Configuration
#
CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_ARCH_DEFCONFIG="arch/x86/configs/x86_64_defconfig"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_HAVE_LATENCYTOP_SUPPORT=y
CONFIG_MMU=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ZONE_DMA32=y
CONFIG_AUDIT_ARCH=y
CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_HAVE_INTEL_TXT=y
CONFIG_ARCH_HWEIGHT_CFLAGS="-fcall-saved-rdi -fcall-saved-rsi -fcall-saved-rdx -fcall-saved-rcx -fcall-saved-r8 -fcall-saved-r9 -fcall-saved-r10 -fcall-saved-r11"
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=4
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_EXTABLE_SORT=y

#
# General setup
#
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_CROSS_COMPILE=""
CONFIG_COMPILE_TEST=y
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_FHANDLE is not set
# CONFIG_USELIB is not set
# CONFIG_AUDIT is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_DEBUG=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_DATA=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_HZ_PERIODIC=y
# CONFIG_NO_HZ_IDLE is not set
# CONFIG_NO_HZ is not set
CONFIG_HIGH_RES_TIMERS=y

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_VIRT_CPU_ACCOUNTING_GEN is not set
# CONFIG_IRQ_TIME_ACCOUNTING is not set
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
# CONFIG_TASK_IO_ACCOUNTING is not set

#
# RCU Subsystem
#
CONFIG_TINY_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
# CONFIG_TASKS_RCU is not set
CONFIG_RCU_STALL_COMMON=y
# CONFIG_TREE_RCU_TRACE is not set
CONFIG_RCU_KTHREAD_PRIO=0
# CONFIG_RCU_EXPEDITE_BOOT is not set
CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_SUPPORTS_INT128=y
# CONFIG_CGROUPS is not set
CONFIG_CHECKPOINT_RESTORE=y
# CONFIG_SCHED_AUTOGROUP is not set
CONFIG_SYSFS_DEPRECATED=y
CONFIG_SYSFS_DEPRECATED_V2=y
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
# CONFIG_RD_GZIP is not set
# CONFIG_RD_BZIP2 is not set
# CONFIG_RD_LZMA is not set
# CONFIG_RD_XZ is not set
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_ANON_INODES=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
CONFIG_EXPERT=y
# CONFIG_MULTIUSER is not set
# CONFIG_SGETMASK_SYSCALL is not set
CONFIG_SYSFS_SYSCALL=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
# CONFIG_PRINTK is not set
# CONFIG_BUG is not set
# CONFIG_PCSPKR_PLATFORM is not set
# CONFIG_BASE_FULL is not set
# CONFIG_FUTEX is not set
# CONFIG_EPOLL is not set
# CONFIG_SIGNALFD is not set
# CONFIG_TIMERFD is not set
CONFIG_EVENTFD=y
# CONFIG_BPF_SYSCALL is not set
# CONFIG_SHMEM is not set
# CONFIG_AIO is not set
CONFIG_ADVISE_SYSCALLS=y
# CONFIG_USERFAULTFD is not set
# CONFIG_PCI_QUIRKS is not set
CONFIG_MEMBARRIER=y
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PERF_USE_VMALLOC=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
CONFIG_DEBUG_PERF_USE_VMALLOC=y
# CONFIG_VM_EVENT_COUNTERS is not set
CONFIG_SLUB_DEBUG=y
CONFIG_COMPAT_BRK=y
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
CONFIG_SYSTEM_DATA_VERIFICATION=y
# CONFIG_PROFILING is not set
CONFIG_TRACEPOINTS=y
CONFIG_KEXEC_CORE=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
# CONFIG_KPROBES is not set
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
CONFIG_UPROBES=y
# CONFIG_HAVE_64BIT_ALIGNED_ACCESS is not set
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_ATTRS=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_DMA_API_DEBUG=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP_FILTER=y
CONFIG_HAVE_CC_STACKPROTECTOR=y
# CONFIG_CC_STACKPROTECTOR is not set
CONFIG_CC_STACKPROTECTOR_NONE=y
# CONFIG_CC_STACKPROTECTOR_REGULAR is not set
# CONFIG_CC_STACKPROTECTOR_STRONG is not set
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_COPY_THREAD_TLS=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# CONFIG_HAVE_GENERIC_DMA_COHERENT is not set
CONFIG_SLABINFO=y
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=1
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
# CONFIG_MODULE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
CONFIG_MODULE_SRCVERSION_ALL=y
CONFIG_MODULE_SIG=y
# CONFIG_MODULE_SIG_FORCE is not set
CONFIG_MODULE_SIG_ALL=y
CONFIG_MODULE_SIG_SHA1=y
# CONFIG_MODULE_SIG_SHA224 is not set
# CONFIG_MODULE_SIG_SHA256 is not set
# CONFIG_MODULE_SIG_SHA384 is not set
# CONFIG_MODULE_SIG_SHA512 is not set
CONFIG_MODULE_SIG_HASH="sha1"
CONFIG_MODULE_COMPRESS=y
CONFIG_MODULE_COMPRESS_GZIP=y
# CONFIG_MODULE_COMPRESS_XZ is not set
CONFIG_MODULES_TREE_LOOKUP=y
# CONFIG_BLOCK is not set
CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
# CONFIG_FREEZER is not set

#
# Processor type and features
#
# CONFIG_ZONE_DMA is not set
# CONFIG_SMP is not set
CONFIG_X86_FEATURE_NAMES=y
# CONFIG_X86_X2APIC is not set
# CONFIG_X86_MPPARSE is not set
# CONFIG_X86_EXTENDED_PLATFORM is not set
CONFIG_X86_INTEL_LPSS=y
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
CONFIG_IOSF_MBI_DEBUG=y
CONFIG_SCHED_OMIT_FRAME_POINTER=y
# CONFIG_HYPERVISOR_GUEST is not set
CONFIG_NO_BOOTMEM=y
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
# CONFIG_PROCESSOR_SELECT is not set
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_HPET_TIMER=y
# CONFIG_DMI is not set
# CONFIG_GART_IOMMU is not set
# CONFIG_CALGARY_IOMMU is not set
CONFIG_SWIOTLB=y
CONFIG_IOMMU_HELPER=y
CONFIG_NR_CPUS=1
CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
CONFIG_UP_LATE_INIT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
# CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS is not set
# CONFIG_X86_MCE is not set
# CONFIG_VM86 is not set
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_I8K=y
CONFIG_MICROCODE=m
# CONFIG_MICROCODE_INTEL is not set
CONFIG_MICROCODE_AMD=y
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_ARCH_PHYS_ADDR_T_64BIT=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
# CONFIG_ARCH_MEMORY_PROBE is not set
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_HAVE_MEMORY_PRESENT=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER=y
# CONFIG_SPARSEMEM_VMEMMAP is not set
CONFIG_HAVE_MEMBLOCK=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_ARCH_DISCARD_MEMBLOCK=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
# CONFIG_COMPACTION is not set
CONFIG_MIGRATION=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_ZONE_DMA_FLAG=0
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
# CONFIG_TRANSPARENT_HUGEPAGE is not set
CONFIG_NEED_PER_CPU_KM=y
CONFIG_CLEANCACHE=y
CONFIG_CMA=y
CONFIG_CMA_DEBUG=y
# CONFIG_CMA_DEBUGFS is not set
CONFIG_CMA_AREAS=7
# CONFIG_MEM_SOFT_DIRTY is not set
CONFIG_ZPOOL=m
CONFIG_ZBUD=m
# CONFIG_ZSMALLOC is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_ARCH_SUPPORTS_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
# CONFIG_IDLE_PAGE_TRACKING is not set
# CONFIG_ZONE_DEVICE is not set
CONFIG_FRAME_VECTOR=y
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
CONFIG_X86_RESERVE_LOW=64
# CONFIG_MTRR is not set
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
# CONFIG_X86_INTEL_MPX is not set
CONFIG_EFI=y
# CONFIG_EFI_STUB is not set
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
# CONFIG_KEXEC_VERIFY_SIG is not set
# CONFIG_CRASH_DUMP is not set
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_RANDOMIZE_BASE_MAX_OFFSET=0x40000000
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
# CONFIG_LEGACY_VSYSCALL_NATIVE is not set
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
CONFIG_CMDLINE_BOOL=y
CONFIG_CMDLINE=""
CONFIG_CMDLINE_OVERRIDE=y
# CONFIG_MODIFY_LDT_SYSCALL is not set
CONFIG_HAVE_LIVEPATCH=y
# CONFIG_LIVEPATCH is not set
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
# CONFIG_HAVE_MEMORYLESS_NODES is not set

#
# Power management and ACPI options
#
# CONFIG_SUSPEND is not set
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
CONFIG_PM_OPP=y
CONFIG_PM_CLK=y
CONFIG_PM_GENERIC_DOMAINS=y
CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
CONFIG_PM_GENERIC_DOMAINS_OF=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
CONFIG_ACPI_PROCFS_POWER=y
# CONFIG_ACPI_REV_OVERRIDE_POSSIBLE is not set
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_AC=y
# CONFIG_ACPI_BATTERY is not set
# CONFIG_ACPI_BUTTON is not set
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=m
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=m
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=m
# CONFIG_ACPI_CUSTOM_DSDT is not set
CONFIG_ACPI_INITRD_TABLE_OVERRIDE=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=y
# CONFIG_X86_PM_TIMER is not set
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=y
CONFIG_ACPI_HED=y
# CONFIG_ACPI_CUSTOM_METHOD is not set
# CONFIG_ACPI_BGRT is not set
CONFIG_ACPI_REDUCED_HARDWARE_ONLY=y
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
# CONFIG_ACPI_APEI_GHES is not set
# CONFIG_ACPI_APEI_EINJ is not set
CONFIG_ACPI_APEI_ERST_DEBUG=m
# CONFIG_PMIC_OPREGION is not set
# CONFIG_SFI is not set

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
# CONFIG_CPU_FREQ_STAT_DETAILS is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_GOV_POWERSAVE is not set
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y

#
# CPU frequency scaling drivers
#
CONFIG_CPUFREQ_DT=m
# CONFIG_X86_INTEL_PSTATE is not set
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_ACPI_CPUFREQ is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=y

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=y

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED is not set
# CONFIG_INTEL_IDLE is not set

#
# Memory power savings
#
# CONFIG_I7300_IDLE is not set

#
# Bus options (PCI etc.)
#
CONFIG_PCI=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCI_CNB20LE_QUIRK=y
# CONFIG_PCIEPORTBUS is not set
CONFIG_PCI_BUS_ADDR_T_64BIT=y
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=m
# CONFIG_HT_IRQ is not set
CONFIG_PCI_ATS=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
CONFIG_PCI_LABEL=y

#
# PCI host controller drivers
#
# CONFIG_ISA_DMA_API is not set
CONFIG_AMD_NB=y
CONFIG_PCCARD=m
CONFIG_PCMCIA=m
CONFIG_PCMCIA_LOAD_CIS=y
CONFIG_CARDBUS=y

#
# PC-card bridges
#
CONFIG_YENTA=m
# CONFIG_YENTA_O2 is not set
CONFIG_YENTA_RICOH=y
CONFIG_YENTA_TI=y
CONFIG_YENTA_ENE_TUNE=y
CONFIG_YENTA_TOSHIBA=y
CONFIG_PD6729=m
CONFIG_I82092=m
CONFIG_PCCARD_NONSTATIC=y
# CONFIG_HOTPLUG_PCI is not set
CONFIG_RAPIDIO=y
CONFIG_RAPIDIO_DISC_TIMEOUT=30
# CONFIG_RAPIDIO_ENABLE_RX_TX_PORTS is not set
CONFIG_RAPIDIO_DMA_ENGINE=y
CONFIG_RAPIDIO_DEBUG=y
# CONFIG_RAPIDIO_ENUM_BASIC is not set

#
# RapidIO Switch drivers
#
CONFIG_RAPIDIO_TSI57X=m
# CONFIG_RAPIDIO_CPS_XX is not set
CONFIG_RAPIDIO_TSI568=m
CONFIG_RAPIDIO_CPS_GEN2=m
# CONFIG_X86_SYSFB is not set

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_SCRIPT=m
# CONFIG_HAVE_AOUT is not set
CONFIG_BINFMT_MISC=m
# CONFIG_COREDUMP is not set
# CONFIG_IA32_EMULATION is not set
# CONFIG_X86_X32 is not set
CONFIG_X86_DEV_DMA_OPS=y
CONFIG_PMC_ATOM=y
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=m
# CONFIG_PACKET_DIAG is not set
CONFIG_UNIX=m
CONFIG_UNIX_DIAG=m
CONFIG_XFRM=y
CONFIG_XFRM_ALGO=m
CONFIG_XFRM_SUB_POLICY=y
# CONFIG_XFRM_MIGRATE is not set
CONFIG_NET_KEY=m
# CONFIG_NET_KEY_MIGRATE is not set
# CONFIG_INET is not set
# CONFIG_NETWORK_SECMARK is not set
# CONFIG_NET_PTP_CLASSIFY is not set
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
CONFIG_NETFILTER=y
CONFIG_NETFILTER_DEBUG=y
# CONFIG_NETFILTER_ADVANCED is not set
CONFIG_ATM=y
# CONFIG_ATM_LANE is not set
CONFIG_STP=m
CONFIG_GARP=m
CONFIG_MRP=m
# CONFIG_BRIDGE is not set
CONFIG_VLAN_8021Q=m
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
# CONFIG_DECNET is not set
CONFIG_LLC=y
CONFIG_LLC2=y
# CONFIG_IPX is not set
CONFIG_ATALK=m
CONFIG_DEV_APPLETALK=m
CONFIG_IPDDP=m
# CONFIG_IPDDP_ENCAP is not set
CONFIG_X25=y
# CONFIG_LAPB is not set
CONFIG_PHONET=y
# CONFIG_IEEE802154 is not set
# CONFIG_NET_SCHED is not set
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=y
# CONFIG_BATMAN_ADV is not set
# CONFIG_VSOCKETS is not set
CONFIG_NETLINK_MMAP=y
CONFIG_NETLINK_DIAG=m
# CONFIG_MPLS is not set
CONFIG_HSR=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
# CONFIG_BPF_JIT is not set

#
# Network testing
#
# CONFIG_HAMRADIO is not set
CONFIG_CAN=y
# CONFIG_CAN_RAW is not set
CONFIG_CAN_BCM=y
# CONFIG_CAN_GW is not set

#
# CAN Device Drivers
#
# CONFIG_CAN_VCAN is not set
CONFIG_CAN_DEV=y
CONFIG_CAN_CALC_BITTIMING=y
# CONFIG_CAN_LEDS is not set
CONFIG_CAN_AT91=y
# CONFIG_CAN_JANZ_ICAN3 is not set
CONFIG_PCH_CAN=m
CONFIG_CAN_GRCAN=m
# CONFIG_CAN_SUN4I is not set
CONFIG_CAN_XILINXCAN=m
CONFIG_CAN_SJA1000=y
CONFIG_CAN_SJA1000_ISA=y
CONFIG_CAN_SJA1000_PLATFORM=y
CONFIG_CAN_EMS_PCMCIA=m
CONFIG_CAN_EMS_PCI=m
CONFIG_CAN_PEAK_PCMCIA=m
CONFIG_CAN_PEAK_PCI=m
# CONFIG_CAN_PEAK_PCIEC is not set
CONFIG_CAN_KVASER_PCI=y
CONFIG_CAN_PLX_PCI=m
CONFIG_CAN_C_CAN=m
CONFIG_CAN_C_CAN_PLATFORM=m
CONFIG_CAN_C_CAN_PCI=m
# CONFIG_CAN_M_CAN is not set
CONFIG_CAN_CC770=m
CONFIG_CAN_CC770_ISA=m
CONFIG_CAN_CC770_PLATFORM=m

#
# CAN SPI interfaces
#
# CONFIG_CAN_MCP251X is not set

#
# CAN USB interfaces
#
# CONFIG_CAN_EMS_USB is not set
CONFIG_CAN_ESD_USB2=m
CONFIG_CAN_GS_USB=m
CONFIG_CAN_KVASER_USB=m
CONFIG_CAN_PEAK_USB=y
CONFIG_CAN_8DEV_USB=m
CONFIG_CAN_SOFTING=m
# CONFIG_CAN_SOFTING_CS is not set
CONFIG_CAN_DEBUG_DEVICES=y
CONFIG_IRDA=y

#
# IrDA protocols
#
# CONFIG_IRLAN is not set
# CONFIG_IRDA_ULTRA is not set

#
# IrDA options
#
CONFIG_IRDA_CACHE_LAST_LSAP=y
CONFIG_IRDA_FAST_RR=y
CONFIG_IRDA_DEBUG=y

#
# Infrared-port device drivers
#

#
# SIR device drivers
#

#
# Dongle support
#
CONFIG_KINGSUN_DONGLE=y
CONFIG_KSDAZZLE_DONGLE=m
CONFIG_KS959_DONGLE=m

#
# FIR device drivers
#
CONFIG_USB_IRDA=m
# CONFIG_SIGMATEL_FIR is not set
CONFIG_VLSI_FIR=y
CONFIG_MCS_FIR=y
CONFIG_SH_IRDA=y
# CONFIG_BT is not set
# CONFIG_WIRELESS is not set
# CONFIG_WIMAX is not set
CONFIG_RFKILL=m
# CONFIG_RFKILL_INPUT is not set
CONFIG_RFKILL_REGULATOR=m
CONFIG_RFKILL_GPIO=m
CONFIG_NET_9P=y
# CONFIG_NET_9P_VIRTIO is not set
CONFIG_NET_9P_DEBUG=y
CONFIG_CAIF=y
# CONFIG_CAIF_DEBUG is not set
CONFIG_CAIF_NETDEV=m
CONFIG_CAIF_USB=m
CONFIG_NFC=m
# CONFIG_NFC_DIGITAL is not set
CONFIG_NFC_NCI=m
# CONFIG_NFC_NCI_SPI is not set
CONFIG_NFC_HCI=m
CONFIG_NFC_SHDLC=y

#
# Near Field Communication (NFC) devices
#
CONFIG_NFC_PN533=m
CONFIG_NFC_MEI_PHY=m
CONFIG_NFC_SIM=m
CONFIG_NFC_PN544=m
CONFIG_NFC_PN544_I2C=m
CONFIG_NFC_PN544_MEI=m
CONFIG_NFC_MICROREAD=m
# CONFIG_NFC_MICROREAD_I2C is not set
CONFIG_NFC_MICROREAD_MEI=m
CONFIG_NFC_MRVL=m
CONFIG_NFC_MRVL_USB=m
CONFIG_NFC_ST21NFCA=m
CONFIG_NFC_ST21NFCA_I2C=m
CONFIG_NFC_ST_NCI=m
# CONFIG_NFC_ST_NCI_I2C is not set
# CONFIG_NFC_ST_NCI_SPI is not set
CONFIG_NFC_NXP_NCI=m
# CONFIG_NFC_NXP_NCI_I2C is not set
CONFIG_NFC_S3FWRN5=m
CONFIG_NFC_S3FWRN5_I2C=m
CONFIG_LWTUNNEL=y
CONFIG_HAVE_BPF_JIT=y

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
CONFIG_STANDALONE=y
# CONFIG_PREVENT_FIRMWARE_BUILD is not set
CONFIG_FW_LOADER=y
CONFIG_FIRMWARE_IN_KERNEL=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
# CONFIG_ALLOW_DEV_COREDUMP is not set
CONFIG_DEBUG_DRIVER=y
CONFIG_DEBUG_DEVRES=y
# CONFIG_SYS_HYPERVISOR is not set
# CONFIG_GENERIC_CPU_DEVICES is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=m
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_SPMI=m
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
CONFIG_FENCE_TRACE=y
CONFIG_DMA_CMA=y

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=0
CONFIG_CMA_SIZE_SEL_MBYTES=y
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8

#
# Bus devices
#
CONFIG_SIMPLE_PM_BUS=y
CONFIG_CONNECTOR=y
# CONFIG_PROC_EVENTS is not set
# CONFIG_MTD is not set
CONFIG_OF=y
# CONFIG_OF_UNITTEST is not set
CONFIG_OF_DYNAMIC=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_ADDRESS_PCI=y
CONFIG_OF_IRQ=y
CONFIG_OF_PCI=y
CONFIG_OF_PCI_IRQ=y
CONFIG_OF_RESOLVE=y
CONFIG_OF_OVERLAY=y
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
CONFIG_PARPORT_PC_PCMCIA=m
# CONFIG_PARPORT_GSC is not set
CONFIG_PARPORT_AX88796=m
CONFIG_PARPORT_1284=y
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV_NVME=y

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
# CONFIG_AD525X_DPOT is not set
CONFIG_DUMMY_IRQ=y
CONFIG_IBM_ASM=m
# CONFIG_PHANTOM is not set
CONFIG_SGI_IOC4=m
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
CONFIG_ICS932S401=m
CONFIG_ATMEL_SSC=y
# CONFIG_ENCLOSURE_SERVICES is not set
CONFIG_HP_ILO=y
CONFIG_QCOM_COINCELL=m
CONFIG_APDS9802ALS=m
# CONFIG_ISL29003 is not set
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1780=m
CONFIG_SENSORS_BH1770=m
# CONFIG_SENSORS_APDS990X is not set
CONFIG_HMC6352=m
# CONFIG_DS1682 is not set
CONFIG_TI_DAC7512=y
CONFIG_BMP085=y
# CONFIG_BMP085_I2C is not set
CONFIG_BMP085_SPI=m
CONFIG_PCH_PHUB=y
CONFIG_USB_SWITCH_FSA9480=m
CONFIG_LATTICE_ECP3_CONFIG=m
CONFIG_SRAM=y
CONFIG_C2PORT=m
CONFIG_C2PORT_DURAMAR_2150=m

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
# CONFIG_EEPROM_AT25 is not set
# CONFIG_EEPROM_LEGACY is not set
CONFIG_EEPROM_MAX6875=m
# CONFIG_EEPROM_93CX6 is not set
CONFIG_EEPROM_93XX46=y
CONFIG_CB710_CORE=y
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_SENSORS_LIS3_I2C is not set

#
# Altera FPGA firmware download module
#
CONFIG_ALTERA_STAPL=m
CONFIG_INTEL_MEI=y
# CONFIG_INTEL_MEI_ME is not set
CONFIG_INTEL_MEI_TXE=y
CONFIG_VMWARE_VMCI=m

#
# Intel MIC Bus Driver
#
# CONFIG_INTEL_MIC_BUS is not set

#
# SCIF Bus Driver
#
# CONFIG_SCIF_BUS is not set

#
# Intel MIC Host Driver
#

#
# Intel MIC Card Driver
#

#
# SCIF Driver
#

#
# Intel MIC Coprocessor State Management (COSM) Drivers
#
CONFIG_GENWQE=m
CONFIG_GENWQE_PLATFORM_ERROR_RECOVERY=0
CONFIG_ECHO=y
# CONFIG_CXL_BASE is not set
# CONFIG_CXL_KERNEL_API is not set
# CONFIG_CXL_EEH is not set
CONFIG_HAVE_IDE=y

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
# CONFIG_SCSI_DMA is not set
# CONFIG_SCSI_NETLINK is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
# CONFIG_FIREWIRE_OHCI is not set
# CONFIG_FIREWIRE_NOSY is not set
CONFIG_MACINTOSH_DRIVERS=y
# CONFIG_NETDEVICES is not set
CONFIG_VHOST_NET=m
CONFIG_VHOST_RING=m
CONFIG_VHOST=m
CONFIG_VHOST_CROSS_ENDIAN_LEGACY=y

#
# Input device support
#
CONFIG_INPUT=y
# CONFIG_INPUT_LEDS is not set
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_POLLDEV=m
CONFIG_INPUT_SPARSEKMAP=y
CONFIG_INPUT_MATRIXKMAP=m

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=m
CONFIG_INPUT_EVBUG=m

#
# Input Device Drivers
#
# CONFIG_INPUT_KEYBOARD is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=m
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=m
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
CONFIG_SERIO_PCIPS2=m
CONFIG_SERIO_LIBPS2=m
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
# CONFIG_SERIO_ARC_PS2 is not set
CONFIG_SERIO_APBPS2=m
CONFIG_SERIO_OLPC_APSP=m
# CONFIG_SERIO_SUN4I_PS2 is not set
CONFIG_GAMEPORT=m
# CONFIG_GAMEPORT_NS558 is not set
CONFIG_GAMEPORT_L4=m
CONFIG_GAMEPORT_EMU10K1=m
CONFIG_GAMEPORT_FM801=m

#
# Character devices
#
# CONFIG_TTY is not set
# CONFIG_DEVMEM is not set
CONFIG_DEVKMEM=y
CONFIG_PRINTER=m
CONFIG_LP_CONSOLE=y
CONFIG_PPDEV=m
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_PANIC_EVENT=y
# CONFIG_IPMI_PANIC_STRING is not set
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
# CONFIG_IPMI_SI_PROBE_DEFAULTS is not set
# CONFIG_IPMI_SSIF is not set
CONFIG_IPMI_WATCHDOG=m
# CONFIG_IPMI_POWEROFF is not set
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=y
CONFIG_HW_RANDOM_AMD=y
CONFIG_HW_RANDOM_VIA=y
CONFIG_HW_RANDOM_VIRTIO=y
CONFIG_HW_RANDOM_TPM=m
CONFIG_NVRAM=m
# CONFIG_APPLICOM is not set

#
# PCMCIA character devices
#
CONFIG_CARDMAN_4000=m
CONFIG_CARDMAN_4040=m
# CONFIG_HPET is not set
# CONFIG_HANGCHECK_TIMER is not set
CONFIG_TCG_TPM=m
CONFIG_TCG_TIS=m
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
# CONFIG_TCG_TIS_I2C_NUVOTON is not set
# CONFIG_TCG_NSC is not set
# CONFIG_TCG_ATMEL is not set
# CONFIG_TCG_INFINEON is not set
CONFIG_TCG_CRB=m
CONFIG_TCG_TIS_ST33ZP24=m
CONFIG_TCG_TIS_ST33ZP24_I2C=m
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
# CONFIG_TELCLOCK is not set
CONFIG_DEVPORT=y
CONFIG_XILLYBUS=y
CONFIG_XILLYBUS_PCIE=m
# CONFIG_XILLYBUS_OF is not set

#
# I2C support
#
CONFIG_I2C=m
CONFIG_I2C_BOARDINFO=y
# CONFIG_I2C_COMPAT is not set
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_ARB_GPIO_CHALLENGE=m
# CONFIG_I2C_MUX_GPIO is not set
CONFIG_I2C_MUX_PCA9541=m
CONFIG_I2C_MUX_PCA954x=m
CONFIG_I2C_MUX_PINCTRL=m
CONFIG_I2C_MUX_REG=m
# CONFIG_I2C_HELPER_AUTO is not set
CONFIG_I2C_SMBUS=m

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_ALGOPCF=m
# CONFIG_I2C_ALGOPCA is not set

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
CONFIG_I2C_ALI1563=m
CONFIG_I2C_ALI15X3=m
CONFIG_I2C_AMD756=m
CONFIG_I2C_AMD756_S4882=m
CONFIG_I2C_AMD8111=m
CONFIG_I2C_HIX5HD2=m
CONFIG_I2C_I801=m
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
# CONFIG_I2C_PIIX4 is not set
CONFIG_I2C_NFORCE2=m
# CONFIG_I2C_NFORCE2_S4985 is not set
CONFIG_I2C_SIS5595=m
CONFIG_I2C_SIS630=m
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
# CONFIG_I2C_VIAPRO is not set

#
# ACPI drivers
#
# CONFIG_I2C_SCMI is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_AXXIA=m
CONFIG_I2C_BCM_IPROC=m
CONFIG_I2C_BRCMSTB=m
# CONFIG_I2C_CBUS_GPIO is not set
# CONFIG_I2C_DESIGNWARE_PLATFORM is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
CONFIG_I2C_EFM32=m
CONFIG_I2C_EG20T=m
CONFIG_I2C_EMEV2=m
CONFIG_I2C_GPIO=m
CONFIG_I2C_IMG=m
CONFIG_I2C_JZ4780=m
CONFIG_I2C_LPC2K=m
CONFIG_I2C_MT65XX=m
# CONFIG_I2C_OCORES is not set
# CONFIG_I2C_PCA_PLATFORM is not set
# CONFIG_I2C_PXA_PCI is not set
# CONFIG_I2C_RIIC is not set
# CONFIG_I2C_RK3X is not set
# CONFIG_I2C_SH_MOBILE is not set
# CONFIG_I2C_SIMTEC is not set
# CONFIG_I2C_SUN6I_P2WI is not set
CONFIG_I2C_XILINX=m
CONFIG_I2C_XLP9XX=m
CONFIG_I2C_RCAR=m

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=m
CONFIG_I2C_PARPORT=m
CONFIG_I2C_PARPORT_LIGHT=m
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
CONFIG_I2C_TINY_USB=m

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_CROS_EC_TUNNEL=m
# CONFIG_I2C_STUB is not set
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=m
# CONFIG_I2C_DEBUG_CORE is not set
CONFIG_I2C_DEBUG_ALGO=y
# CONFIG_I2C_DEBUG_BUS is not set
CONFIG_SPI=y
CONFIG_SPI_DEBUG=y
CONFIG_SPI_MASTER=y

#
# SPI Master Controller Drivers
#
CONFIG_SPI_ALTERA=y
CONFIG_SPI_ATMEL=m
CONFIG_SPI_BCM2835=m
CONFIG_SPI_BCM2835AUX=y
CONFIG_SPI_BCM63XX_HSSPI=m
CONFIG_SPI_BITBANG=y
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
CONFIG_SPI_CLPS711X=y
CONFIG_SPI_EP93XX=m
# CONFIG_SPI_GPIO is not set
CONFIG_SPI_IMG_SPFI=m
CONFIG_SPI_IMX=y
# CONFIG_SPI_LM70_LLP is not set
CONFIG_SPI_FSL_LIB=m
CONFIG_SPI_FSL_SPI=m
CONFIG_SPI_FSL_DSPI=m
CONFIG_SPI_MESON_SPIFC=y
CONFIG_SPI_MT65XX=m
CONFIG_SPI_OC_TINY=y
CONFIG_SPI_TI_QSPI=y
CONFIG_SPI_OMAP_100K=y
# CONFIG_SPI_ORION is not set
CONFIG_SPI_PXA2XX_DMA=y
CONFIG_SPI_PXA2XX=m
CONFIG_SPI_PXA2XX_PCI=m
CONFIG_SPI_RSPI=y
CONFIG_SPI_SC18IS602=m
CONFIG_SPI_SH_MSIOF=m
CONFIG_SPI_SH=y
CONFIG_SPI_SH_HSPI=y
# CONFIG_SPI_SUN4I is not set
CONFIG_SPI_SUN6I=m
CONFIG_SPI_TEGRA114=y
CONFIG_SPI_TEGRA20_SFLASH=y
# CONFIG_SPI_TEGRA20_SLINK is not set
CONFIG_SPI_TOPCLIFF_PCH=m
CONFIG_SPI_TXX9=m
# CONFIG_SPI_XCOMM is not set
CONFIG_SPI_XILINX=y
CONFIG_SPI_XLP=m
CONFIG_SPI_XTENSA_XTFPGA=m
CONFIG_SPI_ZYNQMP_GQSPI=y
CONFIG_SPI_DESIGNWARE=m
# CONFIG_SPI_DW_PCI is not set
CONFIG_SPI_DW_MMIO=m

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_TLE62X0 is not set
CONFIG_SPMI=m
# CONFIG_SPMI_MSM_PMIC_ARB is not set
CONFIG_HSI=y
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
CONFIG_HSI_CHAR=m

#
# PPS support
#
CONFIG_PPS=m
CONFIG_PPS_DEBUG=y
# CONFIG_NTP_PPS is not set

#
# PPS clients support
#
CONFIG_PPS_CLIENT_KTIMER=m
CONFIG_PPS_CLIENT_PARPORT=m
# CONFIG_PPS_CLIENT_GPIO is not set

#
# PPS generators support
#

#
# PTP clock support
#
# CONFIG_PTP_1588_CLOCK is not set

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# CONFIG_PTP_1588_CLOCK_PCH is not set
CONFIG_PINCTRL=y

#
# Pin controllers
#
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
CONFIG_DEBUG_PINCTRL=y
# CONFIG_PINCTRL_AMD is not set
CONFIG_PINCTRL_LPC18XX=y
# CONFIG_PINCTRL_SINGLE is not set
# CONFIG_PINCTRL_BCM281XX is not set
# CONFIG_PINCTRL_CYGNUS_MUX is not set
# CONFIG_PINCTRL_BAYTRAIL is not set
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_SUNRISEPOINT is not set
CONFIG_PINCTRL_MSM=y
CONFIG_PINCTRL_APQ8064=y
CONFIG_PINCTRL_APQ8084=m
CONFIG_PINCTRL_IPQ8064=y
CONFIG_PINCTRL_MSM8660=m
CONFIG_PINCTRL_MSM8960=m
CONFIG_PINCTRL_MSM8X74=y
# CONFIG_PINCTRL_MSM8916 is not set
CONFIG_PINCTRL_QDF2XXX=m
CONFIG_PINCTRL_QCOM_SPMI_PMIC=m
CONFIG_PINCTRL_QCOM_SSBI_PMIC=y
# CONFIG_PINCTRL_MT8135 is not set
# CONFIG_PINCTRL_MT8127 is not set
# CONFIG_PINCTRL_MT8173 is not set
# CONFIG_PINCTRL_MT6397 is not set
CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=y
CONFIG_GPIOLIB=y
CONFIG_GPIO_DEVRES=y
CONFIG_OF_GPIO=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
CONFIG_DEBUG_GPIO=y
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=y

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_74XX_MMIO=y
CONFIG_GPIO_ALTERA=y
CONFIG_GPIO_BCM_KONA=y
CONFIG_GPIO_BRCMSTB=m
CONFIG_GPIO_CLPS711X=m
CONFIG_GPIO_DWAPB=m
CONFIG_GPIO_ETRAXFS=y
CONFIG_GPIO_F7188X=y
CONFIG_GPIO_GENERIC_PLATFORM=y
# CONFIG_GPIO_GRGPIO is not set
CONFIG_GPIO_ICH=m
CONFIG_GPIO_IT87=m
# CONFIG_GPIO_LPC18XX is not set
CONFIG_GPIO_LYNXPOINT=y
# CONFIG_GPIO_RCAR is not set
CONFIG_GPIO_SCH=y
# CONFIG_GPIO_SCH311X is not set
CONFIG_GPIO_SYSCON=m
CONFIG_GPIO_TS5500=m
CONFIG_GPIO_VX855=y
# CONFIG_GPIO_XILINX is not set

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADP5588=m
CONFIG_GPIO_ADNP=m
# CONFIG_GPIO_MAX7300 is not set
CONFIG_GPIO_MAX732X=m
CONFIG_GPIO_PCA953X=m
# CONFIG_GPIO_PCF857X is not set

#
# MFD GPIO expanders
#
CONFIG_GPIO_ARIZONA=m
CONFIG_GPIO_JANZ_TTL=y
CONFIG_GPIO_WM831X=m

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
CONFIG_GPIO_BT8XX=m
CONFIG_GPIO_INTEL_MID=y
# CONFIG_GPIO_ML_IOH is not set
CONFIG_GPIO_PCH=m
CONFIG_GPIO_RDC321X=m
# CONFIG_GPIO_SODAVILLE is not set

#
# SPI GPIO expanders
#
CONFIG_GPIO_74X164=y
CONFIG_GPIO_MAX7301=y
# CONFIG_GPIO_MCP23S08 is not set
# CONFIG_GPIO_MC33880 is not set
CONFIG_GPIO_ZX=y

#
# USB GPIO expanders
#
CONFIG_W1=m
# CONFIG_W1_CON is not set

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
# CONFIG_W1_MASTER_DS2490 is not set
# CONFIG_W1_MASTER_DS2482 is not set
# CONFIG_W1_MASTER_MXC is not set
# CONFIG_W1_MASTER_DS1WM is not set
CONFIG_W1_MASTER_GPIO=m

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=m
CONFIG_W1_SLAVE_SMEM=m
CONFIG_W1_SLAVE_DS2408=m
CONFIG_W1_SLAVE_DS2408_READBACK=y
CONFIG_W1_SLAVE_DS2413=m
CONFIG_W1_SLAVE_DS2406=m
CONFIG_W1_SLAVE_DS2423=m
CONFIG_W1_SLAVE_DS2431=m
CONFIG_W1_SLAVE_DS2433=m
# CONFIG_W1_SLAVE_DS2433_CRC is not set
# CONFIG_W1_SLAVE_DS2760 is not set
CONFIG_W1_SLAVE_DS2780=m
CONFIG_W1_SLAVE_DS2781=m
CONFIG_W1_SLAVE_DS28E04=m
CONFIG_W1_SLAVE_BQ27000=m
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_PDA_POWER=m
# CONFIG_GENERIC_ADC_BATTERY is not set
# CONFIG_WM831X_BACKUP is not set
CONFIG_WM831X_POWER=m
CONFIG_TEST_POWER=m
CONFIG_BATTERY_DS2780=m
# CONFIG_BATTERY_DS2781 is not set
CONFIG_BATTERY_DS2782=m
# CONFIG_BATTERY_SBS is not set
CONFIG_BATTERY_BQ27XXX=m
CONFIG_BATTERY_BQ27XXX_I2C=y
CONFIG_BATTERY_BQ27XXX_PLATFORM=y
CONFIG_BATTERY_MAX17040=m
CONFIG_BATTERY_MAX17042=m
CONFIG_CHARGER_PCF50633=m
# CONFIG_CHARGER_ISP1704 is not set
CONFIG_CHARGER_MAX8903=m
CONFIG_CHARGER_LP8727=m
CONFIG_CHARGER_GPIO=m
# CONFIG_CHARGER_MANAGER is not set
CONFIG_CHARGER_QCOM_SMBB=m
# CONFIG_CHARGER_BQ2415X is not set
CONFIG_CHARGER_BQ24190=m
CONFIG_CHARGER_BQ24257=m
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ25890 is not set
CONFIG_CHARGER_SMB347=m
# CONFIG_CHARGER_TPS65217 is not set
CONFIG_BATTERY_GAUGE_LTC2941=m
CONFIG_BATTERY_GOLDFISH=y
CONFIG_CHARGER_RT9455=m
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_BRCMSTB is not set
CONFIG_POWER_RESET_GPIO=y
CONFIG_POWER_RESET_GPIO_RESTART=y
CONFIG_POWER_RESET_LTC2952=y
# CONFIG_POWER_RESET_RESTART is not set
# CONFIG_POWER_RESET_SYSCON is not set
# CONFIG_POWER_RESET_SYSCON_POWEROFF is not set
CONFIG_POWER_RESET_RMOBILE=y
# CONFIG_POWER_RESET_ZX is not set
CONFIG_POWER_AVS=y
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_AD7314=y
# CONFIG_SENSORS_AD7414 is not set
CONFIG_SENSORS_AD7418=m
# CONFIG_SENSORS_ADM1021 is not set
CONFIG_SENSORS_ADM1025=m
# CONFIG_SENSORS_ADM1026 is not set
# CONFIG_SENSORS_ADM1029 is not set
CONFIG_SENSORS_ADM1031=m
# CONFIG_SENSORS_ADM9240 is not set
CONFIG_SENSORS_ADT7X10=m
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
# CONFIG_SENSORS_ADT7470 is not set
# CONFIG_SENSORS_ADT7475 is not set
CONFIG_SENSORS_ASC7621=m
CONFIG_SENSORS_K8TEMP=m
# CONFIG_SENSORS_K10TEMP is not set
CONFIG_SENSORS_FAM15H_POWER=y
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
CONFIG_SENSORS_ATXP1=m
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DELL_SMM=y
# CONFIG_SENSORS_I5K_AMB is not set
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
# CONFIG_SENSORS_F75375S is not set
CONFIG_SENSORS_MC13783_ADC=m
CONFIG_SENSORS_FSCHMD=m
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
# CONFIG_SENSORS_G762 is not set
CONFIG_SENSORS_GPIO_FAN=m
CONFIG_SENSORS_HIH6130=m
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
CONFIG_SENSORS_IIO_HWMON=m
CONFIG_SENSORS_I5500=m
CONFIG_SENSORS_CORETEMP=y
# CONFIG_SENSORS_IT87 is not set
CONFIG_SENSORS_JC42=m
CONFIG_SENSORS_POWR1220=m
# CONFIG_SENSORS_LINEAGE is not set
# CONFIG_SENSORS_LTC2945 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
CONFIG_SENSORS_LTC4222=m
CONFIG_SENSORS_LTC4245=m
CONFIG_SENSORS_LTC4260=m
# CONFIG_SENSORS_LTC4261 is not set
CONFIG_SENSORS_MAX1111=y
# CONFIG_SENSORS_MAX16065 is not set
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=y
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6642=m
CONFIG_SENSORS_MAX6650=m
# CONFIG_SENSORS_MAX6697 is not set
# CONFIG_SENSORS_MAX31790 is not set
# CONFIG_SENSORS_HTU21 is not set
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=m
CONFIG_SENSORS_LM70=m
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
# CONFIG_SENSORS_LM83 is not set
CONFIG_SENSORS_LM85=m
# CONFIG_SENSORS_LM87 is not set
# CONFIG_SENSORS_LM90 is not set
CONFIG_SENSORS_LM92=m
# CONFIG_SENSORS_LM93 is not set
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
# CONFIG_SENSORS_PC87360 is not set
# CONFIG_SENSORS_PC87427 is not set
CONFIG_SENSORS_NTC_THERMISTOR=m
CONFIG_SENSORS_NCT6683=m
CONFIG_SENSORS_NCT6775=y
# CONFIG_SENSORS_NCT7802 is not set
CONFIG_SENSORS_NCT7904=m
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_LM25066 is not set
CONFIG_SENSORS_LTC2978=m
CONFIG_SENSORS_LTC2978_REGULATOR=y
# CONFIG_SENSORS_MAX16064 is not set
# CONFIG_SENSORS_MAX20751 is not set
# CONFIG_SENSORS_MAX34440 is not set
# CONFIG_SENSORS_MAX8688 is not set
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_UCD9000 is not set
CONFIG_SENSORS_UCD9200=m
CONFIG_SENSORS_ZL6100=m
CONFIG_SENSORS_PWM_FAN=m
# CONFIG_SENSORS_SHT15 is not set
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
# CONFIG_SENSORS_SMSC47M192 is not set
CONFIG_SENSORS_SMSC47B397=m
# CONFIG_SENSORS_SCH56XX_COMMON is not set
# CONFIG_SENSORS_SCH5627 is not set
# CONFIG_SENSORS_SCH5636 is not set
CONFIG_SENSORS_SMM665=m
CONFIG_SENSORS_ADC128D818=m
CONFIG_SENSORS_ADS1015=m
CONFIG_SENSORS_ADS7828=m
CONFIG_SENSORS_ADS7871=y
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
# CONFIG_SENSORS_INA2XX is not set
CONFIG_SENSORS_TC74=m
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
CONFIG_SENSORS_TMP103=m
# CONFIG_SENSORS_TMP401 is not set
# CONFIG_SENSORS_TMP421 is not set
CONFIG_SENSORS_VIA_CPUTEMP=y
CONFIG_SENSORS_VIA686A=y
# CONFIG_SENSORS_VT1211 is not set
CONFIG_SENSORS_VT8231=y
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
# CONFIG_SENSORS_W83795 is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=y
CONFIG_SENSORS_W83627EHF=y
# CONFIG_SENSORS_WM831X is not set

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
CONFIG_SENSORS_ATK0110=y
CONFIG_THERMAL=y
# CONFIG_THERMAL_HWMON is not set
# CONFIG_THERMAL_OF is not set
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
# CONFIG_THERMAL_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
CONFIG_CLOCK_THERMAL=y
# CONFIG_THERMAL_EMULATION is not set
# CONFIG_HISI_THERMAL is not set
CONFIG_SPEAR_THERMAL=y
CONFIG_ROCKCHIP_THERMAL=y
CONFIG_RCAR_THERMAL=m
CONFIG_KIRKWOOD_THERMAL=m
# CONFIG_DOVE_THERMAL is not set
CONFIG_ARMADA_THERMAL=y
CONFIG_INTEL_POWERCLAMP=m
CONFIG_INTEL_SOC_DTS_IOSF_CORE=y
CONFIG_INTEL_SOC_DTS_THERMAL=y
# CONFIG_INT340X_THERMAL is not set
CONFIG_INTEL_PCH_THERMAL=m

#
# Texas Instruments thermal drivers
#
CONFIG_TI_SOC_THERMAL=m
CONFIG_OMAP3_THERMAL=y
# CONFIG_OMAP4_THERMAL is not set
CONFIG_OMAP5_THERMAL=y
# CONFIG_DRA752_THERMAL is not set

#
# Samsung thermal drivers
#
# CONFIG_QCOM_SPMI_TEMP_ALARM is not set
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set

#
# Watchdog Device Drivers
#
# CONFIG_SOFT_WATCHDOG is not set
CONFIG_GPIO_WATCHDOG=y
# CONFIG_GPIO_WATCHDOG_ARCH_INITCALL is not set
CONFIG_WM831X_WATCHDOG=y
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_CADENCE_WATCHDOG is not set
CONFIG_DW_WATCHDOG=y
CONFIG_RN5T618_WATCHDOG=m
CONFIG_MAX63XX_WATCHDOG=y
CONFIG_TEGRA_WATCHDOG=m
# CONFIG_LPC18XX_WATCHDOG is not set
CONFIG_ACQUIRE_WDT=y
CONFIG_ADVANTECH_WDT=y
CONFIG_ALIM1535_WDT=m
# CONFIG_ALIM7101_WDT is not set
CONFIG_F71808E_WDT=y
CONFIG_SP5100_TCO=m
# CONFIG_SBC_FITPC2_WATCHDOG is not set
CONFIG_EUROTECH_WDT=y
CONFIG_IB700_WDT=m
# CONFIG_IBMASR is not set
CONFIG_WAFER_WDT=m
# CONFIG_I6300ESB_WDT is not set
# CONFIG_IE6XX_WDT is not set
CONFIG_ITCO_WDT=m
# CONFIG_ITCO_VENDOR_SUPPORT is not set
CONFIG_IT8712F_WDT=m
# CONFIG_IT87_WDT is not set
CONFIG_HP_WATCHDOG=m
CONFIG_HPWDT_NMI_DECODING=y
CONFIG_SC1200_WDT=m
CONFIG_PC87413_WDT=y
CONFIG_NV_TCO=m
CONFIG_60XX_WDT=m
# CONFIG_CPU5_WDT is not set
# CONFIG_SMSC_SCH311X_WDT is not set
# CONFIG_SMSC37B787_WDT is not set
CONFIG_VIA_WDT=y
# CONFIG_W83627HF_WDT is not set
# CONFIG_W83877F_WDT is not set
# CONFIG_W83977F_WDT is not set
CONFIG_MACHZ_WDT=m
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
CONFIG_IMGPDC_WDT=m
CONFIG_MEN_A21_WDT=m

#
# PCI-based Watchdog Cards
#
# CONFIG_PCIPCWATCHDOG is not set
CONFIG_WDTPCI=m

#
# USB-based Watchdog Cards
#
CONFIG_USBPCWATCHDOG=m
CONFIG_SSB_POSSIBLE=y

#
# Sonics Silicon Backplane
#
CONFIG_SSB=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
# CONFIG_SSB_PCIHOST is not set
CONFIG_SSB_SDIOHOST_POSSIBLE=y
CONFIG_SSB_SDIOHOST=y
CONFIG_SSB_SILENT=y
CONFIG_SSB_DRIVER_GPIO=y
CONFIG_BCMA_POSSIBLE=y

#
# Broadcom specific AMBA
#
CONFIG_BCMA=y
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
# CONFIG_BCMA_HOST_PCI is not set
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
# CONFIG_BCMA_DRIVER_GMAC_CMN is not set
CONFIG_BCMA_DRIVER_GPIO=y
CONFIG_BCMA_DEBUG=y

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_CS5535 is not set
CONFIG_MFD_ATMEL_FLEXCOM=y
CONFIG_MFD_ATMEL_HLCDC=m
CONFIG_MFD_BCM590XX=m
CONFIG_MFD_CROS_EC=m
CONFIG_MFD_CROS_EC_I2C=m
CONFIG_MFD_CROS_EC_SPI=m
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DLN2 is not set
CONFIG_MFD_MC13XXX=m
# CONFIG_MFD_MC13XXX_SPI is not set
CONFIG_MFD_MC13XXX_I2C=m
CONFIG_MFD_HI6421_PMIC=y
# CONFIG_HTC_PASIC3 is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=y
CONFIG_MFD_INTEL_LPSS=m
CONFIG_MFD_INTEL_LPSS_ACPI=m
CONFIG_MFD_INTEL_LPSS_PCI=m
CONFIG_MFD_JANZ_CMODIO=y
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
CONFIG_EZX_PCAP=y
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RETU is not set
CONFIG_MFD_PCF50633=m
CONFIG_PCF50633_ADC=m
CONFIG_PCF50633_GPIO=m
# CONFIG_UCB1400_CORE is not set
CONFIG_MFD_SPMI_PMIC=m
CONFIG_MFD_RDC321X=m
CONFIG_MFD_RTSX_PCI=m
CONFIG_MFD_RTSX_USB=m
CONFIG_MFD_RK808=m
CONFIG_MFD_RN5T618=m
# CONFIG_MFD_SI476X_CORE is not set
# CONFIG_MFD_SM501 is not set
# CONFIG_MFD_SKY81452 is not set
# CONFIG_ABX500_CORE is not set
# CONFIG_MFD_STMPE is not set
CONFIG_MFD_SYSCON=y
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
CONFIG_TPS6105X=m
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
CONFIG_MFD_TPS65217=m
CONFIG_MFD_TPS65218=m
# CONFIG_MFD_TPS65912 is not set
# CONFIG_MFD_TPS65912_SPI is not set
CONFIG_MFD_WL1273_CORE=m
CONFIG_MFD_LM3533=m
# CONFIG_MFD_TIMBERDALE is not set
# CONFIG_MFD_TMIO is not set
CONFIG_MFD_VX855=y
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=m
CONFIG_MFD_ARIZONA_SPI=y
CONFIG_MFD_WM5102=y
CONFIG_MFD_WM5110=y
CONFIG_MFD_WM8997=y
CONFIG_MFD_WM8998=y
CONFIG_MFD_WM831X=y
CONFIG_MFD_WM831X_SPI=y
# CONFIG_MFD_WM8994 is not set
CONFIG_REGULATOR=y
CONFIG_REGULATOR_DEBUG=y
CONFIG_REGULATOR_FIXED_VOLTAGE=m
# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
CONFIG_REGULATOR_USERSPACE_CONSUMER=m
# CONFIG_REGULATOR_ACT8865 is not set
CONFIG_REGULATOR_AD5398=m
CONFIG_REGULATOR_ANATOP=m
# CONFIG_REGULATOR_BCM590XX is not set
CONFIG_REGULATOR_DA9210=m
CONFIG_REGULATOR_DA9211=m
CONFIG_REGULATOR_FAN53555=m
CONFIG_REGULATOR_GPIO=m
CONFIG_REGULATOR_HI6421=y
CONFIG_REGULATOR_ISL9305=m
CONFIG_REGULATOR_ISL6271A=m
CONFIG_REGULATOR_LP3971=m
CONFIG_REGULATOR_LP3972=m
# CONFIG_REGULATOR_LP872X is not set
CONFIG_REGULATOR_LP8755=m
CONFIG_REGULATOR_LTC3589=m
CONFIG_REGULATOR_MAX1586=m
CONFIG_REGULATOR_MAX8649=m
CONFIG_REGULATOR_MAX8660=m
CONFIG_REGULATOR_MAX8952=m
# CONFIG_REGULATOR_MAX8973 is not set
# CONFIG_REGULATOR_MC13783 is not set
# CONFIG_REGULATOR_MC13892 is not set
CONFIG_REGULATOR_MT6311=m
# CONFIG_REGULATOR_PBIAS is not set
CONFIG_REGULATOR_PCAP=y
# CONFIG_REGULATOR_PCF50633 is not set
CONFIG_REGULATOR_PFUZE100=m
CONFIG_REGULATOR_QCOM_SPMI=y
CONFIG_REGULATOR_RK808=m
CONFIG_REGULATOR_RN5T618=m
CONFIG_REGULATOR_TPS51632=m
CONFIG_REGULATOR_TPS6105X=m
CONFIG_REGULATOR_TPS62360=m
CONFIG_REGULATOR_TPS65023=m
CONFIG_REGULATOR_TPS6507X=m
CONFIG_REGULATOR_TPS65217=m
CONFIG_REGULATOR_TPS65218=m
# CONFIG_REGULATOR_TPS6524X is not set
# CONFIG_REGULATOR_WM831X is not set
CONFIG_MEDIA_SUPPORT=m

#
# Multimedia core support
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
CONFIG_MEDIA_SDR_SUPPORT=y
# CONFIG_MEDIA_RC_SUPPORT is not set
CONFIG_MEDIA_CONTROLLER=y
CONFIG_VIDEO_DEV=m
# CONFIG_VIDEO_V4L2_SUBDEV_API is not set
CONFIG_VIDEO_V4L2=m
# CONFIG_VIDEO_ADV_DEBUG is not set
CONFIG_VIDEO_FIXED_MINOR_RANGES=y
CONFIG_VIDEO_TUNER=m
CONFIG_VIDEOBUF_GEN=m
CONFIG_VIDEOBUF_DMA_SG=m
CONFIG_VIDEOBUF_VMALLOC=m
CONFIG_VIDEOBUF_DVB=m
CONFIG_VIDEOBUF2_CORE=m
CONFIG_VIDEOBUF2_MEMOPS=m
CONFIG_VIDEOBUF2_DMA_CONTIG=m
CONFIG_VIDEOBUF2_VMALLOC=m
CONFIG_VIDEOBUF2_DMA_SG=m
CONFIG_VIDEOBUF2_DVB=m
CONFIG_DVB_CORE=m
CONFIG_TTPCI_EEPROM=m
CONFIG_DVB_MAX_ADAPTERS=8
# CONFIG_DVB_DYNAMIC_MINORS is not set

#
# Media drivers
#
CONFIG_MEDIA_USB_SUPPORT=y

#
# Webcam devices
#
CONFIG_USB_VIDEO_CLASS=m
CONFIG_USB_VIDEO_CLASS_INPUT_EVDEV=y
# CONFIG_USB_GSPCA is not set
CONFIG_USB_PWC=m
# CONFIG_USB_PWC_DEBUG is not set
CONFIG_USB_PWC_INPUT_EVDEV=y
CONFIG_VIDEO_CPIA2=m
CONFIG_USB_ZR364XX=m
CONFIG_USB_STKWEBCAM=m
CONFIG_USB_S2255=m
CONFIG_VIDEO_USBTV=m

#
# Analog TV USB devices
#
CONFIG_VIDEO_PVRUSB2=m
CONFIG_VIDEO_PVRUSB2_SYSFS=y
CONFIG_VIDEO_PVRUSB2_DVB=y
# CONFIG_VIDEO_PVRUSB2_DEBUGIFC is not set
CONFIG_VIDEO_HDPVR=m
CONFIG_VIDEO_USBVISION=m
CONFIG_VIDEO_STK1160_COMMON=m
# CONFIG_VIDEO_STK1160_AC97 is not set
CONFIG_VIDEO_STK1160=m
CONFIG_VIDEO_GO7007=m
CONFIG_VIDEO_GO7007_USB=m
CONFIG_VIDEO_GO7007_LOADER=m
CONFIG_VIDEO_GO7007_USB_S2250_BOARD=m

#
# Analog/digital TV USB devices
#
CONFIG_VIDEO_AU0828=m
CONFIG_VIDEO_AU0828_V4L2=y

#
# Digital TV USB devices
#
CONFIG_DVB_USB_V2=m
CONFIG_DVB_USB_AF9015=m
CONFIG_DVB_USB_AF9035=m
CONFIG_DVB_USB_ANYSEE=m
CONFIG_DVB_USB_AU6610=m
# CONFIG_DVB_USB_AZ6007 is not set
CONFIG_DVB_USB_CE6230=m
# CONFIG_DVB_USB_EC168 is not set
CONFIG_DVB_USB_GL861=m
CONFIG_DVB_USB_MXL111SF=m
CONFIG_DVB_USB_RTL28XXU=m
CONFIG_DVB_USB_DVBSKY=m
# CONFIG_DVB_TTUSB_BUDGET is not set
# CONFIG_DVB_TTUSB_DEC is not set
CONFIG_SMS_USB_DRV=m
# CONFIG_DVB_B2C2_FLEXCOP_USB is not set
CONFIG_DVB_AS102=m

#
# Webcam, TV (analog/digital) USB devices
#
CONFIG_VIDEO_EM28XX=m
CONFIG_VIDEO_EM28XX_V4L2=m
# CONFIG_VIDEO_EM28XX_ALSA is not set
# CONFIG_VIDEO_EM28XX_DVB is not set

#
# Software defined radio USB devices
#
# CONFIG_USB_AIRSPY is not set
CONFIG_USB_HACKRF=m
# CONFIG_USB_MSI2500 is not set
CONFIG_MEDIA_PCI_SUPPORT=y

#
# Media capture support
#
CONFIG_VIDEO_SOLO6X10=m
CONFIG_VIDEO_TW68=m
CONFIG_VIDEO_ZORAN=m
CONFIG_VIDEO_ZORAN_DC30=m
CONFIG_VIDEO_ZORAN_ZR36060=m
CONFIG_VIDEO_ZORAN_BUZ=m
# CONFIG_VIDEO_ZORAN_DC10 is not set
CONFIG_VIDEO_ZORAN_LML33=m
CONFIG_VIDEO_ZORAN_LML33R10=m
CONFIG_VIDEO_ZORAN_AVS6EYES=m

#
# Media capture/analog TV support
#
CONFIG_VIDEO_HEXIUM_GEMINI=m
CONFIG_VIDEO_HEXIUM_ORION=m
# CONFIG_VIDEO_MXB is not set
CONFIG_VIDEO_DT3155=m

#
# Media capture/analog/hybrid TV support
#
CONFIG_VIDEO_CX25821=m
# CONFIG_VIDEO_CX25821_ALSA is not set
CONFIG_VIDEO_SAA7134=m
# CONFIG_VIDEO_SAA7134_ALSA is not set
# CONFIG_VIDEO_SAA7134_DVB is not set
CONFIG_VIDEO_SAA7134_GO7007=m
CONFIG_VIDEO_SAA7164=m

#
# Media digital TV PCI Adapters
#
# CONFIG_DVB_AV7110 is not set
CONFIG_DVB_BUDGET_CORE=m
CONFIG_DVB_BUDGET=m
CONFIG_DVB_BUDGET_AV=m
CONFIG_DVB_B2C2_FLEXCOP_PCI=m
CONFIG_DVB_B2C2_FLEXCOP_PCI_DEBUG=y
CONFIG_DVB_PLUTO2=m
CONFIG_DVB_PT1=m
CONFIG_DVB_PT3=m
CONFIG_DVB_NGENE=m
# CONFIG_DVB_DDBRIDGE is not set
CONFIG_DVB_NETUP_UNIDVB=m
# CONFIG_V4L_PLATFORM_DRIVERS is not set
# CONFIG_V4L_MEM2MEM_DRIVERS is not set
# CONFIG_V4L_TEST_DRIVERS is not set
CONFIG_DVB_PLATFORM_DRIVERS=y
CONFIG_DVB_C8SECTPFE=m

#
# Supported MMC/SDIO adapters
#
# CONFIG_SMS_SDIO_DRV is not set
CONFIG_RADIO_ADAPTERS=y
CONFIG_RADIO_TEA575X=m
CONFIG_RADIO_SI470X=y
# CONFIG_USB_SI470X is not set
CONFIG_I2C_SI470X=m
CONFIG_RADIO_SI4713=m
CONFIG_USB_SI4713=m
# CONFIG_PLATFORM_SI4713 is not set
CONFIG_I2C_SI4713=m
CONFIG_USB_MR800=m
CONFIG_USB_DSBR=m
CONFIG_RADIO_MAXIRADIO=m
CONFIG_RADIO_SHARK=m
# CONFIG_RADIO_SHARK2 is not set
CONFIG_USB_KEENE=m
# CONFIG_USB_RAREMONO is not set
CONFIG_USB_MA901=m
# CONFIG_RADIO_TEA5764 is not set
# CONFIG_RADIO_SAA7706H is not set
# CONFIG_RADIO_TEF6862 is not set
CONFIG_RADIO_WL1273=m

#
# Texas Instruments WL128x FM driver (ST based)
#

#
# Supported FireWire (IEEE 1394) Adapters
#
CONFIG_DVB_FIREDTV=m
CONFIG_DVB_FIREDTV_INPUT=y
CONFIG_MEDIA_COMMON_OPTIONS=y

#
# common driver options
#
CONFIG_VIDEO_CX2341X=m
CONFIG_VIDEO_TVEEPROM=m
CONFIG_CYPRESS_FIRMWARE=m
CONFIG_DVB_B2C2_FLEXCOP=m
CONFIG_DVB_B2C2_FLEXCOP_DEBUG=y
CONFIG_VIDEO_SAA7146=m
CONFIG_VIDEO_SAA7146_VV=m
CONFIG_SMS_SIANO_MDTV=m

#
# Media ancillary drivers (tuners, sensors, i2c, frontends)
#
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y
CONFIG_MEDIA_ATTACH=y

#
# Encoders, decoders, sensors and other helper chips
#

#
# Audio decoders, processors and mixers
#
CONFIG_VIDEO_TVAUDIO=m
# CONFIG_VIDEO_TDA7432 is not set
CONFIG_VIDEO_TDA9840=m
CONFIG_VIDEO_TEA6415C=m
# CONFIG_VIDEO_TEA6420 is not set
CONFIG_VIDEO_MSP3400=m
CONFIG_VIDEO_CS5345=m
CONFIG_VIDEO_CS53L32A=m
# CONFIG_VIDEO_TLV320AIC23B is not set
CONFIG_VIDEO_UDA1342=m
CONFIG_VIDEO_WM8775=m
CONFIG_VIDEO_WM8739=m
# CONFIG_VIDEO_VP27SMPX is not set
CONFIG_VIDEO_SONY_BTF_MPX=m

#
# RDS decoders
#
CONFIG_VIDEO_SAA6588=m

#
# Video decoders
#
# CONFIG_VIDEO_ADV7183 is not set
CONFIG_VIDEO_BT819=m
CONFIG_VIDEO_BT856=m
CONFIG_VIDEO_BT866=m
CONFIG_VIDEO_KS0127=m
CONFIG_VIDEO_ML86V7667=m
# CONFIG_VIDEO_SAA7110 is not set
CONFIG_VIDEO_SAA711X=m
CONFIG_VIDEO_TVP514X=m
CONFIG_VIDEO_TVP5150=m
CONFIG_VIDEO_TVP7002=m
CONFIG_VIDEO_TW2804=m
CONFIG_VIDEO_TW9903=m
CONFIG_VIDEO_TW9906=m
CONFIG_VIDEO_VPX3220=m

#
# Video and audio decoders
#
CONFIG_VIDEO_SAA717X=m
CONFIG_VIDEO_CX25840=m

#
# Video encoders
#
CONFIG_VIDEO_SAA7127=m
CONFIG_VIDEO_SAA7185=m
CONFIG_VIDEO_ADV7170=m
CONFIG_VIDEO_ADV7175=m
CONFIG_VIDEO_ADV7343=m
# CONFIG_VIDEO_ADV7393 is not set
CONFIG_VIDEO_AK881X=m
# CONFIG_VIDEO_THS8200 is not set

#
# Camera sensor devices
#
# CONFIG_VIDEO_OV2659 is not set
CONFIG_VIDEO_OV7640=m
# CONFIG_VIDEO_OV7670 is not set
CONFIG_VIDEO_VS6624=m
CONFIG_VIDEO_MT9V011=m
CONFIG_VIDEO_SR030PC30=m

#
# Flash devices
#
CONFIG_VIDEO_ADP1653=m
# CONFIG_VIDEO_AS3645A is not set
CONFIG_VIDEO_LM3560=m
# CONFIG_VIDEO_LM3646 is not set

#
# Video improvement chips
#
# CONFIG_VIDEO_UPD64031A is not set
CONFIG_VIDEO_UPD64083=m

#
# Audio/Video compression chips
#
CONFIG_VIDEO_SAA6752HS=m

#
# Miscellaneous helper chips
#
CONFIG_VIDEO_THS7303=m
CONFIG_VIDEO_M52790=m

#
# Sensors used on soc_camera driver
#
CONFIG_MEDIA_TUNER=m

#
# Customize TV tuners
#
CONFIG_MEDIA_TUNER_SIMPLE=m
CONFIG_MEDIA_TUNER_TDA8290=m
CONFIG_MEDIA_TUNER_TDA827X=m
CONFIG_MEDIA_TUNER_TDA18271=m
CONFIG_MEDIA_TUNER_TDA9887=m
CONFIG_MEDIA_TUNER_TEA5761=m
CONFIG_MEDIA_TUNER_TEA5767=m
CONFIG_MEDIA_TUNER_MSI001=m
CONFIG_MEDIA_TUNER_MT20XX=m
CONFIG_MEDIA_TUNER_MT2060=m
# CONFIG_MEDIA_TUNER_MT2063 is not set
CONFIG_MEDIA_TUNER_MT2266=m
CONFIG_MEDIA_TUNER_MT2131=m
CONFIG_MEDIA_TUNER_QT1010=m
CONFIG_MEDIA_TUNER_XC2028=m
CONFIG_MEDIA_TUNER_XC5000=m
CONFIG_MEDIA_TUNER_XC4000=m
CONFIG_MEDIA_TUNER_MXL5005S=m
CONFIG_MEDIA_TUNER_MXL5007T=m
CONFIG_MEDIA_TUNER_MC44S803=m
CONFIG_MEDIA_TUNER_MAX2165=m
CONFIG_MEDIA_TUNER_TDA18218=m
CONFIG_MEDIA_TUNER_FC0011=m
CONFIG_MEDIA_TUNER_FC0012=m
CONFIG_MEDIA_TUNER_FC0013=m
CONFIG_MEDIA_TUNER_TDA18212=m
CONFIG_MEDIA_TUNER_E4000=m
CONFIG_MEDIA_TUNER_FC2580=m
CONFIG_MEDIA_TUNER_M88RS6000T=m
CONFIG_MEDIA_TUNER_TUA9001=m
CONFIG_MEDIA_TUNER_SI2157=m
CONFIG_MEDIA_TUNER_IT913X=m
CONFIG_MEDIA_TUNER_R820T=m
CONFIG_MEDIA_TUNER_MXL301RF=m
CONFIG_MEDIA_TUNER_QM1D1C0042=m

#
# Customise DVB Frontends
#

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_STB0899=m
CONFIG_DVB_STB6100=m
CONFIG_DVB_STV090x=m
CONFIG_DVB_STV6110x=m
CONFIG_DVB_M88DS3103=m

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=m
CONFIG_DVB_TDA18271C2DD=m
# CONFIG_DVB_SI2165 is not set

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24110=m
CONFIG_DVB_CX24123=m
CONFIG_DVB_MT312=m
# CONFIG_DVB_ZL10036 is not set
CONFIG_DVB_ZL10039=m
CONFIG_DVB_S5H1420=m
CONFIG_DVB_STV0288=m
CONFIG_DVB_STB6000=m
CONFIG_DVB_STV0299=m
CONFIG_DVB_STV6110=m
CONFIG_DVB_STV0900=m
CONFIG_DVB_TDA8083=m
CONFIG_DVB_TDA10086=m
CONFIG_DVB_TDA8261=m
CONFIG_DVB_VES1X93=m
CONFIG_DVB_TUNER_ITD1000=m
CONFIG_DVB_TUNER_CX24113=m
CONFIG_DVB_TDA826X=m
CONFIG_DVB_TUA6100=m
CONFIG_DVB_CX24116=m
CONFIG_DVB_CX24117=m
CONFIG_DVB_CX24120=m
CONFIG_DVB_SI21XX=m
CONFIG_DVB_TS2020=m
CONFIG_DVB_DS3000=m
CONFIG_DVB_MB86A16=m
CONFIG_DVB_TDA10071=m

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_SP8870=m
# CONFIG_DVB_SP887X is not set
# CONFIG_DVB_CX22700 is not set
# CONFIG_DVB_CX22702 is not set
# CONFIG_DVB_S5H1432 is not set
CONFIG_DVB_DRXD=m
CONFIG_DVB_L64781=m
CONFIG_DVB_TDA1004X=m
# CONFIG_DVB_NXT6000 is not set
CONFIG_DVB_MT352=m
CONFIG_DVB_ZL10353=m
CONFIG_DVB_DIB3000MB=m
CONFIG_DVB_DIB3000MC=m
CONFIG_DVB_DIB7000M=m
CONFIG_DVB_DIB7000P=m
CONFIG_DVB_DIB9000=m
CONFIG_DVB_TDA10048=m
CONFIG_DVB_AF9013=m
# CONFIG_DVB_EC100 is not set
CONFIG_DVB_HD29L2=m
CONFIG_DVB_STV0367=m
CONFIG_DVB_CXD2820R=m
CONFIG_DVB_CXD2841ER=m
CONFIG_DVB_RTL2830=m
CONFIG_DVB_RTL2832=m
CONFIG_DVB_RTL2832_SDR=m
CONFIG_DVB_SI2168=m
CONFIG_DVB_AS102_FE=m

#
# DVB-C (cable) frontends
#
CONFIG_DVB_VES1820=m
CONFIG_DVB_TDA10021=m
CONFIG_DVB_TDA10023=m
CONFIG_DVB_STV0297=m

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_NXT200X=m
CONFIG_DVB_OR51211=m
CONFIG_DVB_OR51132=m
CONFIG_DVB_BCM3510=m
CONFIG_DVB_LGDT330X=m
CONFIG_DVB_LGDT3305=m
CONFIG_DVB_LGDT3306A=m
CONFIG_DVB_LG2160=m
CONFIG_DVB_S5H1409=m
CONFIG_DVB_AU8522=m
CONFIG_DVB_AU8522_DTV=m
CONFIG_DVB_AU8522_V4L=m
CONFIG_DVB_S5H1411=m

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_S921=m
CONFIG_DVB_DIB8000=m
CONFIG_DVB_MB86A20S=m

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_TC90522=m

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=m
# CONFIG_DVB_TUNER_DIB0070 is not set
CONFIG_DVB_TUNER_DIB0090=m

#
# SEC control devices for DVB-S
#
# CONFIG_DVB_DRX39XYJ is not set
CONFIG_DVB_LNBH25=m
CONFIG_DVB_LNBP21=m
# CONFIG_DVB_LNBP22 is not set
# CONFIG_DVB_ISL6405 is not set
CONFIG_DVB_ISL6421=m
CONFIG_DVB_ISL6423=m
CONFIG_DVB_A8293=m
CONFIG_DVB_SP2=m
CONFIG_DVB_LGS8GL5=m
CONFIG_DVB_LGS8GXX=m
# CONFIG_DVB_ATBM8830 is not set
# CONFIG_DVB_TDA665x is not set
# CONFIG_DVB_IX2505V is not set
CONFIG_DVB_M88RS2000=m
CONFIG_DVB_AF9033=m
CONFIG_DVB_HORUS3A=m
CONFIG_DVB_ASCOT2E=m

#
# Tools to develop new frontends
#
CONFIG_DVB_DUMMY_FE=m

#
# Graphics support
#
CONFIG_AGP=y
CONFIG_AGP_AMD64=m
CONFIG_AGP_INTEL=y
CONFIG_AGP_SIS=y
# CONFIG_AGP_VIA is not set
CONFIG_INTEL_GTT=y
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
CONFIG_VGA_SWITCHEROO=y
# CONFIG_DRM is not set

#
# Frame buffer Devices
#
# CONFIG_FB is not set
CONFIG_BACKLIGHT_LCD_SUPPORT=y
# CONFIG_LCD_CLASS_DEVICE is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_GENERIC is not set
CONFIG_BACKLIGHT_LM3533=m
# CONFIG_BACKLIGHT_APPLE is not set
# CONFIG_BACKLIGHT_PM8941_WLED is not set
CONFIG_BACKLIGHT_SAHARA=y
# CONFIG_BACKLIGHT_WM831X is not set
CONFIG_BACKLIGHT_ADP8860=m
CONFIG_BACKLIGHT_ADP8870=m
CONFIG_BACKLIGHT_PCF50633=m
CONFIG_BACKLIGHT_LM3639=m
# CONFIG_BACKLIGHT_TPS65217 is not set
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_VGASTATE is not set
CONFIG_SOUND=m
CONFIG_SOUND_OSS_CORE=y
CONFIG_SOUND_OSS_CORE_PRECLAIM=y
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_HWDEP=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_SEQUENCER=m
# CONFIG_SND_SEQ_DUMMY is not set
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
# CONFIG_SND_PCM_OSS_PLUGINS is not set
# CONFIG_SND_SEQUENCER_OSS is not set
CONFIG_SND_HRTIMER=m
# CONFIG_SND_SEQ_HRTIMER_DEFAULT is not set
# CONFIG_SND_DYNAMIC_MINORS is not set
CONFIG_SND_SUPPORT_OLD_API=y
CONFIG_SND_PROC_FS=y
CONFIG_SND_VERBOSE_PROCFS=y
CONFIG_SND_VERBOSE_PRINTK=y
CONFIG_SND_DEBUG=y
# CONFIG_SND_DEBUG_VERBOSE is not set
# CONFIG_SND_PCM_XRUN_DEBUG is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_RAWMIDI_SEQ=m
# CONFIG_SND_OPL3_LIB_SEQ is not set
# CONFIG_SND_OPL4_LIB_SEQ is not set
# CONFIG_SND_SBAWE_SEQ is not set
# CONFIG_SND_EMU10K1_SEQ is not set
CONFIG_SND_VX_LIB=m
CONFIG_SND_AC97_CODEC=m
# CONFIG_SND_DRIVERS is not set
# CONFIG_SND_PCI is not set

#
# HD-Audio
#
CONFIG_SND_HDA_PREALLOC_SIZE=64
CONFIG_SND_SPI=y
# CONFIG_SND_AT73C213 is not set
# CONFIG_SND_USB is not set
CONFIG_SND_FIREWIRE=y
CONFIG_SND_FIREWIRE_LIB=m
# CONFIG_SND_DICE is not set
# CONFIG_SND_OXFW is not set
# CONFIG_SND_ISIGHT is not set
CONFIG_SND_SCS1X=m
# CONFIG_SND_FIREWORKS is not set
CONFIG_SND_BEBOB=m
CONFIG_SND_FIREWIRE_DIGI00X=m
# CONFIG_SND_FIREWIRE_TASCAM is not set
CONFIG_SND_PCMCIA=y
CONFIG_SND_VXPOCKET=m
CONFIG_SND_PDAUDIOCF=m
# CONFIG_SND_SOC is not set
# CONFIG_SOUND_PRIME is not set
CONFIG_AC97_BUS=m

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=y
# CONFIG_HID_GENERIC is not set

#
# Special HID drivers
#
# CONFIG_HID_A4TECH is not set
# CONFIG_HID_ACRUX is not set
# CONFIG_HID_APPLE is not set
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=y
CONFIG_HID_CHERRY=y
# CONFIG_HID_CHICONY is not set
CONFIG_HID_CORSAIR=m
CONFIG_HID_PRODIKEYS=m
CONFIG_HID_CYPRESS=y
# CONFIG_HID_DRAGONRISE is not set
CONFIG_HID_EMS_FF=m
CONFIG_HID_ELECOM=y
CONFIG_HID_EZKEY=y
CONFIG_HID_GEMBIRD=m
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
CONFIG_HID_WALTOP=m
# CONFIG_HID_GYRATION is not set
CONFIG_HID_ICADE=y
CONFIG_HID_TWINHAN=m
# CONFIG_HID_KENSINGTON is not set
CONFIG_HID_LCPOWER=y
# CONFIG_HID_LENOVO is not set
CONFIG_HID_LOGITECH=y
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=y
CONFIG_LOGITECH_FF=y
# CONFIG_LOGIRUMBLEPAD2_FF is not set
CONFIG_LOGIG940_FF=y
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
CONFIG_HID_MICROSOFT=y
CONFIG_HID_MONTEREY=m
CONFIG_HID_MULTITOUCH=m
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=y
CONFIG_PANTHERLORD_FF=y
CONFIG_HID_PETALYNX=y
# CONFIG_HID_PICOLCD is not set
# CONFIG_HID_PLANTRONICS is not set
CONFIG_HID_PRIMAX=y
CONFIG_HID_SAITEK=m
# CONFIG_HID_SAMSUNG is not set
CONFIG_HID_SPEEDLINK=m
# CONFIG_HID_STEELSERIES is not set
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=m
# CONFIG_HID_GREENASIA is not set
CONFIG_HID_SMARTJOYPLUS=y
CONFIG_SMARTJOYPLUS_FF=y
CONFIG_HID_TIVO=y
# CONFIG_HID_TOPSEED is not set
CONFIG_HID_THINGM=m
# CONFIG_HID_THRUSTMASTER is not set
# CONFIG_HID_WACOM is not set
CONFIG_HID_WIIMOTE=m
# CONFIG_HID_XINMO is not set
CONFIG_HID_ZEROPLUS=y
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=y
CONFIG_HID_SENSOR_HUB=m
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m

#
# USB HID support
#
# CONFIG_USB_HID is not set
# CONFIG_HID_PID is not set

#
# USB HID Boot Protocol drivers
#
CONFIG_USB_KBD=y
CONFIG_USB_MOUSE=m

#
# I2C HID support
#
CONFIG_I2C_HID=m
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_DYNAMIC_MINORS is not set
CONFIG_USB_OTG=y
# CONFIG_USB_OTG_WHITELIST is not set
CONFIG_USB_OTG_BLACKLIST_HUB=y
CONFIG_USB_OTG_FSM=m
# CONFIG_USB_ULPI_BUS is not set
CONFIG_USB_MON=y
CONFIG_USB_WUSB=m
# CONFIG_USB_WUSB_CBAF is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_C67X00_HCD=m
# CONFIG_USB_XHCI_HCD is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
CONFIG_USB_EHCI_HCD_PLATFORM=y
CONFIG_USB_OXU210HP_HCD=y
CONFIG_USB_ISP116X_HCD=y
CONFIG_USB_ISP1362_HCD=m
CONFIG_USB_FUSBH200_HCD=m
CONFIG_USB_FOTG210_HCD=y
CONFIG_USB_MAX3421_HCD=y
CONFIG_USB_OHCI_HCD=m
CONFIG_USB_OHCI_HCD_PCI=m
# CONFIG_USB_OHCI_HCD_SSB is not set
CONFIG_USB_OHCI_HCD_PLATFORM=m
# CONFIG_USB_UHCI_HCD is not set
CONFIG_USB_U132_HCD=y
CONFIG_USB_SL811_HCD=m
# CONFIG_USB_SL811_HCD_ISO is not set
CONFIG_USB_SL811_CS=m
CONFIG_USB_R8A66597_HCD=m
CONFIG_USB_WHCI_HCD=m
CONFIG_USB_HWA_HCD=m
# CONFIG_USB_HCD_BCMA is not set
CONFIG_USB_HCD_SSB=m
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
CONFIG_USB_PRINTER=y
CONFIG_USB_WDM=m
CONFIG_USB_TMC=y

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#

#
# USB Imaging devices
#
CONFIG_USB_MDC800=y
CONFIG_USBIP_CORE=y
# CONFIG_USBIP_VHCI_HCD is not set
CONFIG_USBIP_HOST=y
# CONFIG_USBIP_DEBUG is not set
CONFIG_USB_MUSB_HDRC=y
CONFIG_USB_MUSB_HOST=y

#
# Platform Glue Layer
#
CONFIG_USB_MUSB_DSPS=m
# CONFIG_USB_MUSB_UX500 is not set
CONFIG_USB_MUSB_AM335X_CHILD=m

#
# MUSB DMA mode
#
# CONFIG_MUSB_PIO_ONLY is not set
CONFIG_USB_DWC3=m
CONFIG_USB_DWC3_HOST=y

#
# Platform Glue Driver Support
#
CONFIG_USB_DWC3_OMAP=m
# CONFIG_USB_DWC3_EXYNOS is not set
CONFIG_USB_DWC3_PCI=m
CONFIG_USB_DWC3_KEYSTONE=m
# CONFIG_USB_DWC3_QCOM is not set
CONFIG_USB_DWC2=m
CONFIG_USB_DWC2_HOST=y

#
# Gadget/Dual-role mode requires USB Gadget support to be enabled
#
CONFIG_USB_DWC2_PCI=m
# CONFIG_USB_DWC2_DEBUG is not set
# CONFIG_USB_DWC2_TRACK_MISSED_SOFS is not set
# CONFIG_USB_CHIPIDEA is not set
CONFIG_USB_ISP1760=m
CONFIG_USB_ISP1760_HCD=y
CONFIG_USB_ISP1760_HOST_ROLE=y

#
# USB port drivers
#
CONFIG_USB_USS720=m

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=y
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
CONFIG_USB_SEVSEG=y
# CONFIG_USB_RIO500 is not set
CONFIG_USB_LEGOTOWER=y
CONFIG_USB_LCD=y
CONFIG_USB_LED=y
CONFIG_USB_CYPRESS_CY7C63=y
CONFIG_USB_CYTHERM=m
CONFIG_USB_IDMOUSE=m
CONFIG_USB_FTDI_ELAN=y
CONFIG_USB_APPLEDISPLAY=m
CONFIG_USB_SISUSBVGA=y
# CONFIG_USB_LD is not set
CONFIG_USB_TRANCEVIBRATOR=y
CONFIG_USB_IOWARRIOR=m
CONFIG_USB_TEST=m
CONFIG_USB_EHSET_TEST_FIXTURE=y
# CONFIG_USB_ISIGHTFW is not set
CONFIG_USB_YUREX=m
CONFIG_USB_EZUSB_FX2=y
# CONFIG_USB_HSIC_USB3503 is not set
CONFIG_USB_LINK_LAYER_TEST=y
CONFIG_USB_CHAOSKEY=y
# CONFIG_USB_ATM is not set

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
# CONFIG_KEYSTONE_USB_PHY is not set
CONFIG_NOP_USB_XCEIV=m
# CONFIG_AM335X_PHY_USB is not set
CONFIG_USB_GPIO_VBUS=m
# CONFIG_USB_ISP1301 is not set
# CONFIG_USB_MSM_OTG is not set
# CONFIG_USB_QCOM_8X16_PHY is not set
CONFIG_USB_RCAR_PHY=y
# CONFIG_USB_GADGET is not set
CONFIG_UWB=m
CONFIG_UWB_HWA=m
CONFIG_UWB_WHCI=m
CONFIG_UWB_I1480U=m
CONFIG_MMC=y
CONFIG_MMC_DEBUG=y

#
# MMC/SD/SDIO Card Drivers
#
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
CONFIG_MMC_SDHCI=y
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_PCI=y
# CONFIG_MMC_RICOH_MMC is not set
CONFIG_MMC_SDHCI_ACPI=y
CONFIG_MMC_SDHCI_PLTFM=y
CONFIG_MMC_SDHCI_OF_ARASAN=y
CONFIG_MMC_SDHCI_OF_AT91=m
CONFIG_MMC_SDHCI_PXAV3=m
# CONFIG_MMC_SDHCI_PXAV2 is not set
CONFIG_MMC_SDHCI_F_SDH30=y
# CONFIG_MMC_SDHCI_IPROC is not set
CONFIG_MMC_OMAP_HS=m
CONFIG_MMC_TIFM_SD=m
CONFIG_MMC_SPI=y
CONFIG_MMC_SDRICOH_CS=m
# CONFIG_MMC_CB710 is not set
CONFIG_MMC_VIA_SDMMC=m
CONFIG_MMC_DW=y
CONFIG_MMC_DW_IDMAC=y
CONFIG_MMC_DW_PLTFM=y
CONFIG_MMC_DW_EXYNOS=m
CONFIG_MMC_DW_K3=y
# CONFIG_MMC_DW_PCI is not set
CONFIG_MMC_VUB300=y
CONFIG_MMC_USHC=y
# CONFIG_MMC_USDHI6ROL0 is not set
CONFIG_MMC_REALTEK_PCI=m
CONFIG_MMC_REALTEK_USB=m
# CONFIG_MMC_TOSHIBA_PCI is not set
CONFIG_MMC_MTK=m
CONFIG_MEMSTICK=m
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set

#
# MemoryStick Host Controller Drivers
#
# CONFIG_MEMSTICK_TIFM_MS is not set
CONFIG_MEMSTICK_JMICRON_38X=m
# CONFIG_MEMSTICK_R592 is not set
CONFIG_MEMSTICK_REALTEK_PCI=m
CONFIG_MEMSTICK_REALTEK_USB=m
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=m
# CONFIG_LEDS_CLASS_FLASH is not set

#
# LED drivers
#
# CONFIG_LEDS_BCM6328 is not set
# CONFIG_LEDS_BCM6358 is not set
CONFIG_LEDS_LM3530=m
CONFIG_LEDS_LM3533=m
CONFIG_LEDS_LM3642=m
CONFIG_LEDS_PCA9532=m
# CONFIG_LEDS_PCA9532_GPIO is not set
CONFIG_LEDS_GPIO=m
CONFIG_LEDS_LP3944=m
CONFIG_LEDS_LP55XX_COMMON=m
CONFIG_LEDS_LP5521=m
CONFIG_LEDS_LP5523=m
# CONFIG_LEDS_LP5562 is not set
CONFIG_LEDS_LP8501=m
CONFIG_LEDS_LP8860=m
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
CONFIG_LEDS_WM831X_STATUS=m
CONFIG_LEDS_DAC124S085=m
# CONFIG_LEDS_REGULATOR is not set
# CONFIG_LEDS_BD2802 is not set
# CONFIG_LEDS_LT3593 is not set
CONFIG_LEDS_MC13783=m
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
CONFIG_LEDS_LM355x=m
CONFIG_LEDS_OT200=m

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
# CONFIG_LEDS_BLINKM is not set

#
# LED Triggers
#
# CONFIG_LEDS_TRIGGERS is not set
CONFIG_ACCESSIBILITY=y
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
# CONFIG_EDAC is not set
CONFIG_RTC_LIB=y
# CONFIG_RTC_CLASS is not set
CONFIG_DMADEVICES=y
CONFIG_DMADEVICES_DEBUG=y
CONFIG_DMADEVICES_VDEBUG=y

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
CONFIG_DMA_OF=y
CONFIG_AXI_DMAC=y
CONFIG_DMA_SUN6I=y
CONFIG_FSL_EDMA=m
CONFIG_IMG_MDC_DMA=y
CONFIG_INTEL_IDMA64=m
CONFIG_INTEL_IOATDMA=y
CONFIG_NBPFAXI_DMA=y
CONFIG_PCH_DMA=m
# CONFIG_XGENE_DMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=y
CONFIG_DW_DMAC_PCI=y
CONFIG_HSU_DMA=y
CONFIG_HSU_DMA_PCI=y
CONFIG_RENESAS_DMA=y
# CONFIG_SH_DMAE_BASE is not set
CONFIG_RCAR_DMAC=y
CONFIG_RENESAS_USB_DMAC=y

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
CONFIG_DMATEST=y
CONFIG_DMA_ENGINE_RAID=y
CONFIG_DCA=y
# CONFIG_AUXDISPLAY is not set
CONFIG_UIO=m
# CONFIG_UIO_CIF is not set
CONFIG_UIO_PDRV_GENIRQ=m
CONFIG_UIO_DMEM_GENIRQ=m
CONFIG_UIO_AEC=m
CONFIG_UIO_SERCOS3=m
CONFIG_UIO_PCI_GENERIC=m
CONFIG_UIO_NETX=m
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
CONFIG_VFIO_IOMMU_TYPE1=y
# CONFIG_VFIO_VIRQFD is not set
CONFIG_VFIO=y
# CONFIG_VFIO_PCI is not set
CONFIG_IRQ_BYPASS_MANAGER=y
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y

#
# Virtio drivers
#
CONFIG_VIRTIO_PCI=y
# CONFIG_VIRTIO_PCI_LEGACY is not set
# CONFIG_VIRTIO_BALLOON is not set
# CONFIG_VIRTIO_INPUT is not set
CONFIG_VIRTIO_MMIO=y
# CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_STAGING=y
# CONFIG_SLICOSS is not set
# CONFIG_COMEDI is not set
# CONFIG_PANEL is not set

#
# IIO staging drivers
#

#
# Accelerometers
#
CONFIG_ADIS16201=m
CONFIG_ADIS16203=m
CONFIG_ADIS16204=m
# CONFIG_ADIS16209 is not set
CONFIG_ADIS16220=m
CONFIG_ADIS16240=m
# CONFIG_LIS3L02DQ is not set
CONFIG_SCA3000=m

#
# Analog to digital converters
#
# CONFIG_AD7606 is not set
CONFIG_AD7780=m
CONFIG_AD7816=m
# CONFIG_AD7192 is not set
CONFIG_AD7280=m
CONFIG_LPC32XX_ADC=m
CONFIG_MXS_LRADC=m
CONFIG_SPEAR_ADC=m

#
# Analog digital bi-direction converters
#
CONFIG_ADT7316=m
CONFIG_ADT7316_SPI=m
CONFIG_ADT7316_I2C=m

#
# Capacitance to digital converters
#
CONFIG_AD7150=m
CONFIG_AD7152=m
CONFIG_AD7746=m

#
# Direct Digital Synthesis
#
CONFIG_AD9832=m
CONFIG_AD9834=m

#
# Digital gyroscope sensors
#
CONFIG_ADIS16060=m

#
# Network Analyzer, Impedance Converters
#
CONFIG_AD5933=m

#
# Light sensors
#
CONFIG_SENSORS_ISL29018=m
CONFIG_SENSORS_ISL29028=m
CONFIG_TSL2583=m
# CONFIG_TSL2x7x is not set

#
# Magnetometer sensors
#
CONFIG_SENSORS_HMC5843=m
# CONFIG_SENSORS_HMC5843_I2C is not set
CONFIG_SENSORS_HMC5843_SPI=m

#
# Active energy metering IC
#
CONFIG_ADE7753=m
# CONFIG_ADE7754 is not set
CONFIG_ADE7758=m
CONFIG_ADE7759=m
CONFIG_ADE7854=m
# CONFIG_ADE7854_I2C is not set
# CONFIG_ADE7854_SPI is not set

#
# Resolver to digital converters
#
CONFIG_AD2S90=m
CONFIG_AD2S1200=m
CONFIG_AD2S1210=m

#
# Triggers - standalone
#
# CONFIG_IIO_SIMPLE_DUMMY is not set
CONFIG_FT1000=y
CONFIG_FT1000_USB=y
CONFIG_FT1000_PCMCIA=m

#
# Speakup console speech
#
# CONFIG_TOUCHSCREEN_SYNAPTICS_I2C_RMI4 is not set
# CONFIG_STAGING_MEDIA is not set

#
# Android
#
CONFIG_STAGING_BOARD=y
CONFIG_WIMAX_GDM72XX=m
CONFIG_WIMAX_GDM72XX_QOS=y
CONFIG_WIMAX_GDM72XX_K_MODE=y
CONFIG_WIMAX_GDM72XX_WIMAX2=y
CONFIG_WIMAX_GDM72XX_USB=y
# CONFIG_WIMAX_GDM72XX_SDIO is not set
CONFIG_WIMAX_GDM72XX_USB_PM=y
CONFIG_GS_FPGABOOT=y
# CONFIG_CRYPTO_SKEIN is not set
CONFIG_UNISYSSPAR=y
# CONFIG_UNISYS_VISORBUS is not set
CONFIG_COMMON_CLK_XLNX_CLKWZRD=m
CONFIG_MOST=y
CONFIG_MOSTCORE=y
CONFIG_AIM_CDEV=y
CONFIG_AIM_NETWORK=y
# CONFIG_AIM_SOUND is not set
CONFIG_AIM_V4L2=m
CONFIG_HDM_DIM2=y
CONFIG_HDM_I2C=m
# CONFIG_HDM_USB is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACERHDF=m
CONFIG_ASUS_LAPTOP=m
CONFIG_DELL_SMO8800=y
CONFIG_DELL_RBTN=m
CONFIG_FUJITSU_LAPTOP=m
# CONFIG_FUJITSU_LAPTOP_DEBUG is not set
CONFIG_FUJITSU_TABLET=y
CONFIG_AMILO_RFKILL=m
CONFIG_HP_ACCEL=m
CONFIG_HP_WIRELESS=m
CONFIG_MSI_LAPTOP=m
CONFIG_PANASONIC_LAPTOP=y
CONFIG_COMPAL_LAPTOP=m
# CONFIG_SONY_LAPTOP is not set
# CONFIG_IDEAPAD_LAPTOP is not set
CONFIG_THINKPAD_ACPI=m
# CONFIG_THINKPAD_ACPI_ALSA_SUPPORT is not set
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
CONFIG_SENSORS_HDAPS=m
CONFIG_INTEL_MENLOW=m
# CONFIG_ACPI_WMI is not set
CONFIG_TOPSTAR_LAPTOP=y
CONFIG_TOSHIBA_BT_RFKILL=m
CONFIG_TOSHIBA_HAPS=m
# CONFIG_ACPI_CMPC is not set
CONFIG_INTEL_IPS=y
CONFIG_IBM_RTL=m
CONFIG_XO1_RFKILL=m
# CONFIG_XO15_EBOOK is not set
CONFIG_SAMSUNG_LAPTOP=m
# CONFIG_INTEL_OAKTRAIL is not set
CONFIG_SAMSUNG_Q10=y
CONFIG_APPLE_GMUX=m
CONFIG_INTEL_RST=m
CONFIG_INTEL_SMARTCONNECT=m
# CONFIG_PVPANIC is not set
CONFIG_INTEL_PMC_IPC=m
CONFIG_SURFACE_PRO3_BUTTON=m
CONFIG_CHROME_PLATFORMS=y
# CONFIG_CHROMEOS_PSTORE is not set
CONFIG_CROS_EC_CHARDEV=m
CONFIG_CROS_EC_LPC=m
CONFIG_CROS_EC_PROTO=y
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
# CONFIG_COMMON_CLK_WM831X is not set
CONFIG_COMMON_CLK_RK808=m
CONFIG_COMMON_CLK_SI5351=m
CONFIG_COMMON_CLK_SI514=m
CONFIG_COMMON_CLK_SI570=m
# CONFIG_COMMON_CLK_CDCE925 is not set
# CONFIG_COMMON_CLK_PXA is not set
CONFIG_COMMON_CLK_CDCE706=m
# CONFIG_COMMON_CLK_HI6220 is not set
CONFIG_QCOM_GDSC=y
CONFIG_COMMON_CLK_QCOM=m
CONFIG_APQ_GCC_8084=m
CONFIG_APQ_MMCC_8084=m
CONFIG_IPQ_GCC_806X=m
# CONFIG_IPQ_LCC_806X is not set
CONFIG_MSM_GCC_8660=m
# CONFIG_MSM_GCC_8916 is not set
CONFIG_MSM_GCC_8960=m
CONFIG_MSM_LCC_8960=m
# CONFIG_MSM_MMCC_8960 is not set
# CONFIG_MSM_GCC_8974 is not set
# CONFIG_MSM_MMCC_8974 is not set

#
# Hardware Spinlock drivers
#

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_CLKBLD_I8253=y
# CONFIG_ATMEL_PIT is not set
CONFIG_SH_TIMER_CMT=y
# CONFIG_SH_TIMER_MTU2 is not set
CONFIG_SH_TIMER_TMU=y
# CONFIG_EM_TIMER_STI is not set
# CONFIG_MAILBOX is not set
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# CONFIG_IOMMU_IO_PGTABLE_LPAE is not set
CONFIG_IOMMU_IOVA=y
CONFIG_OF_IOMMU=y
CONFIG_AMD_IOMMU=y
# CONFIG_AMD_IOMMU_STATS is not set
CONFIG_AMD_IOMMU_V2=y
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
CONFIG_INTEL_IOMMU_SVM=y
CONFIG_INTEL_IOMMU_DEFAULT_ON=y
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
CONFIG_IRQ_REMAP=y

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y
CONFIG_STE_MODEM_RPROC=y

#
# Rpmsg drivers
#

#
# SOC (System On Chip) specific Drivers
#
# CONFIG_MTK_INFRACFG is not set
# CONFIG_MTK_SCPSYS is not set
CONFIG_ROCKCHIP_PM_DOMAINS=y
# CONFIG_SUNXI_RSB is not set
# CONFIG_SUNXI_SRAM is not set
CONFIG_SOC_TI=y
CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
# CONFIG_DEVFREQ_GOV_PERFORMANCE is not set
CONFIG_DEVFREQ_GOV_POWERSAVE=m
CONFIG_DEVFREQ_GOV_USERSPACE=m

#
# DEVFREQ Drivers
#
CONFIG_PM_DEVFREQ_EVENT=y
CONFIG_EXTCON=m

#
# Extcon Device Drivers
#
# CONFIG_EXTCON_ADC_JACK is not set
CONFIG_EXTCON_GPIO=m
# CONFIG_EXTCON_RT8973A is not set
# CONFIG_EXTCON_SM5502 is not set
CONFIG_EXTCON_USB_GPIO=m
CONFIG_MEMORY=y
CONFIG_IIO=m
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=m
CONFIG_IIO_KFIFO_BUF=m
CONFIG_IIO_TRIGGERED_BUFFER=m
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
CONFIG_IIO_TRIGGERED_EVENT=m

#
# Accelerometers
#
CONFIG_BMA180=m
CONFIG_BMC150_ACCEL=m
# CONFIG_HID_SENSOR_ACCEL_3D is not set
CONFIG_IIO_ST_ACCEL_3AXIS=m
CONFIG_IIO_ST_ACCEL_I2C_3AXIS=m
CONFIG_IIO_ST_ACCEL_SPI_3AXIS=m
CONFIG_KXSD9=m
# CONFIG_KXCJK1013 is not set
CONFIG_MMA8452=m
CONFIG_MMA9551_CORE=m
CONFIG_MMA9551=m
CONFIG_MMA9553=m
# CONFIG_MXC4005 is not set
CONFIG_STK8312=m
# CONFIG_STK8BA50 is not set

#
# Analog to digital converters
#
CONFIG_AD_SIGMA_DELTA=m
CONFIG_AD7266=m
CONFIG_AD7291=m
CONFIG_AD7298=m
# CONFIG_AD7476 is not set
CONFIG_AD7791=m
CONFIG_AD7793=m
CONFIG_AD7887=m
# CONFIG_AD7923 is not set
CONFIG_AD799X=m
CONFIG_CC10001_ADC=m
# CONFIG_EXYNOS_ADC is not set
CONFIG_HI8435=m
# CONFIG_MAX1027 is not set
CONFIG_MAX1363=m
CONFIG_MCP320X=m
CONFIG_MCP3422=m
CONFIG_MEN_Z188_ADC=m
CONFIG_NAU7802=m
CONFIG_QCOM_SPMI_IADC=m
CONFIG_QCOM_SPMI_VADC=m
# CONFIG_TI_ADC081C is not set
# CONFIG_TI_ADC128S052 is not set
CONFIG_VF610_ADC=m
CONFIG_XILINX_XADC=m

#
# Amplifiers
#
CONFIG_AD8366=m

#
# Chemical Sensors
#
CONFIG_VZ89X=m

#
# Hid Sensor IIO Common
#
CONFIG_HID_SENSOR_IIO_COMMON=m
CONFIG_HID_SENSOR_IIO_TRIGGER=m

#
# SSP Sensor Common
#
# CONFIG_IIO_SSP_SENSORHUB is not set
CONFIG_IIO_ST_SENSORS_I2C=m
CONFIG_IIO_ST_SENSORS_SPI=m
CONFIG_IIO_ST_SENSORS_CORE=m

#
# Digital to analog converters
#
CONFIG_AD5064=m
CONFIG_AD5360=m
CONFIG_AD5380=m
CONFIG_AD5421=m
CONFIG_AD5446=m
CONFIG_AD5449=m
CONFIG_AD5504=m
CONFIG_AD5624R_SPI=m
# CONFIG_AD5686 is not set
CONFIG_AD5755=m
CONFIG_AD5764=m
CONFIG_AD5791=m
# CONFIG_AD7303 is not set
CONFIG_M62332=m
CONFIG_MAX517=m
# CONFIG_MAX5821 is not set
CONFIG_MCP4725=m
# CONFIG_MCP4922 is not set

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
# CONFIG_AD9523 is not set

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
CONFIG_ADF4350=m

#
# Digital gyroscope sensors
#
# CONFIG_ADIS16080 is not set
CONFIG_ADIS16130=m
CONFIG_ADIS16136=m
CONFIG_ADIS16260=m
CONFIG_ADXRS450=m
# CONFIG_BMG160 is not set
# CONFIG_HID_SENSOR_GYRO_3D is not set
CONFIG_IIO_ST_GYRO_3AXIS=m
CONFIG_IIO_ST_GYRO_I2C_3AXIS=m
CONFIG_IIO_ST_GYRO_SPI_3AXIS=m
CONFIG_ITG3200=m

#
# Humidity sensors
#
CONFIG_DHT11=m
CONFIG_HDC100X=m
CONFIG_SI7005=m
CONFIG_SI7020=m

#
# Inertial measurement units
#
CONFIG_ADIS16400=m
# CONFIG_ADIS16480 is not set
CONFIG_KMX61=m
# CONFIG_INV_MPU6050_IIO is not set
CONFIG_IIO_ADIS_LIB=m
CONFIG_IIO_ADIS_LIB_BUFFER=y

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
# CONFIG_ADJD_S311 is not set
# CONFIG_AL3320A is not set
CONFIG_APDS9300=m
CONFIG_APDS9960=m
CONFIG_BH1750=m
# CONFIG_CM32181 is not set
CONFIG_CM3232=m
# CONFIG_CM3323 is not set
CONFIG_CM36651=m
# CONFIG_GP2AP020A00F is not set
CONFIG_ISL29125=m
CONFIG_HID_SENSOR_ALS=m
# CONFIG_HID_SENSOR_PROX is not set
CONFIG_JSA1212=m
CONFIG_RPR0521=m
CONFIG_SENSORS_LM3533=m
CONFIG_LTR501=m
CONFIG_OPT3001=m
# CONFIG_PA12203001 is not set
CONFIG_STK3310=m
CONFIG_TCS3414=m
CONFIG_TCS3472=m
CONFIG_SENSORS_TSL2563=m
CONFIG_TSL4531=m
CONFIG_US5182D=m
# CONFIG_VCNL4000 is not set

#
# Magnetometer sensors
#
CONFIG_AK8975=m
CONFIG_AK09911=m
CONFIG_BMC150_MAGN=m
CONFIG_MAG3110=m
CONFIG_HID_SENSOR_MAGNETOMETER_3D=m
CONFIG_MMC35240=m
CONFIG_IIO_ST_MAGN_3AXIS=m
CONFIG_IIO_ST_MAGN_I2C_3AXIS=m
CONFIG_IIO_ST_MAGN_SPI_3AXIS=m

#
# Inclinometer sensors
#
CONFIG_HID_SENSOR_INCLINOMETER_3D=m
CONFIG_HID_SENSOR_DEVICE_ROTATION=m

#
# Triggers - standalone
#
# CONFIG_IIO_INTERRUPT_TRIGGER is not set
CONFIG_IIO_SYSFS_TRIGGER=m

#
# Pressure sensors
#
CONFIG_BMP280=m
# CONFIG_HID_SENSOR_PRESS is not set
# CONFIG_MPL115 is not set
CONFIG_MPL3115=m
# CONFIG_MS5611 is not set
CONFIG_IIO_ST_PRESS=m
CONFIG_IIO_ST_PRESS_I2C=m
CONFIG_IIO_ST_PRESS_SPI=m
CONFIG_T5403=m

#
# Lightning sensors
#
CONFIG_AS3935=m

#
# Proximity sensors
#
# CONFIG_LIDAR_LITE_V2 is not set
# CONFIG_SX9500 is not set

#
# Temperature sensors
#
CONFIG_MLX90614=m
# CONFIG_TMP006 is not set
# CONFIG_NTB is not set
# CONFIG_VME_BUS is not set
# CONFIG_PWM is not set
CONFIG_IRQCHIP=y
# CONFIG_IPACK_BUS is not set
CONFIG_RESET_CONTROLLER=y
# CONFIG_FMC is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_ARMADA375_USBCLUSTER_PHY=y
CONFIG_PHY_EXYNOS_MIPI_VIDEO=m
CONFIG_PHY_LPC18XX_USB_OTG=y
CONFIG_PHY_PXA_28NM_HSIC=m
# CONFIG_PHY_PXA_28NM_USB2 is not set
CONFIG_OMAP_CONTROL_PHY=y
CONFIG_PHY_EXYNOS_DP_VIDEO=m
CONFIG_BCM_KONA_USB2_PHY=y
CONFIG_PHY_SAMSUNG_USB2=m
# CONFIG_PHY_EXYNOS4210_USB2 is not set
# CONFIG_PHY_EXYNOS4X12_USB2 is not set
# CONFIG_PHY_EXYNOS5250_USB2 is not set
CONFIG_PHY_ST_SPEAR1310_MIPHY=y
CONFIG_PHY_ST_SPEAR1340_MIPHY=m
# CONFIG_PHY_XGENE is not set
CONFIG_PHY_STIH407_USB=y
CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL=y
CONFIG_MCB=y
CONFIG_MCB_PCI=m

#
# Performance monitor support
#
# CONFIG_RAS is not set
# CONFIG_THUNDERBOLT is not set

#
# Android
#
# CONFIG_ANDROID is not set
# CONFIG_NVMEM is not set
CONFIG_STM=m
CONFIG_STM_DUMMY=m
CONFIG_STM_SOURCE_CONSOLE=m
CONFIG_INTEL_TH=y
# CONFIG_INTEL_TH_PCI is not set
CONFIG_INTEL_TH_GTH=y
CONFIG_INTEL_TH_STH=m
CONFIG_INTEL_TH_MSU=y
CONFIG_INTEL_TH_PTI=m
# CONFIG_INTEL_TH_DEBUG is not set

#
# FPGA Configuration Support
#
CONFIG_FPGA=m

#
# Firmware Drivers
#
CONFIG_EDD=y
CONFIG_EDD_OFF=y
CONFIG_FIRMWARE_MEMMAP=y
# CONFIG_DELL_RBU is not set
# CONFIG_DCDBAS is not set
CONFIG_ISCSI_IBFT_FIND=y
CONFIG_GOOGLE_FIRMWARE=y

#
# Google Firmware Drivers
#

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_VARS=y
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
# CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE is not set
CONFIG_EFI_RUNTIME_MAP=y
CONFIG_EFI_RUNTIME_WRAPPERS=y
CONFIG_UEFI_CPER=y

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_FS_POSIX_ACL=y
# CONFIG_FILE_LOCKING is not set
# CONFIG_FSNOTIFY is not set
# CONFIG_DNOTIFY is not set
# CONFIG_INOTIFY_USER is not set
# CONFIG_FANOTIFY is not set
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
# CONFIG_PRINT_QUOTA_WARNING is not set
CONFIG_QUOTA_DEBUG=y
CONFIG_QUOTA_TREE=y
CONFIG_QFMT_V1=y
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=m
# CONFIG_FUSE_FS is not set
CONFIG_OVERLAY_FS=y

#
# Caches
#
# CONFIG_FSCACHE is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
# CONFIG_PROC_SYSCTL is not set
# CONFIG_PROC_PAGE_MONITOR is not set
CONFIG_PROC_CHILDREN=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=m
CONFIG_MISC_FILESYSTEMS=y
CONFIG_ORANGEFS_FS=m
# CONFIG_ECRYPT_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_CONSOLE=y
# CONFIG_PSTORE_PMSG is not set
CONFIG_PSTORE_FTRACE=y
# CONFIG_PSTORE_RAM is not set
# CONFIG_NETWORK_FILESYSTEMS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
# CONFIG_NLS_CODEPAGE_437 is not set
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=y
CONFIG_NLS_CODEPAGE_857=y
CONFIG_NLS_CODEPAGE_860=y
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
CONFIG_NLS_CODEPAGE_869=y
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=m
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
CONFIG_NLS_ISO8859_3=y
CONFIG_NLS_ISO8859_4=m
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
CONFIG_NLS_ISO8859_7=y
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
CONFIG_NLS_ISO8859_14=y
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=y
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_MAC_ROMAN is not set
# CONFIG_NLS_MAC_CELTIC is not set
CONFIG_NLS_MAC_CENTEURO=y
# CONFIG_NLS_MAC_CROATIAN is not set
CONFIG_NLS_MAC_CYRILLIC=y
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=y
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
# CONFIG_NLS_UTF8 is not set

#
# Kernel hacking
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y

#
# printk and dmesg options
#
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4

#
# Compile-time checks and compiler options
#
CONFIG_ENABLE_WARN_DEPRECATED=y
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
CONFIG_READABLE_ASM=y
CONFIG_UNUSED_SYMBOLS=y
CONFIG_PAGE_OWNER=y
CONFIG_DEBUG_FS=y
# CONFIG_HEADERS_CHECK is not set
# CONFIG_DEBUG_SECTION_MISMATCH is not set
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_ARCH_WANT_FRAME_POINTERS=y
CONFIG_FRAME_POINTER=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# CONFIG_MAGIC_SYSRQ is not set
CONFIG_DEBUG_KERNEL=y

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
CONFIG_DEBUG_PAGEALLOC=y
CONFIG_DEBUG_OBJECTS=y
CONFIG_DEBUG_OBJECTS_SELFTEST=y
CONFIG_DEBUG_OBJECTS_FREE=y
# CONFIG_DEBUG_OBJECTS_TIMERS is not set
CONFIG_DEBUG_OBJECTS_WORK=y
CONFIG_DEBUG_OBJECTS_RCU_HEAD=y
# CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER is not set
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=m
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_HAVE_ARCH_KMEMCHECK=y
CONFIG_DEBUG_SHIRQ=y

#
# Debug Lockups and Hangs
#
# CONFIG_LOCKUP_DETECTOR is not set
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=120
CONFIG_BOOTPARAM_HUNG_TASK_PANIC=y
CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=1
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
CONFIG_SCHED_STACK_END_CHECK=y
# CONFIG_DEBUG_TIMEKEEPING is not set
# CONFIG_TIMER_STATS is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
# CONFIG_DEBUG_RT_MUTEXES is not set
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_PROVE_LOCKING=y
CONFIG_LOCKDEP=y
CONFIG_LOCK_STAT=y
CONFIG_DEBUG_LOCKDEP=y
# CONFIG_DEBUG_ATOMIC_SLEEP is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=y
CONFIG_TRACE_IRQFLAGS=y
CONFIG_STACKTRACE=y
CONFIG_DEBUG_KOBJECT=y
# CONFIG_DEBUG_LIST is not set
# CONFIG_DEBUG_PI_LIST is not set
# CONFIG_DEBUG_SG is not set
CONFIG_DEBUG_NOTIFIERS=y
# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
# CONFIG_PROVE_RCU_REPEATEDLY is not set
CONFIG_SPARSE_RCU_POINTER=y
CONFIG_TORTURE_TEST=y
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_TRACE=y
CONFIG_RCU_EQS_DEBUG=y
CONFIG_NOTIFIER_ERROR_INJECTION=y
CONFIG_PM_NOTIFIER_ERROR_INJECT=y
# CONFIG_OF_RECONFIG_NOTIFIER_ERROR_INJECT is not set
# CONFIG_FAULT_INJECTION is not set
CONFIG_LATENCYTOP=y
CONFIG_ARCH_HAS_DEBUG_STRICT_USER_COPY_CHECKS=y
# CONFIG_DEBUG_STRICT_USER_COPY_CHECKS is not set
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_FP_TEST=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
CONFIG_IRQSOFF_TRACER=y
# CONFIG_SCHED_TRACER is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_PROFILE_ALL_BRANCHES is not set
CONFIG_STACK_TRACER=y
CONFIG_UPROBE_EVENT=y
CONFIG_PROBE_EVENTS=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_FUNCTION_PROFILER=y
CONFIG_FTRACE_MCOUNT_RECORD=y
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_MMIOTRACE is not set
CONFIG_TRACEPOINT_BENCHMARK=y
CONFIG_RING_BUFFER_BENCHMARK=y
CONFIG_RING_BUFFER_STARTUP_TEST=y
CONFIG_TRACE_ENUM_MAP_FILE=y

#
# Runtime Testing
#
CONFIG_TEST_LIST_SORT=y
CONFIG_BACKTRACE_SELF_TEST=m
CONFIG_RBTREE_TEST=y
CONFIG_INTERVAL_TREE_TEST=m
CONFIG_PERCPU_TEST=m
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_TEST_HEXDUMP is not set
CONFIG_TEST_STRING_HELPERS=m
CONFIG_TEST_KSTRTOX=y
CONFIG_TEST_PRINTF=y
CONFIG_TEST_RHASHTABLE=m
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
CONFIG_DMA_API_DEBUG=y
CONFIG_DMA_API_DEBUG_POISON=y
CONFIG_TEST_LKM=m
# CONFIG_TEST_USER_COPY is not set
# CONFIG_TEST_BPF is not set
CONFIG_TEST_FIRMWARE=y
CONFIG_TEST_UDELAY=m
CONFIG_MEMTEST=y
CONFIG_TEST_STATIC_KEYS=m
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
# CONFIG_STRICT_DEVMEM is not set
CONFIG_X86_VERBOSE_BOOTUP=y
# CONFIG_EARLY_PRINTK is not set
CONFIG_X86_PTDUMP_CORE=y
CONFIG_X86_PTDUMP=y
CONFIG_EFI_PGT_DUMP=y
# CONFIG_DEBUG_RODATA is not set
# CONFIG_DEBUG_SET_MODULE_RONX is not set
CONFIG_DEBUG_NX_TEST=m
CONFIG_DOUBLEFAULT=y
CONFIG_DEBUG_TLBFLUSH=y
CONFIG_IOMMU_STRESS=y
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_IO_DELAY_TYPE_0X80=0
CONFIG_IO_DELAY_TYPE_0XED=1
CONFIG_IO_DELAY_TYPE_UDELAY=2
CONFIG_IO_DELAY_TYPE_NONE=3
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEFAULT_IO_DELAY_TYPE=0
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
CONFIG_OPTIMIZE_INLINING=y
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
CONFIG_X86_DEBUG_STATIC_CPU_HAS=y
# CONFIG_X86_DEBUG_FPU is not set
CONFIG_PUNIT_ATOM_DEBUG=y

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_PERSISTENT_KEYRINGS is not set
CONFIG_TRUSTED_KEYS=m
CONFIG_ENCRYPTED_KEYS=m
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITYFS=y
CONFIG_INTEL_TXT=y
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_DEFAULT_SECURITY=""
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
# CONFIG_CRYPTO_FIPS is not set
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_BLKCIPHER=y
CONFIG_CRYPTO_BLKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_PCOMP=y
CONFIG_CRYPTO_PCOMP2=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=m
# CONFIG_CRYPTO_RSA is not set
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
# CONFIG_CRYPTO_MANAGER_DISABLE_TESTS is not set
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_WORKQUEUE=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_MCRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_ABLK_HELPER=y
CONFIG_CRYPTO_GLUE_HELPER_X86=y

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=m
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=m
CONFIG_CRYPTO_LRW=y
CONFIG_CRYPTO_PCBC=y
CONFIG_CRYPTO_XTS=y

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=y
CONFIG_CRYPTO_VMAC=m

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
# CONFIG_CRYPTO_CRC32C_INTEL is not set
# CONFIG_CRYPTO_CRC32 is not set
# CONFIG_CRYPTO_CRC32_PCLMUL is not set
# CONFIG_CRYPTO_CRCT10DIF is not set
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_POLY1305_X86_64=y
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=y
# CONFIG_CRYPTO_MICHAEL_MIC is not set
CONFIG_CRYPTO_RMD128=m
CONFIG_CRYPTO_RMD160=y
CONFIG_CRYPTO_RMD256=m
CONFIG_CRYPTO_RMD320=y
CONFIG_CRYPTO_SHA1=y
# CONFIG_CRYPTO_SHA1_SSSE3 is not set
# CONFIG_CRYPTO_SHA256_SSSE3 is not set
CONFIG_CRYPTO_SHA512_SSSE3=y
CONFIG_CRYPTO_SHA1_MB=m
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_TGR192=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=y

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_X86_64 is not set
# CONFIG_CRYPTO_AES_NI_INTEL is not set
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_ARC4=m
# CONFIG_CRYPTO_BLOWFISH is not set
CONFIG_CRYPTO_BLOWFISH_COMMON=y
CONFIG_CRYPTO_BLOWFISH_X86_64=y
CONFIG_CRYPTO_CAMELLIA=y
CONFIG_CRYPTO_CAMELLIA_X86_64=m
# CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64 is not set
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
CONFIG_CRYPTO_CAST5_AVX_X86_64=y
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_CAST6_AVX_X86_64=y
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_DES3_EDE_X86_64=m
CONFIG_CRYPTO_FCRYPT=m
# CONFIG_CRYPTO_KHAZAD is not set
CONFIG_CRYPTO_SALSA20=m
CONFIG_CRYPTO_SALSA20_X86_64=y
CONFIG_CRYPTO_CHACHA20=m
# CONFIG_CRYPTO_CHACHA20_X86_64 is not set
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=y
CONFIG_CRYPTO_SERPENT_AVX_X86_64=y
# CONFIG_CRYPTO_SERPENT_AVX2_X86_64 is not set
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_TWOFISH_COMMON=y
CONFIG_CRYPTO_TWOFISH_X86_64=y
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=y
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=y

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=m
CONFIG_CRYPTO_ZLIB=y
# CONFIG_CRYPTO_LZO is not set
CONFIG_CRYPTO_842=y
CONFIG_CRYPTO_LZ4=y
# CONFIG_CRYPTO_LZ4HC is not set

#
# Random Number Generation
#
# CONFIG_CRYPTO_ANSI_CPRNG is not set
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
# CONFIG_CRYPTO_DRBG_HASH is not set
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
CONFIG_CRYPTO_USER_API_RNG=m
CONFIG_CRYPTO_USER_API_AEAD=y
CONFIG_CRYPTO_HASH_INFO=y
CONFIG_CRYPTO_HW=y
# CONFIG_CRYPTO_DEV_PADLOCK is not set
CONFIG_CRYPTO_DEV_CCP=y
CONFIG_CRYPTO_DEV_CCP_DD=y
CONFIG_CRYPTO_DEV_CCP_CRYPTO=m
CONFIG_CRYPTO_DEV_QAT=m
# CONFIG_CRYPTO_DEV_QAT_DH895xCC is not set
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=m
CONFIG_CRYPTO_DEV_QCE=m
# CONFIG_CRYPTO_DEV_IMGTEC_HASH is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_PUBLIC_KEY_ALGO_RSA=y
CONFIG_X509_CERTIFICATE_PARSER=y
CONFIG_PKCS7_MESSAGE_PARSER=y
CONFIG_PKCS7_TEST_KEY=y
# CONFIG_SIGNED_PE_FILE_VERIFICATION is not set

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_APIC_ARCHITECTURE=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=y
# CONFIG_KVM_INTEL is not set
CONFIG_KVM_AMD=m
# CONFIG_KVM_MMU_AUDIT is not set
CONFIG_KVM_DEVICE_ASSIGNMENT=y
CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_BITREVERSE=y
# CONFIG_HAVE_ARCH_BITREVERSE is not set
CONFIG_RATIONAL=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_GENERIC_IO=y
CONFIG_STMP_DEVICE=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
# CONFIG_CRC_T10DIF is not set
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC7=y
CONFIG_LIBCRC32C=y
CONFIG_CRC8=m
# CONFIG_CRC64_ECMA is not set
# CONFIG_AUDIT_ARCH_COMPAT_GENERIC is not set
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_842_COMPRESS=y
CONFIG_842_DECOMPRESS=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_XZ_DEC=m
CONFIG_XZ_DEC_X86=y
# CONFIG_XZ_DEC_POWERPC is not set
# CONFIG_XZ_DEC_IA64 is not set
CONFIG_XZ_DEC_ARM=y
# CONFIG_XZ_DEC_ARMTHUMB is not set
# CONFIG_XZ_DEC_SPARC is not set
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_INTERVAL_TREE=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DQL=y
CONFIG_NLATTR=y
CONFIG_ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE=y
CONFIG_CLZ_TAB=y
CONFIG_CORDIC=m
CONFIG_DDR=y
CONFIG_MPILIB=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_FONT_SUPPORT=m
CONFIG_FONT_8x16=y
CONFIG_FONT_AUTOSELECT=y
# CONFIG_SG_SPLIT is not set
CONFIG_ARCH_HAS_SG_CHAIN=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_ARCH_HAS_MMIO_FLUSH=y
