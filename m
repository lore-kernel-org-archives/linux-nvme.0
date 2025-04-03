Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81131C3600C
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Apr 2025 04:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qSfNYgqqT1ClQvZAxDyZWAOfkgEyeEYfn//cCD2fBp8=; b=cfLk/ipDUozUi4L7UcE7dQq6s/
	upMj3u025FCuoGL3h7+pKV7DcC3WFYeq6/iIF0DX2DpNT0Bs5vJaoL0Sv3cjCQCGXJoUInjFXBURn
	0KK2Wt0tQDG7WeioRoWH45NrnR0nDPn+7pGKjvBsBJb0/ZopAiDJ1fFgeLfWGBXBCmzDnM7yN7waJ
	yMpBpmphiE3JntcfK8Jeq4gkEznSX8bdz3qBuj2yz28eh7uhh0Y0ayKN1HQYXGjMlj4e1njFt9kz5
	IOEHOE6GJwcrBXaSbsDgNChJWW0A2xDk1UBBIocEa87L9bp+XoLLrms5s3pKAoLsk/Fw9EhX4rGgO
	jKaLxMnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0CB7-00000007kBt-0HPx;
	Thu, 03 Apr 2025 04:27:45 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0CB3-00000007kBP-27Mt
	for linux-nvme@lists.infradead.org;
	Thu, 03 Apr 2025 04:27:43 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1928868C7B; Thu,  3 Apr 2025 06:27:38 +0200 (CEST)
Date: Thu, 3 Apr 2025 06:27:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: Marcelo Moreira <marcelomoreira1905@gmail.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	kch@nvidia.com, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	~lkcamp/patches@lists.sr.ht
Subject: Re: [PATCH] nvmet: replace strncpy with strscpy
Message-ID: <20250403042737.GE22360@lst.de>
References: <20250401004748.29172-1-marcelomoreira1905@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401004748.29172-1-marcelomoreira1905@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250402_212741_703064_399D93FA 
X-CRM114-Status: GOOD (  10.99  )
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

On Mon, Mar 31, 2025 at 09:47:28PM -0300, Marcelo Moreira wrote:
> strncpy() is deprecated due to its lack of NULL-termination
> guarantees and unnecessary zero-padding of the destination buffer.
> Use strscpy() instead.

Nothing explains here why it is deprecated and why the replacement
is better.  And why using memcpy or a seq_buf wasn't considered.

> Link: https://github.com/KSPP/linux/issues/90

And these kinds of links are actively harmful as the point a
commercial entity that can be taken down or changed at any time.
Don't do that.


