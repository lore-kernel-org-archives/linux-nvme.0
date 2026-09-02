Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFD8AC624D3
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2026 14:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R0LVgooeP7EDhzvUlS5w7vYWpDtTQOAQZMfBxqrZe4o=; b=cuUiuL0QTNf0Ljf2MOGiMs6MMz
	RdJssYfRIko4HUwLPeq5bhOJQSLCaDwezcYzte3lPgPMJ7QTxB+CqC8+McO2DC6etyc7ROe6zNLs5
	dQ3Zs8UQjNqX4uRyHJFXNdvd4DBEs8D7t/yLnbpPq1rADXU1OwXNw7LznBtLo9ieiKG/kTN1NmvFA
	P4Gm8/l0L/k2YHW0aXDNJa1EzinPYimyP4jY3sDpE+IUcyFBRfeC8Oybui2LE+HE3MuA1qAtlfY1E
	ArXbmV3DVCC//IbIyDwWrdK9Uz3iGEfdZWjB5gPbVCNejuO96AfGUYvXCNThXblYWhaOr/Io033Xo
	I4EJhNew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1lto-0000000EwCD-3FlA;
	Wed, 02 Sep 2026 14:25:12 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1ltn-0000000EwBv-2CE5
	for linux-nvme@lists.infradead.org;
	Wed, 02 Sep 2026 14:25:11 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 86A0D600D2;
	Wed,  2 Sep 2026 14:25:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA0621F000E9;
	Wed,  2 Sep 2026 14:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788359110;
	bh=R0LVgooeP7EDhzvUlS5w7vYWpDtTQOAQZMfBxqrZe4o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ip7vSIpu/3lvRrXQXgDbDbG0fj/EQ20go7rTZ3N2cLyOLTx/QGB6TxgnqbF1sjLv0
	 prfJm5uA9dVh5HWUQKh2iZ49b4JmTtfQQHVq69MbNqjDhrECzetUAxqGYyzy2R6UTB
	 exOuwxmdbLiMudaJAvBUWkROVBSnRfyKMdCgSaZzMNu9Ciq5UuwL3ae8cdvQCk9KIi
	 cB8BMlHgmYjR/WwARWL7UmpWWXVd+wKerSSGgjMishCUhKeUIsC2ZJIujB7Ai9kE4r
	 e/I6jO8/lsG3pY9V58ZNjIfNkia5vQjOQBGT9TWPA32tBZoR35FHtN5PfB1TYjDfP5
	 8nbRR5sQGzypA==
Date: Wed, 2 Sep 2026 08:25:08 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org,
	sagi@grimberg.me, axboe@fb.com, john.g.garry@oracle.com,
	wenxiong@linux.ibm.com, gjoyce@linux.ibm.com
Subject: Re: [PATCH 1/2] nvme: keep transport module referenced while head
 node is open
Message-ID: <apgxxA6IwejAyAFJ@kbusch-mbp>
References: <20260831152006.819471-1-nilay@linux.ibm.com>
 <20260831152006.819471-2-nilay@linux.ibm.com>
 <20260902133104.GA20945@lst.de>
 <c725f90c-b119-4669-afb7-6aeb6c4a308b@linux.ibm.com>
 <20260902141347.GA24385@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902141347.GA24385@lst.de>
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

On Wed, Sep 02, 2026 at 04:13:47PM +0200, Christoph Hellwig wrote:
> On Wed, Sep 02, 2026 at 07:39:32PM +0530, Nilay Shroff wrote:
> > So the practical problem is that an open multipath head can continue to
> > be used after its underlying transport module has been unloaded. The
> > proposed change keeps the transport module referenced while the head
> > node is open, preventing the module from being unloaded in this
> > scenario.
> 
> But why do you unload it in the first place?

I don't think there's a use case to do it on purpose. It'd probably be
by mistake or mischief. This seems like a reasonable way to remove that
foot gun. We already do this for non-multipath, too.

