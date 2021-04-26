Return-Path: <SRS0=AvHe=JX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D0C2C433ED
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Apr 2021 06:42:43 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB77F611C2
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Apr 2021 06:42:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB77F611C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=MgWhJaP5LpLATkKYXZEW0d/iLR1ryKhxB7t73txNqVM=; b=V9IO9zVG6sAqmZE+TjzqPqMGz
	txYTYvKA1vY4awNxIkAYnyWT1BYTSvnDF+fZoo0GRp9M+II91/iX50c8pmgM4SrGxcNn9DI8SObk7
	426n8eqRXM7L2IkZ1gflwBnJ6KsvCKsDkldClGmpc0c0pvoBc5DPsCyscbZVDRsz8BeRfY3Jn2/0U
	QQMW6uCzawcUEg2c2YFpvaJnSD1ewr7ZEoogHaePW9gZnlnMRE0L+xE8R/ahQxqGmUDVlMdXRFX3X
	WDBCCpr5me3Iusv6yDqTo82bhqQcNMIM8R6poasZKQL9nDdguINHlgYN4nmB3c4toqy3N66LuBXqq
	58fkmk1xA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lauwt-0075RI-Dz; Mon, 26 Apr 2021 06:42:27 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lauwr-0075R9-Im
 for linux-nvme@desiato.infradead.org; Mon, 26 Apr 2021 06:42:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=NM6lOOxPG/ArlLl9ZqV4gZFwO27+A1GwYsbYUuqYRHk=; b=QZThV/cEljcEYwuGj4CmcyRATi
 AkjLiF1/S/5VBG+axQOTj5lXp2jvFzibtbH27+YGpjh6Gmo1w0ft9TffteWr5q5dNiTbRuKDj++5v
 DP6oxizKY6D8XGQqT0AXur+0aKCdFwbRA3C7TmSe7sGTV9PpV5twfUCLM37jxzzVeg2eGikVCzFEF
 VFmGTI+Df92dEhSOOf/je6nmmTspNbUceTsvqEcG9DjopRwYVOBsR4z0Iu6kT2IckXq9mfX8GSFAT
 owxY/6MpyiV0ec6yp+3UePfAU8J0/rpDT3xfEef4988i1MUO3CMlugqzxsqg0pVwpqtK0VIG/i4BQ
 R132LqPA==;
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lauwo-00FlfW-Vp
 for linux-nvme@lists.infradead.org; Mon, 26 Apr 2021 06:42:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619419341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NM6lOOxPG/ArlLl9ZqV4gZFwO27+A1GwYsbYUuqYRHk=;
 b=RlHUTHc4C/3DuCPBCBaYtlgIqdT2VE5M7bKWzWcCvTOWjnKctZgx0jfIGnKabhaVB+XiX2
 MYrdCH27VKAnjIDmrF+ty9/1qoAoxLiGepEGsnMJM+eRqPbN9+TzD2QaZlaiQxRvDydeJV
 r0h6RWTREfo+2P/MIldbfw0eFhnUBxs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-90JESyrnMHOkhKYAiY-u-w-1; Mon, 26 Apr 2021 02:42:17 -0400
X-MC-Unique: 90JESyrnMHOkhKYAiY-u-w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 456031009619;
 Mon, 26 Apr 2021 06:42:16 +0000 (UTC)
Received: from T590 (ovpn-13-194.pek2.redhat.com [10.72.13.194])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F13FB646D6;
 Mon, 26 Apr 2021 06:42:11 +0000 (UTC)
Date: Mon, 26 Apr 2021 14:42:17 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 axboe@kernel.dk, linux-block@vger.kernel.org,
 Yuanyuan Zhong <yzhong@purestorage.com>,
 Casey Chen <cachen@purestorage.com>
Subject: Re: [PATCHv2 3/5] block: return errors from blk_execute_rq()
Message-ID: <YIZgyY0mMj/LIpVh@T590>
References: <20210423220558.40764-1-kbusch@kernel.org>
 <20210423220558.40764-4-kbusch@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210423220558.40764-4-kbusch@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210425_234223_121986_A2E067CE 
X-CRM114-Status: GOOD (  19.38  )
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

On Fri, Apr 23, 2021 at 03:05:56PM -0700, Keith Busch wrote:
> The synchronous blk_execute_rq() had not provided a way for its callers
> to know if its request was successful or not. Return the errno from the
> dispatch status.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  block/blk-exec.c       | 6 ++++--
>  include/linux/blkdev.h | 2 +-
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-exec.c b/block/blk-exec.c
> index b960ad187ba5..4e8e6fe20956 100644
> --- a/block/blk-exec.c
> +++ b/block/blk-exec.c
> @@ -21,7 +21,7 @@ static void blk_end_sync_rq(struct request *rq, blk_status_t error)
>  {
>  	struct completion *waiting = rq->end_io_data;
>  
> -	rq->end_io_data = NULL;
> +	rq->end_io_data = ERR_PTR(blk_status_to_errno(error));
>  
>  	/*
>  	 * complete last, if this is a stack request the process (and thus
> @@ -77,8 +77,9 @@ static bool blk_rq_is_poll(struct request *rq)
>   * Description:
>   *    Insert a fully prepared request at the back of the I/O scheduler queue
>   *    for execution and wait for completion.
> + * Return: The errno value of the blk_status_t provided to blk_mq_end_request().
>   */
> -void blk_execute_rq(struct gendisk *bd_disk, struct request *rq, int at_head)
> +int blk_execute_rq(struct gendisk *bd_disk, struct request *rq, int at_head)
>  {
>  	DECLARE_COMPLETION_ONSTACK(wait);
>  	unsigned long hang_check;
> @@ -97,5 +98,6 @@ void blk_execute_rq(struct gendisk *bd_disk, struct request *rq, int at_head)
>  		while (!wait_for_completion_io_timeout(&wait, hang_check * (HZ/2)));
>  	else
>  		wait_for_completion_io(&wait);
> +	return PTR_ERR_OR_ZERO(rq->end_io_data);

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
