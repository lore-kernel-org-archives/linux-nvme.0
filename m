Return-Path: <SRS0=li1X=BB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6B7C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jul 2020 16:01:05 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECE6820717
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jul 2020 16:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lF2wMfay";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="s9YMEoGq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECE6820717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=SpkwpJgaXZwrFzgvbFDwTC8IrQwAKnkp1Rj2XH7XbRE=; b=lF2wMfayPeo61n/fpVuxxW/df
	0yYMg9uSZqs5WfBbTQ1K+PLQ7MYVQLJtmaoXVLIZQXt9t6RRJI4WTCcMxNyutJiHxQxB/gP7qOvH9
	izDdOjKXjumMflMjWkwJ4JnCvq39bW7A/lf3O96MgejJdrLw5gdy6reTxTqcH2jrgzOQzv+H2rXSA
	TvaLaUl7xFp3tXr4wEWk6yIFN7hHnPQ2ZNRzAQnFg7X0EVmmGr+5cfsKYYsC67nl2QgBwQCeewoSe
	QdLWJZfnKZetiqQUQzbk4Hr1v5OM30iDh7nFyX9rboeXiqqziYvHVtpm+4LJl0XWEGIjyQWE2aZHk
	2z9/G45gw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jyHAy-0003cY-7s; Wed, 22 Jul 2020 16:01:00 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jyHAw-0003bx-79
 for linux-nvme@lists.infradead.org; Wed, 22 Jul 2020 16:00:59 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 19A41206F5;
 Wed, 22 Jul 2020 16:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1595433656;
 bh=JBsdOmGp5ZrTOx2S0cCWDjtEQSd/GUKSZRFFJkMF5vM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=s9YMEoGqqzxYMSxILWDeUxqUUo7yzeK9/oE86lTr3cb7Gf4MNVbr/JMhGZkz7UPr6
 F8/n2RwETbLhdz9NGOf/UTz5sX/+Y327R5LiZIlC6eR6I/N/QDOH5ZM5uNT2UzN05N
 D8gfYcyjOldo5qv35k0hyg2vIkj6DAYLnu3ZjqDM=
Date: Wed, 22 Jul 2020 09:00:54 -0700
From: Keith Busch <kbusch@kernel.org>
To: Chao Leng <lengchao@huawei.com>
Subject: Re: [PATCH] nvme-core: reduce io pause time when fail over
Message-ID: <20200722160054.GA1363519@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200722093633.31347-1-lengchao@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200722093633.31347-1-lengchao@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200722_120058_330788_F31A4F6D 
X-CRM114-Status: GOOD (  10.28  )
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
Cc: axboe@fb.com, hch@lst.de, linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Jul 22, 2020 at 05:36:33PM +0800, Chao Leng wrote:
> To reduce io pause time, nvme_stop_queues use
> blk_mq_quiesce_queue_nowait to quiesce the queue, nvme_stop_queues wait
> all ongoing dispatches completed after all queues has been quiesced.

The comment above blk_mq_quiesce_queue_nowait() wants to remove this
function. I'm not sure we should be introducing more users if that's the
case.

Using synchronize_rcu() at the end may be looking to much into blk-mq's
internal quiesce implementation. It happens to be the right thing to do
for non-blocking hctx, so this patch assumes that will be true for any
nvme request_queue.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
