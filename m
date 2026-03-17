Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AB90F3383D
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Mar 2026 14:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9cy6dO40Vtwl62t+1+A+QaezHXLp//LfMbalhK38G/w=; b=Z608hL3hk9WlXVn/AS1HK6vy/V
	iHkIkKIfcv9rEKrZxnN/yq+KMwYBPiqIw88hwJVxDxwhY11OdP314sh+eRFLy7vnembomwPIzfnzX
	q8JptAnw9kn62wMVAOAoomFj0bKqxgqF7U6D/WNvnKXqTwrInH0YORSVY/tEfAKK3PaG0gvilMgJ+
	kRJSFKXwcFemiji8ewNqqTet+3rbtfx8jwpJ/F38Lp0ym8gj95y/duER0LtRrUZoiqXY7qOCHH4m4
	b17es+FUFRgRnbk9nCpd6ExXlMIBbrc2WEODwjY8b3gvPVF5RjDZ49OLogeOSNWalF+NJ+OlNlFys
	DFe0MTCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2Vln-00000006f5f-1BlO;
	Tue, 17 Mar 2026 14:51:43 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2Vll-00000006f4x-1Yli
	for linux-nvme@lists.infradead.org;
	Tue, 17 Mar 2026 14:51:42 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9CD0668BEB; Tue, 17 Mar 2026 15:51:37 +0100 (CET)
Date: Tue, 17 Mar 2026 15:51:37 +0100
From: Christoph Hellwig <hch@lst.de>
To: YunJe Shin <yjshin0438@gmail.com>
Cc: hare@suse.de, cleech@redhat.com, hch@lst.de, ioerts@kookmin.ac.kr,
	kbusch@kernel.org, kch@nvidia.com, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, sagi@grimberg.me, stable@kernel.org
Subject: Re: [PATCH v2] nvmet: auth: validate dhchap id list lengths
Message-ID: <20260317145137.GA6462@lst.de>
References: <ec03d5ca-a26d-4427-823a-17c5709391f7@suse.de> <20260313052444.3865842-1-ioerts@kookmin.ac.kr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313052444.3865842-1-ioerts@kookmin.ac.kr>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260317_075141_555306_8A48ABF0 
X-CRM114-Status: GOOD (  14.39  )
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

On Fri, Mar 13, 2026 at 02:24:09PM +0900, YunJe Shin wrote:
> +	/*
> +	 * idlist[0..29]: hash IDs
> +	 * idlist[30..59]: DH group IDs
> +	 */
> +	if (data->auth_protocol[0].dhchap.halen > NVME_AUTH_DHCHAP_MAX_HASH_IDS ||
> +	    data->auth_protocol[0].dhchap.dhlen > NVME_AUTH_DHCHAP_MAX_DH_IDS)

Overly lone lines. A local variable for data->auth_protocol[0].dhchap
would really help with readability here.

> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index b09dcaf5bcbc..ea0393ab16fc 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -1824,6 +1824,8 @@ struct nvmf_auth_dhchap_protocol_descriptor {
>  	__u8		dhlen;
>  	__u8		idlist[60];
>  };
> +#define NVME_AUTH_DHCHAP_MAX_HASH_IDS 30
> +#define NVME_AUTH_DHCHAP_MAX_DH_IDS 30

Tabs before the values.  Bonus points for a reference to the relevant
spec.


