Return-Path: <SRS0=ETB4=CR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5805EC43461
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Sep 2020 15:31:23 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0301621D79
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Sep 2020 15:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="etK5kcIK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="R1bOkFPQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0301621D79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=hIB7KT+1f2NH27yPrqKxbbc30dpJviNSkgA6US4xuEA=; b=etK5kcIKik/P8b9tYHo8l2oIE
	8L6cSkgWyR/TFJXJlXE6fFt6D3MsQKuVHXNACpBTSaZmb+Pdeld4bMhX4GT1eXJ5edYPeqJ1FtjUO
	8DmmmrPk9oMtfi84YcvmMR2lE0MXU7zyBUWUyx2bAUGcn56aX5mBT4G2t+PQNaiW39zjb2TKUaFq8
	sKT71+XbaZSs10kZLcqUbyugzzk2qca2h8E18/rs4LVJ2TjKe9hRZkBvimFQJTrCQceyyUg2Dh6MX
	IpWjpnfmRTAgDmLPfrg2Wg5AO2+FC+MEWi8QOumSdRJuo1F2zvBmP5K9ILSDtt4EIuxDS28tS72xE
	5YhXRghsw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kFfaY-0004oq-7h; Tue, 08 Sep 2020 15:31:18 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kFfaT-0004mI-G0
 for linux-nvme@lists.infradead.org; Tue, 08 Sep 2020 15:31:14 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9D48921D6C;
 Tue,  8 Sep 2020 15:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599579071;
 bh=Cxp51egYnklrprsgu3/iIRmmK0GhOZAdQglfcB/KiPs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=R1bOkFPQjvij1LBFwfNqqTJ2SJAYs8xQhIcOckM+b+r8ikpjc2XzB4K/MVXBSLV/o
 SDHHcjaKKBRCRPQF6eR/DE7FFmkCH2577EudPfA1egdUVoxYfK21yAtwdKoGJ1CRnT
 WeVi6O9bEjO4RStGnn0nrG88GjIe/qSG70BBlDIs=
Date: Tue, 8 Sep 2020 08:31:08 -0700
From: Keith Busch <kbusch@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH V3 2/4] blk-mq: implement queue quiesce via percpu_ref
 for BLK_MQ_F_BLOCKING
Message-ID: <20200908153108.GA3341002@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200908081538.1434936-1-ming.lei@redhat.com>
 <20200908081538.1434936-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200908081538.1434936-3-ming.lei@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200908_113113_650354_229661FE 
X-CRM114-Status: GOOD (  15.05  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Chao Leng <lengchao@huawei.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Sep 08, 2020 at 04:15:36PM +0800, Ming Lei wrote:
>  void blk_mq_quiesce_queue(struct request_queue *q)
>  {
> -	struct blk_mq_hw_ctx *hctx;
> -	unsigned int i;
> -	bool rcu = false;
> +	bool blocking = !!(q->tag_set->flags & BLK_MQ_F_BLOCKING);
>  
>  	mutex_lock(&q->mq_quiesce_lock);
>  
> -	if (blk_queue_quiesced(q))
> -		goto exit;

Why remove the 'goto exit' on this condition? There shouldn't be a need
to synchronize dispatch again if a previous quiesce already did so.

> -	blk_mq_quiesce_queue_nowait(q);
> -
> -	queue_for_each_hw_ctx(q, hctx, i) {
> -		if (hctx->flags & BLK_MQ_F_BLOCKING)
> -			synchronize_srcu(hctx->srcu);
> -		else
> -			rcu = true;
> +	if (!blk_queue_quiesced(q)) {
> +		blk_mq_quiesce_queue_nowait(q);
> +		if (blocking)
> +			percpu_ref_kill(&q->dispatch_counter);
>  	}
> -	if (rcu)
> +
> +	if (blocking)
> +		wait_event(q->mq_quiesce_wq,
> +			   percpu_ref_is_zero(&q->dispatch_counter));
> +	else
>  		synchronize_rcu();
> - exit:
> +
>  	mutex_unlock(&q->mq_quiesce_lock);
>  }

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
