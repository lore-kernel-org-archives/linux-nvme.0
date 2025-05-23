Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1CABC54ED0
	for <linux-nvme@archiver.kernel.org>; Fri, 23 May 2025 14:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jJyk0CEej0Uj/+fdqtMTkAt3miWuSMwyOlZecgXIxWQ=; b=DEJhe3bhKa6LlZWPPJwHBmbKrP
	X7vX5bk0qQi4WNTPU33zZ2k035EjOx4xpFmFipi2963KOr1oMi6v3ZVKhjqsLE2AkniHmbaiPLWNA
	aNx9eitp9fDbcR5zxEYOm1jvDRnwjFKNlhDcE50W4/wHWBaVZ6EzWGNK4dI0mewDWhtG6KBRetOkW
	UPupkIjrcl5ENuryV+Kl04qz3j6j51Q+/LsZ9RcBy16rRWmZnFY9mIJbOqkqUC7a0T7PUpHjkzq6W
	6dPsdueoCti/YR7C1W5qO35m2IClGGn3XyU1br77+YIBPoHmuFPOAkjxp+1Mp0qnpX39Ha+0PXB3H
	VXIiV28w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uITbq-000000046ii-1rzu;
	Fri, 23 May 2025 14:42:54 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uISle-0000000417i-0kWx
	for linux-nvme@lists.infradead.org;
	Fri, 23 May 2025 13:48:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8BD0743550;
	Fri, 23 May 2025 13:48:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12FA9C4CEE9;
	Fri, 23 May 2025 13:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748008137;
	bh=CeQL813KTKaDoNfewIcVNz20KXODZ3WH7x4GImGwJyA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DWVqpn34X0SRNI5jAJ5XhNvNx8heDzL8DwIlnnamlxem/vydmXt/JasLzCreQ09Zg
	 DddLj4Eu8IYMCzUh8nsE1VND2DwFGoIt57JbxJ5pS3tZc/7xYWrER1Jiv7dqvetCXM
	 cB4AL07X3zQUxAT8RjZfVv+qG7U3x4KRgnUAP4T+wLQ7xfkghw5Ghg05T5mYavBNqb
	 CwVqj/3JHr00UCu7LE8kCwfUsZUkA8oJJPu3FWn6/DnQ7b0zjuabSlNp9wau+mffdv
	 3AnuC3aYdIePZeR465+JNsB/Bh2X6vNTQtqN9ngZ6S80OftHDm+Md+1TtsdIBVaLMf
	 UR5lgMm0a/0cA==
Date: Fri, 23 May 2025 07:48:54 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/5] block: add support for copy offload
Message-ID: <aDB8xmc3Up0STRVO@kbusch-mbp>
References: <20250521223107.709131-1-kbusch@meta.com>
 <20250521223107.709131-3-kbusch@meta.com>
 <aDBuQbsBRVjOc5wU@infradead.org>
 <aDB3lSQRLxjDHTSE@kbusch-mbp>
 <aDB6Hdp9ZQ1gX5gr@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDB6Hdp9ZQ1gX5gr@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250523_064858_234092_1AC07F62 
X-CRM114-Status: GOOD (  13.74  )
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

On Fri, May 23, 2025 at 06:37:33AM -0700, Christoph Hellwig wrote:
> On Fri, May 23, 2025 at 07:26:45AM -0600, Keith Busch wrote:
> > Darn, this part of the proposal is really the core concept of this patch
> > set that everything builds around. It's what allows submitting
> > arbitrarily large sized copy requests and letting the block layer
> > efficiently split a bio to the queue limits later.
> 
> Well, you can still do that without overloading the bio_bvec by just
> making bi_io_vec in the bio itself a union.

I like that idea.
 
>  - bio_add_copy_src not updating bi_size is unexpected and annoying :)

Ha, I currently have the submitter responsible for bi_size. Your
suggestion will make this easier to use.

