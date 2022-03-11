Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D61E9C433FE
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Mar 2022 07:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dOMLH4qEblqbEueXavU39WP4h80iEBUstzCxJJWAuLU=; b=UyT0NVnJUViqtpFDC2JFKNfjms
	rA8+jIG+qy3uP5kUxYpNzTNd4ltuWDpXvaBYSwMuSfy9irXUi5y+SM0BNw7dbjOqv8xLTPdMivpjU
	wTNAFmkgn7EOzajP2DnVG1pKBHvtr4rXJBKuwqgO5irl3cJd2t/JQtme+BW+F3TAZO9gEPHSHUnTb
	NIkYZajod45HL+ISy6dG9s1BphBQ/wMX490QFWEIvFj4k5CPKksIdEQ2ELXHuwhXl98QnfmL/szos
	MdNLWKJOCMx28VwbC1MMGYTMGu9R2HVBB6/Kb5zUroWegzJUDysVUOypvj1kiAj+u9gIxFcn/Jvve
	M7dzK3KA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nSZUk-00FKwG-Mu; Fri, 11 Mar 2022 07:15:26 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nSZUh-00FKvV-Tf
 for linux-nvme@lists.infradead.org; Fri, 11 Mar 2022 07:15:25 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 1B6CD68AFE; Fri, 11 Mar 2022 08:15:19 +0100 (CET)
Date: Fri, 11 Mar 2022 08:15:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: Mingbao Sun <sunmingbao@tom.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 "David S . Miller" <davem@davemloft.net>,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
 David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, tyler.sun@dell.com, ping.gan@dell.com,
 yanxiu.cai@dell.com, libin.zhang@dell.com, ao.sun@dell.com
Subject: Re: [PATCH 2/3] nvme-tcp: support specifying the congestion-control
Message-ID: <20220311071518.GB18222@lst.de>
References: <20220311030113.73384-1-sunmingbao@tom.com>
 <20220311030113.73384-3-sunmingbao@tom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220311030113.73384-3-sunmingbao@tom.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220310_231524_124735_74F734D5 
X-CRM114-Status: GOOD (  13.24  )
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

On Fri, Mar 11, 2022 at 11:01:12AM +0800, Mingbao Sun wrote:
> +		case NVMF_OPT_TCP_CONGESTION:
> +			p = match_strdup(args);
> +			if (!p) {
> +				ret = -ENOMEM;
> +				goto out;
> +			}
> +
> +			kfree(opts->tcp_congestion);
> +			opts->tcp_congestion = p;

We'll need to check that the string is no loner than TCP_CA_NAME_MAX
somewhere.

>  
> +	if (nctrl->opts->mask & NVMF_OPT_TCP_CONGESTION) {
> +		ret = tcp_set_congestion_control(queue->sock->sk,
> +						 nctrl->opts->tcp_congestion,
> +						 true, true);

This needs to be called under lock_sock() protection.  Maybe also
add an assert to tcp_set_congestion_control to enforce that.

