Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C9BC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Jan 2022 22:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DaaUGCArWoJ13enar8ZLJWX1P69BgDpg9YRakjeDVMM=; b=cWlXnvEe/PmZH4pU+O1kKpTdQ5
	Zj3AcoKWtHHkZ59zZfO0yjpNkfbTf+U6HxPzFLtcY6EfvHSGDVuQnPPrpCJcrQPOo03y58gFPZjOs
	7arA6Zyt4paEWaK6BcI4U4ZqriLllMHrCE4vCKxHztzFgRPOcH12BcpfUpMhTOh6SSGEf7hb099dh
	sNv6AGJye6ZBg6fURh00ZexPMmjIkcIzwQsZFC1Ar8QlL7+IGnAGiWqHA+mw1Co36F3M3PPPLb2e5
	Z/pzWOfYKJJ6CIe+mez30HBHbYURcSUA9/vLIP/Jb5WgsIdrvWaFzAK0EQyepbJyNZPJoOOT4lgUf
	nbmHRjng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nCUi4-009fUQ-AP; Tue, 25 Jan 2022 22:54:44 +0000
Received: from mail-ed1-f41.google.com ([209.85.208.41])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nCUi0-009fTf-MJ
 for linux-nvme@lists.infradead.org; Tue, 25 Jan 2022 22:54:42 +0000
Received: by mail-ed1-f41.google.com with SMTP id p7so542835edc.12
 for <linux-nvme@lists.infradead.org>; Tue, 25 Jan 2022 14:54:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=DaaUGCArWoJ13enar8ZLJWX1P69BgDpg9YRakjeDVMM=;
 b=JNvtsudY3I7ZgsTorppGQINLKSVakUHxr7IIpgxzDh7BqkcGWr0tw0qhAp8DVbufCy
 FavA/2nkqlqWnDH668RYeOLNt0DFeaMYrOMcxgcvctiCQIEuQDixnVOkV2khDYdTrKEM
 llH/cQkrPmAYsSj43KC0wXsaZ10eotA9oVwxzPmZAf8m0KGy9EfdhyjMtZks69McjUup
 RW7cXHE6J2+0vn+YGPML3H72WnkN7yXxcl8UIIreHxYiwg6XiqIwcwySavhbZo1lYYj7
 G/fT7km0jYT+ryL+HKoRFC1yZ/ZugHBBp0w53Y6zMAKOGIPcpjwHJ3Rwx0Jibp1BcXex
 UlBw==
X-Gm-Message-State: AOAM532QcWCbMpU10YyL19lAWESL4/iIo8h82v2y9aVHAVL2Zt8gi8et
 LYuwi4gbp+7M42xJY7RmCfhHoHMoo0Y=
X-Google-Smtp-Source: ABdhPJxZOU3sKG870yIGKCnFUaX5kfOzLmAltU4gtjnT34GQr7Dhbx0hdzyJna1pwlIEvAdvJpnYpA==
X-Received: by 2002:a05:6402:235a:: with SMTP id
 r26mr13425061eda.406.1643151278307; 
 Tue, 25 Jan 2022 14:54:38 -0800 (PST)
Received: from [10.100.102.14] (46-117-116-119.bb.netvision.net.il.
 [46.117.116.119])
 by smtp.gmail.com with ESMTPSA id i18sm6689087ejr.117.2022.01.25.14.54.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Jan 2022 14:54:37 -0800 (PST)
Message-ID: <1e95d514-7846-4a41-6b7a-9955fa903a52@grimberg.me>
Date: Wed, 26 Jan 2022 00:54:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V4 1/1] nvme: Add verbose error logging
Content-Language: en-US
To: Alan Adamson <alan.adamson@oracle.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>
References: <20220124185144.53810-1-alan.adamson@oracle.com>
 <20220124185144.53810-2-alan.adamson@oracle.com>
 <bd45587b-9e6b-8637-a511-7d4269597d51@grimberg.me>
 <BB566CE6-19C1-472F-978B-564A2EC4C4EC@oracle.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <BB566CE6-19C1-472F-978B-564A2EC4C4EC@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220125_145440_756946_98D43FC0 
X-CRM114-Status: GOOD (  13.55  )
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


> +#endif
> + if (err_str == NULL)
> + err_str =  "I/O Error";
> +
> + if (ns) {
> +#ifdef CONFIG_NVME_VERBOSE_ERRORS
> + for (i = 0, entry = nvme_ops ; i < ARRAY_SIZE(nvme_ops) ; i++)
> + if (entry[i].code == nr->cmd->common.opcode)
> + op_str = entry[i].string;
> 
> Same here, the loop looks redundant to me:
> if (nr->cmd->common.opcode <= ARRAY_SIZE(nvme_ops) &&
>     nvme_ops[nr->cmd->common.opcode] != NULL)
> op_str = nvme_ops[nr->cmd->common.opcode].string;
> else
> op_str = "Unknown"
> 
> 
> Currently the nvme_ops and nvme_admin_ops arrays are not built by index so I need to walk the array to find the
> appropriate opcode/name.  Are you asking to change these arrays to be build by index?
> 
> static const char * const nvme_admin_ops[] = {
>          [nvme_admin_delete_sq] = "Delete SQ",
>          [nvme_admin_create_sq] = "Create SQ",
>          [nvme_admin_get_log_page] = "Get Log Page”,
> 
> Rather than:
> 
> static const struct nvme_string_table nvme_admin_ops[] = {
>          { nvme_admin_delete_sq,         "Delete SQ" },
>          { nvme_admin_create_sq,         "Create SQ" },
>          { nvme_admin_get_log_page,      "Get Log Page" },

Yes, is that a problem?

