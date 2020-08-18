Return-Path: <SRS0=NqxM=B4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C14DDC433E3
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 16:58:23 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9275E20786
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 16:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Iv6Rb2HJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1iUF9fGW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9275E20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=D12/eeuav2pA1ImhLTDy6cn8NzYWWVeKOShBXn6UFxg=; b=Iv6Rb2HJ7XrkUJx0ZVTsqDBfK
	0gArd0A4ZLwDypzO81GfAHVy3P4+ABBgWJ6wQGEtr5ni4/R3hYWQ+jgpwPu+qhrZzTj6xxQqeZjc1
	p7Dz3DrwEabfvRy1KFoWjJ6fZyFFGEogwtsbgsjyT5qR8xqkMR5xqhg331m8seDIkr+WGQQce/Rlx
	gi9zNdlQXczLTg1Acirz+uX64ld2O2frvOVw7p+TNI2E11u1i6MBIm1jA/dBUFJWJPMk5FStGM6oj
	cCuxX8TzrLZbGkuKNEYTRyt+XNLrk57EgNLilS/M5gBRLXdhT779YQctC1kTyLaH5dhs6ANbLT7eq
	U4tYd6Agw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k84wD-0002d9-NT; Tue, 18 Aug 2020 16:58:17 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k84wB-0002cY-Cr
 for linux-nvme@lists.infradead.org; Tue, 18 Aug 2020 16:58:16 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C4ED820786;
 Tue, 18 Aug 2020 16:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597769894;
 bh=YAxfXVhRRyjsoOwe1xBQcE8TbImFIWnjUwrnAZb31Lw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=1iUF9fGWN0aHSMGoqUSaAjHfsDTcjYZVjy1XM6ZoRFmrtfQC2skiaGju3vBOHkRBa
 9RuixYt/WxpPJe14gR/l678gCwYGyxE9hthiA9Dl3CCk7RcniaRbXA58Qld2gdcEpg
 7/cA3WV5m3AXIhU26J4vJTXSRnED+4/afv5fAbz8=
Date: Tue, 18 Aug 2020 09:58:11 -0700
From: Keith Busch <kbusch@kernel.org>
To: Javier Gonzalez <javier@javigon.com>
Subject: Re: [PATCH 2/2] nvme: add emulation for zone-append
Message-ID: <20200818165811.GA2979311@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200818052936.10995-1-joshi.k@samsung.com>
 <CGME20200818053256epcas5p46d0b66b3702192eb6617c8bba334c15f@epcas5p4.samsung.com>
 <20200818052936.10995-3-joshi.k@samsung.com>
 <20200818071249.GB2544@lst.de>
 <20200818095033.h6ybdwiq3ljagl5a@mpHalley.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200818095033.h6ybdwiq3ljagl5a@mpHalley.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200818_125815_587000_083B071F 
X-CRM114-Status: GOOD (  10.15  )
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
Cc: axboe@kernel.dk, Damien.LeMoal@wdc.com,
 SelvaKumar S <selvakuma.s1@samsung.com>, sagi@grimberg.me,
 Kanchan Joshi <joshi.k@samsung.com>, johannes.thumshirn@wdc.com,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Nitesh Shetty <nj.shetty@samsung.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Aug 18, 2020 at 11:50:33AM +0200, Javier Gonzalez wrote:
> a number of customers are requiring the use of normal writes, which we
> want to support.

A device that supports append is completely usable for those customers,
too. There's no need to create divergence in this driver.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
