Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 185C1EB64D8
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Jun 2023 05:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GXezkJOB0+xpzBsz4ibKK2ZkE3t6O/DtM5njKkTDDQo=; b=s2ZxE/qpZq4KSppLFRg957uuuW
	MbPvb8Jb5t8AsPDJL+qun990EGiVGLtNlsH4IAdXcf02sHgnyI4YEj5byyHT2O16oJ5OLRQBsgrNg
	4+rBlqc0GiDhLG1DBuNREESpgi+Wv1INwwgD1LCiMsUTycGC5Ztt9OfrIxNKBWUnZv2NIMLsxNAxW
	jfieArcbZGM8F9y0r3YRkxPRICwuq2h6SVAa/YeBKO8qAIICHtlD7Ko8UZfkzJN/5KVcx/XJdfB6g
	ShtQCJ3O7sMdyM9jlFmA27mtyZpOWRUE0QtHmXqahwR2LwMxFXftGzMCOmoSPuVGYWi7jBWsVPsLc
	+Cee+jyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q9IdA-00A6nt-2h;
	Wed, 14 Jun 2023 05:01:16 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q9Id5-00A6lJ-1K
	for linux-nvme@lists.infradead.org;
	Wed, 14 Jun 2023 05:01:14 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8934867373; Wed, 14 Jun 2023 07:01:02 +0200 (CEST)
Date: Wed, 14 Jun 2023 07:01:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	leit@fb.com,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme: Print capabilities changes just once
Message-ID: <20230614050102.GA10740@lst.de>
References: <20230613175538.331639-1-leitao@debian.org> <ZIjnGiMbih0sjn3g@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIjnGiMbih0sjn3g@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230613_220111_613929_E3E3C0D3 
X-CRM114-Status: GOOD (  16.99  )
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

On Tue, Jun 13, 2023 at 04:00:58PM -0600, Keith Busch wrote:
> On Tue, Jun 13, 2023 at 10:55:37AM -0700, Breno Leitao wrote:
> > This current dev_info() could be very verbose and being printed very
> > frequently depending on some userspace application sending some specific
> > commands.
> > 
> > Let's turn it into a dev_info_once(), since it is not useful to know
> > about it all the time.
> 
> This looks good to me. Vendors sometimes put unnecessary effects in the
> log, and spamming the same recommendation to repeated operations isn't
> going to be helpful. I expect anyone who knows what they're doing can
> consult the effects log directly and take appropriate action on their
> own.

Hmm, once seems very little.  It might make more sense to do this
once and then skip it until the controller has been reset.

