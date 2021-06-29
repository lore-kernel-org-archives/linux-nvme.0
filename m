Return-Path: <SRS0=UYep=LX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F482C11F64
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Jun 2021 01:32:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6288761C6F
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Jun 2021 01:32:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6288761C6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uDuf4SuXOf/B1VRpFjS38qAPnaEZgK6zvrThxrq8PX4=; b=CnuQqJw5lUQqYc
	SkJnnReYaCbJZPBKpqf7vvkstHvi2R916Pll1kDrSScZtrtCmAhBOq72uojHcJQ+qScAljOenGSY9
	+HNfDUnvL3OsxxXYLtUX83p8OBDrxbNa3F8+34gYWGkmsAa80nZO/9JBchs9NMR2wXch055i0x599
	MPhLcyCBzu/kxGbb1ibvxJ+Vol1xtWF6IHdTzBuPiBDJddxo3hD7OFqF6+f6BMEMMcbqN+sxyNGfD
	CBRdzGM4rwhHu4gm1Zy93dVVYeUVumGLz9ncK14To7mbLefndI6DDkJ5nTiLipyvvzlGFEBofWWrg
	FdY9ABmqZU5SOgdyWrBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ly2c6-009V4c-Bu; Tue, 29 Jun 2021 01:32:34 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ly2c3-009V3i-39
 for linux-nvme@lists.infradead.org; Tue, 29 Jun 2021 01:32:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1624930348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9kYorP//K1VhOVzWqSp9mV6M/r7OM0NYvrvalKQnHOw=;
 b=TpZJQBxGV66Q8xrRnDHYwMYwteTIpSdhpbhXk7S2gZLCMBElKG/YpuQbRLIPC4VwHGZPR5
 CcLM4JnRDWHLPZk4KIt2ggaNjTxujetjurXVCv9+pPZ/TT9Qj9JwtnaEm8kGGFQpmeynyL
 6a8EpxqsRKkL3FXWvaiHJ+rhfMTpOHQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-CeCnM6Y8McyxyIO4A5ZA2g-1; Mon, 28 Jun 2021 21:32:24 -0400
X-MC-Unique: CeCnM6Y8McyxyIO4A5ZA2g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0592A8015F8;
 Tue, 29 Jun 2021 01:32:23 +0000 (UTC)
Received: from T590 (ovpn-12-115.pek2.redhat.com [10.72.12.115])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E74D360C13;
 Tue, 29 Jun 2021 01:32:15 +0000 (UTC)
Date: Tue, 29 Jun 2021 09:32:11 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 1/2] nvme-fc: Update hardware queues before using them
Message-ID: <YNp4GyXwOlJeqtby@T590>
References: <20210625101649.49296-1-dwagner@suse.de>
 <20210625101649.49296-2-dwagner@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210625101649.49296-2-dwagner@suse.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210628_183231_278410_C7E061AC 
X-CRM114-Status: GOOD (  22.00  )
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

On Fri, Jun 25, 2021 at 12:16:48PM +0200, Daniel Wagner wrote:
> In case the number of hardware queues changes, do the update the
> tagset and ctx to hctx first before using the mapping to recreate and
> connnect the IO queues.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  drivers/nvme/host/fc.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 8a3c4814d21b..a9645cd89eca 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -2951,14 +2951,6 @@ nvme_fc_recreate_io_queues(struct nvme_fc_ctrl *ctrl)
>  	if (ctrl->ctrl.queue_count == 1)
>  		return 0;
>  
> -	ret = nvme_fc_create_hw_io_queues(ctrl, ctrl->ctrl.sqsize + 1);
> -	if (ret)
> -		goto out_free_io_queues;
> -
> -	ret = nvme_fc_connect_io_queues(ctrl, ctrl->ctrl.sqsize + 1);
> -	if (ret)
> -		goto out_delete_hw_queues;
> -
>  	if (prior_ioq_cnt != nr_io_queues) {
>  		dev_info(ctrl->ctrl.device,
>  			"reconnect: revising io queue count from %d to %d\n",
> @@ -2968,6 +2960,14 @@ nvme_fc_recreate_io_queues(struct nvme_fc_ctrl *ctrl)
>  		nvme_unfreeze(&ctrl->ctrl);
>  	}
>  
> +	ret = nvme_fc_create_hw_io_queues(ctrl, ctrl->ctrl.sqsize + 1);
> +	if (ret)
> +		goto out_free_io_queues;
> +
> +	ret = nvme_fc_connect_io_queues(ctrl, ctrl->ctrl.sqsize + 1);
> +	if (ret)
> +		goto out_delete_hw_queues;
> +
>  	return 0;
>  
>  out_delete_hw_queues:
> -- 
> 2.29.2
> 

This way may cause correct hctx_idx to be passed to blk_mq_alloc_request_hctx(), so:

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
