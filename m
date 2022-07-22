Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 202DAC43334
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Jul 2022 06:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1VKRxjbe8Ws5L3Gl51lGCcQOzguBHdCK09NDRA9lFWs=; b=5CMZbESa4LByrgwSP3zSSs0bCI
	H1biCHemr9RZHx3OxBwuKO/rtyi2Yw31xV6G1lDMGSVTY0FFzz+Rh4I2ln3SKIY0SCfUR5HxmfT9p
	bpX52x5qQw4e6Jx2JEZMzkMehm0LN3txbPf5cl6NQZ+GitwT1atYF5iOpkOXeFtCiRXgh2JDtrhoe
	V4ngpbBBBkYO9w4W53tukyIa/qR3GbWzlXPxYHvrCvqonwjkSqraXbI+HMRYpA0T0tVhBPjXVjsv4
	hww5UXy5w3K8qolgSwSVebryFBmv2AVtQ3SiRhY+ftmLE4nLj/iZ8MhuL5aoktZLyxcBecKcP/b0z
	GZeWWv0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEm3D-000K7u-9d; Fri, 22 Jul 2022 06:22:15 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEm39-000K53-VJ
	for linux-nvme@lists.infradead.org; Fri, 22 Jul 2022 06:22:13 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 718901F99C;
	Fri, 22 Jul 2022 06:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1658470927; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1VKRxjbe8Ws5L3Gl51lGCcQOzguBHdCK09NDRA9lFWs=;
	b=UkHjnO+efyLg4Jx3PLuusrTBC/tFXCxyn4TQ0v/8SBgNdjoZ/A70OIyjw8+03SH1uXAvb2
	W0WVrmUsKYkglOabPKMg2mTcLBbjxobDsoTjHsXlMTsy1boKVrvikWsjp8pJFLBtygmtvG
	hcstwZdlABClWdSjTRsCV+pQThYell4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1658470927;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1VKRxjbe8Ws5L3Gl51lGCcQOzguBHdCK09NDRA9lFWs=;
	b=41icutbnFGwkyKNns+yXkLwy343HkTA8RzgVZko6k3heYn2C2m8XfaPj3V38KT+3zclrC1
	7NjI/Dm15Wr6o+DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5659113ABC;
	Fri, 22 Jul 2022 06:22:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id EvwjFA9C2mJ1FAAAMHmgww
	(envelope-from <hare@suse.de>); Fri, 22 Jul 2022 06:22:07 +0000
Message-ID: <10c59d89-2bbd-ae7c-d1cf-97d5c58c7330@suse.de>
Date: Fri, 22 Jul 2022 08:22:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] nvme-auth: Fix off by one checks
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <YtU/bFMYRCrx6tgp@kili>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <YtU/bFMYRCrx6tgp@kili>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220721_232212_206487_FF8F5C8F 
X-CRM114-Status: GOOD (  16.57  )
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

On 7/18/22 13:09, Dan Carpenter wrote:
> The > ARRAY_SIZE() checks need to be >= ARRAY_SIZE() to prevent reading
> one element beyond the end of the arrays.
> 
> Fixes: a476416bb57b ("nvme: implement In-Band authentication")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> The MAINTAINERS file needs to be updated for this new code.
> 
>   drivers/nvme/common/auth.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
> index 0c86ebce59d2..bfb16fec0aed 100644
> --- a/drivers/nvme/common/auth.c
> +++ b/drivers/nvme/common/auth.c
> @@ -55,7 +55,7 @@ static struct nvme_auth_dhgroup_map {
>   
>   const char *nvme_auth_dhgroup_name(u8 dhgroup_id)
>   {
> -	if ((dhgroup_id > ARRAY_SIZE(dhgroup_map)) ||
> +	if ((dhgroup_id >= ARRAY_SIZE(dhgroup_map)) ||
>   	    !dhgroup_map[dhgroup_id].name ||
>   	    !strlen(dhgroup_map[dhgroup_id].name))
>   		return NULL;
> @@ -65,7 +65,7 @@ EXPORT_SYMBOL_GPL(nvme_auth_dhgroup_name);
>   
>   const char *nvme_auth_dhgroup_kpp(u8 dhgroup_id)
>   {
> -	if ((dhgroup_id > ARRAY_SIZE(dhgroup_map)) ||
> +	if ((dhgroup_id >= ARRAY_SIZE(dhgroup_map)) ||
>   	    !dhgroup_map[dhgroup_id].kpp ||
>   	    !strlen(dhgroup_map[dhgroup_id].kpp))
>   		return NULL;
> @@ -113,7 +113,7 @@ static struct nvme_dhchap_hash_map {
>   
>   const char *nvme_auth_hmac_name(u8 hmac_id)
>   {
> -	if ((hmac_id > ARRAY_SIZE(hash_map)) ||
> +	if ((hmac_id >= ARRAY_SIZE(hash_map)) ||
>   	    !hash_map[hmac_id].hmac ||
>   	    !strlen(hash_map[hmac_id].hmac))
>   		return NULL;
> @@ -123,7 +123,7 @@ EXPORT_SYMBOL_GPL(nvme_auth_hmac_name);
>   
>   const char *nvme_auth_digest_name(u8 hmac_id)
>   {
> -	if ((hmac_id > ARRAY_SIZE(hash_map)) ||
> +	if ((hmac_id >= ARRAY_SIZE(hash_map)) ||
>   	    !hash_map[hmac_id].digest ||
>   	    !strlen(hash_map[hmac_id].digest))
>   		return NULL;
> @@ -148,7 +148,7 @@ EXPORT_SYMBOL_GPL(nvme_auth_hmac_id);
>   
>   size_t nvme_auth_hmac_hash_len(u8 hmac_id)
>   {
> -	if ((hmac_id > ARRAY_SIZE(hash_map)) ||
> +	if ((hmac_id >= ARRAY_SIZE(hash_map)) ||
>   	    !hash_map[hmac_id].hmac ||
>   	    !strlen(hash_map[hmac_id].hmac))
>   		return 0;

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

