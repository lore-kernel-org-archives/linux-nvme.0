Return-Path: <SRS0=7yTB=XY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D5A0C4360C
	for <linux-nvme@archiver.kernel.org>; Sun, 29 Sep 2019 19:18:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECBB420863
	for <linux-nvme@archiver.kernel.org>; Sun, 29 Sep 2019 19:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qX76AA4q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECBB420863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kWFvhulpWMncTlTrc/pcuKR1QjO/DDsujy6GdFhylnI=; b=qX76AA4q5yYoZY
	l5WpHg0ZMlKf0CeLx9j+qJ6UBKFCWaj157iicQW+9D1ijTnd9vGppe2XE6cDmurFckZYZ3N5Os17B
	xfzvCsOOvwlc1I7bZlZ/pd7SwPy++aiA3FzQ/xOVVxm4j1OXJt04knVdOwHkF2ntKpLJhI64ywRUo
	rNVDYad4KZqIWEf9mIa3epS+uIp5mJi2buw2TzKtJoYkQOZ0sWe4MAHaYkxvJUDDscRE5Tjm9Bg9h
	bKSY6AHrcMPOOQhXOqMHsCMsWfJrQLSC8KlDNFb/JcwxXTwOLShLa0LAjWLSgJlwp/VnvW8xbFNtP
	uuiDfBYzcbwrgqy4mEOg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iEeiK-0004TO-5c; Sun, 29 Sep 2019 19:18:36 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iEeiG-0004Sr-I3
 for linux-nvme@lists.infradead.org; Sun, 29 Sep 2019 19:18:34 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id C6FEA68BFE; Sun, 29 Sep 2019 21:18:22 +0200 (CEST)
Date: Sun, 29 Sep 2019 21:18:22 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme: look up proper namespace in NVME_IOCTL_IO_CMD
Message-ID: <20190929191822.GA2995@lst.de>
References: <20190928021500.31382-1-minwoo.im.dev@gmail.com>
 <20190929173654.GA1484@C02WT3WMHTD6>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190929173654.GA1484@C02WT3WMHTD6>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190929_121832_745855_CE0BF0D4 
X-CRM114-Status: GOOD (  10.01  )
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
Cc: Jens Axboe <axboe@fb.com>, Minwoo Im <minwoo.im.dev@gmail.com>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sun, Sep 29, 2019 at 11:36:54AM -0600, Keith Busch wrote:
> On Sat, Sep 28, 2019 at 11:15:00AM +0900, Minwoo Im wrote:
> > NVME_IOCTL_IO_CMD is deprecated because IO request for a chardev is
> > unsafe.  But in case userspace gives nsid, kernel should at least look
> > up the proper namespace instance instead getting the first entry and
> > checking whether if it's the last one.
> 
> This pretty much defeats the purpose of discouraging using this interface, and
> possibly opens security issues if someone can issue IO to a device they
> shouldn't be able to access.

It also breaks any old user relying on the fact that the nsid is
ignored.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
