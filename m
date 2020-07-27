Return-Path: <SRS0=kRiD=BG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5145CC433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2020 21:21:49 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AB3D207BB
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2020 21:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HNhF37s6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXCTm8lo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AB3D207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=H409taa8VUgInN/yveedqo9vbLvsx/PbYBVAVJfompg=; b=HNhF37s6JH4caPjlqoZcHfHN6
	VowXkJQlguNvtsHfzZTg32/nL5RdCpQxCVEu5i+ogGkVGmN1qZYpdMM+OfyCNVKfi2pjvxvm6wO/I
	QwLt+zoXpvvUXR4m+g0xD7DPFfO6mNmKF7FUpx2Ptem00Bzb0296+mjXXVD0GV3Iapkh9wd1b0ciX
	skfDKLweTFP0aMbkr6K6hQRpWxKGvxteImyu8jGuM55NdeJTVW246qL8Ohhy12javCg9542zIZqNR
	9dhtnjIA3z/ZmuH7ylD145LEQ85TIKMfVS5ABQhsCcA/QbSS7FiYZcQAc/Wjx2aKNvnzrg2O4bK7u
	aN4WWIJRg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0AZ6-0000oO-33; Mon, 27 Jul 2020 21:21:44 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0AZ3-0000nq-Sw
 for linux-nvme@lists.infradead.org; Mon, 27 Jul 2020 21:21:42 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A42D32075D;
 Mon, 27 Jul 2020 21:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1595884900;
 bh=c6h6Mw4AEBk6WjhMZ7nsBC6+9eWffSSL9V0jMLt5GlU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=aXCTm8loYLa6feLLuGUHcVmYwMaplG9BG51CC+Z/17Ew5qWhS8ShCcyzQtNlBZsQg
 NsBmW0wiD7gmkV4BLBN9/oAHHmQbTG7d4CfnAESKkIc+d2FIUNSQQzxMqPCloSeFw5
 eO3rBr4kY4fkHRQZSMt2FMfenBOK6NFhjRVA9RVg=
Date: Mon, 27 Jul 2020 14:21:37 -0700
From: Keith Busch <kbusch@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v3 1/2] blk-mq: add async quiesce interface
Message-ID: <20200727212137.GA797661@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200726002301.145627-1-sagi@grimberg.me>
 <20200726002301.145627-2-sagi@grimberg.me>
 <20200726093132.GD1110104@T590>
 <9ac5f658-31b3-bb19-e5fe-385a629a7d67@grimberg.me>
 <20200727020803.GC1129253@T590>
 <2c2ae567-6953-5b7f-2fa1-a65e287b5a9d@grimberg.me>
 <f2fc0ecf-b599-678f-7241-fcd44cde6fab@kernel.dk>
 <bcb8f89b-8477-c48b-1e0f-947cbe741818@grimberg.me>
 <23ad666a-af6a-b110-441e-43ec0f833af4@kernel.dk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <23ad666a-af6a-b110-441e-43ec0f833af4@kernel.dk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200727_172142_001709_2281EE99 
X-CRM114-Status: GOOD (  14.84  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
 Chao Leng <lengchao@huawei.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Jul 27, 2020 at 03:05:40PM -0600, Jens Axboe wrote:
> +void blk_mq_quiesce_queue_wait(struct request_queue *q)
>  {
>  	struct blk_mq_hw_ctx *hctx;
>  	unsigned int i;
>  	bool rcu = false;
>  
> -	blk_mq_quiesce_queue_nowait(q);
> -
>  	queue_for_each_hw_ctx(q, hctx, i) {
>  		if (hctx->flags & BLK_MQ_F_BLOCKING)
>  			synchronize_srcu(hctx->srcu);
>  		else
>  			rcu = true;
>  	}
> +
>  	if (rcu)
>  		synchronize_rcu();
>  }

Either all the hctx's are blocking or none of them are: we don't need to
iterate the hctx's to see which sync method to use. We can add at the
very beginning (and get rid of 'bool rcu'):

	if (!(q->tag_set->flags & BLK_MQ_F_BLOCKING)) {
		synchronize_rcu();
		return;
	}


But the issue Sagi is trying to address is quiescing a lot
request queues sharing a tagset where synchronize_rcu() is too time
consuming to do repeatedly. He wants to synchrnoize once for the entire
tagset rather than per-request_queue, so I think he needs an API taking
a 'struct blk_mq_tag_set' instead of a 'struct request_queue'.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
