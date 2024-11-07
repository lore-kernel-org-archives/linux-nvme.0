Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E470D59F5F
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Nov 2024 00:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t7hhzyCd+ZKHBaHQAHzJS0VAezMiojPycPAxr2wrz0c=; b=M2+UhSzBzMknXpIZ6v+oalCc7P
	gintWSdz6jdvFxaKo90D5VNa7i5ciTjlwkxcj32lDztUzGYDhzN3sEFIFFZPM4OjpfFMp5qK8ekNv
	uaqoLhJTVwFWqAQcIq+aOgf2CFWtno9hRcbrUkDAWV7U8F1Kuv2qm+p0MV00luFKyyczEI+aHPrHB
	NbKQAToyMHb8zf93b5UFj114+QzTtdtfXvVPFXrGq+/LM65nJjzd34+6EWr6XEBwBSA6E4LlSjWTZ
	aQvPE7AjZ124kuHzW1TNT1fU7Rj2Rubos1ZKqP4A2j8plkhF/rRSg2QC+H6iqqJwLNyFhPG4aYMT9
	w+sqce8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8qRU-00000005AOP-3hGb;
	Thu, 07 Nov 2024 00:32:08 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8qQ1-00000005AB4-39H4
	for linux-nvme@lists.infradead.org;
	Thu, 07 Nov 2024 00:32:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 853AA5C543D;
	Thu,  7 Nov 2024 00:29:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AB68C4CEC6;
	Thu,  7 Nov 2024 00:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730939436;
	bh=+3iNdMsvyfCyHfzSpTETcLXzhZTHzy42cyIitKoAubk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BCmI9ENgKF2ZpZxrkCH3pCoNphmJ/8OTZ4JN0PJqEy+k6jxtBDTYR0/WH7a/43HsW
	 6+uy06qeyDWxoUfupD2qit6Sd7jC55h/JPe0bpdGCFNDI02RE85J2ddQoL/jveNkxD
	 SIGBg32LZT84zgOabB7nW99yxfNXxwBEUFWmz/BG31xBDljU1DFqDg7kdh39yMbmib
	 tAfZkcG+Ggcse/YoaUDwSwhdV622S2NzQgxc0k+vMOMNXEtIVGZfMy8ElZtH7tanSr
	 EubOuOJ2nbxsZh/zG+nrCGcukQjeTsXhkXWSKlP5blYyF+Kr9RvnDbpt5vanhjsBsJ
	 UMDHY74WupYIg==
Date: Wed, 6 Nov 2024 17:30:33 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	m@bjorling.me, matias.bjorling@wdc.com
Subject: Re: [PATCHv3 01/11] nvmet: implement id ns for nvm command set
Message-ID: <ZywKKZxDcecj3gmh@kbusch-mbp>
References: <20241105174904.3612888-1-kbusch@meta.com>
 <20241105174904.3612888-2-kbusch@meta.com>
 <20241106053800.GA31330@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241106053800.GA31330@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241106_163037_852213_5D054CAF 
X-CRM114-Status: GOOD (  13.67  )
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

On Wed, Nov 06, 2024 at 06:38:00AM +0100, Christoph Hellwig wrote:
> On Tue, Nov 05, 2024 at 09:48:54AM -0800, Keith Busch wrote:
> > +static void nvme_execute_identify_ns_nvm(struct nvmet_req *req)
> > +{
> > +	u16 status;
> > +
> > +	status = nvmet_req_find_ns(req);
> > +	if (status)
> > +		goto out;
> > +
> > +	status = nvmet_copy_to_sgl(req, 0, ZERO_PAGE(0),
> > +				   NVME_IDENTIFY_DATA_SIZE);
> 
> Does this also need a check for the magic all-Fs nsid, which I think
> is not supported for the I/O command set specific identify namespace?
> (see the code іn the zns version)

If the command provides the broadcast NSID, nvmet_req_find_ns() will
fail, and target will return an error.

Since you mention it, it seems I've neglected the nvmet_req_find_ns()
BUG for the failure case used in an rcu context.

