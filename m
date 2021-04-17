Return-Path: <SRS0=qGt+=JO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE808C433B4
	for <linux-nvme@archiver.kernel.org>; Sat, 17 Apr 2021 00:02:38 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 678D86115B
	for <linux-nvme@archiver.kernel.org>; Sat, 17 Apr 2021 00:02:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 678D86115B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Zqp5ddHdNOqO2aWUAdKId2+2xUvLRHJjQKgcJlO4fIk=; b=c+RlvqGJkPyA+Hx9lw5F/J28q
	UCLGKZQBiDh6DL0Zh8NiKB3kbHIQ0Mq0ywcZSpk0fk5wPsdQNfn4h8AMXH2Lwtou0zC+NJTuP58S6
	2NeY1OH139JVVrD/TV8FF1ghyTslifVK16LDuYCf+/6xFyAPREVTyvo//XZUa9MqV851hEJigGVfV
	M67Aym4XZKrjm7RRn/CAUQrkeJWfOD8GSrLTp+0JR5M2FQ+1QxRknIBWZJMBqR/Zq49t6OGvwGoqj
	0Be36SrfoAoPlo8ro5cjFfToesIgklGvJqsWzTeToYLwJ0RBACl+JpnRXBo2BgvlfYl7JO3pro4jE
	MosUtkGfA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lXYPl-003nee-KF; Sat, 17 Apr 2021 00:02:21 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXYPi-003neC-Lj
 for linux-nvme@desiato.infradead.org; Sat, 17 Apr 2021 00:02:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=E28myxiZn1blaS13N56nvXLMFnB30qTzlnI725pXZWY=; b=q8iqCt0r2O/wrGNzOeHevJk/MT
 cph70m7R6OlPjS4jyMFY3SPZNFUi4CScTHUI9z6adbd5eSLyABk99idh0H0qqt6Jaqy/CTdKeG8gU
 O4/9Y0eSHYhfK7W9P5zbqv+SKh4VwZBxeeQG6R4J+wUKs3Hp2F0s2+nZtW3L2lJNNID6LMhQ3fw0w
 Q7cb4WGl8KfcD0xFf92OAkwMV24QRyg0Y7mrwg8kdA99x/ePf6z8M7Qw7C+FcTGuPTIBHzvz7xRUv
 VH+vXV9VkfuVfrskeAQYxV8XBBZrTgRIoKWzlpqgislDB0ZSS3lTjttI/WPXfDZea90vCilUZnz2w
 xD5o2cEA==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXYPd-009nPx-2g
 for linux-nvme@lists.infradead.org; Sat, 17 Apr 2021 00:02:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618617730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E28myxiZn1blaS13N56nvXLMFnB30qTzlnI725pXZWY=;
 b=IvgZdxjzKtAvPNMxTY7Vve+UrPFzh+/g0nRbfTvfHe5RLw+JSNrRoFyG9fOfGiZL6xJYXu
 mkbDjEdwrrBrjJlP091FM8QcDYzXeVmGQr1d4doC1s7lxUx1ZP9vSBXtqfNYeoAr7mfEwq
 G+aYRMAY+/hHicYdsq9RwV7sfwObpwc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-518-AUTfOdcqOSWRan_r0QW4Ww-1; Fri, 16 Apr 2021 20:02:08 -0400
X-MC-Unique: AUTfOdcqOSWRan_r0QW4Ww-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6D5A10054F6;
 Sat, 17 Apr 2021 00:02:07 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E7D4C5D6D3;
 Sat, 17 Apr 2021 00:02:03 +0000 (UTC)
Date: Fri, 16 Apr 2021 20:02:03 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: dm-devel@redhat.com, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH v4 0/4] nvme: improve error handling and ana_state to
 work well with dm-multipath
Message-ID: <20210417000203.GA22241@redhat.com>
References: <20210416235329.49234-1-snitzer@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210416235329.49234-1-snitzer@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210416_170213_222792_23BB9DA8 
X-CRM114-Status: GOOD (  28.44  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Apr 16 2021 at  7:53pm -0400,
Mike Snitzer <snitzer@redhat.com> wrote:

> Hi,
> 
> This patchset reflects changes needed to make NVMe error handling and
> ANA state updates work well with dm-multipath (which always sets
> REQ_FAILFAST_TRANSPORT).
> 
> RHEL8 has been carrying an older ~5.9 based version of this patchset
> (since RHEL8.3, August 2020).
> 
> RHEL9 is coming, would really prefer that these changes land upstream
> rather than carry them within RHEL.
> 
> All review/feedback welcome.
> 
> Thanks,
> Mike
> 
> v3 -> v4, less is more:
> - folded REQ_FAILFAST_TRANSPORT local retry and FAILUP patches
> - simplified nvme_failup_req(), removes needless blk_path_error() et al
> - removed comment block in nvme_decide_disposition()
> 
> v2 -> v3:
> - Added Reviewed-by tags to BLK_STS_DO_NOT_RETRY patch.
> - Eliminated __nvme_end_req() and added code comment to
>   nvme_failup_req() in FAILUP handling patch.
> 
> Mike Snitzer (3):
>   nvme: return BLK_STS_DO_NOT_RETRY if the DNR bit is set
>   nvme: allow local retry and proper failover for REQ_FAILFAST_TRANSPORT
>   nvme: decouple basic ANA log page re-read support from native
>     multipathing
> 
>  drivers/nvme/host/core.c      | 22 +++++++++++++++++++---
>  drivers/nvme/host/multipath.c | 16 +++++++++++-----
>  drivers/nvme/host/nvme.h      |  4 ++++
>  include/linux/blk_types.h     |  8 ++++++++
>  4 files changed, 42 insertions(+), 8 deletions(-)

Sorry for all the noise, but I had a cut-and-paste issue with this cover
letter; should've said "[PATCH v4 0/4] ..."

While I'm replying, I _think_ there is consensus that patch 1 is
worthwile and acceptable. Here is a combined diff of patches 2+3 to
illustrate just how minimalist these proposed changes are:

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 540d6fd8ffef..83ca96292157 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -299,6 +299,7 @@ enum nvme_disposition {
 	COMPLETE,
 	RETRY,
 	FAILOVER,
+	FAILUP,
 };
 
 static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
@@ -306,15 +307,16 @@ static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
 	if (likely(nvme_req(req)->status == 0))
 		return COMPLETE;
 
-	if (blk_noretry_request(req) ||
+	if ((req->cmd_flags & (REQ_FAILFAST_DEV | REQ_FAILFAST_DRIVER)) ||
 	    (nvme_req(req)->status & NVME_SC_DNR) ||
 	    nvme_req(req)->retries >= nvme_max_retries)
 		return COMPLETE;
 
-	if (req->cmd_flags & REQ_NVME_MPATH) {
+	if (req->cmd_flags & (REQ_NVME_MPATH | REQ_FAILFAST_TRANSPORT)) {
 		if (nvme_is_path_error(nvme_req(req)->status) ||
 		    blk_queue_dying(req->q))
-			return FAILOVER;
+			return (req->cmd_flags & REQ_NVME_MPATH) ?
+				FAILOVER : FAILUP;
 	} else {
 		if (blk_queue_dying(req->q))
 			return COMPLETE;
@@ -336,6 +338,14 @@ static inline void nvme_end_req(struct request *req)
 	blk_mq_end_request(req, status);
 }
 
+static inline void nvme_failup_req(struct request *req)
+{
+	nvme_update_ana(req);
+
+	nvme_req(req)->status = NVME_SC_HOST_PATH_ERROR;
+	nvme_end_req(req);
+}
+
 void nvme_complete_rq(struct request *req)
 {
 	trace_nvme_complete_rq(req);
@@ -354,6 +364,9 @@ void nvme_complete_rq(struct request *req)
 	case FAILOVER:
 		nvme_failover_req(req);
 		return;
+	case FAILUP:
+		nvme_failup_req(req);
+		return;
 	}
 }
 EXPORT_SYMBOL_GPL(nvme_complete_rq);
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index a1d476e1ac02..7d94250264aa 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -65,23 +65,29 @@ void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
 	}
 }
 
-void nvme_failover_req(struct request *req)
+void nvme_update_ana(struct request *req)
 {
 	struct nvme_ns *ns = req->q->queuedata;
 	u16 status = nvme_req(req)->status & 0x7ff;
-	unsigned long flags;
-
-	nvme_mpath_clear_current_path(ns);
 
 	/*
 	 * If we got back an ANA error, we know the controller is alive but not
-	 * ready to serve this namespace.  Kick of a re-read of the ANA
+	 * ready to serve this namespace.  Kick off a re-read of the ANA
 	 * information page, and just try any other available path for now.
 	 */
 	if (nvme_is_ana_error(status) && ns->ctrl->ana_log_buf) {
 		set_bit(NVME_NS_ANA_PENDING, &ns->flags);
 		queue_work(nvme_wq, &ns->ctrl->ana_work);
 	}
+}
+
+void nvme_failover_req(struct request *req)
+{
+	struct nvme_ns *ns = req->q->queuedata;
+	unsigned long flags;
+
+	nvme_mpath_clear_current_path(ns);
+	nvme_update_ana(req);
 
 	spin_lock_irqsave(&ns->head->requeue_lock, flags);
 	blk_steal_bios(&ns->head->requeue_list, req);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 07b34175c6ce..4eed8536625c 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -664,6 +664,7 @@ void nvme_mpath_start_freeze(struct nvme_subsystem *subsys);
 void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
 			struct nvme_ctrl *ctrl, int *flags);
 void nvme_failover_req(struct request *req);
+void nvme_update_ana(struct request *req);
 void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl);
 int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl,struct nvme_ns_head *head);
 void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id);
@@ -714,6 +715,9 @@ static inline void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
 static inline void nvme_failover_req(struct request *req)
 {
 }
+static inline void nvme_update_ana(struct request *req)
+{
+}
 static inline void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
 {
 }


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
