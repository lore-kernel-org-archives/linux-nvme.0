Return-Path: <SRS0=kg3i=MP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50A6C4338F
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Jul 2021 06:09:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8872B60E8B
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Jul 2021 06:09:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8872B60E8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=F+l9Y1cADdB2YcN8SwsDaHNDpkhxk76ZJU593EaqW/0=; b=YqAPhgvNwou+EI
	22VhMjneFKsB56YpG+eMLc8CBo3TKU5gnmCfDOMwy86Xu+kx7kNgMXEthgCGi7mdx4RdkFAuN3KLU
	y7RAByzZ5DTJbYN/VSKfuMLzexHV5SH3bKh3EFikyIZq7o7wdNngzxJCqRVOHfR4i1C1au+8vvcDi
	fL7zWWHKZI3r1ZD7I0RvdRBbpHv5Voczz8LqFm28km5lSXueEfsaxienFehVcmdPYA7aZzIJ7ObKM
	aYd+v9P96mTuDc4QwcPscc0W0uXApOHBextXVB7XCKlHkzMjx8rW+F5DHmPcq1xUBlyTQARyV0F8W
	cdgVNbRynz/MkLUlUYXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m6oNC-003VFv-E9; Fri, 23 Jul 2021 06:09:26 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m6oN9-003VFO-Uk
 for linux-nvme@lists.infradead.org; Fri, 23 Jul 2021 06:09:25 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id CBA9367373; Fri, 23 Jul 2021 08:09:17 +0200 (CEST)
Date: Fri, 23 Jul 2021 08:09:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: Boris Pismenny <borisp@nvidia.com>
Cc: dsahern@gmail.com, kuba@kernel.org, davem@davemloft.net,
 saeedm@nvidia.com, hch@lst.de, sagi@grimberg.me, axboe@fb.com,
 kbusch@kernel.org, viro@zeniv.linux.org.uk, edumazet@google.com,
 smalin@marvell.com, boris.pismenny@gmail.com,
 linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 benishay@nvidia.com, ogerlitz@nvidia.com, yorayz@nvidia.com
Subject: Re: [PATCH v5 net-next 23/36] net: Add to ulp_ddp support for
 fallback flow
Message-ID: <20210723060917.GB32369@lst.de>
References: <20210722110325.371-1-borisp@nvidia.com>
 <20210722110325.371-24-borisp@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210722110325.371-24-borisp@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210722_230924_187269_CD411A46 
X-CRM114-Status: GOOD (  13.37  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jul 22, 2021 at 02:03:12PM +0300, Boris Pismenny wrote:
>  	/* NIC driver informs the ulp that ddp teardown is done - used for async completions*/
>  	void (*ddp_teardown_done)(void *ddp_ctx);
> +	/* NIC request ulp to calculate the ddgst and store it in pdu_info->ddgst */
> +	void (*ddp_ddgst_fallback)(struct ulp_ddp_pdu_info *pdu_info);

Overly long line.  More importantly this whole struct should probably
use a kerneldoc comment anyway.

>  } EXPORT_SYMBOL(ulp_ddp_get_pdu_info);

> +	if (!pdu_info || !between(seq, pdu_info->start_seq, pdu_info->end_seq - 1)) {

More overly lone lines.  Please make sure to stick to 80 character lines
unless you have a really good to go over that.

> +	//check if this skb contains ddgst field

Plase avoid //-style comments.

> +	return ulp_ddp_fallback_skb(ctx, skb, sk);
> +} EXPORT_SYMBOL(ulp_ddp_validate_xmit_skb);

This is not how EXPORT_SYMBOLs are place.  Also please export any
such deep internal interfaces using EXPORT_SYMBOL_GPL.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
