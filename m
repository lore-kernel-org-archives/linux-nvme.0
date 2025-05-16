Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ACE4C3ABDD
	for <linux-nvme@archiver.kernel.org>; Fri, 16 May 2025 06:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bx+PC754mSlUlSTVtXpWXTYEYDK+b+ijbxmpi9e/kUc=; b=4CIk2mvIY6b/X199jaS7+Ug2QA
	MBWeOFKuqygEnazg/gbexpTfpS+6x1k7N/zXyuIHtRLBZ6xQRLQeK72nGvgWgJvha+FI+3ToON/Dy
	lU6bV+Tm5xxUASv74dt6Umq8e+RdWufKLxtZXhm3gj1FL//EisLtQZtdy0bgphYFxHJqr6b0Ix3hU
	zv65dbRfCWv458wAATwDw7p3wv5dSmduCuCp8VbC9l8Aak2AmXpyNgXNQMgAdoLuVhlHVKSXr9UfN
	0vZ3pL8+75+RBzhsziuVh22ffNeBo1TNnfD5n+nP2RXKUfeeEs8686JY1z71KdPw4cCNuxICp6+28
	0CTX+aEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFohF-00000002afH-2xf7;
	Fri, 16 May 2025 06:37:29 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFogQ-00000002aYb-3k1X
	for linux-nvme@lists.infradead.org;
	Fri, 16 May 2025 06:36:40 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id EA37E68AA6; Fri, 16 May 2025 08:36:32 +0200 (CEST)
Date: Fri, 16 May 2025 08:36:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: Shminderjit Singh <shminderjit.singh@oracle.com>
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, junxiao.bi@oracle.com
Subject: Re: [PATCH 1/1] nvme-pci: Add quirk for Samsung PM173X with
 Subsystem Vendor id:0x108e
Message-ID: <20250516063632.GA14830@lst.de>
References: <20250516063059.3456399-1-shminderjit.singh@oracle.com> <20250516063059.3456399-2-shminderjit.singh@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516063059.3456399-2-shminderjit.singh@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250515_233639_072514_EB826945 
X-CRM114-Status: GOOD (  11.83  )
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

On Fri, May 16, 2025 at 06:30:59AM +0000, Shminderjit Singh wrote:
> This commit adds NVME_QUIRK_BOGUS_NSID for devices with Vendor ID 0x144d,
> Device ID 0xa824 and Subsystem Vendor id 0x108e.
>
Hi Shminderjit,

this is an enterprise device for which a firmware update should fix
this intentionally introduced bug that only affects the eui64 bug,
and according to previous communication actually is available.

Please contact Samsung for the fix.

