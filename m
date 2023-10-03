Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C15F1E8FDAF
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Oct 2023 20:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Fe53uEuSqACXjrODiQDdyqGqmjJxJSLcyZiM/6zObR4=; b=adysa83po3cNjdHN/lPj7ZGX1v
	kfOQ8cgpaMOlm4S/xErl9IibO8gObUYJY8MfNz2Ffmhx0ys+1Nm0w1xHyEvD16tEhw3N7EuAWLNOq
	AxkqAT4X1y/1N6NrO1VeR5AruSmqS0rNKhh7a1psF656joL+2O7kutBW3xJng4wAFlnEPEvZJtjFy
	N6LdgjMCxQ05/KGI/ed1yiUDkuJXXfO5rmGVZON48S3wX+O63PxkMGPj10jKq8fDfQU1MMGAgvAHL
	41+GX+lWCJ3qlaB2duaivzh0AAKql6AlmVAAeG7PbTQeqRQtaXxsGizfgzo5rCfWxy9eiW9HVrOsZ
	GrZ9Z4gQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qnljm-00FEMy-1M;
	Tue, 03 Oct 2023 20:11:22 +0000
Received: from mail-qt1-x864.google.com ([2607:f8b0:4864:20::864])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qnljh-00FELs-08
	for linux-nvme@lists.infradead.org;
	Tue, 03 Oct 2023 20:11:19 +0000
Received: by mail-qt1-x864.google.com with SMTP id d75a77b69052e-419b232fc99so5164111cf.1
        for <linux-nvme@lists.infradead.org>; Tue, 03 Oct 2023 13:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1696363864; x=1696968664; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Fe53uEuSqACXjrODiQDdyqGqmjJxJSLcyZiM/6zObR4=;
        b=EOgZ+HF4sxav7Sqi646nP8GEs0RXnNVoQmJIhCyXMz0xydB5tNc8z0cA8BkolnMzag
         P6FvBTIOl8+4VpYesY9vpOLr7MfMIdnlYMfUNrcOF5GjD55H1Z5nGI50IkUKe8Dc97vG
         gIFBLJFbi4NcVo0Yv60Q5R2Bxb79Mlf/t35DqR7L8MrNIijw7/Y4stB7zqM4EEJ2wnsW
         zoiRzTEA6F0rwt+mCU2SZbsBTV6kNW5jfbuJWJN8KgXDXrg0VrCzTgJrCSY01wmqSEGc
         TztPmhvClbolgdhF/n8WkTQmWtiNcE7DP+PW3VBnzRZ/pn/BgdWiy6LIlRbkBdqIAYbS
         Mlwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696363864; x=1696968664;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fe53uEuSqACXjrODiQDdyqGqmjJxJSLcyZiM/6zObR4=;
        b=Bf71qvpJU0j+AMArAd+MZtBk7+ashzN7W1gBt4X+VlthtECIKhILLvmdNnclMnBfey
         uV1og9nRtzE9T9/0EM0nWkXUE4frpQaOIk9adC7NKn4anhypWlC1uKvJfaMXkkuNybVU
         ZQMd2UZWB9iP/73LXtODWEkQql/0hrlONJynuEzMQLXFeYKzyqIvPFZGM0Zlqi7jxMv0
         xw7wDyz4qj67BChywKkD2G2HlvK/oMgsc5YkECTyOCX5C3Fib/KFf6/0ptbAO/CrMoEJ
         Q0mE25Uq4fEUFnlgnFSA1zbU2kcKuJXagRLngHqKYKK0UjhtiqKGIgHE8hak2ccZ6F3T
         FZYQ==
X-Gm-Message-State: AOJu0YytX9FqSjiFS552Wi6oyZNYVtlWcCKi1jh/Z0MuR0g6Rr0pa1Cm
	ujt1rP4/LZE5xID33miBJ9zvYxhKneEFPScnlI/D58NBdosrYw==
X-Google-Smtp-Source: AGHT+IGfjoS3rPF1SEfSQUUjLLozL9fBUBxM+OH7ud3iaqqcJEBxihDVVXgdo59L1CmB39RP6FxaARFmVLDg
X-Received: by 2002:ac8:5754:0:b0:419:6391:6c07 with SMTP id 20-20020ac85754000000b0041963916c07mr500996qtx.28.1696363864079;
        Tue, 03 Oct 2023 13:11:04 -0700 (PDT)
Received: from c7-smtp.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id x22-20020ac85396000000b00417e0aafa74sm187792qtp.0.2023.10.03.13.11.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Oct 2023 13:11:04 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp.dev.purestorage.com (Postfix) with ESMTP id DA2E9220FA;
	Tue,  3 Oct 2023 14:11:02 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id D1228E40177; Tue,  3 Oct 2023 14:11:02 -0600 (MDT)
Date: Tue, 3 Oct 2023 14:11:02 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Ewan Milne <emilne@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	tsong@purestorage.com, jmeneghi@redhat.com, mlombard@redhat.com,
	Thomas Song <thomassong0721@gmail.com>,
	Randy Jennings <randyj@purestorage.com>,
	Prabhath Sajeepa <psajeepa@purestorage.com>
Subject: Re: [PATCH 1/3] block: introduce blk_queue_nr_active()
Message-ID: <ZRx1Vtz8A+5Bmo2f@dev-ushankar.dev.purestorage.com>
References: <20230925163123.16042-1-emilne@redhat.com>
 <20230925163123.16042-2-emilne@redhat.com>
 <c63ee412-3f34-49c7-b873-16b37683dc90@suse.de>
 <CAGtn9rmi33WNTibBRWWDJV98QzC1-wPVEdYObtVbi6DihmmCYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGtn9rmi33WNTibBRWWDJV98QzC1-wPVEdYObtVbi6DihmmCYQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231003_131117_188904_3B12E89C 
X-CRM114-Status: GOOD (  29.82  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Ewan,

> For NVMe/TCP, at least on the system I used that has 80 cores, there
> were only 1 hctxs

This sounds like a target limitation and/or an effect of the command
used to create the connection. The host driver will respect any limits
imposed by the target or the command creating the connection, but will
otherwise prefer to create one I/O queue per CPU (see nvmf_nr_io_queues,
nvme_set_queue_count, and nvme_fc_create_io_queues). This is the
suggested behavior from the spec as well (section 2.1):

> For example, on a four core processor based system, there may be a
> queue pair per core to avoid locking and ensure data structures are
> created in the appropriate processor core’s cache.

Targets aiming to provide high performance should thus allow for the
creation of more than one I/O queue. This is the case with the in-kernel
target (the default queue count limit is NVMET_NR_QUEUES, or 128) as
well as Pure's Flasharray.

Testing against such a target, the approach of looping through all hctxs
and summing the nr_active on every I/O comes with a very significant
latency hit. I used fio to run benchmarks (jobfile attached) and the
in-kernel NVMe-TCP target, whose generous limit of 128 allows the host
to create one queue per CPU, for 64 queues total. I used a kernel built
with two queue-depth path selectors (patch against Linux 6.5 attached) -
one is the one you posted, and the other is the atomics-based one that
Thomas wrote (with a small change so that path selectors not using the
atomic do not have to pay its cost). Here are the submission latency
statistics with the looping-over-hctx approach (the full fio output is
also attached):

    slat (usec): min=70, max=598, avg=78.35, stdev= 7.76

And with atomics:

    slat (usec): min=24, max=491, avg=32.51, stdev= 6.47

Note the ~46us difference in the average submission latency. I used
ftrace to measure the amount of time spent in the path selector
functions, and the results confirm that essentially all of this
additional latency is due to the path selector. For the hctx looping
approach:

# grep 'nvme_mpath_start_request' ftrace_queue-depth-hctx | grep us | tr -s ' ' | cut -d ' ' -f3 | jq -s add/length
0.20338877564886418
# grep 'nvme_mpath_end_request' ftrace_queue-depth-hctx | grep us | tr -s ' ' | cut -d ' ' -f3 | jq -s add/length
0.5282572360375025
# grep 'nvme_find_path' ftrace_queue-depth-hctx | grep us | tr -s ' ' | cut -d ' ' -f3 | jq -s add/length
46.14676273950285

vs atomics:

# grep 'nvme_mpath_start_request' ftrace_queue-depth-atomic | grep us | tr -s ' ' | cut -d ' ' -f3 | jq -s add/length
0.20764315633022504
# grep 'nvme_mpath_end_request' ftrace_queue-depth-atomic | grep us | tr -s ' ' | cut -d ' ' -f3 | jq -s add/length
0.5173406296446426
# grep 'nvme_find_path' ftrace_queue-depth-atomic | grep us | tr -s ' ' | cut -d ' ' -f3 | jq -s add/length
0.4562795568166467

I don't know if this is due to the "using xarray on 'small' arrays is
horrible for performance" that Hannes mentioned. Maybe reverting that
patch would help things, but I still prefer the atomics approach for its
simplicity and the fact that the data does not indicate that the two new
RMW ops per I/O are a source of issues. If the contention is still
considered a problem, we can "split" the atomic into pieces along:

- namespace boundaries, so that the atomic lives in struct nvme_ns
  instead of struct nvme_ctrl. if different CPUs are doing I/O to
  different namespaces (which may be a common access pattern), this will
  reduce the contention on the atomic. this would give us pretty much a
  1:1 translation of the queue-length path selector from dm.
- hctx boundaries - when we calculate the queue depth, instead of
  summing the depths for every path's hctxs, only consider the hctx
  associated to the local CPU.
- CPU boundaries - make the queue depth variable fully per-CPU. this
  should be equivalent to the previous approach in the case where the
  host can create one hctx per CPU.

Of course, all of these come with the disadvantage of sharing less
information about path quality. But that's what it boils down to -
sharing of rapidly-changing information between CPUs is expensive.

We can also consider "standard" optimizations around the atomic(s), like
ensuring each one gets its own cache line.

---

fio jobfile:

[global]
ioengine=libaio
randrepeat=1
direct=1
group_reporting
blocksize=512k
iodepth=1
numjobs=1
runtime=15
time_based
rw=randread

[JOB1]
cpus_allowed=1
filename=/dev/nvme4n1

full fio results with hctx-looping approach:

JOB1: (g=0): rw=randread, bs=(R) 512KiB-512KiB, (W) 512KiB-512KiB, (T) 512KiB-512KiB, ioengine=libaio, iodepth=1
fio-3.19
Starting 1 process

JOB1: (groupid=0, jobs=1): err= 0: pid=185197: Mon Oct  2 15:22:39 2023
  read: IOPS=490, BW=245MiB/s (257MB/s)(3680MiB/15001msec)
    slat (usec): min=70, max=598, avg=78.35, stdev= 7.76
    clat (usec): min=1662, max=2743, avg=1958.35, stdev=135.18
     lat (usec): min=1739, max=2901, avg=2036.92, stdev=135.45
    clat percentiles (usec):
     |  1.00th=[ 1729],  5.00th=[ 1778], 10.00th=[ 1811], 20.00th=[ 1844],
     | 30.00th=[ 1876], 40.00th=[ 1909], 50.00th=[ 1942], 60.00th=[ 1975],
     | 70.00th=[ 2008], 80.00th=[ 2057], 90.00th=[ 2147], 95.00th=[ 2212],
     | 99.00th=[ 2376], 99.50th=[ 2442], 99.90th=[ 2540], 99.95th=[ 2671],
     | 99.99th=[ 2737]
   bw (  KiB/s): min=248832, max=254976, per=100.00%, avg=251490.55, stdev=1468.84, samples=29
   iops        : min=  486, max=  498, avg=491.17, stdev= 2.90, samples=29
  lat (msec)   : 2=68.68%, 4=31.32%
  cpu          : usr=0.19%, sys=4.08%, ctx=7359, majf=0, minf=138
  IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=7359,0,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=1

Run status group 0 (all jobs):
   READ: bw=245MiB/s (257MB/s), 245MiB/s-245MiB/s (257MB/s-257MB/s), io=3680MiB (3858MB), run=15001-15001msec

Disk stats (read/write):
  nvme4n1: ios=7274/0, merge=0/0, ticks=14134/0, in_queue=14134, util=99.44%

full fio results with atomics approach:

JOB1: (g=0): rw=randread, bs=(R) 512KiB-512KiB, (W) 512KiB-512KiB, (T) 512KiB-512KiB, ioengine=libaio, iodepth=1
fio-3.19
Starting 1 process

JOB1: (groupid=0, jobs=1): err= 0: pid=185287: Mon Oct  2 15:23:03 2023
  read: IOPS=493, BW=247MiB/s (259MB/s)(3701MiB/15002msec)
    slat (usec): min=24, max=491, avg=32.51, stdev= 6.47
    clat (usec): min=1648, max=24772, avg=1992.77, stdev=329.21
     lat (usec): min=1679, max=24804, avg=2025.49, stdev=329.31
    clat percentiles (usec):
     |  1.00th=[ 1745],  5.00th=[ 1795], 10.00th=[ 1827], 20.00th=[ 1876],
     | 30.00th=[ 1909], 40.00th=[ 1942], 50.00th=[ 1975], 60.00th=[ 2008],
     | 70.00th=[ 2040], 80.00th=[ 2089], 90.00th=[ 2180], 95.00th=[ 2245],
     | 99.00th=[ 2409], 99.50th=[ 2474], 99.90th=[ 2606], 99.95th=[ 2868],
     | 99.99th=[24773]
   bw (  KiB/s): min=235520, max=260096, per=100.00%, avg=252927.10, stdev=4438.49, samples=29
   iops        : min=  460, max=  508, avg=493.97, stdev= 8.68, samples=29
  lat (msec)   : 2=60.26%, 4=39.70%, 10=0.01%, 20=0.01%, 50=0.01%
  cpu          : usr=0.15%, sys=1.91%, ctx=7401, majf=0, minf=139
  IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=7401,0,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=1

Run status group 0 (all jobs):
   READ: bw=247MiB/s (259MB/s), 247MiB/s-247MiB/s (259MB/s-259MB/s), io=3701MiB (3880MB), run=15002-15002msec

Disk stats (read/write):
  nvme4n1: ios=7316/0, merge=0/0, ticks=14470/0, in_queue=14470, util=99.24%

patch against Linux 6.5 used for testing. this needs polish and is buggy
when the iopolicy changes while I/O is outstanding, but I avoided
hitting the bug during experiments by not doing I/O while changing the
iopolicy:

diff --git a/block/blk-mq.h b/block/blk-mq.h
index 1743857e0b01..fbc65eefa017 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -214,11 +214,6 @@ static inline bool blk_mq_tag_is_reserved(struct blk_mq_tags *tags,
 	return tag < tags->nr_reserved_tags;
 }
 
-static inline bool blk_mq_is_shared_tags(unsigned int flags)
-{
-	return flags & BLK_MQ_F_TAG_HCTX_SHARED;
-}
-
 static inline struct blk_mq_tags *blk_mq_tags_from_data(struct blk_mq_alloc_data *data)
 {
 	if (data->rq_flags & RQF_SCHED_TAGS)
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 0a88d7bdc5e3..f71aa1e6f537 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -17,6 +17,8 @@ MODULE_PARM_DESC(multipath,
 static const char *nvme_iopolicy_names[] = {
 	[NVME_IOPOLICY_NUMA]	= "numa",
 	[NVME_IOPOLICY_RR]	= "round-robin",
+	[NVME_IOPOLICY_QD_ATOMIC]      = "queue-depth-atomic",
+	[NVME_IOPOLICY_QD_EWAN] = "queue-depth-ewan",
 };
 
 static int iopolicy = NVME_IOPOLICY_NUMA;
@@ -29,6 +31,10 @@ static int nvme_set_iopolicy(const char *val, const struct kernel_param *kp)
 		iopolicy = NVME_IOPOLICY_NUMA;
 	else if (!strncmp(val, "round-robin", 11))
 		iopolicy = NVME_IOPOLICY_RR;
+	else if (!strncmp(val, "queue-depth-atomic", 18))
+		iopolicy = NVME_IOPOLICY_QD_ATOMIC;
+	else if (!strncmp(val, "queue-depth-ewan", 16))
+		iopolicy = NVME_IOPOLICY_QD_EWAN;
 	else
 		return -EINVAL;
 
@@ -126,6 +132,11 @@ void nvme_mpath_start_request(struct request *rq)
 {
 	struct nvme_ns *ns = rq->q->queuedata;
 	struct gendisk *disk = ns->head->disk;
+	struct nvme_subsystem *subsys = ns->ctrl->subsys;
+
+	if (READ_ONCE(subsys->iopolicy) == NVME_IOPOLICY_QD_ATOMIC) {
+                atomic_inc(&ns->ctrl->nr_active);
+        }
 
 	if (!blk_queue_io_stat(disk->queue) || blk_rq_is_passthrough(rq))
 		return;
@@ -139,9 +150,15 @@ EXPORT_SYMBOL_GPL(nvme_mpath_start_request);
 void nvme_mpath_end_request(struct request *rq)
 {
 	struct nvme_ns *ns = rq->q->queuedata;
+	struct nvme_subsystem *subsys = ns->ctrl->subsys;
+
+	if (READ_ONCE(subsys->iopolicy) == NVME_IOPOLICY_QD_ATOMIC) {
+                atomic_dec(&ns->ctrl->nr_active);
+        }
 
 	if (!(nvme_req(rq)->flags & NVME_MPATH_IO_STATS))
 		return;
+
 	bdev_end_io_acct(ns->head->disk->part0, req_op(rq),
 			 blk_rq_bytes(rq) >> SECTOR_SHIFT,
 			 nvme_req(rq)->start_time);
@@ -329,13 +346,69 @@ static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head,
 	return found;
 }
 
+static struct nvme_ns *nvme_queue_depth_atomic_path(struct nvme_ns_head *head)
+{
+	struct nvme_ns *best_opt = NULL, *best_nonopt = NULL, *ns;
+	unsigned int min_depth_opt = UINT_MAX, min_depth_nonopt = UINT_MAX;
+	unsigned int depth;
+
+	list_for_each_entry_rcu(ns, &head->list, siblings) {
+		if (nvme_path_is_disabled(ns))
+			continue;
+
+		depth = atomic_read(&ns->ctrl->nr_active);
+
+		if (ns->ana_state == NVME_ANA_OPTIMIZED &&
+		    depth < min_depth_opt) {
+			min_depth_opt = depth;
+			best_opt = ns;
+		}
+
+		if (ns->ana_state == NVME_ANA_NONOPTIMIZED &&
+		    depth < min_depth_nonopt) {
+			min_depth_nonopt = depth;
+			best_nonopt = ns;
+		}
+	}
+
+	return best_opt ? best_opt : best_nonopt;
+}
+
+static struct nvme_ns *nvme_queue_depth_ewan_path(struct nvme_ns_head *head)
+{
+	struct nvme_ns *best_opt = NULL, *best_nonopt = NULL, *ns;
+	unsigned int min_depth_opt = UINT_MAX, min_depth_nonopt = UINT_MAX;
+	unsigned int depth;
+
+	list_for_each_entry_rcu(ns, &head->list, siblings) {
+		if (nvme_path_is_disabled(ns))
+			continue;
+
+		depth = blk_mq_queue_nr_active(ns->queue);
+
+		if (ns->ana_state == NVME_ANA_OPTIMIZED &&
+		    depth < min_depth_opt) {
+			min_depth_opt = depth;
+			best_opt = ns;
+		}
+
+		if (ns->ana_state == NVME_ANA_NONOPTIMIZED &&
+		    depth < min_depth_nonopt) {
+			min_depth_nonopt = depth;
+			best_nonopt = ns;
+		}
+	}
+
+	return best_opt ? best_opt : best_nonopt;
+}
+
 static inline bool nvme_path_is_optimized(struct nvme_ns *ns)
 {
 	return ns->ctrl->state == NVME_CTRL_LIVE &&
 		ns->ana_state == NVME_ANA_OPTIMIZED;
 }
 
-inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
+noinline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
 {
 	int node = numa_node_id();
 	struct nvme_ns *ns;
@@ -346,6 +419,11 @@ inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
 
 	if (READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_RR)
 		return nvme_round_robin_path(head, node, ns);
+	else if (READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_QD_ATOMIC)
+		return nvme_queue_depth_atomic_path(head);
+	else if (READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_QD_EWAN)
+		return nvme_queue_depth_ewan_path(head);
+
 	if (unlikely(!nvme_path_is_optimized(ns)))
 		return __nvme_find_path(head, node);
 	return ns;
@@ -900,6 +978,7 @@ void nvme_mpath_remove_disk(struct nvme_ns_head *head)
 
 void nvme_mpath_init_ctrl(struct nvme_ctrl *ctrl)
 {
+	atomic_set(&ctrl->nr_active, 0);
 	mutex_init(&ctrl->ana_lock);
 	timer_setup(&ctrl->anatt_timer, nvme_anatt_timeout, 0);
 	INIT_WORK(&ctrl->ana_work, nvme_ana_work);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index f35647c470af..a2e5d09d697d 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -342,6 +342,7 @@ struct nvme_ctrl {
 	u8 anatt;
 	u32 anagrpmax;
 	u32 nanagrpid;
+	atomic_t nr_active;
 	struct mutex ana_lock;
 	struct nvme_ana_rsp_hdr *ana_log_buf;
 	size_t ana_log_size;
@@ -389,6 +390,8 @@ struct nvme_ctrl {
 enum nvme_iopolicy {
 	NVME_IOPOLICY_NUMA,
 	NVME_IOPOLICY_RR,
+	NVME_IOPOLICY_QD_ATOMIC,
+	NVME_IOPOLICY_QD_EWAN,
 };
 
 struct nvme_subsystem {
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 495ca198775f..a7a32a1fd16c 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -718,6 +718,33 @@ int blk_rq_poll(struct request *rq, struct io_comp_batch *iob,
 
 bool blk_mq_queue_inflight(struct request_queue *q);
 
+#define queue_for_each_hw_ctx(q, hctx, i)				\
+	xa_for_each(&(q)->hctx_table, (i), (hctx))
+
+#define hctx_for_each_ctx(hctx, ctx, i)					\
+	for ((i) = 0; (i) < (hctx)->nr_ctx &&				\
+	     ({ ctx = (hctx)->ctxs[(i)]; 1; }); (i)++)
+
+static inline bool blk_mq_is_shared_tags(unsigned int flags)
+{
+	return flags & BLK_MQ_F_TAG_HCTX_SHARED;
+}
+
+static inline unsigned int blk_mq_queue_nr_active(struct request_queue *q)
+{
+	unsigned int nr_active = 0;
+	struct blk_mq_hw_ctx *hctx;
+	unsigned long i;
+
+	queue_for_each_hw_ctx(q, hctx, i) {
+		if (unlikely(blk_mq_is_shared_tags(hctx->flags)))
+			return atomic_read(&q->nr_active_requests_shared_tags);
+		nr_active += atomic_read(&hctx->nr_active);
+	}
+	return nr_active;
+}
+
+
 enum {
 	/* return when out of requests */
 	BLK_MQ_REQ_NOWAIT	= (__force blk_mq_req_flags_t)(1 << 0),
@@ -943,13 +970,6 @@ static inline void *blk_mq_rq_to_pdu(struct request *rq)
 	return rq + 1;
 }
 
-#define queue_for_each_hw_ctx(q, hctx, i)				\
-	xa_for_each(&(q)->hctx_table, (i), (hctx))
-
-#define hctx_for_each_ctx(hctx, ctx, i)					\
-	for ((i) = 0; (i) < (hctx)->nr_ctx &&				\
-	     ({ ctx = (hctx)->ctxs[(i)]; 1; }); (i)++)
-
 static inline void blk_mq_cleanup_rq(struct request *rq)
 {
 	if (rq->q->mq_ops->cleanup_rq)


