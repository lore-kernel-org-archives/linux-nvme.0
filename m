Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3DC8C7115E
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Aug 2024 04:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r7KG6YcE1YWqYR/M9AlBrq6h1v4K2mlOwgUQMtVHcvY=; b=Zxkz/Ylyd4vkss9M21SrY4lHjv
	cT+YABzHCC4uzYylo8luYnObb7RkBuJunCg5zBGnixX4BLmovA9Qpv/EyG2+9q/4nTTy/l/E7NTLu
	eikYY+veDI+nfGgR4v+/oHLcJ6vESB4MOczegGrsXVaY0fTtGucK71o/KFxpxnESEDg2lUdRTYE+n
	DoCNHgQemT9DlcN9xn2dudaXssKT6aFzLHrGe68tQj27f7eb873VcYR7OguASIlPEjR4ezWc1gNNX
	BvXI6UUk/C3juoB+CdeFK9zT8HgC78iRYvUWUAATDWAHUw4BHqJRx01W9PWXN1UbSPCj6s9gxh+3G
	7CQrD45Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjWOa-00000000RKg-2lTW;
	Thu, 29 Aug 2024 04:04:28 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjWOX-00000000RJy-35Dh
	for linux-nvme@lists.infradead.org;
	Thu, 29 Aug 2024 04:04:26 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id AAEF568AA6; Thu, 29 Aug 2024 06:04:21 +0200 (CEST)
Date: Thu, 29 Aug 2024 06:04:21 +0200
From: Christoph Hellwig <hch@lst.de>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, kbusch@kernel.org,
	martin.petersen@oracle.com, asml.silence@gmail.com, krisman@suse.de,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	linux-scsi@vger.kernel.org
Subject: Re: [PATCH v3 03/10] block: handle split correctly for user meta
 bounce buffer
Message-ID: <20240829040421.GA4211@lst.de>
References: <20240823103811.2421-1-anuj20.g@samsung.com> <CGME20240823104620epcas5p2118c152963d6cadfbc9968790ac0e536@epcas5p2.samsung.com> <20240823103811.2421-4-anuj20.g@samsung.com> <20240824083116.GC8805@lst.de> <20240828111806.GA3301@green245>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828111806.GA3301@green245>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240828_210425_936841_E337A8A4 
X-CRM114-Status: GOOD (  13.15  )
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

On Wed, Aug 28, 2024 at 04:48:06PM +0530, Anuj Gupta wrote:
> I can add it [*], to iterate over the entire bvec array. But the original
> bio_iter still needs to be stored during submission, to calculate the
> number of bytes in the original integrity/metadata iter (as it could have
> gotten split, and I don't have original integrity iter stored anywhere).
> Do you have a different opinion?

Just like for the bio data, the original submitter should never use the
iter, but the _all iter. 


