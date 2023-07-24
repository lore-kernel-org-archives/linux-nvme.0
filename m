Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97CA2C001DF
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Jul 2023 16:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OLTofHeFxhIcfQgBO9TqntRefVAo233SS5n3po4QAaw=; b=njc3I7epZlPtGbSpxAVp+8lSxy
	panglgdLbIQwuo3WipbOHkdTFvShkDETs5wdVufny58T1p9eXj79iWCUQh1Yag3B0TBECymAQA4Va
	YqqRDMHyFRyUmiuFKE9JYp5mpP4CjWxC9hy+YAg/jiuER0UvabEjRMzb7Psm+PmQBbLnhVbID0hjO
	YZmZ5xs4LA5CGGdNM4yIgELKhI5TQhF9jPUQpdEwtIoU4dbgpzEX3maSAmxLCs3WAhPTAB8aLobKb
	UP9rwJ86htmMkYYVyhrAHs7OEkPObluU6q3WXBTV0KTUkWantD3ESVf92fkmXZPU0Tp1Q7Drj2e63
	OzO8aoFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qNymU-004vPZ-0g;
	Mon, 24 Jul 2023 16:51:34 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qNymS-004vPB-31;
	Mon, 24 Jul 2023 16:51:32 +0000
Date: Mon, 24 Jul 2023 09:51:32 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v1 1/2] nvme: drop multipath config option
Message-ID: <ZL6sFA+fwsWwWOkF@infradead.org>
References: <20230719084147.16272-1-dwagner@suse.de>
 <20230719084147.16272-2-dwagner@suse.de>
 <ZLe1QmfGg488wH9D@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLe1QmfGg488wH9D@kbusch-mbp.dhcp.thefacebook.com>
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

On Wed, Jul 19, 2023 at 12:04:50PM +0200, Keith Busch wrote:
> >From my reading of this message, I thought the intention was that this
> driver will eventually replace it with a:
> 
>   			goto out_put_ns_head;
> 
> instead of letting the namespace become visible for some unsupported
> mode. The warning was to give people a chance to migrate off whatever
> unsupported setup they were using, not a deadline for when the warning
> dissappears.

Exactly!

Btw, Daniel - any reason you didn't Cc me on this?


