Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19A84D74941
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Oct 2024 21:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OQshMJFfFtPYi6vvIhN0JGDxAluaqJifVuFMeb8aH4E=; b=Zt+sO22ikImt8gK2wm60fa5vPm
	hjbeqTh/Dp6Cuz/D9V+4fq3QNb6xb/9Jyn3jHcFri4YeEjXR4O1KxSW3nYU/k2R9Eji2Z8i3Zaysb
	GL9gKhZ77M5yG/ntVswPl8EsMuHWKpsBmXcixMYKudbEogL+NnbIl+cot8+YZJvCeXa9qu4gfWCrT
	O+PMQUk3Jrd7Me7yoUdIXInXEoQSRtpbj82aHfMD0un0OUl+6n2piTYcnVDAvWhbytAU4H7+6+GG/
	t2Y0A+COm1QHOqSNSkThNBlodsDEHYdkkxVx5NjncCZTHh3e2J/nohygYpnQthGD3cW3Y4B+llgGt
	7RSNDYRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5txN-0000000FyC7-2GeL;
	Tue, 29 Oct 2024 21:40:53 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5txK-0000000FyBK-3PLg
	for linux-nvme@lists.infradead.org;
	Tue, 29 Oct 2024 21:40:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 2A9955C5620;
	Tue, 29 Oct 2024 21:40:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7AB3C4CECD;
	Tue, 29 Oct 2024 21:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730238049;
	bh=hHya4CFWWb9IorKtvtVVxz2dO0bXEsa0J6T54piHyvw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Djatruc70fMox7Zoi6qtwtgU4iCwwXMXuw9Bf62dCNMei5GIcjJD9t2Y/ahwZpZbF
	 b+ClRYRx5PnFK7468VU4FlgzDob3tEca2+cGL06VurZHzZTuSWuqsUty7qtt0Qye4R
	 J2mLZ2GL9nUF5S00tlDONog/BGvM4BZfq+IxJ/3vJqk7UG0gpxfPXtOUgmYJtQ9kcs
	 DEanJCXZS6x2DWxNjbqMa6/5S0YlnTvs+4pQchAT/8QVwoAT5B9gZnB1Q7o3DF3RH8
	 jaErNIzyq5SzHSEicPlImnwvvKwuSwQ4epnLsKcnFLwG1aQf7RkiLvhtN+V6sfbTLN
	 rZKOxayvBqYXg==
Date: Tue, 29 Oct 2024 15:40:46 -0600
From: Keith Busch <kbusch@kernel.org>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
	asml.silence@gmail.com, anuj1072538@gmail.com, brauner@kernel.org,
	jack@suse.cz, viro@zeniv.linux.org.uk, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, linux-scsi@vger.kernel.org,
	vishak.g@samsung.com, linux-fsdevel@vger.kernel.org,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v5 08/10] nvme: add support for passing on the
 application tag
Message-ID: <ZyFWXqinEAjuJtfe@kbusch-mbp.dhcp.thefacebook.com>
References: <20241029162402.21400-1-anuj20.g@samsung.com>
 <CGME20241029163230epcas5p18172a7e54687e454e4ecb65840810c4e@epcas5p1.samsung.com>
 <20241029162402.21400-9-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029162402.21400-9-anuj20.g@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_144050_913839_790ACD24 
X-CRM114-Status: UNSURE (   7.69  )
X-CRM114-Notice: Please train this message.
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

On Tue, Oct 29, 2024 at 09:54:00PM +0530, Anuj Gupta wrote:
> From: Kanchan Joshi <joshi.k@samsung.com>
> 
> With user integrity buffer, there is a way to specify the app_tag.
> Set the corresponding protocol specific flags and send the app_tag down.

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

