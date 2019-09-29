Return-Path: <SRS0=7yTB=XY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC451C32793
	for <linux-nvme@archiver.kernel.org>; Sun, 29 Sep 2019 17:37:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 965B221D80
	for <linux-nvme@archiver.kernel.org>; Sun, 29 Sep 2019 17:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jHNDE/U6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qcFbJTW7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 965B221D80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Yqo9iKQz97sPM7PPnv5KYVocD/U+9+gf0kw1TQOq39A=; b=jHNDE/U6MILxWe
	Trnw2zjPWk455+OuTkEg1BEC4teqyn87DuvBN8vRBixizQyaA791xsp36q/OGHqXygTwSIzA6lINN
	8S9rqzp5eLuhHblIi61sGJCFZ9X0xP/6BPxkdI6UFM5/JEGX77gG8Tx5WIQgSEmrckYOHNCEvYS94
	BHuRXmJyC3hAQNfUyFJLSxuwc7zOaM4iig0dEP9nLORoIvTSFc3Y2ZJpxOgcMkHEW58sVnjqeor+u
	dZCTOm+gB0ugymFaaUrtDX3AqpihKwb4BloMGVfrCi/csrzKzGIwlHCw9BYpPi495bRrMxc1Yc3At
	aNTVHUnbwnRvoJp6g7BQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iEd80-0008UY-UK; Sun, 29 Sep 2019 17:37:00 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iEd7w-0008TX-Qr
 for linux-nvme@lists.infradead.org; Sun, 29 Sep 2019 17:36:57 +0000
Received: from C02WT3WMHTD6 (unknown [8.36.226.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E22A321906;
 Sun, 29 Sep 2019 17:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1569778616;
 bh=RazS7jFCo4CSD3DZ338PdbdusdnyxnjqHW54FoDDjis=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qcFbJTW7+RA6M0ocux6obPpxaqk0+Pg5EZ313gvOI86qtaD6YdX6M9abM6pQZZqOX
 5y7NIcxjT9KUUr61xnbfnQ1mYbYY6CIZ+2GfdTTiOfKqKddxJk93hGcI1HRWNyqEOk
 QIVd5e022QSx+ScoyoZLrrNvRtjGIG3hlEPKKbpo=
Date: Sun, 29 Sep 2019 11:36:54 -0600
From: Keith Busch <kbusch@kernel.org>
To: Minwoo Im <minwoo.im.dev@gmail.com>
Subject: Re: [PATCH] nvme: look up proper namespace in NVME_IOCTL_IO_CMD
Message-ID: <20190929173654.GA1484@C02WT3WMHTD6>
References: <20190928021500.31382-1-minwoo.im.dev@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190928021500.31382-1-minwoo.im.dev@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190929_103656_888299_0ED89F6B 
X-CRM114-Status: UNSURE (   9.24  )
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
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sat, Sep 28, 2019 at 11:15:00AM +0900, Minwoo Im wrote:
> NVME_IOCTL_IO_CMD is deprecated because IO request for a chardev is
> unsafe.  But in case userspace gives nsid, kernel should at least look
> up the proper namespace instance instead getting the first entry and
> checking whether if it's the last one.

This pretty much defeats the purpose of discouraging using this interface, and
possibly opens security issues if someone can issue IO to a device they
shouldn't be able to access.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
