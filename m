Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 896C2C05027
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Feb 2023 15:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=chR/Zk9V850eG/5ToFs5V4lQBIQ14hBBrBGKFTYxbAQ=; b=fsJn6aE75odARts+nYz2bET4eC
	U93dd2j2lHqhUNeL7ncRe5gc1U/dvMC0tLeqGSgjzSu/zzUulPtTbRWG/DVY+bE31fVAxC7CO6T8o
	ffS3G9uswq85fJmN33ZSDGtExPHJtoyuvlioE7h5WFkjKJN7KYk0571bvI37dvIjlQ+mdJEhPmFUy
	SYMJrz2B0SutqqChmlT11Z/hd/biw58AxFkeE4NYP8hEejMQJCh/Jqq4sDo+9P3fCNuCfRhlhnQxi
	sWwL7tL+/2opFyiQSD172EOZLc8zJXQ1gK0yb/9/6B/IrvZFdTaSBYpecMJA8B5HzPWcI1wvyGZbr
	G6D4HUrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNElA-00Cax9-Vw; Wed, 01 Feb 2023 15:10:52 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNEl8-00CavE-FN
	for linux-nvme@lists.infradead.org; Wed, 01 Feb 2023 15:10:51 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 73A3268B05; Wed,  1 Feb 2023 16:10:43 +0100 (CET)
Date: Wed, 1 Feb 2023 16:10:43 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-nvme@lists.infradead.org, sagi@grimberg.me
Subject: Re: [RESEND PATCHv3 0/2] nvme effects handling updates
Message-ID: <20230201151043.GA6876@lst.de>
References: <20230127165620.3487918-1-kbusch@meta.com> <20230201132044.GA31561@lst.de> <Y9qAjNXsa1swaSb2@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9qAjNXsa1swaSb2@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230201_071050_673562_65DC99B0 
X-CRM114-Status: GOOD (  14.01  )
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

On Wed, Feb 01, 2023 at 08:09:00AM -0700, Keith Busch wrote:
> On Wed, Feb 01, 2023 at 02:20:44PM +0100, Christoph Hellwig wrote:
> > Thanks,
> > 
> > applied to nvme-6.2.
> 
> Totally fine by me to put this in 6.2, though I assumed this was 6.3 material.
> The Security Receive behavior this series addresses is a little annoying, but
> not urgent. 

I'll move it to 6.3.

