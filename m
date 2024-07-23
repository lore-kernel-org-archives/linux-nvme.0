Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70722C3DA63
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jul 2024 14:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=owE3vSdzEcFixOsPczrZbNy87m7u7eybUs53G1BnTvA=; b=3gXHH8VJW/C+lQaU9GrNsDWmxI
	unfJuwEXqbjDvooTtlImawqdMqwV+8pudWUuvflKffhphsy3KEaXL8azjFEx3p36SvkSrqjNv2jiq
	MujWCEG8e0pw8p8/xQZhFewsY6dLQItMl3c1yEez1k17g2oZjLgCKJjwkxHPIL9/B4mXYWF/eBZ68
	F+5tD15T6r2KXtCoP+4fGXlHsu35J3F6Ns3OsZW3YgwGhH373gBQMc2pSCT3b29nGerw+yOWU7pdT
	mQu4KwoTmFqhGIAcs4FsMQFZjz+lLSWExeim+sbW/fl6J46mE0ZkNqpKOtI0/lYlq4CphNdxeF+ng
	FY81LKUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWGg9-0000000CkC2-0eRW;
	Tue, 23 Jul 2024 14:39:49 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWGg5-0000000CkAr-3IPC
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jul 2024 14:39:47 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id D747068AA6; Tue, 23 Jul 2024 16:39:37 +0200 (CEST)
Date: Tue, 23 Jul 2024 16:39:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: Pratyush Yadav <ptyadav@amazon.de>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: do not set the NUMA node of device if it has
 none
Message-ID: <20240723143937.GA20891@lst.de>
References: <20230725110622.129361-1-ptyadav@amazon.de> <CAFL455=O23ci6GCzdnJr8DmyVSXAD=ctmj4AEk=XfSSLjbUQYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFL455=O23ci6GCzdnJr8DmyVSXAD=ctmj4AEk=XfSSLjbUQYA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240723_073945_989141_2025207B 
X-CRM114-Status: GOOD (  15.32  )
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

On Tue, Jul 23, 2024 at 11:49:24AM +0200, Maurizio Lombardi wrote:
> FYI, we have received bug reports because of this patch.
> All single numa nodes like a VMware guest or a system set to interleaved mode
> will now see -1 as the numa_node attribute.
> 
> Apparently, some applications like Lightbits do not expect to see -1.

But they can see the same for all kinds of other devices.  I can't see
how we could cater to this kind of behavior..


