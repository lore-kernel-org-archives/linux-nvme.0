Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD060C47422
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jan 2024 05:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ilOwiwu/kXXZ8YQFRb7DmDqKQZ6gO37mvuafLfdMBlw=; b=XLUkDienENCD8CdmGAqOyULx83
	rY76jtM/8FVqlYnYoYcyoOv3yqsrtGKK/zDrjHas9fHxiVzPnximdS6Ge44bXOmNcozf/vnBYBcSg
	rPF3Z5zGfHRcVcdIOV3ULbADbYIFft5gHaoZEgkArOVxpAMpbl3SE4Y1semXV01AYogY4AUJJNSkI
	Vtyb2PVOz24/UAtHUhUt44QucWCYLa1UISgoOukJqUvhTvaQcc31aazBgBlyAu+je9/4sAGlwi2Qf
	CGDE2Ollu2UnEN2go5nr8VeO0OyN63JB4vS7wiACede2GyyNBcEdDvPhTKVF2qs9Xj5U/nombhcdW
	2l+7E5fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUKfj-0000000BOS8-1I4b;
	Mon, 29 Jan 2024 05:59:07 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUKfg-0000000BORL-3mes
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jan 2024 05:59:06 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4ADCC68B05; Mon, 29 Jan 2024 06:59:02 +0100 (CET)
Date: Mon, 29 Jan 2024 06:59:02 +0100
From: Christoph Hellwig <hch@lst.de>
To: hare@kernel.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 2/3] nvme: simplify __nvme_submit_sync_cmd() calling
 conventions
Message-ID: <20240129055902.GB19136@lst.de>
References: <20240127093746.40246-1-hare@kernel.org> <20240127093746.40246-3-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240127093746.40246-3-hare@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240128_215905_130223_901D0FDA 
X-CRM114-Status: GOOD (  13.96  )
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

On Sat, Jan 27, 2024 at 10:37:45AM +0100, hare@kernel.org wrote:
> From: Hannes Reinecke <hare@suse.de>
> 
> Instead of having two arguments for 'flags' and 'at_head'
> for __nvme_submit_sync_cmd() combine them into a single
> 'flags' argument and use function-specific values to
> indicate what should be set within the function.

I'm not sure it's simplifying per se, but changing the calling
convention ahead of adding even more flags.

You can also use up to 73 characters for your commit log.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

