Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D57C5C433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 06:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OhsdEnAukNI20LTHcjGG/0AGZZHeA54ZVlUkdNpxkNI=; b=On0OxQJvieH/8G8S4H021OASPr
	EDAVJ88Ce1JeeA8TkKKIn1ztxAi7HaItjL1j/3U28mdnJh62PKoUzhw0mMwk7YdvceHsH6pEcag00
	gEYwJWBXCKr0LBz+6YtRyGrGNyHB2S1rOr6V/7yTuRpaUvlNYUOkhjB/dBM8dU3F3YP11Gf9oc9Xh
	4xl5oqpCh0Dx6kaxmTrNm1vLj7NAEA636m3ZvFQpIrsMrIq2Fv0P2w4zE24Hamg6uqQPj3omVXHp/
	im2sfQhg3IBypmwGKtLm2+JlK41IaDISZJxYTZPNZ8k9CjjHkFX+EoyBJfUuwST9uoYPB/eCkEKzh
	Retj66Rw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oseUz-00B6r3-O3; Wed, 09 Nov 2022 06:23:45 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oseUs-00B6qP-Hj
	for linux-nvme@lists.infradead.org; Wed, 09 Nov 2022 06:23:39 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 49BAC68AFE; Wed,  9 Nov 2022 07:23:31 +0100 (CET)
Date: Wed, 9 Nov 2022 07:23:30 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Uday Shankar <ushankar@purestorage.com>, linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Jens Axboe <axboe@fb.com>
Subject: Re: [PATCH v2] nvme: scan sequentially only when list scan
 unsupported
Message-ID: <20221109062330.GC10528@lst.de>
References: <20221107195443.2176099-1-ushankar@purestorage.com> <Y2rpIJ9lSJYnb+GG@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2rpIJ9lSJYnb+GG@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221108_222338_764580_BEF5B486 
X-CRM114-Status: GOOD (  11.92  )
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

On Tue, Nov 08, 2022 at 04:41:20PM -0700, Keith Busch wrote:
> Looks fine, but I really don't look forward to finding out how many
> devices, if any, were secretly relying on this fallback.

I'm a little worried as well.  Maybe we can whitelist a few status
codes as suggestions that a device might just be a broken.  I.e.
"NVME_INVALID_FIELD | NVME_DNR" would very much be an indicator of tat.

Also Uday, the return value from nvme_scan_ns_list can and should be
dropped now.

