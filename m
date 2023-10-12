Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0795BCDB46E
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Oct 2023 15:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T3zpYgozpnd/10wuO5XmQO7F83HaI0WjmAIsyPvvXSo=; b=CwR3xk0nmhu8oItq1+UwrZ2N+0
	AjCjoDdZ3B/KbX8sdi5yeqnx1RIuiLEIcJLnAEwKQ5d/zMCqY9m3myZNDTqwP9LLNo6PKl1Sf/RdG
	yQDtKRj22fD5PQz9LmvI7VgTBHM7NH3jSTsUQsTYlXukBshzaV1Nw1ufkgibUUimtToJnGlyGHI4u
	VpLsEC33Y7mTRbDo5pdWrEgg8ofCsI4GofNmi10HY10ELCdPCY+LAkFAFv6WdOqi53eMNXxknyyvR
	LtO083cq76XDiEpGe/5N0AlrFHn3XHvFr7a5fpYNQWwdyseZUnUJNejDKxIWNMjuk5pTDUrmvCnPm
	vHqoA37g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qqxtS-001KTr-2h;
	Thu, 12 Oct 2023 15:46:34 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qqxtN-001KT7-19
	for linux-nvme@lists.infradead.org;
	Thu, 12 Oct 2023 15:46:33 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9FB9668AA6; Thu, 12 Oct 2023 17:46:19 +0200 (CEST)
Date: Thu, 12 Oct 2023 17:46:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshiiitr@gmail.com>,
	Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk,
	sagi@grimberg.me, linux-nvme@lists.infradead.org,
	vincentfu@gmail.com, ankit.kumar@samsung.com, cpgs@samsung.com,
	stable@vger.kernel.org, Vincent Fu <vincent.fu@samsung.com>
Subject: Re: [PATCH v3] nvme: fix memory corruption for passthrough metadata
Message-ID: <20231012154618.GA17670@lst.de>
References: <CGME20231006135322epcas5p1c9acf38b04f35017181c715c706281dc@epcas5p1.samsung.com> <1891546521.01696823881551.JavaMail.epsvc@epcpadp4> <20231010074634.GA6514@lst.de> <CA+1E3r+2Ce4BCZ2feJX37e1-dtvpZtY6ajiaO_orn8Airu2Bqg@mail.gmail.com> <20231011050254.GA32444@lst.de> <ZSbVuuE8YxgwpqM8@kbusch-mbp.dhcp.thefacebook.com> <20231012043652.GA1368@lst.de> <ZSgRWrcw1FFw3XRJ@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSgRWrcw1FFw3XRJ@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231012_084629_559337_57F05434 
X-CRM114-Status: GOOD (  12.52  )
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

On Thu, Oct 12, 2023 at 09:31:38AM -0600, Keith Busch wrote:
> > I don't want that either, but what can we do against a (possibly
> > unprivileged) user corrupting data?
> 
> The unpriviledged access is kind of recent. Maybe limit the scope of
> decoding to that usage?

Let's just drop support for unpriviledged passthrough for now.  That's
easily backportable and gives us time to sort out what we can do.
Probably only allowing it when SGLs are in use, including a flag to
force using it.


