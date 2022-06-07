Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FB73C433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jun 2022 22:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HuB1jWioLMXlYJD2qIMa5ZfKhKkJtdvCJWpX1KJyM8s=; b=wl30x+5uPKE/lkp0eVMc1PFY8y
	jUhLTctjUlPryAnL7JLcST0/NUHm+eeFr2vfV1p4W9C0QdyZwGDLW9kXGC090CJHSYBI++1pqgP3U
	s+L5x6Ibqfl5GOP7CyLvQqAgRotegzadFv3Rv8WpVlZWgGfP3tPwaJVNoUNhwGUH/08koSj0Zrnh2
	rZ6VeCecNG3y2ovTmXeIorqu+gTwWd8kdoZyBRMst+rnvNRy7d4OtejymfQ3O9WVr37ahedPRL5QJ
	tI1o3jE1bKgHFqY8aV9rRUGUC19u0oyR4Dlc7b+GwVo67mEynokKczoa6eeRBcKm8s2F1RyQ6jKzW
	AbrQTAVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyi7E-009xEh-3W; Tue, 07 Jun 2022 22:56:00 +0000
Received: from todd.t-8ch.de ([159.69.126.157])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyi77-009xDf-Al
	for linux-nvme@lists.infradead.org; Tue, 07 Jun 2022 22:55:55 +0000
Date: Wed, 8 Jun 2022 00:55:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
	s=mail; t=1654642548;
	bh=GKmspcdBAWIOqR/3BljCxm3zwnJIjgIflR7y21vWpks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CgIjeww94QAkYJqcJd8V0NONcKTg2eSKdj8Km8wlj2XIm3HhwZjhvGB6Jhs0wrTlT
	 kx1VGh9lfaALmdiDdJkxxy35Mc0R7bMjwYNGNCJ725ll1UqXG37I+0Zm7XeKzvWOgX
	 ZveuXD2IozmQoV5qSTGebeKEIDxXFp0VeJh/5kxg=
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: add device name to warning in uuid_show()
Message-ID: <169e1083-3d0a-42e0-a600-c41b275623ee@t-8ch.de>
References: <20220607155555.8623-1-linux@weissschuh.net>
 <Yp94yTFrrkbBYqsj@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yp94yTFrrkbBYqsj@kbusch-mbp.dhcp.thefacebook.com>
Jabber-ID: thomas@t-8ch.de
X-Accept: text/plain, text/html;q=0.2, text/*;q=0.1
X-Accept-Language: en-us, en;q=0.8, de-de;q=0.7, de;q=0.6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220607_155553_564737_DEBA51BB 
X-CRM114-Status: GOOD (  12.16  )
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

On 2022-06-07 10:11-0600, Keith Busch wrote:
> On Tue, Jun 07, 2022 at 05:55:55PM +0200, Thomas Weißschuh wrote:
> >  	if (uuid_is_null(&ids->uuid)) {
> > -		printk_ratelimited(KERN_WARNING
> > -				   "No UUID available providing old NGUID\n");
> > +		dev_warn_ratelimited(dev, "No UUID available providing old NGUID\n");
> >  		return sysfs_emit(buf, "%pU\n", ids->nguid);
> 
> The line split was correct to prevent this overly long line. But otherwise,
> this looks good, though I'm wondering why this needs to be printed every time
> someone reads the attribute.

Sorry about the long line, thought it looks nicer on one line and other
(similar) lines in the file are also using up to 100 characters per line.
Do you want me to resend it?

No idea why has to be printed every time. A dev_warn_once() would be less
spammy.

