Return-Path: <SRS0=UYep=LX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23742C11F64
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Jun 2021 01:40:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCBB561CC7
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Jun 2021 01:40:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCBB561CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LJSMN4kUUv9CuRDBdVzdIjGyxb8Hhh+nAHFz6l8UM6A=; b=q3avHhXGtdt4Zx
	moldgbRI1DDlJYeG8lW/IJay41NcZRrCn3EeE6xEmlDeyGWIHPCgmZBVj1YNpf6LSHQERF9YhARl3
	3ZDCh4yNrXFc+QQZDjMJG15bJlwfcgUm54J1HJt/ZCmZTxZe+Qr9bwvMFqo7bLGbFGeODMMP1Lbbm
	1pT7gOFPtOXM3hDcANUfWAXq0oKAi7A2onZqctE9E8ph48Z+IkhP4QXZJ/ywMQArnGLtuJaMcuaaI
	m4rGL8GvC7adegqjJTuz60oaNsyIEXtykUnVCZ4WaUyVlIrFkOvAq48kUXtMPPc9PIPhSOrYoY1fa
	dSN8q+eeEgUk8wrvsX0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ly2jA-009WY5-Vr; Tue, 29 Jun 2021 01:39:53 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ly2j8-009WXO-Dr
 for linux-nvme@lists.infradead.org; Tue, 29 Jun 2021 01:39:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1624930789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nmC6ZFHpVYRnCzG7FJlyXZBzfKH6rggjduLG+czT85I=;
 b=YoGhNIaRk7kEJR23ixv71qYW6iGSUumiwSpkZuKFipzV31usjoX2F8+5zW3jnPwuAWu2yg
 7Ry33G0bohrKF4lP1BqTunNc1bB746h6+5ACncE+QCWIJOL+ZHKXqt8vmUfIeulMARlb73
 LUpWl7Ba/Z1z2mkOShoCz7wSilI+v1I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-Av_utp_hNxmyHvGGDqGEUw-1; Mon, 28 Jun 2021 21:39:45 -0400
X-MC-Unique: Av_utp_hNxmyHvGGDqGEUw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 91F28106B7E4;
 Tue, 29 Jun 2021 01:39:44 +0000 (UTC)
Received: from T590 (ovpn-12-115.pek2.redhat.com [10.72.12.115])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7DC955C1D0;
 Tue, 29 Jun 2021 01:39:35 +0000 (UTC)
Date: Tue, 29 Jun 2021 09:39:30 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 2/2] nvme-fc: Wait with a timeout for queue to freeze
Message-ID: <YNp50pmlzN6M0kNX@T590>
References: <20210625101649.49296-1-dwagner@suse.de>
 <20210625101649.49296-3-dwagner@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210625101649.49296-3-dwagner@suse.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210628_183950_583703_C9896134 
X-CRM114-Status: GOOD (  25.00  )
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

On Fri, Jun 25, 2021 at 12:16:49PM +0200, Daniel Wagner wrote:
> Do not wait indifinitly for all queues to freeze. Instead use a
> timeout and abort the operation if we get stuck.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  drivers/nvme/host/fc.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index a9645cd89eca..d8db85aa5417 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -2955,7 +2955,14 @@ nvme_fc_recreate_io_queues(struct nvme_fc_ctrl *ctrl)
>  		dev_info(ctrl->ctrl.device,
>  			"reconnect: revising io queue count from %d to %d\n",
>  			prior_ioq_cnt, nr_io_queues);
> -		nvme_wait_freeze(&ctrl->ctrl);
> +		if (!nvme_wait_freeze_timeout(&ctrl->ctrl, NVME_IO_TIMEOUT)) {
> +			/*
> +			 * If we timed out waiting for freeze we are likely to
> +			 * be stuck.  Fail the controller initialization just
> +			 * to be safe.
> +			 */
> +			return -ENODEV;
> +		}
>  		blk_mq_update_nr_hw_queues(&ctrl->tag_set, nr_io_queues);
>  		nvme_unfreeze(&ctrl->ctrl);

Can you investigate a bit on why there is the hang? FC shouldn't use
managed IRQ, so the interrupt won't be shutdown.

blk-mq debugfs may help to dump the requests after the hang is triggered,
or you still can add debug code in nvme_wait_freeze_timeout() to dump
all requests if blk-mq debugfs doesn't work.


Thanks,
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
