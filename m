Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86E49C38142
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Jan 2023 04:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=50bGvimqpatXpDf45fe7UKV/bJAaQ5lZ15OKFthgDdA=; b=n1GZvr4zdjzE2IBHK/iLa7gH1m
	BsNE3jZvAenVfISEpZJK+mITP51IdJxcBPNUThQ6/utO1GqjUK6u3pbgpigsagqWcWT8Y/K26FwWt
	3YEAJwbfvgOycIihAoMcE2cS0xdHMAd0ZsnZdCXQV2r15GRu8ZvhJwrMp6Omn4SKql0m+7EbutUjz
	QP6Jkul+4B04L77NdW0FlQgMCUkLlwcJmtBPuOd1S29AmThuzo6BaMAlYT8cxfncIHVqi8frrSJiG
	L3EUhQrQq8z8XgcKpPMfed8xdb/xD8nFm5kHlyoTUl+prf5D+sxHxo1W9xZw7sUvhKol3xT+zridr
	mvC6WwZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pIMSu-003XhB-AF; Thu, 19 Jan 2023 04:23:52 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pIM9R-003SHI-Uj
	for linux-nvme@lists.infradead.org; Thu, 19 Jan 2023 04:03:47 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 3A053B81EE2;
	Thu, 19 Jan 2023 04:03:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A25AC433D2;
	Thu, 19 Jan 2023 04:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1674101022;
	bh=KxsuZGddcB452Yes1i3k8mwKgzNHRz9ATAsQtGq3Orc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BN+y6eEoyIUSGR4brJQkT73rJiO/kbi6cHH88z3gEDuBWP73XXW4M6XsW7VWUN/pv
	 q31dki1nfZvM8GtPZyLD2ozjhnNTHNuDHkVgEVUudiT7DtMkWWCmgF07+DntjmqGTM
	 TzKcAeX8SWLtEeZyxmwLeNj66A4VbPi82llUnbPQ+LDYn7xDCfsiaJWxDMML7Em1gP
	 BAp3ICixmRLYq4smI/7DxFAa6zS3vfbKmkALZ8d635q84rxmlcR+1rdZczL7fyd6uc
	 JN5NsKveLouofU5j0E7sqovOsiq4gvPMp7tOZeyJOzHyTAHdWHNxhzX7KpROR/0YxA
	 65U/a0qHdj2vA==
Date: Wed, 18 Jan 2023 21:03:39 -0700
From: Keith Busch <kbusch@kernel.org>
To: Alistair Francis <alistair23@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Klaus Jensen <its@irrelevant.dk>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Subject: Re: completion timeouts with pin-based interrupts in QEMU hw/nvme
Message-ID: <Y8jBG/j8w2R43kYd@kbusch-mbp>
References: <Y8Yq5faCjAKzMa9O@kbusch-mbp>
 <20230117160933.GB3091262@roeck-us.net>
 <CAFEAcA9pS7P=SvKsOtRHPtkrNAD8LF2ZpFJ870G3B-rhWYap4g@mail.gmail.com>
 <20230117192115.GA2958104@roeck-us.net>
 <CAFEAcA_T8QqSg4SzszP+wR3pR1P1WTZg4f7mHHBGRw4UrTw+DQ@mail.gmail.com>
 <Y8gfQXPYdHKd1v4I@kbusch-mbp>
 <Y8h7aOuVfCb+RsAP@kbusch-mbp>
 <CAKmqyKMHs_-RgagMDYE7vn3MHEP2caBc+RERjaK0DNJw4hFYiA@mail.gmail.com>
 <Y8iulgdgOdVCjuKE@kbusch-mbp>
 <CAKmqyKMveR=RD6fgnzY0SV39tofD+Ws_AbrSZXE_o4m=M6GZHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKmqyKMveR=RD6fgnzY0SV39tofD+Ws_AbrSZXE_o4m=M6GZHg@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230118_200346_178438_CA0D2DD6 
X-CRM114-Status: GOOD (  18.69  )
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

On Thu, Jan 19, 2023 at 01:10:57PM +1000, Alistair Francis wrote:
> On Thu, Jan 19, 2023 at 12:44 PM Keith Busch <kbusch@kernel.org> wrote:
> >
> > Further up, it says the "interrupt gateway" is responsible for
> > forwarding new interrupt requests while the level remains asserted, but
> > it doesn't look like anything is handling that, which essentially turns
> > this into an edge interrupt. Am I missing something, or is this really
> > not being handled?
> 
> Yeah, that wouldn't be handled. In QEMU the PLIC relies on QEMUs
> internal GPIO lines to trigger an interrupt. So with the current setup
> we only support edge triggered interrupts.

Thanks for confirming!

Klaus,
I think we can justify introducing a work-around in the emulated device
now. My previous proposal with pci_irq_pulse() is no good since it does
assert+deassert, but it needs to be the other way around, so please
don't considert that one.

Also, we ought to revisit the intms/intmc usage in the linux driver for
threaded interrupts.

