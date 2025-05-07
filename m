Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58278C3ABC0
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 08:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eJARfxm0+39wHA/4u7y0NlPT/fQ2d+6Ri6PZT7jZC6c=; b=DUqW2GQ9sGXz1QTL+/tln4sG+e
	NnxHOGGM7ANdC56qcrmsDOEgGxRn+a/lSpEQDMQ3OeX6NKjUC78MvrgLGDgdqvkC+R/6WD+AmMPIT
	zhDzKPdHwk5FSVsWdv7kTJ0tYvBhA45umBvfF3r6KdigQ4Z03hQrDSICRu/HZRxkbtVhcftTauTuW
	F+dVdbiRGBkIfzV2sixz63wX7AEY0ZiLQbHHzL3K91AIi3wxstAr9VOFI0NodGamrqNMkxIWKAvd0
	Tq8kEMJhaFU125naUTYtTXaCVHRB3JD2mRBD+BTpImviLMms/r4vd6ckLpim7H9m4IV6pQtjnIutF
	maxT4Ziw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCaEY-0000000EkuD-2Pfz;
	Wed, 07 May 2025 08:34:30 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCZHc-0000000EYBm-3F1P
	for linux-nvme@lists.infradead.org;
	Wed, 07 May 2025 07:33:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id CCDBC61165;
	Wed,  7 May 2025 07:33:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EEF5C4CEE9;
	Wed,  7 May 2025 07:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746603215;
	bh=afWqG/R7TN9TKobKBvsdst+25REk/GXNuaWsR37ZBCY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EZuYRFgYiK3OA6ItVj4l2hEAHn7PWB6HiLrE7rQ7kSyg9/rnNii+RLIR6fyvBO2yy
	 pEx+qQ3oqyBwaaqosHgs/5SVM3Ccpuuyo9g41OoSnghe/gfHjNTNPXsuXdacN+rLXw
	 XDzF4SUD4yfqTx7ArYcsDP0TYZwrYS7Drq5KBDaUnPKHpcy+DWr6IDMgs//HG8vUIE
	 zFYlT6IQDP69Eix1QD6wBLAXIqfeBV/r3VDMEg/87M5Zq0j1mkszgZ4c6QJfruUar0
	 /OrhIpGdpKbHtOUG1RZkUWiqr8nuhIC4KUMx0vcrvx77gSt5v/poaFTAKyHwNbg1r+
	 oyVnJ5U1gJ17w==
Message-ID: <cff6113c-d289-4cbf-aadc-a5b5fe16dc3b@kernel.org>
Date: Wed, 7 May 2025 16:32:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] pci: nvmet: support completion queue sharing by
 multiple submission queues
To: Wilfred Mallawa <wilfred.opensource@gmail.com>,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: alistair.francis@wdc.com, cassel@kernel.org,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>
References: <20250424051352.7980-2-wilfred.opensource@gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250424051352.7980-2-wilfred.opensource@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 4/24/25 2:13 PM, Wilfred Mallawa wrote:
> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> 
> Hi all,
> 
> For the NVMe PCI transport, the NVMe specification allows different
> submission queues (SQs) to share completion queues (CQs), however,
> this is not supported in the current NVMe target implementation.
> Until now, the nvmet target implementation enforced a 1:1 relationship
> between SQs and CQs, which is not specification compliant for the NVMe
> PCI transport.
> 
> This patch series adds support for CQ sharing between multiple SQs in the
> NVMe target driver, in line with the NVMe PCI transport specification.
> This series implements reference counting for completion queues to ensure
> proper lifecycle management when shared across multiple submission queues.
> This ensures that we retain CQs until all referencing SQs are deleted
> first, thereby avoiding premature CQ deletions.

I reviewed this series but please note that I have been reviewing this code
off-list with Wilfred for a while. So given my familiarity with the code, I may
be missing things here and my review may not be as precise as it should.

Other reviews would be nice !

-- 
Damien Le Moal
Western Digital Research

