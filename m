Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27FCDC25B74
	for <linux-nvme@archiver.kernel.org>; Fri, 31 May 2024 01:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1hpSK4ZdulHSDa+Z6nQA+h2rFUeTntX+IFZ+r0yMGto=; b=Egl1jNBj/1SsZaXie3/BRM8Rjq
	h7UWC4tlunErAgrnU2AQ4bZhqRQ1YyywHHe1R/kupHeNbJ2PUCnT8BIjef0/itRlcIMUFDhlaJZdW
	WU6cZoxPvte4ufVm9v2op6cCFiuQaijhqdznvLhafO2fcXsfEWkbKnR4eZY808N5SlC0UbaTd/vM6
	lNg2ZmpruGEandL8iE3QB9SVQ8hGvvuCrUtw1ENwwe2VvbCmkgsar4HpcdpBEkgnIOBFh5jxgllg9
	g56mMvomc0/hd6/Rl40uvkxPBLSJEDMVPqAD/PGIaFuKfYnCXT354yNlvYGZKF24FSPnx12b5Aca/
	HsHVRH/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCrEk-00000008wT3-1Y8d;
	Fri, 31 May 2024 01:39:18 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCrEd-00000008wRE-0GqF
	for linux-nvme@lists.infradead.org;
	Fri, 31 May 2024 01:39:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 8A8E762A36;
	Fri, 31 May 2024 01:39:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEE1BC2BBFC;
	Fri, 31 May 2024 01:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717119548;
	bh=1hpSK4ZdulHSDa+Z6nQA+h2rFUeTntX+IFZ+r0yMGto=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lIr7xaUGCzVuAhZMiCMNZk3Smwx5VoYq9WRwAlE7AD57ht1QY6/qpkVGp9yXUElnH
	 OXgOsYUDrimHQQL0E9uA2HsSnu99Y1ayFWWVJCZJlfmXJOHWJKtCRj16kJzApgpEwU
	 yTLod74d2KjeMDXp1ERHzWOJe/y9q/jwG+d6TdUzk+nBemrF42GtjBMZb1FxWYmsF+
	 f5P7v35I6flNXI4dv90RqaK1fqmBdK5csxINSm4ww458rtPvSLcJtjINJoh3+KpFnY
	 4Y3SKjw5fkvbkMwPozd5dYYKU76CSstJKqwaBqoYM23+tKJ5XVE/jvuFPK+J+NTxOZ
	 bWc7tvZ+A43Uw==
Date: Thu, 30 May 2024 18:39:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net
Subject: Re: [PATCH v25 00/20] nvme-tcp receive offloads
Message-ID: <20240530183906.4534c029@kernel.org>
In-Reply-To: <20240529160053.111531-1-aaptel@nvidia.com>
References: <20240529160053.111531-1-aaptel@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240530_183911_211719_71C5CCED 
X-CRM114-Status: UNSURE (   9.05  )
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

On Wed, 29 May 2024 16:00:33 +0000 Aurelien Aptel wrote:
> These offloads are similar in nature to the packet-based NIC TLS offloads,
> which are already upstream (see net/tls/tls_device.c).
> You can read more about TLS offload here:
> https://www.kernel.org/doc/html/latest/networking/tls-offload.html

Which I had to send a fix for blindly again today:
https://lore.kernel.org/all/20240530232607.82686-1-kuba@kernel.org/
because there is no software model and none of the vendors apparently
cares enough to rigorously test it.

I'm not joking with the continuous tests.

