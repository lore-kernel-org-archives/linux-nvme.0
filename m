Return-Path: <SRS0=CGXy=BV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C0ACC433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Aug 2020 03:33:10 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F37D1206DA
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Aug 2020 03:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="x+PVcKHp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F37D1206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=gz2bCf1dFgKcxlqrxQCsprx/Rkxowvpmm/jaXcL8+4M=; b=x+PVcKHp5ay6UO1+nvtZ5aGFR
	lLQbytSb6cdtsD++9L9exNUP9NELFEC5vkNRe0Svnq9XJRnwgnM/lY3dG7xW2Ol2HWMx/z5msFSGT
	DFzYynxxCqZS1Okc30VXxnqE1flacpTdkjZLaCXLCRGRxg30BCnYIF9phejK3IaLmP1Z1tj1BbjJW
	E1em6OBaRhhpYf34IZqqBBZRjWMKLWzeAN7G+ruvJP3sx91B61qBxBTHdFQVBjgy0Hcqf83EukCiq
	nvrW5pYZ1RvuJ/l9XYKfXZqmDDvAtVtv9DPfg0aTUtaCbH1lQUaxw/4CEj3WdaMk+boD2p0YQ4rez
	APffQHSnQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5L27-0006Hw-CF; Tue, 11 Aug 2020 03:33:03 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5L1m-00066H-NF
 for linux-nvme@lists.infradead.org; Tue, 11 Aug 2020 03:32:51 +0000
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 7CA587322A8E57DF8351;
 Tue, 11 Aug 2020 11:32:35 +0800 (CST)
Received: from [10.169.42.93] (10.169.42.93) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0;
 Tue, 11 Aug 2020 11:32:32 +0800
Subject: Re: [PATCH] nvme: explicitly use normal NVMe error handling when
 appropriate
To: Mike Snitzer <snitzer@redhat.com>, Sagi Grimberg <sagi@grimberg.me>
References: <729820BC-5F38-4E22-A83A-862E57BAE201@netapp.com>
 <E3390A8E-D582-47BA-A085-21663D883365@netapp.com>
 <20200806184057.GA27858@redhat.com> <20200806191943.GA27868@redhat.com>
 <6B826235-C504-4621-B8F7-34475B200979@netapp.com>
 <20200807000755.GA28957@redhat.com>
 <510f5aff-0437-b1ce-f7ab-c812edbea880@grimberg.me>
 <20200807045015.GA29737@redhat.com>
 <fec745aa-0091-ee1f-cb0f-da9e18cf0aa2@grimberg.me>
 <20200810143620.GA19127@redhat.com> <20200810172209.GA19535@redhat.com>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <7f99724a-a1eb-6bec-f8ae-f9a4601b0487@huawei.com>
Date: Tue, 11 Aug 2020 11:32:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200810172209.GA19535@redhat.com>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200810_233250_238780_7E33D96F 
X-CRM114-Status: GOOD (  34.19  )
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
Cc: Hannes Reinecke <hare@suse.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@infradead.org>, dm-devel@redhat.com,
 Ewan Milne <emilne@redhat.com>, Keith Busch <kbusch@kernel.org>, "Meneghini,
 John" <John.Meneghini@netapp.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2020/8/11 1:22, Mike Snitzer wrote:
> On Mon, Aug 10 2020 at 10:36am -0400,
> Mike Snitzer <snitzer@redhat.com> wrote:
> 
>> On Fri, Aug 07 2020 at  7:35pm -0400,
>> Sagi Grimberg <sagi@grimberg.me> wrote:
>>
>>>
>>>>> Hey Mike,
> ...
>>>> I think NVMe can easily fix this by having an earlier stage of checking,
>>>> e.g. nvme_local_retry_req(), that shortcircuits ever getting to
>>>> higher-level multipathing consideration (be it native NVMe or DM
>>>> multipathing) for cases like NVME_SC_CMD_INTERRUPTED.
>>>> To be clear: the "default" case of nvme_failover_req() that returns
>>>> false to fallback to NVMe's "local" normal NVMe error handling -- that
>>>> can stay.. but a more explicit handling of cases like
>>>> NVME_SC_CMD_INTERRUPTED should be added to a nvme_local_retry_req()
>>>> check that happens before nvme_failover_req() in nvme_complete_rq().
>>>
>>> I don't necessarily agree with having a dedicated nvme_local_retry_req().
>>> a request that isn't failed over, goes to local error handling (retry or
>>> not). I actually think that just adding the condition to
>>> nvme_complete_req and having nvme_failover_req reject it would work.
>>>
>>> Keith?
>>
>> I think that is basically what I'm thinking too.
> 
> From: Mike Snitzer <snitzer@redhat.com>
> Subject: nvme: explicitly use normal NVMe error handling when appropriate
> 
> Commit 764e9332098c0 ("nvme-multipath: do not reset on unknown
> status"), among other things, fixed NVME_SC_CMD_INTERRUPTED error
> handling by changing multipathing's nvme_failover_req() to short-circuit
> path failover and then fallback to NVMe's normal error handling (which
> takes care of NVME_SC_CMD_INTERRUPTED).
> 
> This detour through native NVMe multipathing code is unwelcome because
> it prevents NVMe core from handling NVME_SC_CMD_INTERRUPTED independent
> of any multipathing concerns.
> 
> Introduce nvme_status_needs_local_error_handling() to prioritize
> non-failover retry, when appropriate, in terms of normal NVMe error
> handling.  nvme_status_needs_local_error_handling() will naturely evolve
> to include handling of any other errors that normal error handling must
> be used for.
> 
> nvme_failover_req()'s ability to fallback to normal NVMe error handling
> has been preserved because it may be useful for future NVME_SC that
> nvme_status_needs_local_error_handling() hasn't yet been trained for.
> 
> Signed-off-by: Mike Snitzer <snitzer@redhat.com>
> ---
>   drivers/nvme/host/core.c | 16 ++++++++++++++--
>   1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 88cff309d8e4..be749b690af7 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -252,6 +252,16 @@ static inline bool nvme_req_needs_retry(struct request *req)
>   	return true;
>   }
>   
> +static inline bool nvme_status_needs_local_error_handling(u16 status)
> +{
> +	switch (status & 0x7ff) {
> +	case NVME_SC_CMD_INTERRUPTED:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
>   static void nvme_retry_req(struct request *req)
>   {
>   	struct nvme_ns *ns = req->q->queuedata;
> @@ -270,7 +280,8 @@ static void nvme_retry_req(struct request *req)
>   
>   void nvme_complete_rq(struct request *req)
>   {
> -	blk_status_t status = nvme_error_status(nvme_req(req)->status);
> +	u16 nvme_status = nvme_req(req)->status;
> +	blk_status_t status = nvme_error_status(nvme_status);
>   
>   	trace_nvme_complete_rq(req);
>   
> @@ -280,7 +291,8 @@ void nvme_complete_rq(struct request *req)
>   		nvme_req(req)->ctrl->comp_seen = true;
>   
>   	if (unlikely(status != BLK_STS_OK && nvme_req_needs_retry(req))) {
> -		if ((req->cmd_flags & REQ_NVME_MPATH) && nvme_failover_req(req))
> +		if (!nvme_status_needs_local_error_handling(nvme_status) &&
> +		    (req->cmd_flags & REQ_NVME_MPATH) && nvme_failover_req(req))This looks no affect. if work with nvme multipath, now is already retry local.
If work with dm-multipath, still return error.
>   			return;
>   
>   		if (!blk_queue_dying(req->q)) {
> 

Suggest:
REQ_FAILFAST_TRANSPORT may be designed for scsi, because scsi protocol
do not difine the local retry mechanism. SCSI implements a fuzzy local
retry mechanism, so need the REQ_FAILFAST_TRANSPORT for multipath
software, multipath software retry according error code is expected.
nvme is different with scsi about this. It define local retry mechanism
and path error code, so nvme should not care REQ_FAILFAST_TRANSPORT.

Another, for nvme multipath, if the error code is not a path error,
multipath will not fail over to retry. but maybe blk_queue_dying return
true, IO can not be retry at current path, thus IO will interrupted.
blk_queue_dying and path error both need fail over to retry.

So we can do like this:
---
  drivers/nvme/host/core.c      | 26 +++++++++++++++++++-------
  drivers/nvme/host/multipath.c | 11 +++--------
  drivers/nvme/host/nvme.h      |  5 ++---
  include/linux/nvme.h          |  9 +++++++++
  4 files changed, 33 insertions(+), 18 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4ee2330c603e..07471bd37f60 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -243,7 +243,7 @@ static blk_status_t nvme_error_status(u16 status)

  static inline bool nvme_req_needs_retry(struct request *req)
  {
-    if (blk_noretry_request(req))
+    if (req->cmd_flags & (REQ_FAILFAST_DEV | REQ_FAILFAST_DRIVER))
          return false;
      if (nvme_req(req)->status & NVME_SC_DNR)
          return false;
@@ -252,6 +252,14 @@ static inline bool nvme_req_needs_retry(struct request *req)
      return true;
  }

+static inline bool nvme_req_path_error(struct request *req)
+{
+    if ((nvme_req(req)->status & NVME_SCT_MASK) == NVME_SCT_PATH ||
+        blk_queue_dying(req->q))
+        return true;
+    return false;
+}
+
  static void nvme_retry_req(struct request *req)
  {
      struct nvme_ns *ns = req->q->queuedata;
@@ -270,7 +278,7 @@ static void nvme_retry_req(struct request *req)

  void nvme_complete_rq(struct request *req)
  {
-    blk_status_t status = nvme_error_status(nvme_req(req)->status);
+    blk_status_t status;

      trace_nvme_complete_rq(req);

@@ -279,16 +287,20 @@ void nvme_complete_rq(struct request *req)
      if (nvme_req(req)->ctrl->kas)
          nvme_req(req)->ctrl->comp_seen = true;

-    if (unlikely(status != BLK_STS_OK && nvme_req_needs_retry(req))) {
-        if ((req->cmd_flags & REQ_NVME_MPATH) && nvme_failover_req(req))
-            return;
-
-        if (!blk_queue_dying(req->q)) {
+    if (unlikely(nvme_req(req)->status != NVME_SC_SUCCESS &&
+        nvme_req_needs_retry(req))) {
+        if (nvme_req_path_error(req)) {
+            if (req->cmd_flags & REQ_NVME_MPATH) {
+                nvme_failover_req(req);
+                return;
+            }
+        } else {
              nvme_retry_req(req);
              return;
          }
      }

+    status = nvme_error_status(nvme_req(req)->status);
      nvme_trace_bio_complete(req, status);
      blk_mq_end_request(req, status);
  }
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 66509472fe06..e182fb3bcd0c 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -65,7 +65,7 @@ void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
      }
  }

-bool nvme_failover_req(struct request *req)
+void nvme_failover_req(struct request *req)
  {
      struct nvme_ns *ns = req->q->queuedata;
      u16 status = nvme_req(req)->status;
@@ -90,17 +90,13 @@ bool nvme_failover_req(struct request *req)
              queue_work(nvme_wq, &ns->ctrl->ana_work);
          }
          break;
-    case NVME_SC_HOST_PATH_ERROR:
-    case NVME_SC_HOST_ABORTED_CMD:
+    default:
          /*
-         * Temporary transport disruption in talking to the controller.
+         * Normal error path.
           * Try to send on a new path.
           */
          nvme_mpath_clear_current_path(ns);
          break;
-    default:
-        /* This was a non-ANA error so follow the normal error path. */
-        return false;
      }

      spin_lock_irqsave(&ns->head->requeue_lock, flags);
@@ -109,7 +105,6 @@ bool nvme_failover_req(struct request *req)
      blk_mq_end_request(req, 0);

      kblockd_schedule_work(&ns->head->requeue_work);
-    return true;
  }

  void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 09ffc3246f60..cbb5d4ba6241 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -582,7 +582,7 @@ void nvme_mpath_wait_freeze(struct nvme_subsystem *subsys);
  void nvme_mpath_start_freeze(struct nvme_subsystem *subsys);
  void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
              struct nvme_ctrl *ctrl, int *flags);
-bool nvme_failover_req(struct request *req);
+void nvme_failover_req(struct request *req);
  void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl);
  int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl,struct nvme_ns_head *head);
  void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id);
@@ -640,9 +640,8 @@ static inline void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
      sprintf(disk_name, "nvme%dn%d", ctrl->instance, ns->head->instance);
  }

-static inline bool nvme_failover_req(struct request *req)
+static inline void nvme_failover_req(struct request *req)
  {
-    return false;
  }
  static inline void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
  {
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 5ce51ab4c50e..8c4a5b4d5b4d 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -1441,6 +1441,15 @@ enum {
      NVME_SC_DNR            = 0x4000,
  };

+#define NVME_SCT_MASK 0x700
+enum {
+    NVME_SCT_GENERIC = 0,
+    NVME_SCT_COMMAND_SPECIFIC = 0x100,
+    NVME_SCT_MEDIA = 0x200,
+    NVME_SCT_PATH = 0x300,
+    NVME_SCT_VENDOR = 0x700
+};
+
  struct nvme_completion {
      /*
       * Used by Admin and Fabrics commands to return data:
-- 
2.16.4



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
