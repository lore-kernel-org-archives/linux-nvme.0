Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BB06CFA447
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Nov 2025 21:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/6eqfYU/jUUuYoHuv7StAp45WC6GEI72VxPYF//OYgQ=; b=YLsLpHhsWoChbCpRt7PlBqiQza
	tkfXRrodgDVichjWLrqmnVrods4Lba1h9U53+g1zeBdKxxd+6CYMLtDpUW0XBkggPUrvMtLyQudX1
	VYZBd6LJ0UB3Vx8Qs20GHZWgc1KCt4ssI6xePa34xXk6L/21j/hq0DK6v9jw80lgq+U06+8M+NLhc
	QyMI2ex8Mr0De5Ao/F7PA/XKQ9xhlUkVa90NJFN9lFMhF6kVEqM+9tL9hsR6sRn6NP/dQNiDwTzv6
	Rf/e6upyg7IpN9yCudwrWBmE7bRIhBj0jIg8Mletp/sQg7JDcNFAWu/QNne90d1lWB54YTZozNTII
	07bs2J7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMBpH-00000007Oef-15wF;
	Thu, 20 Nov 2025 21:04:23 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMBpE-00000007Oe9-0d8G
	for linux-nvme@lists.infradead.org;
	Thu, 20 Nov 2025 21:04:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 70C0140954;
	Thu, 20 Nov 2025 21:04:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E534C4CEF1;
	Thu, 20 Nov 2025 21:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763672659;
	bh=D6UrdPQuPLa1mnOY4xB+Z4g11uxAOCrC9tuUkAZw2Tw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZA6BhQiTL0+adEMBD5DPDx0J/6ODDMmzTfAVgUirHZp8qPOJm19aqk6ahj+u327ch
	 kBQEu4nm0hPNqccOeQla9JFlt7WNYEFmoz+cjCl8n8y+abVF81nsK6YKI28MxNIFqc
	 3lG+g9065tJzAc+geqyCnQMdD68vp7HBKshTg2YPoGoVM9rNhyV123ecYjtg880f6C
	 pvHLoCQ3rYKMyT+a0hYHfcayji+IsdwCpZzyot0S5NxpjS/M3Amqz/c19sgY05AOb9
	 oYqWMlSAR1ecCq6Km0/8iv+xD8jjbMZpeN5IrAzwj64+3B5IJhtjTWUUNFPv1ARaLw
	 ZigO6j24fkkew==
Date: Thu, 20 Nov 2025 14:04:17 -0700
From: Keith Busch <kbusch@kernel.org>
To: Thomas ten Cate <ttencate@gmail.com>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: "controller is down; will reset" on SK Hynix NVMe drive in
 Lenovo IdeaPad Pro 5
Message-ID: <aR-CUUzWzQKIAfqx@kbusch-mbp>
References: <CACbz5yFi8hiPD0Avg=KVTpdEeJC=3MMSkGtYOBQ=OmB_O0khyQ@mail.gmail.com>
 <aRzb6U1se40SrQRM@kbusch-mbp>
 <CACbz5yE1RNmJkg-RSBe2u60Y5yd1zxkEZ=pVy_gTa2JLh9d5xQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACbz5yE1RNmJkg-RSBe2u60Y5yd1zxkEZ=pVy_gTa2JLh9d5xQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251120_130420_233863_4185D9AE 
X-CRM114-Status: GOOD (  21.67  )
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

On Thu, Nov 20, 2025 at 02:52:22PM +0100, Thomas ten Cate wrote:
> On Tue, Nov 18, 2025 at 9:49 PM Keith Busch <kbusch@kernel.org> wrote:
> >
> > The "report a bug" message was originally pointed at hardware vendors
> > rather than kernel. Something is wrong with the SSD, the PCIe slot, or
> > both if the power features cause the endpoint to drop off the bus. The
> > only recourse we have in the nvme driver is a quirk to disable APST for
> > the device. The driver doesn't control the PCIe ASPM settings though, so
> > that would have to be a different quirk if it's really necessary. Do you
> > need all three of those parameters, or is disabling the nvme driver's
> > apst sufficient on its own? These parameters do have a negative impact
> > on your machine's power consumption, so you'd usually want to hone in if
> > it's just the deepest power state or if every power saving feature
> > really needs to be disabled.
> 
> Thanks for your reply!
> 
> Just `nvme_core.default_ps_max_latency_us=0` appears to be sufficient,
> so presumably it's the drive, not the bus. I wouldn't even know where
> to begin reporting a bug to the manufacturer.

I assume vendor 0x1c5c for SK Hynix, but we also need the device id to
make a quirk. You can get that info from sysfs, for example if your
device is enumerated as "nvme0":

  # cat /sys/class/nvme/nvme0/device/device

There's two quirks we can try: NVME_QUIRK_NO_DEEPEST_PS first, then
NVME_QUIRK_NO_APST if the first one wasn't successful.

