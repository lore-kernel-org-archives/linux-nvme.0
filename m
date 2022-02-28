Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9217C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Feb 2022 12:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Tue/MEpoQnseVbPHqoS/+AEdPX5iCnmkNUysitOxd5g=; b=fYsn/B8bMZSQQbPICvfSdSgoZz
	OuwdtAUNIcIjz2yeY+0VMenJrKaoxH/1JINn7zWvwLWMj7GRn1IdLGY0rqWxFb9jzfenGe3T5HLFn
	1IOq/GYcuQgRWsQJjbY9zIYClBqVJmBhmV7myXBto6vxOc/qP9y34m0zNkBFJjVu0H2+8bW8PS4Ic
	yqObtEY8qfnuNSik84MtuQf+qKrP/HBHCBgCEmPaVwgFQYVD6ofOBd0dWm4rbbJlDABnnDBOqmTZz
	x56o2TvmA+RQO+mJ2FiF5VnkMx+uxqBKrTuhvQO1IHFL/RIVpLk/qyAQH3GdDf74BUOlwB+8naUKP
	rVeuh34w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nOfbg-00COCE-NK; Mon, 28 Feb 2022 12:58:29 +0000
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nOfLq-00CHsQ-4i
 for linux-nvme@lists.infradead.org; Mon, 28 Feb 2022 12:42:07 +0000
Received: by mail-pg1-x530.google.com with SMTP id w37so11254206pga.7
 for <linux-nvme@lists.infradead.org>; Mon, 28 Feb 2022 04:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Tue/MEpoQnseVbPHqoS/+AEdPX5iCnmkNUysitOxd5g=;
 b=ayaEgpOlQIW5dDLzYatY92hKs3CaXDazF0V0nmEmr7D4YsOb4+bilcout+1wUkvgaQ
 +sOZhhwXRacrngeC7NdnqOQQCMGlhQvVjyhQWr3Yk+wXAjFAy/QRmILsgJ3QHp1IAcVF
 xNlgUj5aVxEX5Uu/V4+b55kLPhQ05nuN98UJZiY7zM1QUESdmA90Xyi8whVYNz557tY0
 9/c+uORfbnjsdQo3JQuWQZ4aAXWMDntzxJwpSVziGAL22/VtFfzR2TdlGlOmsxjMB2K0
 9BMv20AzqH3+3KYz8n8HsjNBzhgUPoc6GEcZQfRBvFvv6RlO2LJW1noMQhdte5QAVJ7G
 1Otw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Tue/MEpoQnseVbPHqoS/+AEdPX5iCnmkNUysitOxd5g=;
 b=2SEBzddd0ZzCJUmz1Vg88QS0idR3AGPnkuc/+iSXy39sy2G5YsANh944wiL3ik5zZi
 bSp8QKGV3zGMeJs/ruAA7chhf8hQrVgDL9J17t4Ukdb+F8uKpjTx11T7ZBc0TomKUKKv
 eWUZjlQqTSaPWJrFfMok6fzRcl7rFPDIclo8LUgle7YO3FpHMUDujqIMZjHcedytXI7e
 HpmKHYpjBoP/aporcDodqe3DjTwW5spUyqa9T3W/TPP4uLrQHtKj7YhIG1T5Vili7S1u
 yyH/MSRo9pcKsxTy5wWo+B9/YEZsjz9WvogRNgvMh/CEy4ZRdpPWw8ppZVV4Tfm62Dar
 pDxw==
X-Gm-Message-State: AOAM532Xs/0AJC394kc2qhrCaxPUbzXF0/tGg7u5PViEjn0lZKWp65pa
 T5QCwpOI03DJFMTMM3GNXXFBc1TtGRuiZoKdm28=
X-Google-Smtp-Source: ABdhPJzHRJ+rbm9mlAfE07v6tNBe3WBtjSRSp8+azUG0vEVJdjXCrCh9Ot0bAl2buYaDieFG8vKSdhwuDVJ2vSBkoAc=
X-Received: by 2002:a63:d018:0:b0:374:a3c1:dfed with SMTP id
 z24-20020a63d018000000b00374a3c1dfedmr17212226pgf.155.1646052124650; Mon, 28
 Feb 2022 04:42:04 -0800 (PST)
MIME-Version: 1.0
References: <CGME20220210054304epcas5p14aa9d83205f74b2e4942ed9b4e43fc23@epcas5p1.samsung.com>
 <20220210053755.451855-1-joshi.k@samsung.com> <20220228114830.GA10899@lst.de>
In-Reply-To: <20220228114830.GA10899@lst.de>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Mon, 28 Feb 2022 18:11:39 +0530
Message-ID: <CA+1E3rLQBxN3y-F+KVe9MhdgQD9+XGGacnGQ6F8h_hAQHsj3dQ@mail.gmail.com>
Subject: Re: [PATCH v4] nvme: add vectored-io support for user-passthru
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, 
 linux-nvme@lists.infradead.org, kch@nvidia.com, 
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220228_044206_239485_1D049657 
X-CRM114-Status: GOOD (  12.69  )
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

On Mon, Feb 28, 2022 at 5:18 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Btw, I noticed this is not wired up for the /dev/ngX character device.
> Can you send a follow on patch for that?

Err, do you see that it is not working? I actually tested it over both
block and char.
My test utility did write-vectored to /dev/nvme0n1 followed by
read-vectored from /dev/ng0n1, and did data-comparison. It passed.

Code wise, the handler for NVME_IOCTL_IO64_CMD_VEC is added insided
nvme_ns_ioctl().
- for non-multipath char node:
nvme_ns_chr_ioctl -> __nvme_ioctl -> nvme_ns_ioctl
- for multipath char node:
 nvme_ns_head_chr_ioctl -> nvme_ns_ioctl

Please let me know how I can produce the failure that you see.

Thanks,
-- 
Joshi

