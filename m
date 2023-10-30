Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C88A1C4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Oct 2023 13:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aIIeN042D2W99hyNg6bXdLKV25G8NrYFwRct4bxt+nU=; b=UrZub/361iVpJU0QBubXXmmxYP
	Az84uxN36YzObLgLJkSQy8Z9TK5DXPmwFuUUGV5p1koUuENKsvMVGndfi3jsSJ0FEox633VVZW8pt
	S8FHgFQOdzEqspGqBntDA9VSxL0RdUB1Pf9nRwD3ueh0rPFpA+ykDbmoBI6l4qQlXBB+lc7pnOAbe
	/XSl1e0x2/rhYda78lmmGaTHNowO480yu0TJ/wN168tehPoEdEm3Q4QhoD8O+5gHTmwrgG4WWk6TA
	VuBgW5fr8aYaPEYVR/ObT6Er89PuqFCYUagBUl/5UiOEQTXRVil3Ae1o9pe9teewO4ngCpLPREOtl
	0dzSUA9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qxSLB-003PR3-1W;
	Mon, 30 Oct 2023 13:30:01 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qxSL7-003PPa-1B
	for linux-nvme@lists.infradead.org;
	Mon, 30 Oct 2023 13:29:59 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id AF9C26732A; Mon, 30 Oct 2023 14:29:54 +0100 (CET)
Date: Mon, 30 Oct 2023 14:29:54 +0100
From: Christoph Hellwig <hch@lst.de>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-tcp: Fix a memory leak
Message-ID: <20231030132954.GD21741@lst.de>
References: <f9420cde9afdc5af40bf8a8d5aa9184a9b5da729.1698614556.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9420cde9afdc5af40bf8a8d5aa9184a9b5da729.1698614556.git.christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231030_062957_548763_625B84C0 
X-CRM114-Status: GOOD (  15.03  )
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

On Sun, Oct 29, 2023 at 10:22:57PM +0100, Christophe JAILLET wrote:
>  		if (ctype != TLS_RECORD_TYPE_DATA) {
>  			pr_err("queue %d: unhandled TLS record %d\n",
>  			       nvme_tcp_queue_id(queue), ctype);
> -			return -ENOTCONN;
> +			ret = -ENOTCONN;
> +			goto free_icresp;
>  		}
>  	}
>  	ret = -EINVAL;

I'd slightly prefer the code to be consistent how it assigns to err,
and use the style where it is assigned in the main path as with the
-EINVAL for the next checks.

Except for that this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

