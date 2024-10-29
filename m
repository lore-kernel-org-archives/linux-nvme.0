Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB122D3A678
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Oct 2024 17:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+Zm8oaXlmXBIoGQ+veipBJfpBwl93YFe5RUpRCSHyPY=; b=P+1hWUhnBWffrDk4tnz1KxZYkx
	VXUuuVtZh9fdbiNGJTMg6mCO9DiVUTkHiorvSkIIooxCSKzRR0Elg/eMB1i3OzPbc8HmOUSYOUz/S
	ZpDOLkVCgvEIfV7SplkiMSmRAmR72b2a7oO+Z4bAP65baY2M6Ie/O6PjHl5DBA7whziS4LyOyHoj0
	aBUOqXMyxQjlHvn9T8WT22RDPmLJdD6TmwAT6rkgprEn/g/V/AlW2P4S0ab6iuHDYsWV6Gap+ifNc
	Z3TGTHeumA0vHGX/yFbbbtErio5Sm0SVBm6j0n8q7GrYxzx7Cn6FURAoUuoew1qkK9uhSWCDnuvEr
	CHwV4r9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5q85-0000000FHeI-3dva;
	Tue, 29 Oct 2024 17:35:41 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5oD6-0000000EwFY-2Niv
	for linux-nvme@lists.infradead.org;
	Tue, 29 Oct 2024 15:32:46 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 72B79227A88; Tue, 29 Oct 2024 16:32:39 +0100 (CET)
Date: Tue, 29 Oct 2024 16:32:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: Michael Kelley <mhklinux@outlook.com>
Cc: stuart hayes <stuart.w.hayes@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lukas Wunner <lukas@wunner.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>,
	David Jeffery <djeffery@redhat.com>,
	Jeremy Allison <jallison@ciq.com>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Jan Kiszka <jan.kiszka@seimens.com>,
	Bert Karwatzki <spasswolf@web.de>
Subject: Re: [PATCH v9 0/4] shut down devices asynchronously
Message-ID: <20241029153238.GA26979@lst.de>
References: <20241009175746.46758-1-stuart.w.hayes@gmail.com> <BN7PR02MB41480DE777B9C224F3C2DF43D4792@BN7PR02MB4148.namprd02.prod.outlook.com> <SN6PR02MB41571E2DD410D09CE7494B38D4402@SN6PR02MB4157.namprd02.prod.outlook.com> <2024101809-granola-coat-9a1d@gregkh> <ZxInC1U7WiB7FNkJ@wunner.de> <2024101808-subscribe-unwrapped-ee3d@gregkh> <7ec51cc8-b64f-4956-b4e6-4b67f1a8fa76@gmail.com> <SN6PR02MB4157B4916F2B8581B9C6E214D4422@SN6PR02MB4157.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157B4916F2B8581B9C6E214D4422@SN6PR02MB4157.namprd02.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_083244_881726_FE25117E 
X-CRM114-Status: GOOD (  13.79  )
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

On Sun, Oct 20, 2024 at 12:24:32AM +0000, Michael Kelley wrote:
> Yes, I agree that a single core system should be able to get multiple
> NVMe drives shutting down in parallel. The parallelism would be
> governed by the number of worker processes that the workqueue
> decides are needed. I didn't look at how it makes that decision.

Or we could just go back to the old design where one methods kicks off
the shutdown, and then another one waits for it, which requires no
extra threads at all.


