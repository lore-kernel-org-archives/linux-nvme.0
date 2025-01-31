Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D4EAC02193
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Jan 2025 07:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/spkH1pKYercYbyT/E6E97zXxyDNQ/J3zchf7N5fbd4=; b=QFIQprRB1+tdEClb4xW54caHPK
	YsypEwcQKnBOAWlKV3Akk2OELW2p7NHXN7isHofEnT7fjtAlio1eYmxCn6V15YYtqzZzzspG0bhrJ
	7D4mTDJfLmq0zZLcW0IutWLu2i7j0JhawA97NuWxbgrATfoAVr2u6DLVPhhgDMX5iXdgH8BJ/YclO
	/vJyami6SpS5u4L/FMJIy5WW2JYizMaQRJ7gZ4zk5KKEehsWdUw8c9fkKf59pMVHoXCJWuCKm03nw
	mjl8fuQXcQGpsbulvAD+iH7o2w39ug8jQkMyE+4nsHxyn649zk4R/CE5yHw3JhN5sET1DEIuKQZ/N
	YfexwwCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tdllS-0000000A8yp-1sQ8;
	Fri, 31 Jan 2025 07:48:34 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tdllQ-0000000A8yV-1tDL
	for linux-nvme@lists.infradead.org;
	Fri, 31 Jan 2025 07:48:33 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C668A68B05; Fri, 31 Jan 2025 08:48:28 +0100 (CET)
Date: Fri, 31 Jan 2025 08:48:28 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	pmenzel@molgen.mpg.de, Keith Busch <kbusch@kernel.org>
Subject: Re: [RFC PATCH] nvme: replace lazy sgl warn with informational
 message
Message-ID: <20250131074828.GA16628@lst.de>
References: <20250130175131.3613423-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250130175131.3613423-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250130_234832_633260_5AA5E4CF 
X-CRM114-Status: GOOD (  15.26  )
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

On Thu, Jan 30, 2025 at 09:51:31AM -0800, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Instead of warning about the device's SGL capabilities the first time we
> consider using them with a passthrough command, print out what the
> device is capable of during initialization. While we're at it, print
> other interesting capabilities that may be useful to know when you just
> have a dmesg. The ouput format was inspired by other existing subsystems
> like pci.
> 
> And example of the new message when used with a default qemu nvme
> emulated device:
> 
>   nvme nvme0: sgl+ meta-sgl+ sed- vwc+ apst- dsm+ wz+

Printing out the capabilities sounds really useful.  But I don't see
how this is useful for replacing the warning about the unchecked
passthrough?


