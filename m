Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D66FFC4332F
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Oct 2022 05:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l9+5cdaN2puXsYEfLSS/d99dhPF0JFNlgMNeDng7KRY=; b=c5sipZtfbzPOoRfiFhZBc4Xj5N
	aDrr18tWR2+mmm6GfIcsT7ut1E6sm9pWizZx7hrNZnbdc/YyyED1yu4YjxruB2shk5HsFJkda+7kn
	/lPWT77AMlrTyfK70UVBTEQXLp6Bu+Ye/B1XiMRV3pXqKJs9qYxrlpP0yPzMDwz7A746ITrk10MPg
	AHMuOvR0Pp+FMrc08HPUffbLQHbYiANZ4kybU8jJYNazqG6E/B5ej1HNRrtzREc+3fsu9f8bMDjOw
	bp9V/+pXMPdJOKlOHtedLXjDpPbd3TvyOF87zaLLAR2vN+dLe5pZidP6O1ldAU18t+oiXXp/sE2QA
	RddNuMng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olkE6-005HWj-MP; Fri, 21 Oct 2022 05:05:46 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olkE4-005HUU-Nr
	for linux-nvme@lists.infradead.org; Fri, 21 Oct 2022 05:05:46 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 0D2B2B82A0A;
	Fri, 21 Oct 2022 05:05:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 046CAC433C1;
	Fri, 21 Oct 2022 05:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1666328741;
	bh=ik0qCeO7x7gDxThiGNslgszS5S/5jn/mqyzKI9T4MjE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LxOfCJXJhEVcsqX/X41JhyUYVsFM5/jEzN3bNwspL1wNxQuC36ujBub8Qrn0dbbff
	 2CWEdxQph5nqFLdHEJ+OPaQ8gUYhoZibaj0t2uWdRxB2OWXJ2JlRk3krI0cKJcpaRm
	 e0n1gZjGwKKc1QrjmABX5ba8Di36nL0z+qSl6ks7IEuuAFjprH+/IXwjgFAEr0F19d
	 Wvw+DSAHj/c+H5mrVfe14HyAr9tAy9FmJBFmUfhWezeybWDk6pq0tURmuN57sP5P6t
	 svpHbTROQXp8vE17MYj1CA14YhOGjhx4XME+dCQVBTvakr8166hNCoqjJOzhzkjRre
	 ON3pLJnVUghig==
Date: Thu, 20 Oct 2022 22:05:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, saeedm@nvidia.com, tariqt@nvidia.com,
 linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 kbusch@kernel.org, axboe@fb.com, chaitanyak@nvidia.com, smalin@nvidia.com,
 ogerlitz@nvidia.com, yorayz@nvidia.com, borisp@nvidia.com,
 aurelien.aptel@gmail.com, malin1024@gmail.com
Subject: Re: [PATCH v6 01/23] net: Introduce direct data placement tcp
 offload
Message-ID: <20221020220540.363b0d02@kernel.org>
In-Reply-To: <20221020101838.2712846-2-aaptel@nvidia.com>
References: <20221020101838.2712846-1-aaptel@nvidia.com>
	<20221020101838.2712846-2-aaptel@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221020_220544_954609_752919D7 
X-CRM114-Status: UNSURE (   9.26  )
X-CRM114-Notice: Please train this message.
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

On Thu, 20 Oct 2022 13:18:16 +0300 Aurelien Aptel wrote:
> +#ifdef CONFIG_ULP_DDP
> +	__u8                    ulp_ddp:1;
> +	__u8			ulp_crc:1;
> +#define IS_ULP_DDP(skb) ((skb)->ulp_ddp)
> +#define IS_ULP_CRC(skb) ((skb)->ulp_crc)
> +#else
> +#define IS_ULP_DDP(skb) (0)
> +#define IS_ULP_CRC(skb) (0)
> +#endif

This spews 10000 sparse warnings. I think it may be because of 
the struct_group() magic. Try moving the macros outside of the struct
definition. And make it a static inline while at it, dunno why you used
a define in the first place :S

Please don't repost before Monday just for that, maybe someone will find
time to review over the weekend... 

