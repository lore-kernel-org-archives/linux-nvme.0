Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE7C0C61DA4
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Mar 2023 13:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xxal/J1IMOjtCtbUg6cFk8WbaVc2ytWnWuU4TCGQJ3w=; b=zLwSncTL7k6v0wYp4wmceKZthg
	T4pp9icCr4VplFgA1ns0LZ+93d0a7bDuSaQcWhS5qPuRjAquApn9FsZgoHPq5GRRz3/V36rOHKfD4
	oi7Zgd7FX7RcpJ2pqp+WKGU/UTDWnhM0FtCdyCkjIMgBjvSokF/lU8NJ+H4I9NOJUJITapwhFttj1
	8d2GeLRMcSea3nNBkVDdBFN4b/Sxh1H2s7mmZm3NYDH0gWC8cqyT6eSevTghiDCY5Er788zryfqBl
	61GTNjejtkPYA6NvDK/Y/Rmz9S7x1EZNbVwuNMrk0gKePDRALRu/FS1tBicW5lFAnLEPSZCIeuF4B
	sSSZxndA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pcRHx-00DSfk-0Q;
	Wed, 15 Mar 2023 13:35:33 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pcRHu-00DSf5-0k
	for linux-nvme@lists.infradead.org;
	Wed, 15 Mar 2023 13:35:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B9B1267373; Wed, 15 Mar 2023 14:35:26 +0100 (CET)
Date: Wed, 15 Mar 2023 14:35:26 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH 2/5] nvmet: Fix Identify Controller handling
Message-ID: <20230315133526.GB24915@lst.de>
References: <20230315105939.305825-1-damien.lemoal@opensource.wdc.com> <20230315105939.305825-3-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315105939.305825-3-damien.lemoal@opensource.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230315_063530_414231_3F4E9D19 
X-CRM114-Status: GOOD (  11.12  )
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

On Wed, Mar 15, 2023 at 07:59:36PM +0900, Damien Le Moal wrote:
> The identify command with cns set to NVME_ID_CNS_CTRL does not depend on
> the command set. The execution of this command should thus not look at
> the csi specified in the command. Simplify nvmet_execute_identify() to
> directly call nvmet_execute_identify_ctrl() without the csi switch-case.

Indeed - same as the last one.

