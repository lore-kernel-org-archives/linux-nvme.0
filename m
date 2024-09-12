Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AEC1EED601
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Sep 2024 13:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GH0x62wguGVfEaPQ4/mMjSek9VkAJmbOgepYDy0YKW8=; b=k/lTfK0s4s4eDkaHahRfHo9bMi
	t1PuwgiVLcGkW+FNlJZdOBpfjGzH/f1Bc9zdYRiJE3qv9aSYtEUq1j0YKYbNNKD3Tx0xYNqvrHdk1
	eARLQZKesXANG/WK0B0wX/8+dcKUjf9iffpyUJA99vO6PLNWxXvzMtLzHyamj+3eXLgUPRswct72m
	x0ghGV7mVvUcZa6rJ4q3CeMhaijnbybS6cRkTlwZ97FGUJaNM7vMDL2Ymreo3jHY4f+Ms7+VcNOkw
	oXu1AonaVj8XSPs5h7fdrm/Bv6OqjxuukOON4607djzanRKTkDJtnfvZsqkmINtchf8Yl036lCOJs
	8IyibXPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sojfG-0000000DACZ-1DXu;
	Thu, 12 Sep 2024 13:15:14 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sojfD-0000000DAC6-31hi
	for linux-nvme@lists.infradead.org;
	Thu, 12 Sep 2024 13:15:13 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 276EA227AAF; Thu, 12 Sep 2024 15:15:07 +0200 (CEST)
Date: Thu, 12 Sep 2024 15:15:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, song@kernel.org, yukuai3@huawei.com, kbusch@kernel.org,
	hch@lst.de, sagi@grimberg.me, James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH RFC 1/4] block: Make bdev_can_atomic_write() robust
 against mis-aligned bdev size
Message-ID: <20240912131506.GA29641@lst.de>
References: <20240903150748.2179966-1-john.g.garry@oracle.com> <20240903150748.2179966-2-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903150748.2179966-2-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240912_061511_930216_39A36AEA 
X-CRM114-Status: GOOD (  14.57  )
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

On Tue, Sep 03, 2024 at 03:07:45PM +0000, John Garry wrote:
> For bdev file operations, a write will be truncated when trying to write
> past the end of the device. This could not be tolerated for an atomic
> write.
> 
> Ensure that the size of the bdev matches max atomic write unit so that this
> truncation would never occur.

But we'd still support atomic writes for all but the last sectors of
the device?  Isn't this really an application problem?

If not supporting atomic writes at all for unaligned devices is the right
thing to do, we'll need to clearly document this somewhere.  Any maybe
also add a pr_once to log a message?


