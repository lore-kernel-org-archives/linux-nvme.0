Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E4E2CD1284
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Apr 2024 13:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0X1N9UYYvOoIHwDzXG/BPnFBpS6+JSt/rcrIzGB1s6g=; b=tVhoUlKSewtosQJaqRRaAa1pjo
	9wWcIShfKn9xl9EAyzTGMtNuk4lonA12j7lbB4uPl487MjEjrHbr8Q1OEXb7RYos4yyYwVa0DmTia
	3AYJM1y4wF8sHaKh8YE88fjCI5ulmyGEkA4M0TrzYzNJ7GgyZPwh87wFfOVIzX1JgsQpzaE8aWkyJ
	XpOBnmnJaDN6nvGot1OtlfEI76VmkZDbcnFOvbcR0GCTczgPRK/b9snWUHt32UqribG8X20whfRmI
	iRzUtaLhPbnkOgtXowqGoLSjZ0fwT875C3FHa45VlU/s91GubFJhb7D9R1VRJnbrcBG3ASHwtePjv
	EPLBSYyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rre0f-0000000BJdy-0GKj;
	Tue, 02 Apr 2024 13:17:05 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rre0c-0000000BJcR-11LI
	for linux-nvme@lists.infradead.org;
	Tue, 02 Apr 2024 13:17:03 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 54EA368BFE; Tue,  2 Apr 2024 15:16:58 +0200 (CEST)
Date: Tue, 2 Apr 2024 15:16:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Werner Sembach <wse@tuxedocomputers.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Georg Gottleuber <ggo@tuxedocomputers.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Add sleep quirk for Samsung 990 Evo
Message-ID: <20240402131658.GA31963@lst.de>
References: <20240328130923.61752-1-wse@tuxedocomputers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328130923.61752-1-wse@tuxedocomputers.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240402_061702_446641_38288744 
X-CRM114-Status: GOOD (  14.53  )
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

On Thu, Mar 28, 2024 at 02:09:22PM +0100, Werner Sembach wrote:
> From: Georg Gottleuber <ggo@tuxedocomputers.com>
> 
> On some TUXEDO platforms, a Samsung 990 Evo NVMe leads to a high
> power consumption in s2idle sleep (2-3 watts).
> 
> This patch applies 'Force No Simple Suspend' quirk to achieve a
> sleep with a lower power consumption, typically around 0.5 watts.

Does this only apply to a specific SSD or all SSDs on this platform?
How do these platforms even get into the conditional?  Probably
through acpi_storage_d3 setting, which probably is set incorrectly
for the platform?  Any chance to just fix that?


