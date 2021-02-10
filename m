Return-Path: <SRS0=Gy4h=HM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03CE7C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Feb 2021 10:12:39 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88B0E64D9F
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Feb 2021 10:12:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88B0E64D9F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=eJGrqAW+aJEInRpdrZB6+ZgIyejYMru5/jlDyG1cVLs=; b=OQicdlVyQz8TLbwPhjRxg1Oou
	83tg7rIU7C50uhbOhUYFJrWRiqE3C9g7/O5V6SCfOYJngckKDKLVWUZl0L3Wl2oiF72OrP5svEpWS
	/SMXqyUyqG9F2R3zJcqo8Jr73H6wzG3p3B5BLELWjEdNnQ68oCIpFeGF0xB2hdMjEQSw+xeEvXx4S
	hyF/BXDzxRnYxkMfEk8eQW9cm+qRAUPjHXpd7QfCwW3U3+BzNI8sibo6pG838r1IIvOcYffv0xVux
	5Aty5OqrjRb7+8TkIAVXtscj83p6xmIa2Wu196PPCTDBKhLEF83+woTcz2XFG5boxAwhRvhzhTP2l
	3TTcMtyCA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9mU5-0002xu-58; Wed, 10 Feb 2021 10:12:33 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9mU4-0002xY-7a
 for linux-nvme@merlin.infradead.org; Wed, 10 Feb 2021 10:12:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=r3zszAJq7KnUp/IgfVkTR1t/hFMx8TZc2+2CeYJ9i0Y=; b=lRNU+rTBTcM1/XotcalDeUEci6
 6ZxsHiuxrMFYg0D2GZYdBfDnUYwSn1Mo6biqbwx2PFdYo7CGKwOVdkU3nKAf2cK+olhmSgyYv66hi
 aaFmG+SdwtAhCCr7JQXvy44Vek/1xL7ZbYpyidfcIy0j0Yij+78WA/whfhgatOdWDDx5vDCnCwPyI
 7xO5QBvvc3NhWunq2NkB8EoGfcIDZcF7x9yBnPEhAIzaS6PYt9JQ7gUaXZxUrtRYdKfKlsNlz3Q0M
 KZnoKI0WDmByAKo6Eqyk7koe2TLF/c63aG1mfDey6TmXOwa7bYkwkhqRenYzP8oWYqbBDBI+nEKqg
 KycLJRZg==;
Received: from [2001:4bb8:184:7d04:5e70:671e:7b3:191] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1l9mU2-008h9p-EX; Wed, 10 Feb 2021 10:12:30 +0000
Date: Wed, 10 Feb 2021 11:12:29 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Gopal Tiwari <gtiwari@redhat.com>
Subject: Re: [PATCH] nvme-pci: prevent SK Hynix PE8000 from using Write
 Zeroes command
Message-ID: <YCOxjZhBTBchOq0n@infradead.org>
References: <20210209045902.72345-1-gtiwari@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210209045902.72345-1-gtiwari@redhat.com>
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
Cc: kbusch@kernel.org, hch@lst.de, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Feb 09, 2021 at 10:29:02AM +0530, Gopal Tiwari wrote:
> For SK Hynix PE8000 WriteZerocommands exceed typical I/O MDTS
> (Maximum Data Transfer Size) supported by the hardware. Which
> intern fail and generate following erros :

Well, if it works under MDTS please add a new quirk that follows
MDTS for Write Zeroes.  In fact I wonder if we should just do
that by default to be on the safe side.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
