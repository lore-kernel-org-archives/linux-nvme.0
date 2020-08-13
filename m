Return-Path: <SRS0=x9Yf=BX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25E5C433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Aug 2020 00:32:14 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F983207DA
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Aug 2020 00:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pLkwP7SN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZG+AL1r5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F983207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=tCXvOdDdQBU4RNTFWWYh7iWIrxnr4y1Ui6jtI2iBmBY=; b=pLkwP7SNnswi6tXiqL9PrEeHU
	Zyn2gK5+BKphqF4zO2/Nb7HLyPR40YHIF8c6GcAoZA+8gAaGsr60zS9Mivn1Sj8PolLYmxUN66BBK
	XLc1EJx7ed0m+1OarFBDjwX8SiPoqmfJYMYcE8jIzB5fRdhM7gSi5wtkW+YccEw5V/yIVQuFdIxuF
	by/9Yen4hzVvDSWRiRNdfWAFRnVyP6NkgtFnXy+k5Dnc6XBBrjuhGhnEXApSUIxkpEtXnLDa0xMVv
	AatZfeDmSWhAE/uHgkc8jn5S+0DoJc8buMP3KPFSsoNfNjl3JaBxdKmgnU17xiHoim2gVmvbLPrdV
	RXY2If60g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k61A6-0001ps-LW; Thu, 13 Aug 2020 00:32:06 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k61A3-0001pF-RX
 for linux-nvme@lists.infradead.org; Thu, 13 Aug 2020 00:32:04 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 421F620771;
 Thu, 13 Aug 2020 00:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597278722;
 bh=DK6cpoMIVfyVu3p4pB2161IxNHY/GDxfnQI+cNfyugo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZG+AL1r5NU/udFg4cl05Mi6MI9WssSOPQQ0fn9v5LXwYCDLVzjyTV+2PpGNeZiYkz
 IGl9HF7xLFWVDGJHZnyU7fcZb3yy2mfQFSXT2/2xG97PjnegHQcIuFKcO4vQ5lRz15
 Cnb3E4XqVMCm2ldp9MAzByXqshGGdUznUybWP5+w=
Date: Wed, 12 Aug 2020 17:32:00 -0700
From: Keith Busch <kbusch@kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v2] nvme: Use spin_lock_irq() when taking the ctrl->lock
Message-ID: <20200813003200.GA1640756@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200812232444.18310-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200812232444.18310-1-logang@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200812_203204_089408_AD6B94EB 
X-CRM114-Status: UNSURE (   8.37  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

There's an unrelated whitespace change in nvme_init_identify().
Otherwise, looks fine.

Reviewed-by: Keith Busch <kbusch@kernel.org>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
