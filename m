Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 671C0C001B0
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Aug 2023 08:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IE+cQYrLbzbuiiR055HvYGpi3UVMCeFENxlo5dC5k5w=; b=NuQSxxUUbLkbGHzLGntnvKF3+Y
	q7Vp7VkiQXodDsMAZUcTEtSU/yYuXXFFk0wdNvvaqDKiIeyJ/95ZvN0FaL7xmUss7vDa07RS9jSbO
	cpeK4W73au95w+1hlns849B7QDopNdI2+DiXODDEomoUQxVjwJIuXm9RXlxQ6IaCT6PJzizIQ2Eqq
	YAJFWyG7kFZNa7zDxqZrM5PBesHIp6m4LdZ2unOfx1emPP+0PGvV+0MrH4WIpi+x7UODoIuKZlGcS
	j0bJFFibCEi1vWRveElTJoyWiJRk5bu8cgUe8qb80B8deBpmio3W+BgLbhb0Nb+u3hZuOJGCfuvj+
	t8l1DrkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTIN8-0024h4-2L;
	Tue, 08 Aug 2023 08:47:22 +0000
Received: from mail-ed1-f44.google.com ([209.85.208.44])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTIN5-0024gJ-2K
	for linux-nvme@lists.infradead.org;
	Tue, 08 Aug 2023 08:47:20 +0000
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5230f92b303so1603252a12.0
        for <linux-nvme@lists.infradead.org>; Tue, 08 Aug 2023 01:47:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691484436; x=1692089236;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IE+cQYrLbzbuiiR055HvYGpi3UVMCeFENxlo5dC5k5w=;
        b=HEMfar7k9mino8IpG3fqemA/K6B8R9ro0QAx4aN41rKaiyBSV18ndZvxm7hgyZfFRo
         +rxmx67UeUBcHWiSJzkPHDY+jj9X/E+cXwtm9I6oSVpb2QPr7dJJgKU3Qum607kQBuGM
         AvWjgUGIBzr+G9E1gGIJThg1mV6zs01DVGO49XYKXbMuGFzTJqOOWW6qtWVM478zZc58
         67ZpnKWtpeyWO0wSKGh3QYp0JRivTjBU/7frupQD5144/OwU+yD3lbv7ndS7d0A+Abak
         yO8tfHAyinFJoehflS8JMq9LVGL/XjqByoZXAbtoYywtzk/WnysryuRI2qbVLxIHm4TO
         sGQg==
X-Gm-Message-State: ABy/qLb4wmHIUPvuST5HseMXD8LWkJDKetdnU652mBtoFGFMQT8C4EX4
	7PWy3lkebnBXQvsXpNYZwxU=
X-Google-Smtp-Source: APBJJlG4LDvxeTCVtTRK5ag4k0ARoHjKSEheRUpF87XGkzeWpDSuk6i1u1K5hwjweUKyMIwTiJ12Xg==
X-Received: by 2002:a17:906:519d:b0:99b:d682:f306 with SMTP id y29-20020a170906519d00b0099bd682f306mr20659333ejk.4.1691484435936;
        Tue, 08 Aug 2023 01:47:15 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id ot29-20020a170906ccdd00b00991d54db2acsm6298299ejb.44.2023.08.08.01.47.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 01:47:15 -0700 (PDT)
Message-ID: <e33c1a36-2b8e-8331-5f36-54dc47ab02d1@grimberg.me>
Date: Tue, 8 Aug 2023 11:47:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH libnvme v2 2/2] fabrics: Do not pass disable_sqflow if not
 supported
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Caleb Sander <csander@purestorage.com>,
 Keith Busch <kbusch@kernel.org>
References: <20230808070907.18834-1-dwagner@suse.de>
 <20230808070907.18834-3-dwagner@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230808070907.18834-3-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230808_014719_773875_F68238EA 
X-CRM114-Status: GOOD (  19.27  )
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


> Only retry a connect attempt with disable_sqflow if the kernel
> actually supports this option.
> 
> Reported-by: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   src/nvme/fabrics.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/src/nvme/fabrics.c b/src/nvme/fabrics.c
> index 9725eeb3cda8..f0e85d3b766d 100644
> --- a/src/nvme/fabrics.c
> +++ b/src/nvme/fabrics.c
> @@ -1043,7 +1043,8 @@ nvme_ctrl_t nvmf_connect_disc_entry(nvme_host_t h,
>   	if (!ret)
>   		return c;
>   
> -	if (errno == EINVAL && c->cfg.disable_sqflow) {
> +	if (errno == EINVAL && c->cfg.disable_sqflow &&
> +	    nvmf_check_option(h->r, disable_sqflow)) {
>   		errno = 0;
>   		/* disable_sqflow is unrecognized option on older kernels */
>   		nvme_msg(h->r, LOG_INFO, "failed to connect controller, "

I think you want to check this before the initial call
and avoid the retry altogether.
--
-       if (e->treq & NVMF_TREQ_DISABLE_SQFLOW)
+       if (e->treq & NVMF_TREQ_DISABLE_SQFLOW &&
+           nvmf_check_option(h->r, disable_sqflow))
                 c->cfg.disable_sqflow = true;
+       else
+               c->cfg.disable_sqflow = false;

         if (e->trtype == NVMF_TRTYPE_TCP &&
             (e->treq & NVMF_TREQ_REQUIRED ||
--

