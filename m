Return-Path: <SRS0=KS3B=PB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B16C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 15:13:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 336E160F21
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 15:13:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 336E160F21
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=INJOCXO1UwtHd8vKKDCRoPGfd7PoqD/RbsqReQv2DdQ=; b=AFQPrOf3Yw/x4o6QGAqJrtjX6P
	qztBzfxXSbNWSfAM8Ngw4XQyru9c8FENDupmFwkxmtHX9zqvH+okh+CnZLx5kq/GNnRpRl5AOqqVN
	P6F0Mp0qe9f2Se2FtoViR4Q3wvBI9VUwrWnVr02fnXCDtS8gcxYtcR9cR7tmVYSx0dLjpoCgrZKNn
	DmsvHY1fWoqHme7vh3NLIJuPPywzItA+N1hfKwEZpfs6g6Zx5dHIJngVWYScR9Ub/cBg978E1V0t/
	2aZVwODqhZ+9+mk3XIPd3Viet5wlI0X2ueEZ5ZF8ZRPv4NiDiM3JrQR8w17um+lCpVznQ/q3VkQZ6
	3P7gTkqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mafvy-00HJEM-4S; Wed, 13 Oct 2021 15:12:46 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mafvw-00HJE6-K5
 for linux-nvme@bombadil.infradead.org; Wed, 13 Oct 2021 15:12:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=INJOCXO1UwtHd8vKKDCRoPGfd7PoqD/RbsqReQv2DdQ=; b=pPmDoqNg3dvl/rOS6V9pKM9x6H
 tCWc7YqdSZYcVjwbekDErbmn4kH+cBnpdIQDQ0CYKwC6mjjhjDeYArWMP/wLwe4GxYiTlqvAPyjp3
 xf8t61pD1V8C7watpDM1F68ZwjtQ2qYJWP2UkiynL7UBMbbaCOcxUinxeiM6mYAWamD8nwbuLxm3f
 H4E/mYn/PTwXs11PsVzXEbP+qpPtErK+ev6iuCY8JTQh9lOukOystjXAQ2/PuARQ7K+VnJP+UtZPi
 OgPNe7usuFb7IEvYw+W0Yc0Q4DTNxMGDAmFEddn0JXi56kBZta8AzDMdg1j+3X46H/ZfcLygo0exf
 j0+cfv4A==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat
 Linux)) id 1mafuO-007Xq2-A6; Wed, 13 Oct 2021 15:11:22 +0000
Date: Wed, 13 Oct 2021 16:11:08 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH 5/9] nvme: move the fast path nvme error and disposition
 helpers
Message-ID: <YWb3DATaQtAhJUFt@infradead.org>
References: <20211012181742.672391-1-axboe@kernel.dk>
 <20211012181742.672391-6-axboe@kernel.dk>
 <YWaDQiwoo/vjNXxZ@infradead.org>
 <044549fd-b3eb-cfa8-b687-42726c2ed08e@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <044549fd-b3eb-cfa8-b687-42726c2ed08e@kernel.dk>
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Oct 13, 2021 at 08:41:27AM -0600, Jens Axboe wrote:
> I think I'll just kill this patch and check nvme_req(req)->status in the
> caller. If it's non-zero, just do the normal completion path and skip
> the batch list.

Yes, that sounds like a better approach.

