Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B53C0D2F326
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Jan 2026 15:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H5LlMgpaBNWh7J4HTLkQ7eQls2ckvzG+sAlWVky3cnc=; b=dv3OeZ/lSpuRnc/3dJiZAVsZnp
	HX5mMQMxmFOS4nietlNOd4s9n5rx1R7Xk9pk0PYbNdh0g6pVN4eHq6ZzGwV4VYQBNGldq6lq5N3d3
	odMK+Ji6kOVgwZ+sVF4DNcaciyLIExpOkM4ruR6s8I0KpQ0KNCxQ7sSmhmJR3FacWtPvLfW9RCStO
	jOqPHB7haSg2ZPImXYj0B73YgTIgnbSppmePEYOY4CqjbXVR/4lpgq7AHdifTmargHwQ+1MD0m353
	CX+aOUlHO+39LqQ2Tr7JGeYDqN1d/TDdHxBDR6l+59Gg5bU/ErS0Vl3iKLpSNJx29/OkycnAXPkQP
	wtetRyNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfgNL-00000007NzE-2NeH;
	Tue, 13 Jan 2026 15:32:07 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfgNE-00000007Ny3-3bNE
	for linux-nvme@lists.infradead.org;
	Tue, 13 Jan 2026 15:32:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id BDAF643911;
	Tue, 13 Jan 2026 15:31:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65E90C19421;
	Tue, 13 Jan 2026 15:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768318319;
	bh=IitBvgmXXstUL6nUzQeTpmcc2LthUnPMNvciPuo7pj0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EgnGPl8KPz5bpvXIBRBY4YaZ5m/eyoVQqzcPBdQI9UZYWMsXjvzIfXq+3T2jz2Mkv
	 fU69Ome7h61SmVHaOmIhYZLRTyWz74i/UtY/qC75ZGaLlwkOMd/odgmjZWMPQUvfZe
	 jJKbZVMKXDtmpMi8gUbzbQ9JrtT+arEFNHjW+xqA5bmp0NL8ej7LoFp4of2aAz5z4h
	 9obSLxp4iQIZ9qGk6fWIfSCgoQWBQAJKOyBa+dm1Lrypxd1okann+xDJ3ElL6ODyjv
	 hzmFxLG1L1bDQ2NlLJ8sW9uM2hoBHvAIcIvA6JSaGJZDsTYbp7ldM8DVctgbOylrkL
	 WeE2HjTv65JnQ==
Date: Tue, 13 Jan 2026 08:31:57 -0700
From: Keith Busch <kbusch@kernel.org>
To: hare@kernel.org
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCH] nvmet-tcp: fixup hang in nvmet_tcp_listen_data_ready()
Message-ID: <aWZlbTsZNhxVLi52@kbusch-mbp>
References: <20250818093245.41641-1-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818093245.41641-1-hare@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260113_073200_916897_2D44AB13 
X-CRM114-Status: UNSURE (   9.53  )
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

On Mon, Aug 18, 2025 at 11:32:45AM +0200, hare@kernel.org wrote:
> From: Hannes Reinecke <hare@kernel.org>
> 
> When the socket is closed while in TCP_LISTEN a callback is run to
> flush all outstanding packets, which in turns calls
> nvmet_tcp_listen_data_ready() with the sk_callback_lock held.
> So we need to check if we are in TCP_LISTEN before attempting
> to get the sk_callback_lock() to avoid a deadlock.

Thanks, applied to nvme-6.19.

