Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1C93C54EBC
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Jan 2023 14:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TNWQ8z3lRZlzDCw3o2qtxbj+zIgHCPF3v57TT7RGR+c=; b=bCD3fSnbmKrg9R0w/gYBwJMh0y
	BuHochtnYgXk/bosjH/T5nWOi1tBu0qWqfBh+hHzrc5TNor9hWwvV0iu5FC43yhSFNnVDT2RVolc7
	4AmsiTv9j+w0iS2LT95tMyBH4f5F2ge9SN7GmpcTDx4gj9CbAxmp4tJ9b1LBGjF1Onp8/F56Gq//C
	uoqcpVt+pXTUO/kjdpEbb4nQwQY37M5+TEVMAnopsa7f4OV1KH6i/anCGkp7lJc+uyYgZuV4Ihl3z
	Bm/DO2AWWsorJPHZZPrfxpQocJEBugP1KDCpEXXjh8KEtc6y2ID1S0JDAAJd+OF0sGuJVCZ08PAhS
	o4TmfB1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pFyB9-00FHch-1y; Thu, 12 Jan 2023 14:03:39 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pFyB4-00FHYK-Re
	for linux-nvme@lists.infradead.org; Thu, 12 Jan 2023 14:03:36 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3EE9768BEB; Thu, 12 Jan 2023 15:03:27 +0100 (CET)
Date: Thu, 12 Jan 2023 15:03:26 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/3] nvme: don't allow unprivileged passthrough on
 partitions
Message-ID: <20230112140326.GB6416@lst.de>
References: <20230108165033.380842-1-hch@lst.de> <20230108165033.380842-4-hch@lst.de> <df4da166-9fc3-11af-7481-2da452c04d35@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df4da166-9fc3-11af-7481-2da452c04d35@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230112_060335_164437_90902950 
X-CRM114-Status: GOOD (  10.94  )
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

On Thu, Jan 12, 2023 at 02:23:06PM +0100, Hannes Reinecke wrote:
> Doesn't a similar argument hold for ctrl vs ns-specific commands?

Can you phrase the argument?

