Return-Path: <SRS0=ANVZ=BC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05435C433E1
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jul 2020 16:42:22 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C41932071A
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jul 2020 16:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="F65RK17e";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dn7GJ6CJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C41932071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=nh/SC0I0M/jmq+FUV4+wLdOiSxjuR0OLw3cVmwCHAJs=; b=F65RK17eWkWbJlJv5SbROvc5t
	osxHPgrWPaPTzpxUez+cam7qK/AY+H0hwG4o4r5VHiYGCYDk4wMRF0NG9anyy9soiO40jufXA7eWM
	xkIXcQX03zF0Akhu2Bg8r1x3E66nTLeBsRk8BkDqi/HbbGyVpWfACbWcM/W+xRv0m53D8qHQlBS64
	wbrIzP0H1iUYSabUbrH3aD0wQVYxQyNzc0UoPV5mpY9PwL3DLhf+b0bPI9FaVcSZRuLOF76t6lzf5
	bAMOzLZ3CKMKRTetWzULn15fxiQlLkXELWT5e4qR6Na2fTmyyZv4XaSI6McO4wBrGzkIz7oe01ZI4
	m8Hm0FsAw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jyeIT-0007Tx-Om; Thu, 23 Jul 2020 16:42:17 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jyeIR-0007TT-Kp
 for linux-nvme@lists.infradead.org; Thu, 23 Jul 2020 16:42:16 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 06ED720714;
 Thu, 23 Jul 2020 16:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1595522534;
 bh=ZdmH4uSm2DGHNkrxdXbRIk0dIyRhSpItddmPzFUF+lI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dn7GJ6CJvHdiktD+HgST+NhyKvVZZkJwmR09/Hw7h2rL+9wYYtTQ1VqSV+AvFnP/U
 WalUcYa12LqbvFB2cH4z/JqsjElZqMvjuoQC4/oX9PYGEOWxm6FJfcM/619iVahUwQ
 JlqGtz3Narevltj6+Ig16Od9BELoAy2SXHqo1g2Y=
Date: Thu, 23 Jul 2020 09:42:12 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvme-core: reduce io pause time when fail over
Message-ID: <20200723164212.GA2366615@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200722093633.31347-1-lengchao@huawei.com>
 <20200722160054.GA1363519@dhcp-10-100-145-180.wdl.wdc.com>
 <973d6470-05e8-8be4-2c8b-3162f37a971e@grimberg.me>
 <fffa2b82-f933-6531-7f98-2f6269fd0d11@huawei.com>
 <d6c07da9-e553-19c9-78e8-f52519730b3c@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d6c07da9-e553-19c9-78e8-f52519730b3c@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200723_124215_743708_DA451999 
X-CRM114-Status: UNSURE (   7.90  )
X-CRM114-Notice: Please train this message.
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
Cc: axboe@fb.com, linux-nvme@lists.infradead.org,
 Chao Leng <lengchao@huawei.com>, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jul 23, 2020 at 09:30:57AM -0700, Sagi Grimberg wrote:
> +       /* all namespaces share hctxs, so sync just once */
> +       blk_mq_quiesce_queue_sync(ns->queue);

They don't share hctx's. An hctx is a property of a specific
request_queue, and each namespace has their own.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
