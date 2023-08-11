Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5008C0015E
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Aug 2023 10:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CiaEUv3yRQlBAouSFIVd+bmkk9MdhMknLZuejykO+YY=; b=MQPXsdZ9YfjWhtfvZIzKmCKehh
	q3vUNMyZXRbHBeXctJgINK3Bhu4P0rRcR5n89+VS+GNiKTDd9lrdAJW8DBMWJfSKE8/xKqgqdzGRX
	cfWSotSJjD1TcYEZA1ksuUBvpF69MeFXUZL/lvDNuwyIlRiOgLKhKv9Y+COAiGWXtA4G8mgqXt33z
	/DXgJUcYcXkBFvTI3H0Jy1IqG4Z97+DlTnYdKTvAK6x7bh3SqLMvRPgUpTLLzGI96yrnPKduShc5q
	sO3KW0w+adtP/I+53z63fXDrXe6T2GJrnaV4YMs3i0x6uQJW/m/i962EqvlI1SwTRA92QveLmoMW3
	C6TdHqXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qUPJQ-00ABAa-2i;
	Fri, 11 Aug 2023 10:24:08 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qUPJP-00AB9E-0l
	for linux-nvme@lists.infradead.org;
	Fri, 11 Aug 2023 10:24:08 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id AC73B66F33;
	Fri, 11 Aug 2023 10:24:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4125CC433C8;
	Fri, 11 Aug 2023 10:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691749446;
	bh=iFY0y5C/BNPee/4OykRohNEvTU8wlyAtgkdxJKcG1R4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qjPfAW1Ps4YL08T4tSzEb6P7KpqS9W2SdrlQJXj3TQG9vXgc+RSMtrBtq6KB0ywCg
	 v2MLX1/fSSfQh0bxQBon87ty79y5OstN/LX2b80moCU2eMa8tYBgaVAcO/9B6djuDz
	 laYQ/BFTYcv6M7kkkDLs9+rBlAW5ryUGu4xjaiDN63Gek1D9AjSgxnP6xYR9fuplFb
	 K+ga0yJddF+fJKzr6N8+zFJzk/mFYTDv5m6zn3UVDkb0qdrc1sPj+YEjU9PK97G+DS
	 vL4uuSLV96AWqk8ZcM4WGKjpcLpc2n03JsVU2LAOV2XaSIE/gta7/GH+4Yzov6lkY4
	 A1HpbbXHc/CUw==
Date: Fri, 11 Aug 2023 12:24:00 +0200
From: Simon Horman <horms@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH 11/17] nvmet: make TCP sectype settable via configfs
Message-ID: <ZNYMQPCbsqxOtFur@vergenet.net>
References: <20230810150630.134991-1-hare@suse.de>
 <20230810150630.134991-12-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810150630.134991-12-hare@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230811_032407_339102_FB067667 
X-CRM114-Status: GOOD (  13.69  )
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

On Thu, Aug 10, 2023 at 05:06:24PM +0200, Hannes Reinecke wrote:

...

> +static ssize_t nvmet_addr_tsas_store(struct config_item *item,
> +		const char *page, size_t count)
> +{
> +	struct nvmet_port *port = to_nvmet_port(item);
> +	u8 treq = nvmet_port_disc_addr_treq_mask(port);

Hi Hannes,

treq appears to be unused in this function.

> +	u8 sectype;
> +	int i;
> +
> +	if (nvmet_is_port_enabled(port, __func__))
> +		return -EACCES;
> +
> +	if (port->disc_addr.trtype != NVMF_TRTYPE_TCP)
> +		return -EINVAL;
> +
> +	for (i = 0; i < ARRAY_SIZE(nvmet_addr_tsas_tcp); i++) {
> +		if (sysfs_streq(page, nvmet_addr_tsas_tcp[i].name)) {
> +			sectype = nvmet_addr_tsas_tcp[i].type;
> +			goto found;
> +		}
> +	}
> +
> +	pr_err("Invalid value '%s' for tsas\n", page);
> +	return -EINVAL;
> +
> +found:
> +	nvmet_port_init_tsas_tcp(port, sectype);
> +	return count;
> +}

...

