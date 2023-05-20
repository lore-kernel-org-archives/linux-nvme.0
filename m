Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5045BC77B7A
	for <linux-nvme@archiver.kernel.org>; Sat, 20 May 2023 04:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XoAn80R8jE0bvsmO5+4ey6UqR730KJlP10R0Nw8L9Qg=; b=ywya41jjUNN3Z6FvDXFS5KfeGG
	0F/eioM832yQcxWt/wZPfq11qA7CcNwZyXgbkm3XMTHgWTG7QeUXOqNaPbx1QwHzrbwm7vCQO3ZzE
	whLoZjvDc1a2Q+JS2X0DCiFgT8QsUBQJzSAVkz/rwI84D6FJo5uJbc6cGrtYpQPeLZkfNOR93oVjE
	d02B+8y4HTkUATS1vdV/ygsl4SgS7Pb3V7LGyUkBDEPcKnNVz598oW8S09411wjadZ5WT+I3kC5gh
	/k+9wfUYDP35b6uZgAA+gr8a16/BzKwkK3PLEjhQtyEBSUV9eBiAFLMDyZT4VTeH+hhGeNwnUE/fC
	68AmWhYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q0ENV-000hL5-03;
	Sat, 20 May 2023 04:39:37 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q0ENS-000hKW-0d
	for linux-nvme@lists.infradead.org;
	Sat, 20 May 2023 04:39:35 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 11F7868CFE; Sat, 20 May 2023 06:39:31 +0200 (CEST)
Date: Sat, 20 May 2023 06:39:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Irvin Cote <irvincoteg@gmail.com>, hch@lst.de, axboe@kernel.dk,
	sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/1] nvme-core : remove redundant check from
 nvme_init_ns_head
Message-ID: <20230520043930.GH31780@lst.de>
References: <20230517220915.7244-1-irvincoteg@gmail.com> <ZGbfE7Wsief3erBq@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGbfE7Wsief3erBq@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230519_213934_379249_D447F284 
X-CRM114-Status: GOOD (  15.59  )
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

On Thu, May 18, 2023 at 08:29:39PM -0600, Keith Busch wrote:
> On Wed, May 17, 2023 at 07:09:15PM -0300, Irvin Cote wrote:
> > -		if (!multipath && !list_empty(&head->list)) {
> > +		if (!multipath) {
> >  			dev_warn(ctrl->device,
> >  				"Found shared namespace %d, but multipathing not supported.\n",
> >  				info->nsid);
> > -- 
> 
> Thanks, applied for nvme-6.5.
> 
> Side note, the very next print says this path was to be removed by 6.0,
> so we're a little late on that.

Yeah, I need to get to this and the resulting cleanup.  Hopefully I'll
find some time the next weeks.

