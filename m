Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64D82C61DE8
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Aug 2026 21:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KulJb9m4lyjbS/Bxlru8m+jiMLlRHaAM9CjPiqQQbHY=; b=wtbaMI9pf6ekClefRbaUUDD4HM
	4yR4LFGzDvj5WI3HojcpWZuiIlJ24kOKM0T8e4Jw++QEcOolOyTprhOGEEretBr5kZMk3y48UJDR0
	7Mzeur9wbxKaQ/qxrAXsRctlmRzOPr7q54m3wUjt9FRAKNddTWF3Yf7gC/6w//0uuiQEdXqC+ffpU
	LMDrvr5l5SMP672uzSt0muVeWYIya7NgyzMZY+6oppYHj8Z1/82ABIbzavNb2Pa2pD9UrDhTb0srC
	NTm3LANKJeUnI5EkxuZYBcMlVaBc+l9nvlG9XacMhBCSmbQfbiYfIQcbqXjUNS1rNX/nA3pi2Oah6
	aGLtU7Ww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0n05-000000087Ho-3MIu;
	Sun, 30 Aug 2026 21:23:37 +0000
Received: from mail-wm1-f42.google.com ([209.85.128.42])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0n02-000000087Gw-30w2
	for linux-nvme@lists.infradead.org;
	Sun, 30 Aug 2026 21:23:35 +0000
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49b8be0409fso16294655e9.2
        for <linux-nvme@lists.infradead.org>; Sun, 30 Aug 2026 14:23:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788125013; x=1788729813;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KulJb9m4lyjbS/Bxlru8m+jiMLlRHaAM9CjPiqQQbHY=;
        b=oG7vyXF/PhdkPKQy857j7wfP96A6A8IZ9hC5KyMMxEfyqXzHGcNgvgX7upgqqnnp2a
         e3GGHzKH2MA0MtxdgB8fV9FxLwmbn+poS9zS3vMRubBdMQEWGhVZdnpAQD5JEfSA/qpu
         HgSDny+ozhl7x9NZC7V3RRHh9kDmc0QNTUIpoLmnp5X9D0Q4/PdEBA54rvMd/USomDnb
         nwbOS0oc3zrEIgWXfenjuVbeMJtFa+PT9KlMC2rKib9+SRc/fEVrD6LNfv2kvDLG6/RT
         ivk1aep4B8Qdsjsikf7lpkEQhm/BM8IfJOLa7PlVK3loSAI0Tdf37VxHDYafS9AeFUA5
         5sqA==
X-Forwarded-Encrypted: i=1; AHgh+RrNqTIC2IQb8Hw2yJpTEFrU0aCFJjYLcNxQeMOJtPfV47wDTorJnFL/wGLlVEkoGmn4RbUJkmic1sAs@lists.infradead.org
X-Gm-Message-State: AFuF++mG/Z1UMlNHeKf2pPk4Cn94wzuRnUeE6Opnb0qONinfaG2/J4DK
	Fj2KByVxauhc9lmVAzjk01C4ncY/IysYiH+sQEmKH8dmaz2Exl319pmXbb+oJoYFV68=
X-Gm-Gg: AR+sD13mJ2L36gECg82v3tpmOm9HzCWr94QvzP6gQ+NBNA0iZNPN6FFK3K+Nk5wVDFi
	M/6A4Vw0FhMRy4ObZWQd/IzXrzJDSGFjHFk2TZL65XfnNX4hNxfdPyI5RmaFtOHhY2/cI0B9HFW
	wmGdf3xVnQPDgduXGgfdu+iGcZskN6xyM7EuQ6epZS2RoKqrVnAnMKjbIIEa0838jnKu5naiNIT
	oMltX9fkGUQqt2i3LUUK2maBWPo1MWsQro4bRFsYNXKGbRP4Q7nIgpckZiPvldUu1+HPYksFIeH
	LYbYA8NtC7F5GIFssYMQQ38rwc4z2hqrPyTZ2bu2wp3b503Ji57umrkvTzeBvRZLF1/Kz2u0db9
	KXzYSq6coLfUjCeh18K1mEYl/2wvXPnrLmfgjT91PVNyyRXiLsLCGlyU2wkpq/nwgHPuvH+YmFF
	FmwtSBCHKzUgLALGxpD+QaKsQs87acU3g/FAEaXkSU4SaAIiSM7scel+WrT85IvHPv2abx52hzb
	oH1MRxTb+3WToqJ8Xg9EA==
X-Received: by 2002:a05:600c:6088:b0:49b:2796:be30 with SMTP id 5b1f17b1804b1-49b91c433a4mr342610655e9.11.1788125012656;
        Sun, 30 Aug 2026 14:23:32 -0700 (PDT)
Received: from [10.100.102.74] (89-138-77-243.bb.netvision.net.il. [89.138.77.243])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b91728319sm219625835e9.12.2026.08.30.14.23.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Aug 2026 14:23:32 -0700 (PDT)
Message-ID: <499d5395-3055-4968-8b73-d095ba427134@grimberg.me>
Date: Mon, 31 Aug 2026 00:23:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH nvme-7.3 v2 4/4] nvme-fabrics: add helper for DH-CHAP
 secret options
To: raoxu <raoxu@uniontech.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
References: <0D24A9A3F19DBCF9+20260827125710.1381672-1-raoxu@uniontech.com>
 <A234F50F1018A58C+20260827130407.1391174-1-raoxu@uniontech.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <A234F50F1018A58C+20260827130407.1391174-1-raoxu@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260830_142334_771904_34C1B761 
X-CRM114-Status: GOOD (  19.32  )
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



On 27/08/2026 16:04, raoxu wrote:
> From: Xu Rao <raoxu@uniontech.com>
>
> The dhchap_secret and dhchap_ctrl_secret options have a distinct string
> lifetime because their values are authentication material.  The temporary
> string must be checked for the DHHC-1 representation and discarded with
> kfree_sensitive() when validation fails before ownership is transferred.
>
> Add nvmf_parse_dhchap_secret() to keep match_strdup(), DHHC-1 validation,
> failure cleanup, replacement of the old value and successful ownership
> transfer in one scope.  Both secret options use the same helper because
> their parsing and ownership rules are identical.
>
> Keep the existing replacement semantics for an already stored valid secret;
> this patch only moves the parsing and temporary allocation lifetime into
> the helper.
>
> No functional change is intended.
>
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Xu Rao <raoxu@uniontech.com>
> ---
>   drivers/nvme/host/fabrics.c | 48 ++++++++++++++++++-------------------
>   1 file changed, 24 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 24385e777307..dc8883d85f45 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -725,6 +725,25 @@ static int nvmf_parse_string_option(substring_t *args, char **dst)
>   	return 0;
>   }
>   
> +static int nvmf_parse_dhchap_secret(substring_t *args, char **secret)
> +{
> +	char *value;
> +
> +	value = match_strdup(args);
> +	if (!value)
> +		return -ENOMEM;
> +
> +	if (strlen(value) < 11 || strncmp(value, "DHHC-1:", 7)) {
> +		pr_err("Invalid DH-CHAP secret %s\n", value);
> +		kfree_sensitive(value);
> +		return -EINVAL;
> +	}
> +
> +	kfree(*secret);
> +	*secret = value;
> +	return 0;

Looks very similar to nvmf_parse_string_option... Would this be better? 
-- static int nvmf_parse_dhchap_secret(substring_t *args, char **secret) 
{ int ret; ret = nvmf_parse_string_option(args, secret); if (ret) return 
ret; if (strlen(*secret) < 11 || strncmp(*secret, "DHHC-1:", 7)) { 
pr_err("Invalid DH-CHAP secret %s\n", *secret); 
kfree_sensitive(*secret); return -EINVAL; } return 0; } --

