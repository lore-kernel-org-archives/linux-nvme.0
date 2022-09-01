Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04366ECAAD1
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Sep 2022 10:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WjC5MMmeXT3QbFNucFQXnhs+/PC/vM67wXqw/sIvdOk=; b=VSK6qqo9CgLzzlcMfqO1g4NMAO
	zMiplwXDkSGQDz3pBm2d9ob2HwZ04SzLonUYpWsCD6o3XNhayucTUinFXqulWx/CMeYEVuI0bEsJb
	DwUEAWAv4LH8gqsDqjwM0GoVge8phCmZz6zMaHH9kUun2mGA8xQXYhelfmwtHDt86u+Mzk1Tv4JwT
	Ow5fT3wIeYN5Q8YH4nP/IPh2vfDJNYimXbXYEFa5/mtDPRa9XyAgUC2Bek6o+mpDuYqxePYSdKKDo
	Tx4SpcV9CvkL3mmmln9NWYCpl59zL0wOkaEUk7q+3qXxfzHzETvV59xQn98+fcXpFbnFjrze74pwD
	HVfBl9Bw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oThlX-00B8E8-3o; Thu, 01 Sep 2022 10:49:43 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oThlU-00B89P-9q
	for linux-nvme@lists.infradead.org; Thu, 01 Sep 2022 10:49:41 +0000
Received: by mail-wr1-f50.google.com with SMTP id u17so2529483wrp.3
        for <linux-nvme@lists.infradead.org>; Thu, 01 Sep 2022 03:49:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=WjC5MMmeXT3QbFNucFQXnhs+/PC/vM67wXqw/sIvdOk=;
        b=biqROz2CnSGZzQjsEK/zxgbnXcLfdDb5EdXRVz77FuZyVAvu4v18rQ5ycN/yefQXdO
         r+0dG6aiBYrvBhyUHrUicIPou7aI7d2g2O14YoezclcoG6dZCfjoKBlRI2cxpS65sNnK
         dNTW/KqHaArsZ9WY4RkgBua4u3EiNoWTlZ0fzQX9bS3ej1kuUexBJvR3BZRCNPNpa6CC
         ZNkE49i+eK9jIuOgTI4FGD4JaZ6VGTXySlwJHJqQiCQpPvmOpSfKMQ7C30T3jqU80xQ6
         ckGUVa8yO9S9UqwSy7Y7anuLcgX/v5uFCeR8/+x6mq+dR1xQa/h6cgxrVMEVbf5dT4+K
         XDwQ==
X-Gm-Message-State: ACgBeo3CHdH3plnncbofsxzNVi6j4EOIkuEYVKxww3hoWtipDwUyxCv4
	mfkynbm+pySHNaNs6oTJHe8=
X-Google-Smtp-Source: AA6agR6XN6fPghRY6m4UvfSO/a5VgaXvSdaPKgEJQvnTeiC3Bbq5mbrSMkaXumOd0Qm7oJF4IfpbCQ==
X-Received: by 2002:adf:f911:0:b0:21e:c0f6:fd26 with SMTP id b17-20020adff911000000b0021ec0f6fd26mr14153824wrr.361.1662029375141;
        Thu, 01 Sep 2022 03:49:35 -0700 (PDT)
Received: from [192.168.64.104] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id q28-20020a056000137c00b002205cbc1c74sm14250469wrz.101.2022.09.01.03.49.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 03:49:33 -0700 (PDT)
Message-ID: <62e78a2f-998a-b340-9dcd-7d5c12c96fe9@grimberg.me>
Date: Thu, 1 Sep 2022 13:49:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] drivers/nvme/host: Fix namespace duplication check
 rule
Content-Language: en-US
To: sungup.moon@samsung.com, "kbusch@kernel.org" <kbusch@kernel.org>,
 "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CGME20220901002815epcms2p6ae137d9de49bef5764f19c0fa7f3536e@epcms2p4>
 <20220901004941epcms2p4e5e1c53484889619f050a02d8e671eca@epcms2p4>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220901004941epcms2p4e5e1c53484889619f050a02d8e671eca@epcms2p4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220901_034940_380064_445F3E73 
X-CRM114-Status: GOOD (  25.00  )
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



On 9/1/22 03:49, Sungup Moon wrote:
> Some NVMe device, use EUI64 and NGUID, has fixed value EUI64 on a
> sub-system because of the bit size of ID. Current kernel check the
> all IDs should have unique value in a sub-system and globally.
> However, if an namespace has duplicate IDs (not all) in a sub-system,
> current kernel raise "duplicate IDs in subsystem for nsid" error. But
> NVMe Specification defines the namespace unique identifier like this:
> 
> When creating a namespace, the controller shall indicate a globally
> unique value in one or more of the following:
> a) the EUI64 field;
> b) the NGUID field; or
> c) a Namespace Identification Descriptor with the Namespace Identifier
> Type field set to 3h
> (reference: 7.11 Unique Identifier; NVM Express 1.4c spec)
> 
> So, I suggest the modified nvme_subsys_check_duplicate_ids function
> checking uniqueness from all IDS to one more IDs.
> 
> I missed the initializing of "duplicated" variable, so I reissue the
> version2 patch.
> 
> Signed-off-by: Sungup Moon <sungup.moon@samsung.com>
> ---
>   drivers/nvme/host/core.c | 25 ++++++++++++++++++-------
>   1 file changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index af367b22871b..8c2faa2881a4 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3902,24 +3902,35 @@ static struct nvme_ns_head *nvme_find_ns_head(struct nvme_ctrl *ctrl,
>          return NULL;
>   }
> 
> +#define IDS_EQUAL(A, B) (memcmp(&(A), &(B), sizeof(A)) == 0)

No need for this macro IMO.

> +
>   static int nvme_subsys_check_duplicate_ids(struct nvme_subsystem *subsys,
>                  struct nvme_ns_ids *ids)
>   {
>          bool has_uuid = !uuid_is_null(&ids->uuid);
>          bool has_nguid = memchr_inv(ids->nguid, 0, sizeof(ids->nguid));
>          bool has_eui64 = memchr_inv(ids->eui64, 0, sizeof(ids->eui64));
> +       bool duplicated;
>          struct nvme_ns_head *h;
> 
>          lockdep_assert_held(&subsys->lock);
> 
>          list_for_each_entry(h, &subsys->nsheads, entry) {
> -               if (has_uuid && uuid_equal(&ids->uuid, &h->ids.uuid))
> -                       return -EINVAL;
> -               if (has_nguid &&
> -                   memcmp(&ids->nguid, &h->ids.nguid, sizeof(ids->nguid)) == 0)
> -                       return -EINVAL;
> -               if (has_eui64 &&
> -                   memcmp(&ids->eui64, &h->ids.eui64, sizeof(ids->eui64)) == 0)
> +               duplicated = has_uuid || has_nguid || has_eui64;
> +
> +               if (has_uuid)
> +                       duplicated = duplicated &&
> +                               uuid_equal(&ids->uuid, &h->ids.uuid);
> +
> +               if (has_nguid)
> +                       duplicated = duplicated &&
> +                               IDS_EQUAL(ids->nguid, h->ids.nguid);
> +
> +               if (has_eui64)
> +                       duplicated = duplicated &&
> +                               IDS_EQUAL(ids->eui64, h->ids.eui64);
> +
> +               if (duplicated)
>                          return -EINVAL;

That is very confusing.

So a ns can have an identifier that does not have to be unique? or that
every identifier that exist should be unique but at least one identifier
should exist?

The former seems weird...

