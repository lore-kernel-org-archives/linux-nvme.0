Return-Path: <SRS0=z7iv=AZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99EBFC433E1
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jul 2020 23:31:30 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 644D62065E
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jul 2020 23:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XQyVlR9m";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CN5/5bdS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 644D62065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=o+hjOuCl4m1teXlsQa6LL9KVxTmQC+VUegzRYSIgt1M=; b=XQyVlR9m3Qm0y8+SJe+LsEanNu
	eo1VadYN4WwXMkm3bClzCFqqL/8fqNi7bgyqVcTokOthiP8XB9Fy8IhxxFBcLFj+/0BdigUlaJ1DO
	DXuPFiiqxMB+4BoA4TowWZC6Vwf3lRHpr5QV88nGrzCQ4eGVueRzDjOAjtKjVD+aI8/iNwUTLLRPJ
	AohFzgJ0+Nv0Z/3pfuxpNkHWpHrmaHVz0/fRPaXXECe0pymlpA3viG/CmVKCXObQ00QhjnJW1nFTZ
	kwzH9OKp55SVmGx0LBpxwZ0CbKeKxkVVwi/Us1maPFUVa24opAkWyWciY/tke8jl25fUZL8SH5CVh
	EfmfY+Ug==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jvUOR-0005JQ-KD; Tue, 14 Jul 2020 23:31:23 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jvUOO-0005IW-Gs
 for linux-nvme@lists.infradead.org; Tue, 14 Jul 2020 23:31:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1594769481; x=1626305481;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=wR2FQyAU/+FZnSG6DGPP2KHcI5q0t9dbIIOziTu0CDI=;
 b=CN5/5bdSsSPqUVwHb8/2VOIKb5RQw7DnCMQ70843pJWeA+/QQIs6xSON
 f18Xe0BTkagBVWu3DSFuxazl20L6YTISM6/WOsmeG7RfptIUMbzS33Aba
 Z7sB3/BOMQK4WAoz2kmTmDyC4lZTbxxN0p+kKI1tpHEazPOLTieMytv6u
 9j+q/qXrh5u3d0QsW6uWPrQSEKzJQlP9LvXB7ynFngAoBeLUMHWst6Gid
 o245PYhAz1xEz6re2t25XSVW5kgRD0fYEuMM4Fzw/Fdjnnr7Si9x8XVbs
 6uCITxgUTlwSfHfivZ3p/Ar04do/3vsdS2PGfqm4i1ga5XsgsBX6iabnz A==;
IronPort-SDR: XN9lB/VOFr9Vk5AiQJoSkTbuMsOqSbPe/nK2nVwGTPgq+sr0NLrHXdztgnUk+Yd81JlZZ55VIV
 gGmGwS4Tuqlj/CJzsYbeh4q6fLEDbL+XtjAiJ1ZoV3oEMfVspL8bNGAYomndA/3NJ4ivDCRMDB
 9nwQwmuFd3ViaH0ikA5Kp5lMDRcFDAkwgOnXQZ3e39qdFykpWLNym2/TbhmQpy5dJzCPbf/0LZ
 asA2l0812XhsRKvHma1JXUpWTd70JIyNrFveXYocIxdW3LRwqioOwX/X4dOSE+/IgCA74MeSR3
 Ro8=
X-IronPort-AV: E=Sophos;i="5.75,353,1589212800"; d="scan'208";a="142609475"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 15 Jul 2020 07:31:17 +0800
IronPort-SDR: 0O+D9I5J7g0EcvRnzyfxp+y9nG7wI0zwKqzz1GU8eOfxZlCYQd5dFMgUsf/91ZjXaOuIXvSlDn
 f/B7we3SzxZwiaRxPXBEd4I4985zHoQFc=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2020 16:19:42 -0700
IronPort-SDR: 82FfOYakjmrVPdEt0FCGAbkvxIzWysGQb3TH46h8sXsX4KiJRyJjm7nkXaj72PjsBlH0RL1woS
 hfUBR+0My1BA==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip02.wdc.com with ESMTP; 14 Jul 2020 16:31:16 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	willy@infradead.org
Subject: [PATCH V3 00/10] nvme: use xarray for ns tracking
Date: Tue, 14 Jul 2020 16:30:47 -0700
Message-Id: <20200714233057.10915-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200714_193120_782634_269BA00B 
X-CRM114-Status: GOOD (  16.95  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

This patch-series uses ctrl->namespaces with an xarray for host-core and
target-core. We can see following performance improvement when running
fio with 32 parallel jobs where first 16 namespaces and last 16
namespaces are used for I/O using NVMeOF (nvme-loop) backed by nulli blk
devices mapped 1:1 on target namespaces.

For host even though nvme_find_get_ns() doesn't fall into the fast path
yet it does for NVMeOF passthru. This prepares us to improve performance
for future NVMeOF passthru backend which is under review which uses the
similar data structure as target.

Following are the performance numbers with NVMeOF (nvme-loop) backed by
null_blk devices mapped 1:1 on NVMeOF target backend :-

Bandwidth ~16.4198% increase with XArray (higher the better) :-
-----------------------------------------------------------------------

default-1.fio.log:  read:  IOPS=820k,  BW=3204MiB/s  (3360MB/s)(188GiB/60002msec)
default-2.fio.log:  read:  IOPS=835k,  BW=3260MiB/s  (3418MB/s)(191GiB/60002msec)
default-3.fio.log:  read:  IOPS=834k,  BW=3257MiB/s  (3415MB/s)(191GiB/60001msec)
xarray-1.fio.log:   read:  IOPS=966k,  BW=3772MiB/s  (3955MB/s)(221GiB/60003msec)
xarray-2.fio.log:   read:  IOPS=966k,  BW=3775MiB/s  (3958MB/s)(221GiB/60002msec)
xarray-3.fio.log:   read:  IOPS=965k,  BW=3769MiB/s  (3952MB/s)(221GiB/60002msec)

Latency (submission) ~25% decrease with XArray (lower the better) :-
------------------------------------------------------------------------

default-1.fio.log:  slat  (usec):  min=8,  max=26066,  avg=25.18,  stdev=47.72
default-2.fio.log:  slat  (usec):  min=8,  max=907,    avg=20.24,  stdev=7.36
default-3.fio.log:  slat  (usec):  min=8,  max=723,    avg=20.21,  stdev=7.16
xarray-1.fio.log:   slat  (usec):  min=8,  max=639,    avg=14.84,  stdev=1.50
xarray-2.fio.log:   slat  (usec):  min=8,  max=840,    avg=14.84,  stdev=1.51
xarray-3.fio.log:   slat  (usec):  min=8,  max=2161,   avg=15.08,  stdev=9.56

CPU usage (system) ~12.2807% decrease with XArray (lower the better) :-
-----------------------------------------------------------------------

default-1.fio.log:  cpu  :  usr=3.92%,  sys=57.25%,  ctx=2159595,  majf=0,  minf=2807
default-2.fio.log:  cpu  :  usr=3.98%,  sys=57.99%,  ctx=1565139,  majf=0,  minf=2425
default-3.fio.log:  cpu  :  usr=3.99%,  sys=57.85%,  ctx=1563792,  majf=0,  minf=2977
xarray-1.fio.log:   cpu  :  usr=4.47%,  sys=50.88%,  ctx=1810927,  majf=0,  minf=2478
xarray-2.fio.log:   cpu  :  usr=4.47%,  sys=50.88%,  ctx=1812184,  majf=0,  minf=2176
xarray-3.fio.log:   cpu  :  usr=4.49%,  sys=50.86%,  ctx=1816963,  majf=0,  minf=2736

We did not hear anything on XArray bits, it will be great to have some feedback
from Matthew Willcox so we can atleast converge XArray part of this series.

I'm still doing more deeper testing but basic things seems to work with
performance numbers being consistent with couple of outstanding issues.
(using xa for ns remove instead of list_head and overall xa comments from
Matthew).

Regards,
Chaitanya

* Changes from V2:-
-------------------

1.  Add Xarray __xa_load() API as a preparation patch.
2.  Remove the id_ctrl call in nvme_dev_user_cmd().
3.  Remove the switch error check for xa_insert().
4.  Don't change the ns->kref code. when calling xa_erase().
5.  Keep XArray for deletion in the nvme_remove_invalid_namespaces()
    see [1].
6.  Keep XArray for deletion in the nvme_remove_namespaces() see [1].
7.  Remove randomly changed the lines to alingn the coding style in
    nvmet patch.
8.  Remove remaining #include nvme.h from the nvmet patch.
9.  Remove the xa_empty() from nvmet_max_nsid().
10. Centralize the blk-mq queue wrapper. The blk-mq queue related
    wrapper functions nvme_kill_queues(), nvme_unfreeze(),
    nvme_wait_freeze(), nvme_start_freeze(), nvme_stop_queues(),
    nvme_start_queues(), nvme_start_queues(), and nvme_sync_queues()
    differ in only one line i.e. blk_mq_queue_xxx() call. For the one
    line we have 7 functions and 7 exported symbols. Using a 
    centralize ctrl-queue action function and well defined enums
    represnting names of the helpers we can minimize the code and
    exported symbol and still maintain the redability.

* Change from V1:-
------------------

1. Use xarray instead of rcu locks.

[1] Keeping the Xarray for ns deletion in nvme_remove_namespaces() and
    nvme_remove_invalid_namepaces() :-

1.1. No impact on the fast patch :-

    The list_head is only needed for the deletion purpose which and has no
    impact on the fast path.

1.2 Effects on cacheline size :-

    Size of the struct nvme_ns without list head is 112 [1.3] which still
    has some room for future members so that we can fit members in 2
    cachelines before 3rd one is needed. With addition it becomes 128 i.e.
    for any new member we will need 3rd cacheline the test machine has 
    cacheline size == 64.

    # getconf LEVEL1_DCACHE_LINESIZE
    64

    Even though nvme_fine_get_ns() is not in the fast path yet with
    addtion of passthru it will be, also with any new field we will have
    to fetch one extra cache line.


[1.3] Without addition of the list_head size 112 :-

# dmesg  -c
[  737.953355] nvme_core_init 4601 sizeof(nvme_ns) 112 <---
# git diff
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a8c39254dae1..89c10cb7f6ef 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4598,6 +4598,7 @@ static int __init nvme_core_init(void)
 {
        int result = -ENOMEM;
 
+       pr_info("%s %d sizeof(nvme_ns) %lu\n", __func__, __LINE__, sizeof(struct nvme_ns));
        _nvme_check_size();
 
        nvme_wq = alloc_workqueue("nvme-wq",

[1.4] With addition of the list_head size becomes 128 :-

# dmesg  -c
[  772.513266] nvme_core_init 4601 sizeof(nvme_ns) 128 < ----
# git diff
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a8c39254dae1..89c10cb7f6ef 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4598,6 +4598,7 @@ static int __init nvme_core_init(void)
 {
        int result = -ENOMEM;
 
+       pr_info("%s %d sizeof(nvme_ns) %lu\n", __func__, __LINE__, sizeof(struct nvme_ns));
        _nvme_check_size();
 
        nvme_wq = alloc_workqueue("nvme-wq",
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 1e8dedee74df..2907f6fe0400 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -394,6 +394,7 @@ enum nvme_ns_features {
 };
 
 struct nvme_ns {
+       struct list_head list;
        struct nvme_ctrl *ctrl;
        struct request_queue *queue;
        struct gendisk *disk;

Chaitanya Kulkarni (10):
  xarray: add __xa_load() version
  nvme-core: use xarray for ctrl ns tracking
  nvme: centralize queue action nvme_kill_queues()
  nvme: centralize queue action nvme_unfreeze()
  nvme: centralize queue action nvme_wait_freeze()
  nvme: centralize queue action nvme_start_freeze()
  nvme: centralize queue action nvme_stop_queues()
  nvme: centralize queue action nvme_start_queues()
  nvme: centralize queue action nvme_sync_queues()
  nvmet: use xarray for ctrl ns storing

 drivers/nvme/host/core.c        | 291 ++++++++++++++------------------
 drivers/nvme/host/fc.c          |   4 +-
 drivers/nvme/host/multipath.c   |  15 +-
 drivers/nvme/host/nvme.h        |  23 +--
 drivers/nvme/host/pci.c         |  28 +--
 drivers/nvme/host/rdma.c        |   6 +-
 drivers/nvme/host/tcp.c         |   6 +-
 drivers/nvme/target/admin-cmd.c |  17 +-
 drivers/nvme/target/core.c      |  58 ++-----
 drivers/nvme/target/loop.c      |   2 +-
 drivers/nvme/target/nvmet.h     |   3 +-
 include/linux/xarray.h          |   1 +
 lib/xarray.c                    |  26 ++-
 13 files changed, 212 insertions(+), 268 deletions(-)

-- 
2.26.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
