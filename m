Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCBBEC433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Oct 2022 10:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yuxhxnCYm+2O8Hho+/QDCg4q9JFI5NYKA9K3jJJXa00=; b=Sbn3ZZW20JxXwITS//N9UzGLSb
	bGGj/lx602QZGfz3tuoxXI3uoHk2+yuYU4R6YkPtE8LWyo1vW7AuIwyw60xwmed4NiVbe7hg1d7MG
	OXcA7K241vGhNks5/r6LWuSHKO28h0zA4uV6ZdeYmpGku6WNVmCAT4nJZn9UToYqQMDfbJdek7mRx
	RwZF5+omNhfx3iGvSAYv1NxL5q2GQEULzninZaHcBDo7B+DT9LfF1hgtFJpOJ30ybRXF/IlLVqxNX
	A8N0U4SBWGFoM5to1gy0KlhF985ga+20C0m4s2Kq47YR5ggUYZhYUOgpdBb4zC1kEBdz5+DDPGU4b
	+gWYnL3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ondyN-008xkk-Bd; Wed, 26 Oct 2022 10:49:23 +0000
Received: from mail-wr1-f47.google.com ([209.85.221.47])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ondyK-008xk6-QI
	for linux-nvme@lists.infradead.org; Wed, 26 Oct 2022 10:49:22 +0000
Received: by mail-wr1-f47.google.com with SMTP id v1so25621580wrt.11
        for <linux-nvme@lists.infradead.org>; Wed, 26 Oct 2022 03:49:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yuxhxnCYm+2O8Hho+/QDCg4q9JFI5NYKA9K3jJJXa00=;
        b=mHtFKngx7RbxFZCxUh+3Op4P0so6Zn7vZmFsjCyirx7Uet1G8wc1Oem+LsSt13VKgm
         mMmffU6znEa41VlZ4WbDrpVsTiUd5/oauQCrG4vRphj3RUF7WzHTZ3bo6mN7yZQo5v9B
         z5buXrx2iFxAa56OZZmk9gCLV42EYbkbkAkeDA7cRkegcyMnhHAU5KEzav2oO48EAfiv
         Qq8YiJNfZUCb3XQltqBJwH15eQQ4Jddt6+gwQIMLTPNKHEN47tNIcteQJDPP5y6UjjPs
         +C1ZhYnby0KmuQhGQ+SHT51MesgnWPMMoaYgRsEla1PWXAMCNINnj3N8eEDcoreIW7rw
         my5g==
X-Gm-Message-State: ACrzQf2RGWb8NrzOPMiOwV30rOzHzrI+lMDP6TTdf4EUru1a8PElifH3
	nNSxRJVeWcAX2AToNY0Vm28=
X-Google-Smtp-Source: AMsMyM4+FvdhvGc9Q9FldQeL2DNBCgVObKlw/lWCrUlwdmHs594QIxtKPlbgzUBwnFGtqwxr5lxfYQ==
X-Received: by 2002:a5d:6dad:0:b0:22e:734f:31b1 with SMTP id u13-20020a5d6dad000000b0022e734f31b1mr28933921wrs.11.1666781358758;
        Wed, 26 Oct 2022 03:49:18 -0700 (PDT)
Received: from [192.168.64.94] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id k1-20020a05600c1c8100b003b4fe03c881sm1557627wms.48.2022.10.26.03.49.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 03:49:18 -0700 (PDT)
Message-ID: <6f630727-72bc-6ae8-e23f-dece692c31e7@grimberg.me>
Date: Wed, 26 Oct 2022 13:49:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 2/3] nvmet: expose IEEE OUI to configfs
Content-Language: en-US
To: Aleksandr Miloserdov <a.miloserdov@yadro.com>,
 Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, linux@yadro.com,
 Konstantin Shelekhin <k.shelekhin@yadro.com>,
 Dmitriy Bogdanov <d.bogdanov@yadro.com>
References: <20221026083135.77125-1-a.miloserdov@yadro.com>
 <20221026083135.77125-3-a.miloserdov@yadro.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221026083135.77125-3-a.miloserdov@yadro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221026_034920_880368_CD4DD0AC 
X-CRM114-Status: GOOD (  14.14  )
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



On 10/26/22 11:31, Aleksandr Miloserdov wrote:
> Allow user to set OUI for the controller vendor.
> 
> Reviewed-by: Konstantin Shelekhin <k.shelekhin@yadro.com>
> Reviewed-by: Dmitriy Bogdanov <d.bogdanov@yadro.com>
> Signed-off-by: Aleksandr Miloserdov <a.miloserdov@yadro.com>
> ---
>   drivers/nvme/target/admin-cmd.c |  9 +++---
>   drivers/nvme/target/configfs.c  | 49 +++++++++++++++++++++++++++++++++
>   drivers/nvme/target/core.c      |  2 ++
>   drivers/nvme/target/nvmet.h     |  1 +
>   4 files changed, 56 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index c8a061ce3ee5..0b415335bb5f 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -372,6 +372,10 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
>   	memcpy_and_pad(id->fr, sizeof(id->fr),
>   		       UTS_RELEASE, strlen(UTS_RELEASE), ' ');
>   
> +	id->ieee[0] = (subsys->ieee_oui) & 0xff;
> +	id->ieee[1] = (subsys->ieee_oui >> 8) & 0xff;
> +	id->ieee[2] = (subsys->ieee_oui >> 16) & 0xff;
> +

put_unaligned_24 ?

