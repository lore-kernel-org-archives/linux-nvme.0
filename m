Return-Path: <SRS0=/f9n=N4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BD3C433EF
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Sep 2021 07:59:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1515360F43
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Sep 2021 07:59:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1515360F43
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OSCZRENDw0WDReA/CNsXLQ/x5xdYqw2x8BjzjTAZYuk=; b=pGG8U/mYz++BHR
	BaNmrLQAo2/f+YmQXIs46vlpd3G016FPnIVWYZTYkKw2fqkfDn4OBFdVSKb8pxieQjwlT8XvuQbIV
	kDCuV8C4Z0ibieQraytZ/uDIRcgSxLibUHzIaC8qmFe+96PwKjGYlA+14uuR0wo2xmhTbkQIyCTCk
	8cGQqpg8dtB6F6v+YT+mByhMWlgngoIJENl1/oQcwgt58sRKX0kMwtNfMfDUHedO7fNamcBb7IcAo
	qlNfdgW9bJSEzYwxate7BapqOCOepuTxJbHer/E1GhRNUiCpXzpEIbTMC3D0uirXt0gshHdp8Av1i
	zUimuetfudyF3CGJyA3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mN9Wu-0008C5-Lk; Mon, 06 Sep 2021 07:59:00 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mN9Ws-0008BV-BS
 for linux-nvme@bombadil.infradead.org; Mon, 06 Sep 2021 07:58:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=oOFV3aBUUEEGyqvLAa8hfq+cLKEmGeypv5PDL5XSJEM=; b=by6aIIKk03uvjCAvjPQuiYUlYE
 q8jRCXMRztEBoYU6O426ssAa9KcZpWfL7ER69FBal0pENP/9S9hiDu1+3L/9gxeSdo9RZ3u94P8DZ
 7NUGUe/KKYoWXIosJyAtBybX/FhZrMPjtKeXMVWUHfzIUqN/HGjdu5jv7b7cvb5aSXzkLlQBLPifT
 NkFw9vOu94tiT8ASL57JcFX0gxW3bL6BQtG0+GsbC/qP8ADfRhm9Q8PHxGg+WjML1lYHahFPsAdRu
 BmAxQbpLkqEOS56c5hRngdiN87/7M6je6BTpnu4erJAHpeNJqePeIjCwZAOPyYogPvlvAkQesFON1
 QtAzB9sg==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat
 Linux)) id 1mN9WG-006kn5-7B; Mon, 06 Sep 2021 07:58:29 +0000
Date: Mon, 6 Sep 2021 08:58:20 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC v1] nvme-tcp: enable linger socket option on shutdown
Message-ID: <YTXKHOfnuf+urV1D@infradead.org>
References: <20210903121757.140357-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210903121757.140357-1-dwagner@suse.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Sep 03, 2021 at 02:17:57PM +0200, Daniel Wagner wrote:
> When the no linger is set, the networking stack sends FIN followed by
> RST immediately when shutting down the socket. By enabling linger when
> shutting down we have a proper shutdown sequence on the wire.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
> The current shutdown sequence on the wire is a bit harsh and
> doesn't let the remote host to react. I suppose we should
> introduce a short (how long?) linger pause when shutting down
> the connection. Thoughs?

Why?  I'm not really a TCP expert, but why is this different from
say iSCSI or NBD?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
