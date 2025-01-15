Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86984C02180
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jan 2025 15:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rSIoW+pSrK4ulyXu15Q0kluo5X+XY5Mi5yM1yQMCQTU=; b=NbAy6aJ2EY4PgdUSmfZVCcXc6m
	WQQVrDWHHGKBuJZfZdhHO9cTUDf4562BlLbKT1LBZVQxfPyhmVz3LAjZ0I98oPQTeNRMqsKXMc3I+
	U9TQI6sdLSyZuG/EN5y4yljFRFg1y6eZeB2Y1a4A0qahZXnGF0Q8/u/LP0khxR1rUyXtZ6ucka8dd
	gKPATLTM9nVziGShX3FnpjbOrtFctkhSoeMsClXXxI/VyDIz5UBo+tVoNePc3qoo/9iMuKrWPEi5L
	7uZrAmLxst3UlEsQysU1Rbghlpbnelm+K51zF71gYLv97BtEh2yy8vie23joLhSVydkzu0WXHprHM
	3nYl0sEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tY5i4-0000000CKzT-2KZ1;
	Wed, 15 Jan 2025 15:53:36 +0000
Received: from mail-io1-xd36.google.com ([2607:f8b0:4864:20::d36])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tY5i2-0000000CKyk-1ZZp
	for linux-nvme@lists.infradead.org;
	Wed, 15 Jan 2025 15:53:35 +0000
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-844ee166150so218798939f.2
        for <linux-nvme@lists.infradead.org>; Wed, 15 Jan 2025 07:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1736956413; x=1737561213; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rSIoW+pSrK4ulyXu15Q0kluo5X+XY5Mi5yM1yQMCQTU=;
        b=NCcG0RjZ3gyCcJZrsAfzmF+z6DlDQN9fv6XCYrjCKRspnTsTyQziU8E1hpzlvREiOu
         D6ZBUS33CcMTeX0SjBjul/KIlqmpkshXvcrk5TPzRKVB6U4xq38JOvuBoTdNVRR9vVsT
         Ap6mcTWXwVsCIBjJHzjmLvIxGckPC7vlSxIFy4YSF+eCcFtiA/tAxyHaPp7lB2dk4+Uo
         qEZyGsTId0cczd1eeCGXzekrgE8SAJ1MsfPeKBxeZiMJiCQevewzto3ArCyduYZghUMg
         QbdAeW7/S1T4GMEpDDOvkfsTaqE678CZoraCCRf6xuHkmSGZoTGMnQ4uEKbHKhYxadr4
         ksdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736956413; x=1737561213;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rSIoW+pSrK4ulyXu15Q0kluo5X+XY5Mi5yM1yQMCQTU=;
        b=u39ROENxMowqx8aGBD/TFtuT6fwJucHoRwzOn8nNprIvm4jlkTnFODBJmJV5qOZrWV
         WkyPK2q54iekUDyxMrkK+QT+L0XFLrXii/4auLqhmaoo+BQGAdE/OQub+BWy5H17glU+
         Q2KQqwqbVulIysJM4D/lj+DLg8ccPeoJ41QCcjUMW9FEo4WZqhGhh/7pmGnoVik8/Zsv
         rPI//mIgsnZR603fg/00Rk9VfikjuWugHbOQnlU4orWWC5Klt5xQJDDGNr8xBhJm+Lk3
         C/5YwrsCruiwNCF1FEI0WjNfAuVI6Oz7O1OA77HnBhpfEdm0hA8MkacDBnmhj1gjwvyh
         tsDg==
X-Forwarded-Encrypted: i=1; AJvYcCXM3Vhr6aBdMn20swUnnhweEURU45mjHYgX/LrggorG9g9vo0x1UbfkQ6h/qE+ovaUnMwJteXtAweB0@lists.infradead.org
X-Gm-Message-State: AOJu0Yyh5oBluUuOXPijFxr7DDvZe75B79AsjfT+R2LC4buTAGB6+7tN
	jAmmNaA8zHLqj8Ap/RHSEPvkZykWAOmTznj4TjvIS1rqJXF+3dHD045nB++d+IiQwfBxoLEfsDl
	O
X-Gm-Gg: ASbGnct+YGnwf9+JwjIlQsAzZ6c3uGHMe/iULFxdJjnkICzaSnbND/wBD4jpseGJmCo
	oV0H3LaC4ODDjokPGLDQ5EuspdiFlVjpF+HRZUITBpb5p2t6H9adf/YINLBm2ogeEWH05RrNrb+
	HKKjahuPzNB19G+bZvvQLl+dGAEohxBgI5/ERvlAJO0YaX61J2PiGgPCRp+1Z+Zl/DI3kMS1z6e
	g5FSra/GjeizHOqFLjIKwHTWFMOxLrxCs5E4N9Wj+GkGGYHaS7Z
X-Google-Smtp-Source: AGHT+IH6QEiwZ1kWtBnMU+zmHk+ZwlW+6z57Q6JxyXgh1bqC91GoZ7XDL4EUNWnWqisFwGkYrc8jfw==
X-Received: by 2002:a05:6e02:1d98:b0:3ce:8693:728e with SMTP id e9e14a558f8ab-3ce869373a0mr28587855ab.3.1736956413550;
        Wed, 15 Jan 2025 07:53:33 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ea1b612fa4sm4131943173.42.2025.01.15.07.53.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2025 07:53:33 -0800 (PST)
Message-ID: <2114e6fc-550c-4772-a891-a8d40195eb39@kernel.dk>
Date: Wed, 15 Jan 2025 08:53:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: fix compliation errors
To: Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
References: <20250115034722.145742-1-kch@nvidia.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250115034722.145742-1-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250115_075334_411850_16F141D2 
X-CRM114-Status: GOOD (  11.94  )
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

On 1/14/25 8:47 PM, Chaitanya Kulkarni wrote:
> nvmet_alloc_ctr() only takes nvmet_alloc_ctrl_args. nvmet_alloc_ctrl
> doesn't have nvmet_req argumrnt. In nvmet_alloc_ctrl nvmet_req is
> needed when setting up authentication capabilities since call to
> nvmet_setup_auth() requires nvmet_req argument which later uses req->sq
> to determnine if tls is enabled or not.
> 
> That leads to following compliation errors:-
> 
> target/fabrics-cmd.c: In function ‘nvmet_execute_admin_connect’:
> target/fabrics-cmd.c:318:35: error: too few arguments to function ‘nvmet_connect_result’
>       |                       ^~~~~~~~~~~
> target/fabrics-cmd.c:237:12: note: declared here
>   237 | static u32 nvmet_connect_result(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
>       |            ^~~~~~~~~~~~~~~~~~~~
> make[4]: *** [/mnt/data/nvme/scripts/Makefile.build:194: target/fabrics-cmd.o] Error 1
> make[4]: *** Waiting for unfinished jobs....
> target/core.c: In function ‘nvmet_alloc_ctrl’:
> target/core.c:1527:37: error: ‘struct nvmet_alloc_ctrl_args’ has no member named ‘req’
>  1527 |         struct nvmet_req *req = args->req;
>       |                                     ^~
> target/core.c:1635:25: error: too few arguments to function ‘nvmet_setup_auth’
>  1635 |         dhchap_status = nvmet_setup_auth(ctrl);
>       |                         ^~~~~~~~~~~~~~~~
> In file included from target/trace.h:19,
>                  from target/core.c:16:
> target/nvmet.h:879:4: note: declared here
>   879 | u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_req *req);
>       |    ^~~~~~~~~~~~~~~~
> target/core.c:1654:17: error: too few arguments to function ‘nvmet_has_auth’
>  1654 |                 nvmet_has_auth(ctrl) ? " with DH-HMAC-CHAP" : "");
>       |                 ^~~~~~~~~~~~~~
>   889 | static inline bool nvmet_has_auth(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
>       |                    ^~~~~~~~~~~~~~
> target/core.c:1527:27: warning: unused variable ‘req’ [-Wunused-variable]
>  1527 |         struct nvmet_req *req = args->req;
>       |                           ^~~
> 

Ugh... Thanks for finding this. When you do a v2, can you please also add
a fixes tag?

-- 
Jens Axboe


