Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAFFFC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Nov 2021 22:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eNde0H2Yv2GBxX2aqV63Bpr9bhgZdZu5J7gtQ09hLHw=; b=qXHHkqLmGaYXBGIbdEtEsJ6q61
	+x6sLOm9rGoNGXJDR1XQ2lxOEhfugauUZJdq6cvan0Li20xQx2gGEdJo/OThcfCgDQXNnd8ZorPZQ
	q2h6ua/ep/hwB9TJNExV5j1qxk5sEYsFs9inIysxcxY3rqcOZQIV+xZ5VyJ+znfNbau7H4u0nF4jc
	S8/sdkggZDoPGJ8UX2kdUn8qTBd3B+LHHF6misXrgzqojjlIYfjhspqHFR4FJFXWZbr1rVrUSaCUt
	SjtyXoIszCCmn2ZjubKXPtfSOaGwlIFm53NDCHff2y6RMBrEs8izUFQi7mGl+OtSe64hVQnvXnor0
	k68jHktg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mrpDd-002tux-H1; Mon, 29 Nov 2021 22:33:53 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mrpDa-002tuH-Om
 for linux-nvme@lists.infradead.org; Mon, 29 Nov 2021 22:33:52 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 77944CE1689;
 Mon, 29 Nov 2021 22:33:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B66C53FC7;
 Mon, 29 Nov 2021 22:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1638225225;
 bh=jR4JrrzlR5WgCYfDh7may1dehuiBeL2/2+J6EKLFHHA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=g55zzhzdtpSkEyRYLaE5nKs4MGvRPRh0gC7KuVqRbHMvvQisO6/mulJHsulaZEMg3
 wiIl+tyA5HYEFvXHHjrdo1xhlxDFH7ajnKCJ0omtGUIrTeYPiAEddQZNbPjyN1kE2f
 az3G6F7VoosX0aoXjVv6UUSrt6dE6wrlCi0Da7GLoURx6kBaYeDwjt04ZhctuX5CfD
 PPiB1frw3HIdPkar9N9BY+Ke+xgCAdDECuShZh7k3NR9GtJGnKIND/tn9kMo1tiun+
 LJQXRSeSWM0rbzZL35waa6lVgXVW512cbFAnQVcYLAWEnqVw753KlTqBdMBnYhDTcE
 GaKWvWHwjvrnA==
Date: Mon, 29 Nov 2021 14:33:42 -0800
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org, hch@lst.de
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCHv2] nvme: disable namespaces with unsupported metadata
Message-ID: <20211129223342.GD3582042@dhcp-10-100-145-180.wdc.com>
References: <20211129160712.3596738-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211129160712.3596738-1-kbusch@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211129_143351_007459_15CBBFE5 
X-CRM114-Status: UNSURE (   8.32  )
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

On Mon, Nov 29, 2021 at 08:07:12AM -0800, Keith Busch wrote:
> +		if (ctrl->max_integrity_segments && nvme_ns_has_pi(ns))
>  			ns->features |=
>  				(NVME_NS_METADATA_SUPPORTED | NVME_NS_EXT_LBAS);

Apparently the passthrough interface works fine for any arbitrary
metadata format, so looks like we should leave NVME_NS_EXT_LBAS flag set
for all transports. I'll need to send a v3.

