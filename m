Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F109FD116EA
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Nov 2025 05:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l1eIbKtcI47ARmgDaF6pAjkz2qY2W5DPgqZvQZUd/7A=; b=YK4G+5KUHDM04WwAhcG1X1nmEm
	EMu4F+g8X7gBLJhW3wyXUiu/ULwZoHzyLybRcCylMU6yxHTdz7iXKl4vvIeHmmz2bGfzy+IuC9qjV
	mdah/K/mtv/SoSnayF0YejIdhaqqLVTw7b2gkDXjPulugcES27um6e4YMnVjVLr2leZ/GBtcMCTqW
	UC5cje0QvoNKmmknNTbfh+3m7kNl4dSP7CfxiG9hDciEQmO9C0yVSzR1QUm51a0ZHouw8tN68UFSl
	rL7eUopOWIQNUytIvLU9cJ65btRYUmptdoNmY+AwivrEZK9ig4hWBfiGibBjLlMy3+bcoCLw9nOag
	VHsy+o7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOrRp-0000000015h-2wtc;
	Fri, 28 Nov 2025 05:55:13 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOrRo-0000000015K-0I0V;
	Fri, 28 Nov 2025 05:55:12 +0000
Date: Thu, 27 Nov 2025 21:55:12 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Stephen Zhang <starzhangzsd@gmail.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, nvdimm@lists.linux.dev,
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org,
	gfs2@lists.linux.dev, ntfs3@lists.linux.dev,
	linux-xfs@vger.kernel.org, zhangshida@kylinos.cn
Subject: Re: [PATCH 1/9] block: fix data loss and stale date exposure
 problems during append write
Message-ID: <aSk5QFHzCwz97Xqw@infradead.org>
References: <20251121081748.1443507-1-zhangshida@kylinos.cn>
 <20251121081748.1443507-2-zhangshida@kylinos.cn>
 <aSA_dTktkC85K39o@infradead.org>
 <CAHc6FU7NpnmbOGZB8Z7VwOBoZLm8jZkcAk_2yPANy9=DYS67-A@mail.gmail.com>
 <CANubcdXzxPuh9wweeW0yjprsQRZuBWmJwnEBcihqtvk6n7b=bQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANubcdXzxPuh9wweeW0yjprsQRZuBWmJwnEBcihqtvk6n7b=bQ@mail.gmail.com>
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

On Fri, Nov 28, 2025 at 11:22:49AM +0800, Stephen Zhang wrote:
> Therefore, we could potentially change it to::
> 
>         if (bio->bi_status && !READ_ONCE(parent->bi_status))
>                 parent->bi_status = bio->bi_status;
> 
> But as you mentioned, the check might not be critical here. So ultimately,
> we can simplify it to:
> 
>         if (bio->bi_status)
>                 parent->bi_status = bio->bi_status;

It might make sense to just use cmpxchg.  See btrfs_bio_end_io as an
example (although it is operating on the btrfs_bio structure)


