Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44734C54EBC
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Jan 2023 16:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mH2JfUbwFOjGsvZM0dIcjdshoV7NXzVBvzVP29UiaQY=; b=TOHs/QaMLLI6WljDvMKuRd5gfo
	dtmQLHwIAy8bdqLoag5cZWmrrYOgLvplyJIzUJExZUZ5dvmm5zlB/zKZOMRsTgOPcHRVRiNM94Ojh
	4JnZ0dvtqRCbKzbFT70ZoCkrYj1kATHmeC8gnSPqMu1NLuwl+zegOphfBJyQhqdgRoy5IMHPDF7OC
	8cf3GDgtPOxkURPbv6YgMyqOwhkw9fjgiRJiBgoqBwnRMC1Gu7nSV9vzJxXKDo23WQGFh8WeHbWpq
	Tn1DFl89d3QQJrxwW8T4Ghqy/cx9JPXsODoVA/fjRDKhHf8pohQXwKrJzOc/8NitteDXl3db3N/fG
	sTnsk3tQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pG0Xh-00FroQ-Pq; Thu, 12 Jan 2023 16:35:05 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pG0XX-00Frkz-PQ
	for linux-nvme@lists.infradead.org; Thu, 12 Jan 2023 16:34:59 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id C7927B81E3B;
	Thu, 12 Jan 2023 16:34:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C852AC433D2;
	Thu, 12 Jan 2023 16:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1673541292;
	bh=x9Q0Z5tuZ3B0Z7EWlGfdKlAtTCFfIu4fF3nyQrn6ATY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TUnjeYYWJOAg9UwwEnAxnupeD86dOp/bZiT5VVb3cymJpGtgxguu0o35blZaKDOTI
	 5pQsxZDAdEMFjNQA6IEQClePBdWGkSOKf3/L9pO6N15f22HXrF7YeucECd3Lp2V8sv
	 6E8vEMhDEvcOuZJWw/hnoWwC5oYm65pUoI8sG6Vo8JIkPjcsRK+2isRIPv12jYFK/n
	 ss6vhdn3HAwInfCmY56vwB6VR0itd9hkx5jYsl4vPr1co/UUAHVxtbcJ3PvJKylmxI
	 DgS+G7EFjd0D1Y8DQMDkWgHZqmAMSEOd2Wa68qukAYg2qLrXhcs+xGE6NxjYkr1kEo
	 AaF1Lk2JZtEHQ==
Date: Thu, 12 Jan 2023 09:34:49 -0700
From: Keith Busch <kbusch@kernel.org>
To: Klaus Jensen <its@irrelevant.dk>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	qemu-block@nongnu.org, qemu-devel@nongnu.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: completion timeouts with pin-based interrupts in QEMU hw/nvme
Message-ID: <Y8A2qdbDZPicuZfL@kbusch-mbp.dhcp.thefacebook.com>
References: <Y8AG21o/9/3eUMIg@cormorant.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8AG21o/9/3eUMIg@cormorant.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230112_083456_029745_BA75D74D 
X-CRM114-Status: GOOD (  14.21  )
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

On Thu, Jan 12, 2023 at 02:10:51PM +0100, Klaus Jensen wrote:
> 
> The pin-based interrupt logic in hw/nvme seems sound enough to me, so I
> am wondering if there is something going on with the kernel driver (but
> I certainly do not rule out that hw/nvme is at fault here, since
> pin-based interrupts has also been a source of several issues in the
> past).

Does it work if you change the pci_irq_assert() back to pci_irq_pulse()?
While probably not the "correct" thing to do, it has better results in
my testing.

