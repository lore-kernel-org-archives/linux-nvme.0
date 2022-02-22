Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3947C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Feb 2022 19:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Kl9HYlzZxP762rmr3JZDe12LdTpl7vHkbGrosPHci0Y=; b=SDER+gIdCJltzC+JQVJmg14mGJ
	VhHOyKzj+hCCadPhtUCZBIsWboDLdxDanaN0g1tNUhzkk9/GmcimTaeINY5DYmHyJyBoluZ+4w+9E
	dWn/iu4pe+3GnXOr0hQ5z89usENaWHvRbg5U4XTnLUT/Jn2cdA+1IR0ZO58cJTQZuZqLKjug13A5Q
	EPvzEd5Dxt/e7UHd8uLzcrjZLaRNaINIgqiS7K9SY8xqDO2wNRsdvbyFI8BgQrTBxtMBFrVt7Yrgm
	kSL1iJEbY2cz85S/zTGzpUu/VaiQSFgMjkSFWNVizdk65IjO7xMlv3qGoZh0/AREsizDizo3QpT07
	hujWdENA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nMbHX-00BQrg-1G; Tue, 22 Feb 2022 19:57:07 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nMbHR-00BQpO-Rq
 for linux-nvme@lists.infradead.org; Tue, 22 Feb 2022 19:57:05 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 6D4B461639;
 Tue, 22 Feb 2022 19:57:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E95C2C340E8;
 Tue, 22 Feb 2022 19:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1645559821;
 bh=IRRUSdLETAOrVQqHjzSOULYJd8z2xUvczM2ffIfQJO8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RprbaORm3tXLLYNuyG+hAlHiHwMGMzmWW+64ONeTyE+H7NyvjSA/HfcYkHJIILnfR
 aZ6YA9SRbz7M9HsgSbsHLf7n7Q0wL76LTefx4iKLDhtn4nXSF/cnRzV13lL+uK1arP
 DxS3KPBDDnPhbaD4oogYVGAUhl1Df+HneQYC3Ve0qG/KcSY+j/9N5T0+BV9eLG01CW
 AJd+HRYMHOsC+mg5CvOkr0YTtvhl1BTNNEDhjgu8LvrftkOy+qzWYzmSsM2LIMPKIu
 HAwVdxCdGKOJEvLKb5WnQIS8J5nz3sfagv1oFDXvIC0j9oS8Cn9OmY9J1075Gt+60w
 1PLxYd10AtETA==
Date: Tue, 22 Feb 2022 11:56:59 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-crypto@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
 martin.petersen@oracle.com, colyli@suse.de
Subject: Re: [PATCHv3 06/10] crypto: add rocksoft 64b crc framework
Message-ID: <YhVACzTEylUg5LJx@sol.localdomain>
References: <20220222163144.1782447-1-kbusch@kernel.org>
 <20220222163144.1782447-7-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222163144.1782447-7-kbusch@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220222_115701_981218_E57F3BF6 
X-CRM114-Status: GOOD (  13.98  )
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

On Tue, Feb 22, 2022 at 08:31:40AM -0800, Keith Busch wrote:
> Hardware specific features may be able to calculate a crc64, so provide
> a framework for drivers to register their implementation. If nothing is
> registered, fallback to the generic table lookup implementation. The
> implementation is modeled after the crct10dif equivalent.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  crypto/Kconfig                  |   9 +++
>  crypto/Makefile                 |   1 +
>  crypto/crc64_rocksoft_generic.c | 104 +++++++++++++++++++++++++
>  include/linux/crc64.h           |   5 ++
>  lib/Kconfig                     |   9 +++
>  lib/Makefile                    |   1 +
>  lib/crc64-rocksoft.c            | 129 ++++++++++++++++++++++++++++++++
>  7 files changed, 258 insertions(+)
>  create mode 100644 crypto/crc64_rocksoft_generic.c
>  create mode 100644 lib/crc64-rocksoft.c

I tried testing this, but I can't because it is missing a self-test:

[    0.736340] alg: No test for crc64-rocksoft (crc64-rocksoft-generic)
[    5.440398] alg: No test for crc64-rocksoft (crc64-rocksoft-pclmul)

All algorithms registered with the crypto API need to have a self-test
(in crypto/testmgr.c).

- Eric

