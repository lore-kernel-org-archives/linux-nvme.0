Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82BB3C2BA18
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Jun 2024 16:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=rmO7nP1cbPRqhvWC1tb+nbJvj4x3lUl3qHkDLwvVLpg=; b=EfHfmDoZCsA0hf
	eZIereF0BilhWDZvh2EBH08dIOc5y/S7qqWJwYgc1IVqRu5HSgkx6MM+jA9H4asCgo41lj3vVcKFF
	PA4CpHLiyq0KDU1cPSCu5ZtAu0Em/5MpaZ//smsDXj/FtflHcn9KsZ39bTw4Q9BfW7AdGuJ1BsUZL
	uEiv+X0tEsc2+XAGnfAos1x3O9rU+Buvo9kISzTAnr+HUUw+kJWPS3s1bKIBnHWTbjryAIAXFxtBx
	8KTJbVmsoZgfvn5UpaPGXJnjn15vR4nzGseg5qAHER05scm71+Q+jBNnIVDZJHnUYTcTqH9xdhpLP
	FjHMsiHW5hIEcRRDGJTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJbYx-0000000FpDx-2NUU;
	Tue, 18 Jun 2024 16:20:03 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJbYs-0000000FpBb-2BMd
	for linux-nvme@lists.infradead.org;
	Tue, 18 Jun 2024 16:20:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 8CCC5CE12E4;
	Tue, 18 Jun 2024 16:19:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A927C4AF1C;
	Tue, 18 Jun 2024 16:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718727594;
	bh=+I09tVzQ9OtS9eIzACeB4nthPggIMP3+i7udNNOzVvs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=LQzgJSBP7HFiHKA9jkri7zvJ7NUSfYuQQBSgKPuLmObptGzn1arS98vKbeihR775U
	 GHvY/rrf46nqnbW7Q5H/7+Mx9E5qj8hlQr4tOaduAbDwmbMJ86Au5wGhh//4KEaklw
	 nxhZE3I30uqXE+CkTmp3B3jNfcXdL1izhMeP99m81hqG0rJeBW4utT00qWx/s+5eEh
	 pQrr7l25/x7MHNvOuJcGGPDit86H+B4evwMRuPpT1pFyH5f5pbRbx1pbfm5+rzZhv3
	 HR8bVn/gZ3q+2pvNK570jImcDHca2ri4+oU3U2ZtSRd9GholN9FX0lWML3KYovd7y7
	 6qBwy62s+zMQw==
Date: Tue, 18 Jun 2024 11:19:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux NVMe <linux-nvme@lists.infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	gloriouseggroll@gmail.com, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: Fwd: Regression: Kernel 6.4 rc1 and higher causes Steam Deck to
 fail to wake from suspend (bisected)
Message-ID: <20240618161952.GA1258613@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4d09ffc-a8e4-4e9f-9032-7c8583ca6abd@leemhuis.info>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240618_091958_757644_857496F2 
X-CRM114-Status: GOOD (  21.60  )
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

On Tue, Jun 18, 2024 at 08:42:07AM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> Hi Bjorn!
> 
> On 08.05.24 17:49, Bjorn Helgaas wrote:
> > On Tue, Oct 31, 2023 at 03:21:20PM +0700, Bagas Sanjaya wrote:
> >>
> >> I notice a regression report on Bugzilla [1]. Quoting from it:
> >> 
> >>> On Kernel 6.4 rc1 and higher if you put the Steam Deck into suspend then press the power button again it will not wake up. 
> >>>
> >>> I don't have a clue as to -why- this commit breaks wake from suspend on steam deck, but it does. Bisected to:
> >>>
> >>> ```
> >>> 1ad11eafc63ac16e667853bee4273879226d2d1b is the first bad commit
> >>> commit 1ad11eafc63ac16e667853bee4273879226d2d1b
> >>> Author: Bjorn Helgaas <bhelgaas@google.com>
> >>> Date:   Tue Mar 7 14:32:43 2023 -0600
> >>>
> >>>     nvme-pci: drop redundant pci_enable_pcie_error_reporting()
> >>>     
> >>>     pci_enable_pcie_error_reporting() enables the device to send ERR_*
> >>>     Messages.  Since f26e58bf6f54 ("PCI/AER: Enable error reporting when AER is
> >>>     native"), the PCI core does this for all devices during enumeration, so the
> >>>     driver doesn't need to do it itself.
> >>> [...]
> >>>
> >>> Reverting that commit by itself on top of 6.5.9 (stable) allows it to wake from suspend properly.
> >>
> >>> https://bugzilla.kernel.org/show_bug.cgi?id=218090
> >>
> > I don't think regzbot picked this up [...]
> 
> This is still open and it seems nothing happened for a few weeks now
> (sorry, should have sent a reminder earlier, but such old regressions
> have a lower priority here). Did it fall through the cracks or is this
> some good reason why giving up on this one might be the right thing to do?

Thanks for the reminder.  Will work on it today.

Bjorn

