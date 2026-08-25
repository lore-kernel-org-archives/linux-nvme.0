Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1C62C5DF81
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Aug 2026 00:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9mrOq5pNWRQKbPuwbSb5LK9W7IPmqYibvjgO/RM65Q4=; b=PvH4U+SAh3TTa6C+DklcnGXk+N
	Cs2Y+0gK+1y64khzcLnJL6zN+tLwaCv38i+ZPEk3+ErSHf3vyTZRMuwuf5qb3+qndw6oYM9DxIlLa
	R8MuPOouEmsPMeqcPHqXCgjkj05Eq7Va0Y2LI1sBstQSRqAlha4IrkW93OKOLw9xP0AMTG+Ajop+A
	RScuucWateiPP/P3Ykmyu4p7WkleK3Pj9lkNfMf8ijNL6Y4eQ6A+6Xx4Sa/1BDD1wDmne9GNHTCX5
	roUPymcm8bpVfUhNFIcWuh2un+gXsW54HXntnEmtOsB16zWdeYDdSEdJwIaZ2L900pAZxhlCCbLmb
	uCMF5gVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyfSX-0000000HaSx-1h1d;
	Tue, 25 Aug 2026 00:56:13 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyfSV-0000000HaSm-3ky6
	for linux-nvme@lists.infradead.org;
	Tue, 25 Aug 2026 00:56:11 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A617B41968;
	Tue, 25 Aug 2026 00:56:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A40B1F000E9;
	Tue, 25 Aug 2026 00:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787619371;
	bh=9mrOq5pNWRQKbPuwbSb5LK9W7IPmqYibvjgO/RM65Q4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NPLfckCLQaXfHbqkRFWFAiTnDhqLS9akLW7M3/LDalnh+j3XMUJcxvtCaZEzIP6wz
	 7c4UcXCbA3nswl4Aby/5I1esorynKja7DmodMICZBymVQN8eW0+7wi2zOifBemXfa3
	 wBjzWgTc5Lhx0vTWMwpvr2kwn5r1+0bD8JYoKE6WuXluayZGI8UAUdNTlFRkm0QInn
	 JrV0+w3/yxr4uy5dO4dcYrLvXacVeCw9XsAZ39Qo7Sw5xjDT8tyVtTVT8MyapsSNP1
	 InHDyAnQzXkfe2NTZTAMTQnBbHkdSO04lNQ1/N/m506F1c+Qr37dH7EyzroInKhYSu
	 WX/2nNoPrzHzQ==
Date: Mon, 24 Aug 2026 18:56:09 -0600
From: Keith Busch <kbusch@kernel.org>
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] nvme: print namespace IDs as unsigned 32bit value
Message-ID: <aozoKQQDkNaEOhre@kbusch-mbp>
References: <20260821230310.3937527-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821230310.3937527-1-mkhalfella@purestorage.com>
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

On Fri, Aug 21, 2026 at 04:03:09PM -0700, Mohamed Khalfella wrote:
> NSIDs are 32-bit unsigned values, but a number of log messages print
> them with %d. An NSID larger than 0x7fffffff is rendered as a negative
> number, which is confusing in the kernel log and makes the message hard
> to correlate with the namespace it talks about. Sparse NSID spaces
> where high NSIDs are common are the most likely to hit this.
> 
> The nsid sysfs attribute has the same problem, and there it is worse
> because userspace parses the value.

Thanks, applied to nvme-7.3.

