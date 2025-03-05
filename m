Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B25C282DE
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Mar 2025 15:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DkwTd7sB8CX/Z3ngIAKxnSgH/1vdK2QO0VPmjX7CcoQ=; b=a84PgvYpUmxolTnY22USsNQexb
	NDDbQYvscmDzy7waKQWIcD0q/oxy5WhKT2dcSR7ZqM8VQyKTN9yMX3r+RgDVY74Lx9/3VU0vQLEL6
	0xuFBOfC/LIrq5AuGdwXaBbY33XlPQlpQ4fOBox2kW15xH2gPj3wnc1Z8p+Q09D0I5an0J24xeAEU
	egVlDE+gFadornbMnecgyp4YOzgiVQ24/uSAk8lu8sU3OEIk53116HQKLHBtnnIeUFMl0hRP6fRNc
	eJmZWFzuMkvItRJyFzq2l+zo+3WQDBnqlnTjPZjLQQy+iWviOES8oYDxHulaVtGhp6fxMa+xkueBD
	FimJyB1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tpqzD-00000008Ycv-3OEp;
	Wed, 05 Mar 2025 15:48:43 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tppry-00000008NYA-0kGD
	for linux-nvme@bombadil.infradead.org;
	Wed, 05 Mar 2025 14:37:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DkwTd7sB8CX/Z3ngIAKxnSgH/1vdK2QO0VPmjX7CcoQ=; b=Al2l4EQteGqEa3K0W8or3iK0xL
	H7hZpgDnfbIY9BluI9U+/RX1MZyMSfl2yzc2CdlZugOvQiTRgN1Ch6AQ5lRNRr+S5mBjYCy+v8SdT
	uBR2DPtvBd6ZzKTdPkkzcKmcZj+VEY0wLEXIgOVqn/Pt5zsVWcfcmY5UHX8XnpweZBcZkg1FKWjEr
	J0cJeFotzKbFHkFWKT+pmV9nARzblel5fudwHQ8mHgC1KySBgaJkyMoshUuFFSEV/UyM3pzyOSV5e
	tT8TuzSPNOtKWcD/0Vxla9Am7ikwfNvSIAo5Nz+8YTsNATLL/W+JKEjUi1eVRFuE6ZC+tUBp3IzXD
	M8AFKIGw==;
Received: from verein.lst.de ([213.95.11.211])
	by casper.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tpprv-00000005fdv-1uc8
	for linux-nvme@lists.infradead.org;
	Wed, 05 Mar 2025 14:37:09 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3F18C68AFE; Wed,  5 Mar 2025 15:37:01 +0100 (CET)
Date: Wed, 5 Mar 2025 15:37:01 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Meneghini <jmeneghi@redhat.com>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, loberman@redhat.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	emilne@redhat.com, bgurney@redhat.com
Subject: Re: [PATCH 4/4] nvme: add mulitipath warning to nvme_alloc_ns
Message-ID: <20250305143701.GA18818@lst.de>
References: <20250228032541.369804-1-jmeneghi@redhat.com> <20250228032541.369804-5-jmeneghi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228032541.369804-5-jmeneghi@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250305_143707_516375_7C3D594D 
X-CRM114-Status: GOOD (  14.00  )
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

On Thu, Feb 27, 2025 at 10:25:41PM -0500, John Meneghini wrote:
> When CONFIG_NVME_MULTIPATH is disabled, add a warning if
> we discover a multipath enabled controller with an attached
> shared namespace.
> 
> Signed-off-by: John Meneghini <jmeneghi@redhat.com>
> ---
>  drivers/nvme/host/core.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index c2b7e6834535..465069c0f6a8 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3938,6 +3938,15 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
>  	} else {
>  		sprintf(disk->disk_name, "nvme%dn%d", ctrl->instance,
>  			ns->head->instance);
> +#ifndef CONFIG_NVME_MULTIPATH

This can use IS_ENABLED to clean the code up a bit.

> +		if ((ctrl->subsys->cmic & NVME_CTRL_CMIC_MULTI_CTRL) && info->is_shared) {

overly long line.


