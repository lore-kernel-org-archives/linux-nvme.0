Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F11FC43458
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jul 2026 18:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g1lO6eQinke3g+u23uKP/C5+Qg9mo+bCCNuVb6Fl7L8=; b=iNAokKnNX3dQs0hKJ/waWBGtWV
	kkd6otOXFtzZnHMhC8ClqFel4nUqTbnuin99vEmK5IbzEtIj2wkwtA4sZbTmfBmwVLGewhx+AQ3Ap
	N3Vk0bfTCrQVPFq5k4UnSMu16cOo/rTzKaTAqJPi92kcIuvdxm7l1ekV17uAt1W4Um1jp35tGcyqA
	yc2NAss2/G/l/0lXGZBsZpi1AxvXP8pycfDFmKZe9ypmejgz/dThY4WPchVXJ7H/j9rYPeI2B1nrY
	FTGzJ6/K0nZ/0ZknWe2eCbOAIgvW0vZKOJ3vFoPXhOIa4euAeTrtFXH81fDIOPBIMQxI/QbMJYRvB
	HQRIkAXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgoVc-0000000DOZT-09Ol;
	Mon, 06 Jul 2026 18:57:36 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgoVb-0000000DOZH-1ZD3
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jul 2026 18:57:35 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 196F44080E;
	Mon,  6 Jul 2026 18:57:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE5A31F000E9;
	Mon,  6 Jul 2026 18:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783364255;
	bh=g1lO6eQinke3g+u23uKP/C5+Qg9mo+bCCNuVb6Fl7L8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IFqamzyUNyC3IY8uDWRdoyQ1ioefIqoHLsyD8j1aYZp48tEV95e8rOEwqWLLIXu3W
	 VWW0uhHY2i17obq798qpgBMo0OmC4CFaJtyhBTM+ZaIN+bMpovDEWCiZ5CO+wAkaXR
	 FLa/WcamwTmesQMHEIMoUyy7B8TuwHp/UlRamRLajKzNsmvgBn8Y9mo8AYVatKYxdQ
	 ws2T7Tk5oRYCkTOy2U8MBMw1xF0XN4IInBB8Vf5MTm+CBMkdfvclLEhJL+8QG8kNlw
	 8AtXm1KHeqa/R0dfnoEIxuOmddxtUbnpZOq4hw5cBs6MvWaq3teJoXS65v8lmCE3af
	 vGGSBkdLZUw6g==
Date: Mon, 6 Jul 2026 12:57:33 -0600
From: Keith Busch <kbusch@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: hch@lst.de, sagi@grimberg.me, axboe@fb.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: handle positive error codes in nuse_show()
Message-ID: <akv6nYVwUXvUOqC8@kbusch-mbp>
References: <20260630102717.2671475-1-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630102717.2671475-1-john.g.garry@oracle.com>
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

On Tue, Jun 30, 2026 at 10:27:17AM +0000, John Garry wrote:
> Function __nvme_submit_sync_cmd() returns a positive error code for NVMe
> errors. Otherwise, we get 0 for success or a negative error code for a
> kernel error.
> 
> In nuse_show() -> ns_{head}_update_nuse() -> nvme_identify_ns() ->
> nvme_submit_sync_cmd() -> __nvme_submit_sync_cmd(), we then may get a
> positive error code returned.
> 
> Function nuse_show() - being a device attr handler - should return the
> number of bytes written to the buffer or a negative error code.
> 
> Convert any positive NVMe error code to -EIO.

Thanks, applied to nvme-7.3.

