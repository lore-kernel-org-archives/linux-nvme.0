Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48A45D2A555
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Oct 2024 19:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gClp2PrRKDSxZ4gptJmmjYTITdiAC5WX71+RvafK6E4=; b=oXvD3MqK6ul5O1Q/OZ54ra4UmF
	3+6RM4JtnSoGjC9XRqBqgprA+5cIMklcNjnNPW/8atRXRECc2tGRmZkegwsqAve+d7IFvGTOUq7qJ
	VJTyXiWCXU/u+qnx8ugFOOk2/0Mi0LR1EyHg3ABNosubjjL/7KO1mm7Ri/8Wu7aJ4IlUMQX14NBX+
	Br7AZfXPfqlBQ6tyE/Ia557vZ8I9oSxuyVPxkF4S8voy9rg/usyD86NXrYMIcpWatjbUWRQO7sosn
	bfW6ZL3b1xt32B63W2eyf7Uo9akuyrqw0oRTPYJ5TTf1BZcW1hvgaqZmYNDW95fEw4GOXO/9bFGCA
	DcPASy7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t19um-0000000Cq3N-0Eo9;
	Wed, 16 Oct 2024 19:42:36 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t19oH-0000000CpIW-1UvA
	for linux-nvme@lists.infradead.org;
	Wed, 16 Oct 2024 19:35:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 572FA5C575F;
	Wed, 16 Oct 2024 19:35:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51B8EC4CED1;
	Wed, 16 Oct 2024 19:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729107352;
	bh=zQBkoRKgsffe6sm8fQRMZvpdlOGY9+zXwYUi6ybAbV8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JHob37zr2eyddutbScP40veOlgjdzzewqg0C3Kydv5hPYn+i+i7JgcqyJ3F2rEask
	 xw2wJ46bITMY+zwuljeoC7DTqEj/8p0HmEdgc9uV5WfQw39S61S2RaW0vnkUxQxPXB
	 IWVaKuHdnMW7XEkdLEpSHekVGCuGzYA3GL3YChGO/J4VW9ZSfXne3DqdeaTvA8zFYV
	 KB7jW/vnTx4Z8NYGECMdHJ2tRGxLsfyr0fAOwEBBwyIVkgoLOjpatskNDtRNGcc4UO
	 TK4eoQGss5ZUENN6R1GFcyLP8dsntpKJwf16zLHO9mOSiN0BR7pK9pERmQM5bFhIbn
	 fRvow2mNKcnbA==
Date: Wed, 16 Oct 2024 13:35:48 -0600
From: Keith Busch <kbusch@kernel.org>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
	asml.silence@gmail.com, anuj1072538@gmail.com, krisman@suse.de,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	linux-scsi@vger.kernel.org, vishak.g@samsung.com,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v4 04/11] block: define meta io descriptor
Message-ID: <ZxAVlFfF-gjzFLwr@kbusch-mbp.dhcp.thefacebook.com>
References: <20241016112912.63542-1-anuj20.g@samsung.com>
 <CGME20241016113741epcas5p3b90adb3b43b6b443ffd00df29d63d289@epcas5p3.samsung.com>
 <20241016112912.63542-5-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016112912.63542-5-anuj20.g@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241016_123553_477763_96A1FA19 
X-CRM114-Status: UNSURE (   8.19  )
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

On Wed, Oct 16, 2024 at 04:59:05PM +0530, Anuj Gupta wrote:
> +struct uio_meta {
> +	meta_flags_t	flags;
> +	u16		app_tag;
> +	u32		seed;
> +	struct iov_iter iter;
> +};

Is the seed used for anything other than the kernel's t10 generation and
verification? It looks like that's all it is for today, and that part is
skipped for userspace metadata, so I'm not sure we need it.

I know it's been used for passthrough commands since nvme started
supporitng it, but I don't see why the driver ever bothered. I think it
wasn't necessary and we've been carrying it forward ever since.

