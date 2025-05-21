Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 528F8C54E71
	for <linux-nvme@archiver.kernel.org>; Wed, 21 May 2025 06:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z4CxfUEoyc86g5444JK2tr2lcshI0ghBPe/+ti4egkU=; b=r79dmODgKCl8s84a/J4JfPawth
	R2IlIj6n0P7k+4cqcE27xlooWBwyoWvjl3+Jpfirdr88DIFrRX1S7yt7g3/M9XHMbl/yzNPHTX3bt
	XV+pneiirrXwsgKHHIIbeuOQd/7jPpT1lMPofaR/HHnbovV03VA+0xdkf6KjZ5bhpZwjQIM08lN/j
	wP7p+ue8ljfBS/vK9lRPytpy23NFQhrnSR7wrt7H4CCuigEeff4jfJMPDB7vgOZPXjZz4A3EhBhwL
	Rm6x9GrOifX65iY4lMSh/3O+66AcyjpXpl0ILYiNriqvXRbtEf7J5XRmo7MpBBPNCeAMzG7M/0J4h
	TyDdtY9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHciT-0000000Euzr-1O0t;
	Wed, 21 May 2025 06:14:13 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHciQ-0000000Euz2-3jA6
	for linux-nvme@lists.infradead.org;
	Wed, 21 May 2025 06:14:12 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id D9A6068D17; Wed, 21 May 2025 08:14:00 +0200 (CEST)
Date: Wed, 21 May 2025 08:14:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH] nvme: fix command limits status code
Message-ID: <20250521061400.GA3539@lst.de>
References: <20250520202037.2751433-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520202037.2751433-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250520_231411_065411_4F77F54E 
X-CRM114-Status: GOOD (  13.54  )
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

On Tue, May 20, 2025 at 01:20:37PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The command specific status code, 0x183, was introduced in nvme 2.0
> specification defined to "Command Size Limits Exceeded" and only ever
> applied to DSM and Copy commands.

Yeah, that's weird.  Chaitanya, did you implement this off an early
draft?

> Fix the name and remove the incorrect
> special handling for it.

Where the incorrect handling is the mappings in nvme_error_status
and nvme_status_to_pr_err?  Yes, limit exceed should not be a not
supported, so this looks fine.  But it would be good to actually
spell that out in the commit message.  I'll fix it up if you don't
object.


