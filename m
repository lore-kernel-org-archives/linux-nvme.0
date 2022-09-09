Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4565CECAAD3
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Sep 2022 15:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZjQfAC4r33ZqjukyiKEjxTM5P4f80QTOV82z/KdNZqE=; b=PPQxuTAH8RO9VM6TJDc0Pz4Bb/
	zBjlUzCLmLk+oOWYySalBhJRA12ew7SsxFUJ0NbT0OvXDH3SCo1wDMD0M3nEc7dlBBocCjuJE63vo
	BRQ4DOS+6njbbhZhnvtVjQp8WtTctex2InYIX3Jbk+D/hdoxy9e28il9btVLULT3AthdwLMcINIvW
	/oCm5bIx1d9j3H52EvU/Mq6yoCs6dIxlwOjKZ7LcX9pvvFnlmSUROEDFCovwiojrcPHJUgMi1FRlJ
	rbsSdE21hCbIHT/mvajXwcU6VSrYbwRfmgLHi36LTWZDZT3YjyzmdnMsWalvCyUmnenPtFvjc5kb3
	MggvDOAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oWffK-00HEiS-EW; Fri, 09 Sep 2022 15:11:34 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oWffH-00HEPR-GI
	for linux-nvme@lists.infradead.org; Fri, 09 Sep 2022 15:11:32 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5C7BF68AA6; Fri,  9 Sep 2022 17:11:27 +0200 (CEST)
Date: Fri, 9 Sep 2022 17:11:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@fb.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme: restrict management ioctls to admin
Message-ID: <20220909151127.GA12466@lst.de>
References: <20220908213517.3085323-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908213517.3085323-1-kbusch@fb.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220909_081131_709320_6863F3DE 
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

On Thu, Sep 08, 2022 at 02:35:17PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The passthrough commands already have this restriction, but the other
> operations do not. Require the same capabilities for all users as all of
> these operations can be disruptive.

Where "these operations" are: NVME_IOCTL_RESET, NVME_IOCTL_SUBSYS_RESET,
NVME_IOCTL_RESCAN.  Yes, I think those are very disruptive and the
definition of what CAP_SYS_ADMIN was designed for, but that should
be spelled out in the commit log.

That being said I think we should just do the capable() check in the
individul ioctl opcode to document things better, even if that does't
currently make any difference.  Any we really need a FIXES tag going
back to the addition of the first of these ioctls.

