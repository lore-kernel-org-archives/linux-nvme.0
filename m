Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1400BC433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Jul 2022 04:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h9kQnWAcSF9Yzs1kL6Yq0lTdcDF4ILi/uKX3XcZK1Lc=; b=f+PL1xCUqP8h7mN3PQpKZ1QqhC
	DGFoZXP7ggXDPUG+ajBNnK1yEjE70DSfOXu7rR0jwTzTbAVADkSrVUekBE6pkNTDspVlWWrVHGYXV
	K7qooU0EkMh9+kU6Nflp/4wV5mXBxS2hyUze2hZYXjLxAU93VVoN4NZnylF5N8b6HiayCHP9uTASk
	+KPICBiFsTSQtgVjZD13nG5vW0y11ZZxhQa47BGgerxPWy/mY6i/gc4B5UeuknMjdDDvat0Gawk1G
	bSWNS5/9SVfl/jCCFROpuDc3LbxWBAULFNrvYaYLYVyb31EfB+uevG7ieWhZiWL3Gi29jQPaagflW
	hTOmJoKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEkam-00HYO0-Fz; Fri, 22 Jul 2022 04:48:48 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEkal-00HYNi-8O; Fri, 22 Jul 2022 04:48:47 +0000
Date: Thu, 21 Jul 2022 21:48:47 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Hannes Reinecke <hare@suse.de>, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/2] nvme-auth: Fix off by one checks
Message-ID: <YtosL0gGow56siA5@infradead.org>
References: <YtU/bFMYRCrx6tgp@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtU/bFMYRCrx6tgp@kili>
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

Hannes, can you review these please?

On Mon, Jul 18, 2022 at 02:09:32PM +0300, Dan Carpenter wrote:
> The > ARRAY_SIZE() checks need to be >= ARRAY_SIZE() to prevent reading
> one element beyond the end of the arrays.
> 
> Fixes: a476416bb57b ("nvme: implement In-Band authentication")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> The MAINTAINERS file needs to be updated for this new code.
> 
>  drivers/nvme/common/auth.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
> index 0c86ebce59d2..bfb16fec0aed 100644
> --- a/drivers/nvme/common/auth.c
> +++ b/drivers/nvme/common/auth.c
> @@ -55,7 +55,7 @@ static struct nvme_auth_dhgroup_map {
>  
>  const char *nvme_auth_dhgroup_name(u8 dhgroup_id)
>  {
> -	if ((dhgroup_id > ARRAY_SIZE(dhgroup_map)) ||
> +	if ((dhgroup_id >= ARRAY_SIZE(dhgroup_map)) ||
>  	    !dhgroup_map[dhgroup_id].name ||
>  	    !strlen(dhgroup_map[dhgroup_id].name))
>  		return NULL;
> @@ -65,7 +65,7 @@ EXPORT_SYMBOL_GPL(nvme_auth_dhgroup_name);
>  
>  const char *nvme_auth_dhgroup_kpp(u8 dhgroup_id)
>  {
> -	if ((dhgroup_id > ARRAY_SIZE(dhgroup_map)) ||
> +	if ((dhgroup_id >= ARRAY_SIZE(dhgroup_map)) ||
>  	    !dhgroup_map[dhgroup_id].kpp ||
>  	    !strlen(dhgroup_map[dhgroup_id].kpp))
>  		return NULL;
> @@ -113,7 +113,7 @@ static struct nvme_dhchap_hash_map {
>  
>  const char *nvme_auth_hmac_name(u8 hmac_id)
>  {
> -	if ((hmac_id > ARRAY_SIZE(hash_map)) ||
> +	if ((hmac_id >= ARRAY_SIZE(hash_map)) ||
>  	    !hash_map[hmac_id].hmac ||
>  	    !strlen(hash_map[hmac_id].hmac))
>  		return NULL;
> @@ -123,7 +123,7 @@ EXPORT_SYMBOL_GPL(nvme_auth_hmac_name);
>  
>  const char *nvme_auth_digest_name(u8 hmac_id)
>  {
> -	if ((hmac_id > ARRAY_SIZE(hash_map)) ||
> +	if ((hmac_id >= ARRAY_SIZE(hash_map)) ||
>  	    !hash_map[hmac_id].digest ||
>  	    !strlen(hash_map[hmac_id].digest))
>  		return NULL;
> @@ -148,7 +148,7 @@ EXPORT_SYMBOL_GPL(nvme_auth_hmac_id);
>  
>  size_t nvme_auth_hmac_hash_len(u8 hmac_id)
>  {
> -	if ((hmac_id > ARRAY_SIZE(hash_map)) ||
> +	if ((hmac_id >= ARRAY_SIZE(hash_map)) ||
>  	    !hash_map[hmac_id].hmac ||
>  	    !strlen(hash_map[hmac_id].hmac))
>  		return 0;
> -- 
> 2.35.1
> 
> 
---end quoted text---

