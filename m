Return-Path: <SRS0=uBfD=K4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB818C47083
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Jun 2021 12:26:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EAB3613B8
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Jun 2021 12:26:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EAB3613B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:Subject:
	From:References:Cc:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f9RGoymfyAQIi/QwBp8Sf/GElRgoIVKDhq129iwzJTc=; b=OiLbXU8I6TfqJ/C4AkcmrtaVJ/
	BU0Yu13J0xEDyWXX6QNR2uLrhWfv+jYSTeOuouv179Pn6o0KM9aUqKvhmdKpmcWxWR15fNHt8LENI
	z9sOv8f5U8F996Sa9vL2/CCMFz/cALEQow9w0+MKkLomKpAmiYgj+H45Qb3rIU04iGDSlFmXuyuYg
	VxSaxz3m7OMEPEeNV6PwfZ7/p2pj2cnuhFHAXAhK3n3qlY4VhA1r/1JVJctWpXAKnCMJ2U7qoUF7a
	U15D9ANgf2Jn2h3815G2WGaGJezjlKfR5Yyhp5Xu8z2uXqmxqbmLDLo20WoJEQGI0YFVE53FITxHw
	5myz+klg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1loPwg-0042eu-5w; Wed, 02 Jun 2021 12:26:02 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1loPlu-003xOq-CJ
 for linux-nvme@lists.infradead.org; Wed, 02 Jun 2021 12:14:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622636092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+WZvzkWyoU33l+EoH2um7bddlB7uqhofjcxdl6V4QOM=;
 b=DrrQhr1R91S2ShJkNeOOWFIK8Co0EQUEvqlap6vdjK5OpwSm0ANJyhHp776LeXNEr4m9Tg
 nhzESGQkwDy1zguZvxAqVYM8JiQ1ZehvJYX+y9mle56aormTzjh4HPp2EPgbLP3rC96rJC
 4ujHSZgH3VQtJyoJWowK9Z3llfVq/TQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-I2g7E3xWPyOWoRnylBCEig-1; Wed, 02 Jun 2021 08:14:51 -0400
X-MC-Unique: I2g7E3xWPyOWoRnylBCEig-1
Received: by mail-wr1-f72.google.com with SMTP id
 t5-20020adfb7c50000b029010dd0bb24cfso942153wre.2
 for <linux-nvme@lists.infradead.org>; Wed, 02 Jun 2021 05:14:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:references:from:organization:subject
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=+WZvzkWyoU33l+EoH2um7bddlB7uqhofjcxdl6V4QOM=;
 b=EaZPq0yzHMc+5eww6N2MZ4nkoWZ+a93zMa/OQFof0XEU6QV9jHGauDlIFIxE4JX7O0
 S/hMfFscgKmqN4m27x1DPMnWxGHxsvgA0VQnWCsblgl2UTtPxuKdMQ2d+KXOg8EQuP7M
 SyhcQZfQsJ/RkOaEs9WkpHWiTaSgKYb8LbcNwGA/w1T5e0YR92YZ2TwC/66yWwEULZsb
 SZ7QXvlfTw/3X3bcXemcg7gcyzfU7l3Rqp9ds0K/Se76UJoOr3XddDzLb1vrf/XEqkQq
 k6GsY4i2Ps3PBA+/nRQPzYeQtzQDhHNvtzEBrnSsaetNnR3myzf2lJj6YwF5G1AaIl51
 IPoA==
X-Gm-Message-State: AOAM5324FPZChxnF5vWPnfxLTxb+OPkn7pcgiLjZ5MzwpUb/8v6xG5ed
 mMI3h9Bdnw+aURHjHvkTqpZigsiPtcFhB5DKYjiN9UwIza7N2MGdP6yjO/kPDPhtFb5m33zsUdM
 FgpHHDHKY0i6VwEZ1USV/hdHUpwE=
X-Received: by 2002:a7b:c396:: with SMTP id s22mr10160293wmj.131.1622636090057; 
 Wed, 02 Jun 2021 05:14:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwGpbVgDrSlfIRKic51uMtC0PdZNIeN370u1E5fK+jYKeWSaQQbVkV3u6Hl/kPrdrf6iUsjYQ==
X-Received: by 2002:a7b:c396:: with SMTP id s22mr10160274wmj.131.1622636089857; 
 Wed, 02 Jun 2021 05:14:49 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6b6d.dip0.t-ipconnect.de. [91.12.107.109])
 by smtp.gmail.com with ESMTPSA id r7sm2581509wmq.3.2021.06.02.05.14.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jun 2021 05:14:49 -0700 (PDT)
To: Max Gurtovoy <mgurtovoy@nvidia.com>, linux-nvme@lists.infradead.org,
 dan.j.williams@intel.com, logang@deltatee.com, linux-mm@kvack.org, hch@lst.de
Cc: sagi@grimberg.me, oren@nvidia.com, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org
References: <20210602111055.10480-1-mgurtovoy@nvidia.com>
 <20210602111055.10480-2-mgurtovoy@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 1/3] mm,memory_hotplug: export mhp min alignment
Message-ID: <283740c3-db3f-3c9a-2954-f1c037a13e86@redhat.com>
Date: Wed, 2 Jun 2021 14:14:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210602111055.10480-2-mgurtovoy@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210602_051454_532341_B823AF89 
X-CRM114-Status: GOOD (  25.46  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 02.06.21 13:10, Max Gurtovoy wrote:
> Hotplugged memory has alignmet restrictions. E.g, it disallows all
> operations smaller than a sub-section and only allow operations smaller
> than a section for SPARSEMEM_VMEMMAP. Export the alignment restrictions
> for mhp users.
> 
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>   include/linux/memory_hotplug.h |  5 +++++
>   mm/memory_hotplug.c            | 33 +++++++++++++++++++--------------
>   2 files changed, 24 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index 28f32fd00fe9..c55a9049b11e 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -76,6 +76,7 @@ struct mhp_params {
>   
>   bool mhp_range_allowed(u64 start, u64 size, bool need_mapping);
>   struct range mhp_get_pluggable_range(bool need_mapping);
> +unsigned long mhp_get_min_align(void);
>   
>   /*
>    * Zone resizing functions
> @@ -248,6 +249,10 @@ void mem_hotplug_done(void);
>   	___page;				\
>    })
>   
> +static inline unsigned long mhp_get_min_align(void)
> +{
> +	return 0;
> +}
>   static inline unsigned zone_span_seqbegin(struct zone *zone)
>   {
>   	return 0;
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 9e86e9ee0a10..161bb6704a9b 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -270,24 +270,29 @@ void __init register_page_bootmem_info_node(struct pglist_data *pgdat)
>   }
>   #endif /* CONFIG_HAVE_BOOTMEM_INFO_NODE */
>   
> +/*
> + * Disallow all operations smaller than a sub-section and only
> + * allow operations smaller than a section for
> + * SPARSEMEM_VMEMMAP. Note that check_hotplug_memory_range()
> + * enforces a larger memory_block_size_bytes() granularity for
> + * memory that will be marked online, so this check should only
> + * fire for direct arch_{add,remove}_memory() users outside of
> + * add_memory_resource().
> + */
> +unsigned long mhp_get_min_align(void)
> +{
> +	if (IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP))
> +		return PAGES_PER_SUBSECTION;
> +	return PAGES_PER_SECTION;
> +}
> +EXPORT_SYMBOL_GPL(mhp_get_min_align);

We have to main interfaces to "hotplug" memory:

a) add_memory() and friends for System RAM, which have memory block 
alignment requirements.

b) memremap_pages(), which has the alignemnt requirements you mention here.

I feel like what you need would better be exposed in mm/memremap.c, for 
example, via "memremap_min_alignment" so it matches the "memremap_pages" 
semantics.

And then, memremap_pages() is only available with CONFIG_ZONE_DEVICE, 
which depends on SPARSEMEM_VMEMMAP. So you'll always have 
PAGES_PER_SUBSECTION.

I can already spot "memremap_compat_align", maybe you can reuse that or 
handle it accordingly in there?


-- 
Thanks,

David / dhildenb


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
