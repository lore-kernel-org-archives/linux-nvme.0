Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36780C5B572
	for <linux-nvme@archiver.kernel.org>; Sat, 22 Aug 2026 22:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YqBvLWdahQvTz+LV259w0B4zkUoUpI+mGUIV1cdkyVs=; b=IesDqTGdIlI6vYLo6Hx4CsrYp6
	eJDjgzlISTLqLBo6LtMRrlI05grjCRiK1CwQzl7YyXDBqgXXkzJ/vDH9cvzguAH0V1HXS564yI5lV
	M5aJss4SWBxHu6XATiYTEC/41BcCfPI3ALsuq49d5PlEydD0+aidAD/65/0yoBWU9+2TzuuLY2il3
	aplLdDJdSXwAu2bDvynxKMQRgiP8V71NE8QVhUcmk2cmEy3Q+muGd5x1DwU5XkZHR0thPswA/K3Nl
	ZpsHkK39ZhzwUcMAx2Fn2FTsRikiaF+UAjmsySWb9+dq3AJ7ahrP1zNxfBVqPl5y2X04b3EOCqQ7l
	jFc9vBHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxtwZ-0000000Epdz-19Dy;
	Sat, 22 Aug 2026 22:12:03 +0000
Received: from mail-ej1-f50.google.com ([209.85.218.50])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxtwX-0000000EpdR-0QmH
	for linux-nvme@lists.infradead.org;
	Sat, 22 Aug 2026 22:12:02 +0000
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c15f020a223so325866966b.1
        for <linux-nvme@lists.infradead.org>; Sat, 22 Aug 2026 15:12:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787436719; x=1788041519;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YqBvLWdahQvTz+LV259w0B4zkUoUpI+mGUIV1cdkyVs=;
        b=XjApQxp91HHAQz0UpMeJ/ZC3aJkTQuocMhBKRX+yAFdMVWvJSZpeM8xHwuIq02z8LV
         vkk+hiGdEY1WsKICGKFuAuK9MUn+LBbroBv/TBa+kFU6++y4rG7Ues3o2fmbO0Y2Cn+Z
         7ixTLRusHCPbbcK0i8ls++4XwzHxpbF3q/u02kJ1w0b/l3QL8PsNVGiWVMLrcztjYi4D
         w4cYc0rMJVZ+zN1LAQv4zGv06Z/+36NsHk4MECq/EaU9RF452Zhbfbp4gFcmggomVnR7
         rk7sa1yUiHsQ4jrrQDY0nNWZy7QJjZqY4Jn95eXdCgsUxBWjsE7auJ1FoE0NDvdPZbxG
         4euQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqe+SltKODFbqICFpXG6zDwvH3mzzb71o/cXw29WyUEKoe2A6KiBdjdhUTTMN0yivWYNSTZBCLMVRfV@lists.infradead.org
X-Gm-Message-State: AFuF++k9maw3sVK+8ABlCHwLHzlKfGs2nG4En/vlJYjF5ywT9VBiO57D
	RCtJvM6+713tdnF0X2cbEeItgqTkxWX0siN+vBaFiTsgEvUkPUHo3aUSfT6dsw==
X-Gm-Gg: AR+sD123F7KvaIBm4qdnPzoej0ULGy5KfghgWUHW75q66liEE5IpkgT2fkJn9yqc38d
	PBP4V6SjD+t+ly1r9jEOvehaBaoxjhS8ci6Z+sK418IXTtLTXE2glXCjI/GvSBdb33RNDxWAjUa
	ABc1US5YraVDmCCFMz6vf+E2FOZGe+ra6wNvMcRkUSedR8pGf80c+xg2V1252g/LYowTHxtT4Qd
	BpK1TA8pwPG97+LnXI9P+ACtZhCtv7gIXnY387luW4KlgfrfU/cFIbQ2+OjQF2yq2Oap99pjMJ8
	F4fqQwU2+r3gLNygsCQ/wkB5YQDGkmDbbW/sJagCdJeQRjsLR7hOg8myKy1NVu1PTu72Nt9MI1J
	Kz5tq10r1zTWo83z+TL8Ifwu6wSOYRZYPwCkGPfgFTOoJlt5H82b9IzgWwSsLMtLmKMNI0+/BK1
	DVLiyIpoY74pCAh3K1Y2t2kQJHQzTzch5lXwWCMwoiCvbmcmw0Vgc6j2d5Qy74b39bWjs8yLv+i
	IRsIzG2EpY2e4gpYiCKmpM=
X-Received: by 2002:a17:907:97c9:b0:c20:f703:c411 with SMTP id a640c23a62f3a-c246a4ad5c9mr1401657866b.5.1787436718958;
        Sat, 22 Aug 2026 15:11:58 -0700 (PDT)
Received: from [10.100.102.74] (89-138-65-240.bb.netvision.net.il. [89.138.65.240])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24966f8f08sm488159866b.35.2026.08.22.15.11.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2026 15:11:58 -0700 (PDT)
Message-ID: <e948f5e5-3e96-4467-a4dd-67316871cc7a@grimberg.me>
Date: Sun, 23 Aug 2026 01:11:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH nvme-7.3 3/4] nvme-fabrics: add helpers for subsystem and
 host identity options
To: raoxu <raoxu@uniontech.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
References: <29BB44C32FF06823+20260821062142.1932160-1-raoxu@uniontech.com>
 <450E21059686C852+20260821062529.1936914-1-raoxu@uniontech.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <450E21059686C852+20260821062529.1936914-1-raoxu@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260822_151201_168790_599B4952 
X-CRM114-Status: GOOD (  21.40  )
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



On 21/08/2026 9:25, raoxu wrote:
> From: Xu Rao <raoxu@uniontech.com>
>
> The nqn, hostnqn and hostid options also start with match_strdup(), but
> unlike the direct string replacements handled by nvmf_parse_string_option()
> they perform option-specific validation or conversion before parsing is
> complete.

Does this warrant that they get a special handler? I am not sure I see 
how this helps.

>
> Move each lifetime into a helper whose name identifies the value being
> parsed:
>
>    nvmf_parse_subsysnqn() handles NVMF_OPT_NQN.  It replaces
>    opts->subsysnqn, checks NVMF_NQN_SIZE and updates discovery_nqn.  Using
>    subsysnqn in the helper name distinguishes the subsystem NQN from the
>    host NQN at the call site.
>
>    nvmf_parse_hostnqn() handles the hostnqn option.  It keeps the existing
>    host-assignment check, validates the temporary NQN, copies it to the
>    hostnqn buffer and frees the temporary allocation before returning.
>
>    nvmf_parse_hostid() handles the hostid option.  It converts the temporary
>    string to uuid_t and frees the duplicated string on both success and
>    failure paths.
>
> These three helpers are grouped because they parse non-sensitive identity
> values that require validation or conversion rather than a simple owned
> string replacement.  Preserve the existing validation and ownership
> ordering while moving the code.
>
> No functional change is intended.
>
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Xu Rao <raoxu@uniontech.com>
> ---
>   drivers/nvme/host/fabrics.c | 118 +++++++++++++++++++++---------------
>   1 file changed, 69 insertions(+), 49 deletions(-)
>
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index aab3fd279d0e..120e57964cdd 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -725,13 +725,75 @@ static int nvmf_parse_string_option(substring_t *args, char **dst)
>   	return 0;
>   }
>   
> +static int nvmf_parse_subsysnqn(struct nvmf_ctrl_options *opts, substring_t *args)
> +{
> +	char *nqn;
> +
> +	nqn = match_strdup(args);
> +	if (!nqn)
> +		return -ENOMEM;
> +
> +	kfree(opts->subsysnqn);
> +	opts->subsysnqn = nqn;

The above is nvmf_parse_string_option() no?
> +	if (strlen(opts->subsysnqn) >= NVMF_NQN_SIZE) {
> +		pr_err("%s needs to be < %d bytes\n",
> +		       opts->subsysnqn, NVMF_NQN_SIZE);
> +		return -EINVAL;
> +	}
> +
> +	opts->discovery_nqn = !strcmp(opts->subsysnqn, NVME_DISC_SUBSYS_NAME);

Not sure that this helper existence is really needed, but ok.

