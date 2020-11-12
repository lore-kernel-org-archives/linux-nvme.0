Return-Path: <SRS0=6u0/=ES=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDEAC2D0A3
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Nov 2020 14:53:40 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EFF920872
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Nov 2020 14:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="z8iHlRas";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHXS4JsK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EFF920872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=fYsscNBpc5jSrEaevTcdfmuorprRp+Rq18mWxFmYjqM=; b=z8iHlRas4vH02rn9yp3EpWjIb
	wp2vxp/7XDf182x63s7LA0LxhD6P0y+o0u3sKo2ni8+wQxzDRe4k1u1FEEm5UzK3tL3JX2EHeumNI
	hI0+lkeNa2ZK3ab6s+/GFkUYstK1YvmsSCBTcCLizKP3Z3xC41h/1sp+WzkhGdpGU5aWE9+pdiulV
	/4vZ0tlM4aala6u4CMP5O71eXo4mFOoy8Pi+l57EP8VWwsPQELCHjizRtvu7+rPfVlftoYfKcgiU3
	NelRrbmj0BDvBjcuvftkNDRnNN+WnKBFFnbi9nvuCVlsUM2o2amPAZB5/+uC2Cu5NsZUOLpVZObpP
	vWM4AInmw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kdDyg-0007FS-FM; Thu, 12 Nov 2020 14:53:34 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kdDyd-0007Ee-I4
 for linux-nvme@lists.infradead.org; Thu, 12 Nov 2020 14:53:32 +0000
Received: from dhcp-10-100-145-180.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AC25020872;
 Thu, 12 Nov 2020 14:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605192809;
 bh=/KlAWNAD1+tCSwffPMeMfbxtqiL9CCu/YpbwvOwXbAc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XHXS4JsK9KcSqUL53gxBe0I5Ye7FAJB+vXCaW9PnkTMOBtYLg6FyiBsaS/oJkSBFT
 JpdUJCFvblA70JyHGQSRfQ5waI7nqiPwsn9+NTiB8KUZXJnMo0yJBXqBtILUWHpFfp
 qhJ04+7XMoJReY++YMN80dPYrgnHiT2FSjHR+Mvs=
Date: Thu, 12 Nov 2020 06:53:25 -0800
From: Keith Busch <kbusch@kernel.org>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Subject: Re: [PATCH 0/2] nvme-pic: improve max I/O queue handling
Message-ID: <20201112145325.GC2573679@dhcp-10-100-145-180.wdc.com>
References: <20201112082302.82441-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201112082302.82441-1-schnelle@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201112_095331_704707_20BA33B5 
X-CRM114-Status: GOOD (  19.30  )
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
Cc: Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Nov 12, 2020 at 09:23:00AM +0100, Niklas Schnelle wrote:
> while searching for a bug around zPCI + NVMe IRQ handling on a distro
> kernel, I got confused around handling of the maximum number
> of I/O queues in the NVMe driver.
> I think I groked it in the end but would like to propose the following
> improvements, that said I'm quite new to this code.
> I tested both patches on s390x (with a debug config) and x86_64 so
> with both data center and consumer NVMes.
> For the second patch, since I don't own a device with the quirk, I tried
> always returning 1 from nvme_max_io_queues() and confirmed that on my
> Evo 970 Pro this resulted in about half the performance in a fio test
> but did not otherwise break things. I couldn't find a reason why
> allocating only the I/O queues we actually use would be problematic in
> the code either but I might have missed something of course.

I don't think you missed anything, and the series looks like a
reasonable cleanup. I suspect the code was left over from a time when we
didn't allocate the possible queues up-front.

Reviewed-by: Keith Busch <kbusch@kernel.org>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
