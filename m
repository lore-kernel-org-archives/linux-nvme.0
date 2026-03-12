Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9E9CFED2D9
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Mar 2026 07:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pXvo3yJ4J5+BbHI17sHgJmQardAP3YIzeCxyY0UcpQY=; b=ikm3ZxT5nAuIKRwdgStYt+qdJi
	QQoWpLo0x3Vs4WOxzYfPQm9Cje8TyDlRBe0nlU1m9O4Iz39a83lZzqJsCl+kI04ZBU5w+YbsIAns/
	5qXyswq6MH6rAwhHfKIlY+wxbVDmseiofLr/dce5qeTXT12WTj8jVtH0yTjLk3q/kaPJQP/Wlz2dU
	dJzUVTmO2oHtFRq8YDJZH+On2xc8S7f8QZz2GzTwvO0C3iV6gfegX6DLWXhYJ0SFOgDIzFbk27ep1
	DA4SMl03ga1RasvdenrZmw2Cqzq5pdhP5jM20T6I3p7M/LdBwnf1O0if4Yl1fR6aNqMHEKI97Tmgi
	lHWNQlsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0a5Z-0000000DVy2-3BFo;
	Thu, 12 Mar 2026 07:04:09 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0a5X-0000000DVxZ-1Rbc
	for linux-nvme@lists.infradead.org;
	Thu, 12 Mar 2026 07:04:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C9A3268BFE; Thu, 12 Mar 2026 08:03:55 +0100 (CET)
Date: Thu, 12 Mar 2026 08:03:54 +0100
From: Christoph Hellwig <hch@lst.de>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-tcp.h: correct kernel-doc comments
Message-ID: <20260312070354.GA27358@lst.de>
References: <20260312051431.684352-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312051431.684352-1-rdunlap@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260312_000407_523547_548585D6 
X-CRM114-Status: GOOD (  12.41  )
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

On Wed, Mar 11, 2026 at 10:14:31PM -0700, Randy Dunlap wrote:
> Mark reserved fields as "private:" so that kernel-doc comments are
> not required for them.

I'm honestly not sure the kerneldoc makes any sense for an on-disk
structure that has an external specification.  So insteada of these
hacks, what about just dropping the kerneldoc comment entirely?


