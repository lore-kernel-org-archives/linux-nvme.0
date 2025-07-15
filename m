Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0407BC83F36
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jul 2025 15:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4r2JaeQGWIH6DnAapOQ/t1cDd5i/7zsM+XiVjzpRVhM=; b=Od4e8cWD+kdCKz2p+/IZ/yIxza
	1l0xaO+KFYb/AqiC6d4IF6pzkuBWavnDyc9fdPVgn6vQD5W7OCk8CYFFGkHuKXJMLn53lwOVcsMp8
	a7Hz0REdYgaEQDCY/Sr5YlbOO1d56kj2LOQG3NAqloz4ld6OjYUj8Kj4LIkqLCuns930eWI7dD6Ay
	RtHNEAivuNBPe7Ig9C5z3FMdfkwmLA/FyabT32fzO5VdLY3yA+X1qHL6aDRvaoqi5bUz4fl4zainb
	8RJz8ZnWXTePpsIIeuAsMk8lca3xu//ajVbHDuX4GrNKwnH4Pk6a4FfsxPaVPpTKn5SaWjO8FrfNd
	9GMZ+qUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubhCu-00000005WQ9-2MFa;
	Tue, 15 Jul 2025 15:04:36 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubfjP-00000005DNx-3ZMo
	for linux-nvme@lists.infradead.org;
	Tue, 15 Jul 2025 13:30:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id CAE55A56F57;
	Tue, 15 Jul 2025 13:30:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB6DC4CEE3;
	Tue, 15 Jul 2025 13:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752586202;
	bh=o7WWAS+C4c0kp5aZTPJ9hm5Yc9ScIUQnTbsZg8H/h9Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b0N51nNt6seMVjEsBZ4+xjN+eGaCtEIVidQrfUX2jB0Wk1O89FFoNMaJWMWdXONoB
	 mPIP7LaHf41MspgXpMq5P283pV7VOCY88f0IAMnAl/SlS2mfE7JNjtlBruXQDe881B
	 +FDCzn+wWEDNV75KullTr+KxmldLDOJ1Y5EEyJLlqa4scMziYqtWoFjIEWfbPEYajU
	 IKi4WVZ4jdDW3czWGuccxIqXJznXIaKCXcVwycgtrfjAH5+qirNHIhBsHu4wmpavSa
	 yDCOSmnPpZVmtDncyTRiNTrH7KuiHnJMGVoU8eGQHHZw74LIr0cNLUcb65fITkEGT4
	 xHasdWvhJb83A==
Date: Tue, 15 Jul 2025 07:30:00 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-pci: try function level reset on init failure
Message-ID: <aHZX2OloBVXiE_8k@kbusch-mbp>
References: <20250714171328.681885-1-kbusch@meta.com>
 <20250715074558.GA20362@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715074558.GA20362@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250715_063003_953322_DD68376E 
X-CRM114-Status: GOOD (  21.80  )
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

On Tue, Jul 15, 2025 at 09:45:58AM +0200, Christoph Hellwig wrote:
> On Mon, Jul 14, 2025 at 10:13:28AM -0700, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > I've encountered various nvme devices that for whatever reason are stuck
> > in a reset state. Historically these have required a power cycle to make
> > them usable again. Vendors don't report any problem with the device when
> > we ship these for analysis.
> 
> Who is the "we" here?

Meta.
 
> > In many cases, a PCIe FLR is sufficient to restart operation without a
> > power cycle. Try it if controller reset fails the first time.
> 
> Why is that only done in the probe path and not the runtime reset path?

nvme_pci_configure_admin_queue() is called for both probe and
reset_work.

Is it because I wrote "fails the first time"? I mean the first reset for
each initialization attempt, whether it happens during probe or a later
reset. The code path will try an FLR on every single nvme reset if
CSTS.RDY doesn't clear as expected.

> > +	if (result < 0) {
> > +		struct pci_dev *pdev = to_pci_dev(dev->dev);
> > +
> > +		result = pcie_flr(pdev);
> > +		if (result < 0)
> > +			return result;
> > +		pci_restore_state(pdev);
> > +
> > +		result = nvme_disable_ctrl(&dev->ctrl, false);
> > +		if (result < 0)
> > +			return result;
> > +	}
> 
> Either way this warrants a big comment explaining what we are doing
> here.

Sure, no problem. I think also a dev_warn() if the 2nd disable_ctrl call
was successful to indicate an FLR was needed to get an expected
response.

