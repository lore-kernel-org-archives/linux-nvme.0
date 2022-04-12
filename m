Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C086C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Apr 2022 18:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BsanHeC4rW6D0OCVv8MUUxUHJaB0aFW9VnloIEl4pZc=; b=cCtz/hy7h/MnO7i5kkXZXbR2RW
	pZh6VDRib9ZeWNhHMNwKiiTCx7k8xMz8fd0pWlg0PVfQ5I/FwCj7+ShBngeC2tJ9ovETRRrWOMiwU
	DUEt9dcV5eU70g+B+6lFZRfGdeZGvyTqQOSwmADKC9+ar0QuztgXFXQcppO174MfKjYFJpnfBFdjx
	4P7y8o0qESmVE26ic0msKfK8yr4V70eyhoU76LQfgf7tA7ffC6ItPnVnhJ7xfkZz4Ee2EWcbrfrjk
	hJ/iPcUKCZ3CB6swELUjukwcADqAVJ9H67GDMvXw/Bbl60+jpFXpGCpGQKLQ7lyIxYRHHSEud2DGO
	VC/Hnn9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1neLWt-00FTlh-6L; Tue, 12 Apr 2022 18:46:19 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2
 (Red Hat Linux)) id 1neLWr-00FTlZ-El; Tue, 12 Apr 2022 18:46:17 +0000
Date: Tue, 12 Apr 2022 11:46:17 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 4/4] nvme: check that EUI/GUID/UUID are globally unique
Message-ID: <YlXI+dfftyuoJPPG@bombadil.infradead.org>
References: <20220224192845.1097602-1-hch@lst.de>
 <20220224192845.1097602-5-hch@lst.de> <Yk+KO8hEYpnKdGu3@garbanzo>
 <20220408052907.GA31990@lst.de>
 <b395277c-5721-4773-9bbc-13cfbc1b0401@www.fastmail.com>
 <20220408161052.GA28661@lst.de>
 <YlB1E/p1uqpl3HiN@bombadil.infradead.org>
 <20220411050533.GB13927@lst.de> <20220411055455.GA14480@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411055455.GA14480@lst.de>
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

On Mon, Apr 11, 2022 at 07:54:55AM +0200, Christoph Hellwig wrote:
> It would be great if qemu could switch to a new PCI ID after this is
> fixed as that simplifies the quirking.

Thanks,  I think it's worth to re-iterate why:

The most directly visible problem is that this breaks the                                                                                                                                     
/dev/disk/by-id/ links - all devices would have to point to the same                                                                                                                          
one, and which one actually shows up is somewhat random.  This basically                                                                                                                      
means random corruption if people actually use the links or the uuid                                                                                                                          
functionality in any other way.

  Luis

