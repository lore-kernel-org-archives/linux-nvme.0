Return-Path: <SRS0=AvHe=JX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12BA1C433ED
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Apr 2021 06:35:18 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E2F761249
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Apr 2021 06:35:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E2F761249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wMmHmW6Api6ZA/op5NxmDwYZQ3n7smyb3amxIS0WRZs=; b=M4CA5jxE+OtAamMfxEc00bsdC
	tQc1nKQCOFrouuxDNNNqvhA7uqGTEhcjC/xQpoQ028FEPbAMu762OxwgsRDgVuGgI/dmf8jC8LveM
	6kk6J0G9F4vbkT+m+Pxu/PIfRDGdHN+qfWsmLSD5AQMn1yU7W7LY20jNmWJHGvdonXsuiJDNIjWec
	NKvDVrJlss3t35bPwIyRnZfYOVubr8mhNnF00GtXdrw0dQrK7c46oAZ3Yyyk34sfmNIpb9boXjfUA
	MVwbzsP4UfqHYoNh9xJJx7PfDPr7MPBGY4raWFSSMvp9QqI2SBDHugZxkUPR+UOi3d+1hUwU8LKkv
	nKmiSFm5Q==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1laupk-0074Q3-OT; Mon, 26 Apr 2021 06:35:04 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1laupj-0074PS-CM
 for linux-nvme@desiato.infradead.org; Mon, 26 Apr 2021 06:35:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=b0//KiwrXJCAQEbZh6v7UYUMFjngDAQ0xEhOxI4LuvE=; b=VA60Edd3jfy+brwLc8Q8U6sDdU
 OEKeJR+i6u9GOCjS7fsbIPo9NcOpDeBetTDZ9cIOy6M8NmDQC6E7TwA9EmbD6+xp8S8JAZfvzEeTc
 BhmBIkEVLcYdF585vKebHVZ6WsDlZ3oRI3QfBwNsEuVRcHL7+tSF31yUDoIyVlrL3/x2hFwOsI7Du
 IYw0uZ60sIExnN9jAXeJTrSstlALmP9G4gWhk1JGvyN9HN7HskFuAlJA1XceRNSaeQ87ronICP55n
 aKR1ug/b8ezoRAEdY7rldWdluCGmdoQU//Sd7lDXY/g4dbaR4FDWRoY3CGLWl/VBtYSe8WXjeduZE
 3bkrHcoA==;
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1laupf-00FlTb-A5
 for linux-nvme@lists.infradead.org; Mon, 26 Apr 2021 06:35:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619418896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b0//KiwrXJCAQEbZh6v7UYUMFjngDAQ0xEhOxI4LuvE=;
 b=Sv4uy6K5bhPHAGGcl0bEI3JxtQb05JutoZ6KfR6+uXxWJQy3hwrVT+GxiVmzeYDuHpoqLH
 r6cDXxTfBnrXKUBn0WjR04PVuo48OYVzotL5egxvSaJVjU6jP+u7kLIHW0wz2VNKXsz7fr
 Slt5KsMBI6Dcgc7AvBPvpfT5GnKK0Es=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-RMzoaL0fPCCLtl3TPtgv4Q-1; Mon, 26 Apr 2021 02:34:52 -0400
X-MC-Unique: RMzoaL0fPCCLtl3TPtgv4Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A63BC343AA;
 Mon, 26 Apr 2021 06:34:50 +0000 (UTC)
Received: from T590 (ovpn-13-194.pek2.redhat.com [10.72.13.194])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6748D61F38;
 Mon, 26 Apr 2021 06:34:43 +0000 (UTC)
Date: Mon, 26 Apr 2021 14:34:48 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 axboe@kernel.dk, linux-block@vger.kernel.org,
 Yuanyuan Zhong <yzhong@purestorage.com>,
 Casey Chen <cachen@purestorage.com>
Subject: Re: [PATCHv2 1/5] block: support polling through blk_execute_rq
Message-ID: <YIZfCBYvH1hm+QM4@T590>
References: <20210423220558.40764-1-kbusch@kernel.org>
 <20210423220558.40764-2-kbusch@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210423220558.40764-2-kbusch@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210425_233459_444687_CAE3775F 
X-CRM114-Status: GOOD (  19.52  )
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

On Fri, Apr 23, 2021 at 03:05:54PM -0700, Keith Busch wrote:
> Poll for completions if the request's hctx is a polling type.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  block/blk-exec.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-exec.c b/block/blk-exec.c
> index beae70a0e5e5..b960ad187ba5 100644
> --- a/block/blk-exec.c
> +++ b/block/blk-exec.c
> @@ -63,6 +63,11 @@ void blk_execute_rq_nowait(struct gendisk *bd_disk, struct request *rq,
>  }
>  EXPORT_SYMBOL_GPL(blk_execute_rq_nowait);
>  
> +static bool blk_rq_is_poll(struct request *rq)
> +{
> +	return rq->mq_hctx && rq->mq_hctx->type == HCTX_TYPE_POLL;
> +}
> +
>  /**
>   * blk_execute_rq - insert a request into queue for execution
>   * @bd_disk:	matching gendisk
> @@ -83,7 +88,12 @@ void blk_execute_rq(struct gendisk *bd_disk, struct request *rq, int at_head)
>  
>  	/* Prevent hang_check timer from firing at us during very long I/O */
>  	hang_check = sysctl_hung_task_timeout_secs;
> -	if (hang_check)
> +	if (blk_rq_is_poll(rq)) {
> +		do {
> +			blk_poll(rq->q, request_to_qc_t(rq->mq_hctx, rq), true);
> +			cond_resched();
> +		} while (!completion_done(&wait));
> +	} else if (hang_check)
>  		while (!wait_for_completion_io_timeout(&wait, hang_check * (HZ/2)));
>  	else
>  		wait_for_completion_io(&wait);
> -- 
> 2.25.4
> 

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
