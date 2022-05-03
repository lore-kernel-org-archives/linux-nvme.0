Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56EF5C433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  3 May 2022 20:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=78yEy+j3Zjc215IXMjRZUfu1k4KqIwD0sQggWNAmfvs=; b=4R620y1aiW8w5vk+/lL/kSVAjl
	RPYFON41Uh919Uf4Tax4n0hB2Eq9mUaJvwhwJJOhudTayimOvbrC7X1GQI/ZAfv0ftUNi+9sCu8lH
	yX8Yl6yaXYEc1XoW2nNb5KM3Vsx+PddytmAeLBA8pcVG2xJCIZ66pDyuzIoRnElWWSvgRYvp/JMB8
	HuC63bdEZ/Py9ePKlIdu5ax1ZDnzsM3LQ6BFuZE7V1yIwXdlgo7x3tcDrvGJxz3BeclQx+MdOvi7a
	t5R/62M8PAvSmXju0JKjXCnDI35ZAAtzNZqJ5+LK+PoOw4ihjA4HnjCs03+gBC7XDAcYfZjamLmSz
	SrOan60w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nlzYO-007eXu-NP; Tue, 03 May 2022 20:55:28 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nlzYM-007eX5-8r
 for linux-nvme@lists.infradead.org; Tue, 03 May 2022 20:55:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 8DE4F68B05; Tue,  3 May 2022 22:55:22 +0200 (CEST)
Date: Tue, 3 May 2022 22:55:22 +0200
From: Christoph Hellwig <hch@lst.de>
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, asml.silence@gmail.com,
 ming.lei@redhat.com, mcgrof@kernel.org, shr@fb.com,
 joshiiitr@gmail.com, gost.dev@samsung.com,
 Kanchan Joshi <joshi.k@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH v3 4/5] nvme: wire-up uring-cmd support for io-passthru
 on char-device.
Message-ID: <20220503205522.GC9567@lst.de>
References: <20220503184831.78705-1-p.raghav@samsung.com>
 <CGME20220503184915eucas1p2ae04772900c24ef0b23fd8bedead20ae@eucas1p2.samsung.com>
 <20220503184831.78705-5-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503184831.78705-5-p.raghav@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220503_135526_498586_D58132ED 
X-CRM114-Status: GOOD (  12.71  )
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

On Tue, May 03, 2022 at 08:48:30PM +0200, Pankaj Raghav wrote:
> operation NVME_URING_CMD_IO. This operates on a new structure
> nvme_uring_cmd, which is similiar to struct nvme_passthru_cmd64 but
> without the embedded 8b result field. This is not needed since uring-cmd
> allows to return additional result to user-space via big-CQE.

So let's have a discussion for everyone on whether to reuse the existing
struct or not.

Pros for reusing:

 - any application that is passing around a nvme_passthru_cmd64 doesn't
   need to do special marshalling

Cons:

 - these fields are pointless

I'm fine going either way, we just need to think about the implications.

Otherwise this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

