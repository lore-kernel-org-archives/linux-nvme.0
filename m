Return-Path: <SRS0=U7CH=C2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B01BDC2BBD1
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Sep 2020 08:55:06 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DF0E20872
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Sep 2020 08:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lXBfrmSL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DX1rNqPb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DF0E20872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=l8sqcj0iww6lZMbF25lJcTIlvQCHo1ZIcfuHfC0fnfY=; b=lXBfrmSLGvpIAfkGBiTD8apm8
	D+iEAKYZXI9tQ3MsSScArLxWllqqChCYXAzMu9mFtBpkSSiphsqJVgxKKMdSPzfU0BxUfwoTaM+ga
	9WfSTjEXBvZOk29BcOW3agNrwu0WA9F1WXwpBfwL22oL24BJACdry0LpObAnL8FFls3jrDSjpQpdT
	Fy3VaotcwM4tK+QxLaNSrlr3qQ7FwIps9OXWMjRrUls03g5K+XCA/3BFIy/IPXYoVcjcK7nBjpG60
	deyBzDxxT9R4ZzfNpMpK4r95UylWdpOTK8YI2oly2BI+DqlLrBdIKRRxuLpwLAdxkbjZZ5yKYqUjQ
	oAX4ycxJQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kIph1-0004yI-Uz; Thu, 17 Sep 2020 08:55:04 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIph0-0004xh-B8
 for linux-nvme@merlin.infradead.org; Thu, 17 Sep 2020 08:55:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=9ciugbDHmeEi2y+jofuvp7M8uBuMs3NGr9WY7zBuwO0=; b=DX1rNqPb7xGxl6P9AFmOfBin1r
 SM9ubneGsGGN/UZXcRHAhq9q2E8p+j89zBstCXUhzUBGEKwt0OOGZQg0nXeaaCcsMJbFck9lYFzBV
 9EIb5hu5/+yK9MVlBfeWGysChC3Wm/K3+NLJm8IvHunwpdUUIsUD1xgnPrFNExkGy+QXLkHEfa13G
 ngVmZTh70qYXN9Bd5xVbbFfbKXvo/vpZ9/PSxRtAxmmz4Sudhj4qtgBvpjxmeZXfB6vdJ2I45DPXl
 Sz2J/rgOjyr9igZPoF2T3VetX8f/qoHr2Quel8/06Rlg7CLLvjP5/hbGp4Y2yLexLa6ktkHSgvCkL
 q++t2iEg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1kIpgy-00031y-KI; Thu, 17 Sep 2020 08:55:00 +0000
Date: Thu, 17 Sep 2020 09:55:00 +0100
From: Christoph Hellwig <hch@infradead.org>
To: amit.engel@dell.com
Subject: Re: [PATCH] nvmet: handle keep-alive timer when kato is modified by
 a set features cmd
Message-ID: <20200917085500.GB11528@infradead.org>
References: <20200916174720.12610-1-amit.engel@dell.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200916174720.12610-1-amit.engel@dell.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Applied to nvme-5.10 with an updated changelog and the author line made
to match the signoff.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
