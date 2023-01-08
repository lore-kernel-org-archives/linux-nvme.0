Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE846C53210
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Jan 2023 17:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IWqPhXsp/bnPmXzTmZPKPNtoA9gcp/QXH0UL1m3axbM=; b=ygJZJ0PprLE4HCpDiBsv4LO3fA
	XKPB2SWJRooHUJIrNePnfVRC1+B24DvuI2m0gOwE4B4JyykBNuj3O2Ijmp9P7yccR0mgsTZfYoWLZ
	XZtR5LT2Xn3rhmn29LsyIcQCJjrN6yDvSO8ahDhxqNgX7Xm8AxA/NfR1ROfm4dphDUr7Gh33vQ7oR
	QWbBkVB3oXXEfuMwr5aIwlPQYPqbvainOGdVngEL7XA9BsyFMwx13uCZUoLxrC0VO4h0b0XsPln2h
	M8a0KnT5MLjKiMjIIY5Xbr2/WQ/n9RAFwGjh2oqNtZ8vR5ean55lbIVKkAs8OyIEl6wKlgga7kI7c
	rK6wMaeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pEZIA-00EW4X-KW; Sun, 08 Jan 2023 17:17:06 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pEZI8-00EW3k-9H; Sun, 08 Jan 2023 17:17:04 +0000
Date: Sun, 8 Jan 2023 09:17:04 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <kbusch@kernel.org>
Cc: user090909 <fuckgithub@riseup.net>, axboe@fb.com, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] Add quirk for ADATA SX6000PNP
Message-ID: <Y7r6kPjbDmjovlju@infradead.org>
References: <ed916236ae7f2823aeccc8a85230abe5@riseup.net>
 <Y6yWS8SfrouPyeTY@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6yWS8SfrouPyeTY@kbusch-mbp.dhcp.thefacebook.com>
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

On Wed, Dec 28, 2022 at 12:20:24PM -0700, Keith Busch wrote:
> The sign off is required to use the real name of the patch author.
> 
> The patch itself is mangled with line wraps.

Yes.  Also please check with the vendor if there is a firmware update
available first.

