Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 473E1C54739
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Aug 2024 15:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WXx4VoZAeWvQH5Xe5EE3WN2bpboCrALpASSGtxM9nQI=; b=eALzis46EtpKMuD8ShNN2noaon
	Fhzo9ZHF7znt+433vFN52mAdy9f1SaOQhGK7GAReFSACbQxEflzDtodpj0h9WIEnOqR4pRVmCqdj3
	S5tHeUEqBmA52e0XNHOeB0LYQaOBGkXEYndCejOcz6QGi143etEc93OYEg877uF4KKLrvoOCkhmmX
	X9UAbP/D/fW8kjEhzdNKdx1vHUnKgMtlM6ozYHDWszikexKdpeQAmOHyQZ8pvLI1jNTmSbC8wcCgW
	Xkxfg4T7hnzqew+Ns3y8UunO9UUzm+IB9vBcRtP/2CbCJg4+bBO1Cy4zJLt5ZXK6TrbGfQuo82M70
	Ux1M7khQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siyb8-0000000Bz9o-2yGe;
	Tue, 27 Aug 2024 15:59:10 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siyUc-0000000Bxg2-1wG5
	for linux-nvme@lists.infradead.org;
	Tue, 27 Aug 2024 15:52:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 3B0CDCE13B3;
	Tue, 27 Aug 2024 15:52:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B60AC4AF18;
	Tue, 27 Aug 2024 15:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724773331;
	bh=ct6HsZJM+KbM3jK/pFTdFUUrmqP2gqx8ImXYUPW9F+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nkYNZw6M+QD0ekK/X/XfDOnHo+5zWJ/ZTs1SSSgbHuf5TDE8kEIAuNMiooKqkoDDZ
	 EtNHIgPu3pY5p6JsFT37HOzFq9OKJ2++cYqJ/Vgwzz0VlmRpxe6arYZVwJ5IoROluk
	 b3w3DF6dJQmZR/MjrTOdHCrKRQAPO3cIvCjTGDNLayST2pcPrOybkKsbODnuIPmD10
	 dItZ9i0sFGpqRMjej9NC6oXP1j3V3+1XEelKPKAiX4kk1F5gGwrluxyPxwZbbguLwC
	 Lxc25vQjLhXMoFwqrRlzrmIQCzjImpGgO+w/vukd1Oc3S7zaahv81wpUeSs6Ec/EgX
	 auoxW2bASVwTA==
Date: Tue, 27 Aug 2024 09:42:08 -0600
From: Keith Busch <kbusch@kernel.org>
To: Puranjay Mohan <pjy@amazon.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, puranjay@kernel.org
Subject: Re: [PATCH] nvme: check if the namespace supports metadata in
 nvme_map_user_request()
Message-ID: <Zs3z0CNrREMYafoC@kbusch-mbp.dhcp.thefacebook.com>
References: <20240827121701.48792-1-pjy@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827121701.48792-1-pjy@amazon.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240827_085226_788812_36A3331A 
X-CRM114-Status: GOOD (  11.42  )
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

On Tue, Aug 27, 2024 at 12:17:01PM +0000, Puranjay Mohan wrote:
> @@ -122,6 +123,9 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
>  	struct bio *bio = NULL;
>  	int ret;
>  
> +	if (meta_buffer && meta_len && bdev && !blk_get_integrity(bdev->bd_disk))
> +		return -EINVAL;
> +

Should we also fail if there's no bdev? The driver won't use the
requested metadata for admin commands either, so that is also an invalid
user request.

