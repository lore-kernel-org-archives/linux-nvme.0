Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59235C021AA
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Feb 2025 15:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lIIj+oqt2PMCaA+O9oKOfDgn6l7+YLTv5fEwnHdDFm0=; b=cnxxOKDv0Jz0D9qP6dIRtHsEG6
	XXERet/xXF2Gb+XNQXjXsX0w7JIGRHpLcTWaHgxxJ3UAGcRnJmFI81F7FF2BGa5BhgN1yUkDRl8Vz
	nlqphRjHDAlUW4rrkK/cFyGqvaWSUbupl4U1JSRaTkUgrNkOI8loXOv5KABb/WN8yP7isgZq3t0MF
	TtugmxRU12uCEEuYtUfAGKrxmXadAD1xYzYap0RpmBFIyOvSv/H4XRh01jedVEHyDSTY8kz6uAwMk
	/JRN9EIWP1lXoew5mV9jNB7Ol0xR/bF/dUb4f+mpZKHg9us8DvR3Z0Z4Ivkf90Jm39FpVspo6ymOn
	MDfeRTrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkPmo-00000008oTe-3TrG;
	Tue, 18 Feb 2025 15:45:26 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tkPmm-00000008oSY-10ZX
	for linux-nvme@lists.infradead.org;
	Tue, 18 Feb 2025 15:45:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 776FC5C4CCD;
	Tue, 18 Feb 2025 15:44:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF650C4CEE7;
	Tue, 18 Feb 2025 15:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739893523;
	bh=5JfDhTzXE81b3tFt5BfLH1mIZ5uJJ+J8yZNrB4+zJhM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fjXvQnhUTNziYvvtNYmEV28btTN+TMox1tAYDrpbp7zISgYRnfXZA+72qmvVfQW8d
	 ezUSJu3hoZVtWBCylybJJT2IFEOo/tqH6tmjz1GGZBUGA8pu9YsEfB85VW6ktrnx9r
	 INFyLgjkZmlxBNLSPu55QBgLTotMCsbQXCaUx7wYVHWyImnVw/o4PRU1Y98ZhsPRZp
	 PkbFutleDBDTJBmZFgMP5yQwmxF6jQBB7tn2qbaVSeI9DBXzp/h2gqCXHnyuR/pYBQ
	 +D3AxwznbMzuBbyv6DyoWe81x1PHFNXa7q1fqH3MaG8UEsWuFCmT4mSEqQfYf4+Bnm
	 SrFm8nhMoAh6A==
Date: Tue, 18 Feb 2025 08:45:21 -0700
From: Keith Busch <kbusch@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v3 0/4] nvme pci-epf target and tcp host fixes
Message-ID: <Z7SrEWGwmTzztO6I@kbusch-mbp>
References: <20250213065231.598527-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213065231.598527-1-dlemoal@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250218_074524_327205_81908FD8 
X-CRM114-Status: UNSURE (   9.64  )
X-CRM114-Notice: Please train this message.
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

On Thu, Feb 13, 2025 at 03:52:27PM +0900, Damien Le Moal wrote:
> All,
> 
> 4 patches in this series to fix some issues with the PCI endpoint
> function target driver and a trivial fix for a compilation warning with
> the tcp fabrics host driver.

Thanks, applied to nvme-6.14.

