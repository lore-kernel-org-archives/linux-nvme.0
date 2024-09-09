Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC3BBECE588
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Sep 2024 20:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hPiKzQ2MFgE8BNowohQU42Vyju/yIvsh/2C5Lasvj9c=; b=2mZG9pMgGuahb1raoZiisYMCGh
	pZxWTqUc9amih0DimUL19VMoALvKTV2xrvHwjc364rZErEVr7mD4eqyMiBieoSOyBvglfdwl7Kpc3
	5rq2+SnC6a8cj0eRIqOkL/cWqwHIWb0efl3exqc1AB2XlpduMwAnBmv3WzsxzOsDP8vzwH8vhfn2S
	1agriLna0lEqnsKG3Y2lbLdw7MGM9UEHBAY/nCAn/8k9v5everjwN20zqO20vKaXwfoxkPbFlGDnE
	IKa0qJXv+CJDAQqk1DRDVpCCMfLiO5B7penBk7RLB3mMhPpirs9b1Ax+oKVMUG9Ykr6Kwk+zHusvb
	3VUacoWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snl3f-00000003F0T-0dW2;
	Mon, 09 Sep 2024 20:32:23 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snl2H-00000003EkX-3OPg
	for linux-nvme@bombadil.infradead.org;
	Mon, 09 Sep 2024 20:30:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hPiKzQ2MFgE8BNowohQU42Vyju/yIvsh/2C5Lasvj9c=; b=MVE4BxzGQdJ74a4mS+kwBR1h3u
	HCwBLsIKiiscT2NcrvIFqyds1q4V3G+RJbjsvKDvNrmW2xqXVUSHhklRBXulTsOFjps+z9uRpGSay
	JGoYLLIxyslVu3Wi2YjR+M69o02LLaZVq4rXo8ydf1b26IqcZPApYwKVGXuqN3r7i9YoQril15N6C
	DdE2kdnUDnnTza1cWfrsESSbZf22BOpWkvxVFHcEoqwzOgntXdu1CpnnEVEPiCGcynSzjhrb/sAvZ
	1AvOzXnHvwX4J7S00b3HYonCP79vm8Fp/oJLRgfBFkf1oj8vuUuMul+YIdmiEs+7tiNxMh9cpFrfu
	0uOgX1Ow==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1snl2E-0000000H9JD-2Yxy;
	Mon, 09 Sep 2024 20:30:54 +0000
Date: Mon, 9 Sep 2024 21:30:54 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: cvam <cvam0000@gmail.com>, kbusch@kernel.org, axboe@kernel.dk,
	hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Typo in the file 'feature-and-quirk-policy.rst'.
Message-ID: <Zt9a_lSCXWwXKdDk@casper.infradead.org>
References: <20240909200253.19818-1-cvam0000@gmail.com>
 <8734m8h9ce.fsf@trenco.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8734m8h9ce.fsf@trenco.lwn.net>
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

On Mon, Sep 09, 2024 at 02:15:45PM -0600, Jonathan Corbet wrote:
> >  =======================================
> > -Linux NVMe feature and and quirk policy
> > +Linux NVMe feature and quirk policy
> >  =======================================
> 
> A nice touch would be to adjust the width of the "====" lines to match.

Actually, I wouldn't.  The tooling only complains about lines which are
too short (and honestly, I wish it wouldn't).  Lines which are a bit too
long are fine with the tool, and I don't object to how they look in a
text editor either.

