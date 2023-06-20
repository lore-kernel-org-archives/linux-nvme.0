Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C53B2EB64DB
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jun 2023 13:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4ogIibVOnLt0486zOB1sPzcKIarKm0lmpYQoT+khdF8=; b=oj14/pK0nO+OKI66eN10pivxVe
	COIx/uVbwMrWQjlf84Ym4hqV4KNVUcDRf9rnUUi5tMscvZHrfjaBw1oTfbrSJ8g3u8XRxtReBzBNm
	88K7Tc6xj279Uee80uDSnnIVDJWRi1n258BvcR+fWmDNP4P0un/XCjhXSu7x0wFO3xfIlxQ0ZhrDF
	vzWj4Q7Zn/ayLOsONytoSbZmHq95xqGeBcaR93UB0O1xryTLeo2l+HKkGtMqTDhACiTh0hjmyStTG
	nPi3aVDrgd++KebgyMVqDmOAhaz5uctgP/nzrG71hc+avzbElIcRiBuIUHv1q2iwlKk6qv56kqUdc
	3I46ArkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qBbDm-00BLqc-2U;
	Tue, 20 Jun 2023 13:16:34 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qBbDj-00BLpX-0r
	for linux-nvme@lists.infradead.org;
	Tue, 20 Jun 2023 13:16:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687266990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4ogIibVOnLt0486zOB1sPzcKIarKm0lmpYQoT+khdF8=;
	b=NmaFx3lcV975CCB6IswcKr8FBBmT87xVWlk/hMafKmuACZIgbRadJxvQLjnT6yIxR8NgIh
	34JAsVQj5wLlH0qxnPeIdIb24nwGd3Q0RrvMtHVcGgk9lWFe51ETjr3GkGX7PHMTX5z3TW
	Uvr/WX5DKr+C8MXgl0S7A4T0pjn57Qk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-592-GCAQWWmxOiKw8ZGkanUDUg-1; Tue, 20 Jun 2023 09:16:28 -0400
X-MC-Unique: GCAQWWmxOiKw8ZGkanUDUg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F11EB88D0F7;
	Tue, 20 Jun 2023 13:15:37 +0000 (UTC)
Received: from ovpn-8-23.pek2.redhat.com (ovpn-8-18.pek2.redhat.com [10.72.8.18])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9142A1402C06;
	Tue, 20 Jun 2023 13:15:12 +0000 (UTC)
Date: Tue, 20 Jun 2023 21:15:07 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	Yi Zhang <yi.zhang@redhat.com>, linux-block@vger.kernel.org,
	Chunguang Xu <brookxu.cn@gmail.com>
Subject: Re: [PATCH 1/4] blk-mq: add API of blk_mq_unfreeze_queue_force
Message-ID: <ZJGmW7lEaipT6saa@ovpn-8-23.pek2.redhat.com>
References: <20230615143236.297456-1-ming.lei@redhat.com>
 <20230615143236.297456-2-ming.lei@redhat.com>
 <ZIsrSyEqWMw8/ikq@kbusch-mbp.dhcp.thefacebook.com>
 <ZIsxt7Q2nmiLNTX2@ovpn-8-16.pek2.redhat.com>
 <20230616054800.GA28499@lst.de>
 <ZIwNRu1zodp61PEO@ovpn-8-18.pek2.redhat.com>
 <20230620054141.GA12626@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620054141.GA12626@lst.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230620_061631_373188_21482965 
X-CRM114-Status: GOOD (  25.51  )
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

On Tue, Jun 20, 2023 at 07:41:41AM +0200, Christoph Hellwig wrote:
> On Fri, Jun 16, 2023 at 03:20:38PM +0800, Ming Lei wrote:
> > > > GD_DEAD is only set if the device is really dead, then all pending IO
> > > > will be failed.
> > > 
> > > del_gendisk also sets GD_DEAD early on.
> > 
> > No.
> > 
> > The hang happens in fsync_bdev() of del_gendisk(), and there are IOs pending on
> > bio_queue_enter().
> 
> IFF we know we can't do I/O by the time del_gendisk is called, we
> need to call mark_disk_dead first and not paper over the problem.

In theory, device removal can happen any time, when it isn't clear
if the controller is recovered well at that time, that is why this
API is added for avoiding to fail IO unnecessarily.

However maybe it is just fine to mark controller as dead in case that
removal breaks current error recovery given current nvme driver error
handling isn't very fine-grained control, so how about something like
the following:

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c3d72fc677f7..120d98f348de 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -558,6 +558,7 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
        }

        if (changed) {
+               ctrl->old_state = ctrl->state;
                ctrl->state = new_state;
                wake_up_all(&ctrl->state_wq);
        }
@@ -4654,7 +4655,7 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
         * removing the namespaces' disks; fail all the queues now to avoid
         * potentially having to clean up the failed sync later.
         */
-       if (ctrl->state == NVME_CTRL_DEAD) {
+       if (ctrl->state == NVME_CTRL_DEAD || ctrl->old_state != NVME_CTRL_LIVE) {
                nvme_mark_namespaces_dead(ctrl);
                nvme_unquiesce_io_queues(ctrl);
        }
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 953e59f56139..7da53cc76f11 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -246,8 +246,9 @@ enum nvme_ctrl_flags {

 struct nvme_ctrl {
        bool comp_seen;
-       enum nvme_ctrl_state state;
        bool identified;
+       enum nvme_ctrl_state old_state;
+       enum nvme_ctrl_state state;
        spinlock_t lock;
        struct mutex scan_lock;
        const struct nvme_ctrl_ops *ops;

> 
> An API that force unfreezes is just broken and will leaves us with
> freezecount mismatches.

The freezecount mismatch problem is actually in nvme driver, please
see the previous patch[1] I posted.


[1] https://lore.kernel.org/linux-block/20230613005847.1762378-1-ming.lei@redhat.com/T/#m17ac1aa71056b6517f8aefbae58c301f296f0a73


Thanks,
Ming


