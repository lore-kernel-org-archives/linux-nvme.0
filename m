Return-Path: <SRS0=AvHe=JX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 015A1C43460
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Apr 2021 14:36:08 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FE806101B
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Apr 2021 14:36:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FE806101B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=yss3fEsFFeD3kEboYTsxpzIaRTuS82ArHTGP91YsoR8=; b=UXU5OXniKOUPq5mZhgmOaw7OZ
	g+Fm8sCrILZMALWm4eRRPSVfyIs0IUf4DdH8PReYHlN6IGDXJTBqOvN1o47uRDsQXmyb5M7YfdGH3
	jHrRB7pu0YiHsfndxOiWh5X4scSr+UX/L6jfcumw8wtbpms0SDw7EhWm6/Ec/i2+4vZ4t8PvCZ+bB
	LtzsV2ACrqqVytr+CqQ+LVxMQOE9HbGki5qC526C+c7RWsaMllwLS/SW8MHfL6YWGmLWHaWiayL2g
	wNwvbv1kyrpQS3SR/WzNf4C8ttJgZZVQhjUH2U1dgPhKUZy7SwbOk26Rb1P1mL3pkhzrbpeju3M52
	m2xOjhrrQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lb2L1-007r9T-5O; Mon, 26 Apr 2021 14:35:51 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lb2Kz-007r91-Td
 for linux-nvme@desiato.infradead.org; Mon, 26 Apr 2021 14:35:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=Oq7Ls9WBBOONngUA3AZ8tJoHWRW0LZRYSW8w7kWOMhg=; b=TEovWYiDsYBTDMRai1P8t5SVwe
 w8SkQHa/bpL0fk15mIDg/BxkYzQcfjXipDxSJhEDUvXt4HfSKOh6iuRC11s6CUKgCugLFIA2pKH8Y
 Sy49WONP3QeG94UYuK3EZzhIXfwM+NwQwNj5Ocwvhm7Or298/fE10G/blYmUPw3c8Kx+a9VMBg81h
 I8UyJKeJwgWgbzsP63B3hAmCNUiY43s2nNl/SD7/d9FoPI3C8m17RiiyaCQByDbojPRdejFbHg2Ni
 vH2N+UIf18q9HyxgaRN+Y5GZruhROvZGEoW87Lb5wJAnAVE7sxDIGBAuLfRiXtyHRKX8Y/OvG6mqE
 sJdsK1mA==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lb2Kx-00G122-9x
 for linux-nvme@lists.infradead.org; Mon, 26 Apr 2021 14:35:48 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 17FA668C4E; Mon, 26 Apr 2021 16:35:44 +0200 (CEST)
Date: Mon, 26 Apr 2021 16:35:43 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 axboe@kernel.dk, linux-block@vger.kernel.org,
 Yuanyuan Zhong <yzhong@purestorage.com>,
 Casey Chen <cachen@purestorage.com>
Subject: Re: [PATCHv2 1/5] block: support polling through blk_execute_rq
Message-ID: <20210426143543.GA20668@lst.de>
References: <20210423220558.40764-1-kbusch@kernel.org>
 <20210423220558.40764-2-kbusch@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210423220558.40764-2-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210426_073547_521311_4AD20032 
X-CRM114-Status: GOOD (  21.83  )
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

I think it would be nice to split this into a little helper.

> +	} else if (hang_check)
>  		while (!wait_for_completion_io_timeout(&wait, hang_check * (HZ/2)));

And while we're at it, it would be nice to split this out as well and
document this mess..

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
