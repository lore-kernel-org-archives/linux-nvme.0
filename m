Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBADDC41535
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Dec 2023 05:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qXSwiMyevTCwgRYJgVeUenyFL/zIkFiaGnBZObbX85w=; b=xW3dGF4mRU+nQrO38wyZLF0g83
	IpWfQEAipL7XyoDRf68P6I2iVb4KjhATLI0zZ7uSe9JfV3xVysU5jKoJSTAHCoqj1IeTVxIjTNto/
	uIJnBsSihTNAFKj704uj41ehx83t+A9ZkCbuZPw22UBJbpHrGT08b+w4D17I9u59z5FOmSF+1USU3
	3FuV59CvP6NbT83c4MPtYv2jIttO+hSl9EyFyjQo71fvV6qhRbeyCGW467zts3LHWATTPomrhZtzo
	9mghUIF4wAdQnpY3gi9rWZDl+mCJtHekJRk90uTw1KdwE/CenG3ifX2Fdo88sgYfchWZgKtbHURzV
	XOdXruBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFStY-00Cunj-0T;
	Tue, 19 Dec 2023 05:43:56 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFStV-00CunM-1u
	for linux-nvme@lists.infradead.org;
	Tue, 19 Dec 2023 05:43:54 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id CE54C68C4E; Tue, 19 Dec 2023 06:43:49 +0100 (CET)
Date: Tue, 19 Dec 2023 06:43:49 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jeremy Allison <jallison@ciq.com>
Cc: jra@samba.org, tansuresh@google.com, hch@lst.de,
	linux-nvme@lists.infradead.org, gregkh@linuxfoundation.org,
	rafael@kernel.org, bhelgaas@google.com
Subject: Re: [PATCH 3/3] nvme: Add async shutdown support
Message-ID: <20231219054349.GA892@lst.de>
References: <20231215000358.1203338-1-jallison@ciq.com> <20231215000358.1203338-4-jallison@ciq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215000358.1203338-4-jallison@ciq.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_214353_797847_6A82D81F 
X-CRM114-Status: GOOD (  16.47  )
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

On Thu, Dec 14, 2023 at 04:03:58PM -0800, Jeremy Allison wrote:
> From: Tanjore Suresh <tansuresh@google.com>
> 
> This works with the asynchronous shutdown mechanism setup for the PCI
> drivers and participates to provide both pre and post shutdown
> routines at pci_driver structure level.
> 
> The shutdown_pre routine starts the shutdown and does not wait for the
> shutdown to complete.  The shutdown_post routine waits for the shutdown
> to complete on individual controllers that this driver instance
> controls. This mechanism optimizes to speed up the shutdown in a
> system which host many controllers.

I had a really hard time trying to understand this patch.

Please split switching from the bool shutdown to an enum (with initially
just two values) into a separate patch.   And the names really confuse
me.  I would have expect something like:

	NVME_DISABLE_RESET,
	NVME_DISABLE_SHUTDOWN_SYNC,
	NVME_DISABLE_SHUTDOWN_ASYNC,

then again mixing two rather different concept (reset vs shutdown)
into a single enum is also not very helpful (but neither would be
two bool arguments).  Not really sure what the right thing is, but
as-is it feels pretty obfuscated.


