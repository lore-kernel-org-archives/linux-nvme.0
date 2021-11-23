Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 598B8C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Nov 2021 13:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hIgU0bK5U3yCEuWSX482p4gO1STEH+SNL6B2DSf7JC0=; b=XLB4oqWJOBzpEP005hUOmukLDs
	eXl/NelpJzMcukBZ4serzmbLwkub7T/GTi0NI+lI5YfNekiNK508liCsA/mr+iPLOTxNEFNljwJ8B
	lJpOViz3Mfc+JlPhTksPkLmJjScFmhbinB746gP+YB9VKQ7+7348g473esGy/tdEakT84bl61Mebf
	SJ7MUE4OSs12CbJZOauWi6s1XfwupiEPQnVXa/Ul+SX+UOYP9ykyyCIIABlnyshAr6RsgZ4SfLxXT
	enxRgAiVru6G0zPDyphbu0ghtq20xGl5jsq4hc96qPlv2XZhQC9Y+tz8+az0yD92Q3Iarhogo/uC3
	i/6Q36Ow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mpVj0-002LVV-VJ; Tue, 23 Nov 2021 13:20:42 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mpVZz-002HuG-MD
 for linux-nvme@lists.infradead.org; Tue, 23 Nov 2021 13:11:27 +0000
Received: by mail-wr1-f48.google.com with SMTP id r8so38812766wra.7
 for <linux-nvme@lists.infradead.org>; Tue, 23 Nov 2021 05:11:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hIgU0bK5U3yCEuWSX482p4gO1STEH+SNL6B2DSf7JC0=;
 b=PFiOKguygLEaE1MTt/2P2iWK8SoFVwlViSve5kobfrkHDfroomtTiSfwsrE0IWDNao
 piLgP2GmiK780YkdEQuVKyLaddAtKOWKs2Excq6+bmnYs+20rHYpKyKV4J9VNUKJah3v
 0si+DMOo+IRTMxOT6Tid8X3ZpAHw7uoo+SwVxP1FkujqnMIs78iyVFBZ5hmZoZ3PrXo8
 Yr95d29lPaGklJbgpQCMJy4qRF6HpYKZflIUwh/ndLfKBnTT0GsWtroLIeSGH0uh7FQD
 aSEOsWk+C6+oFI/KFWyr8YxwdlttTPdewRpuFt43CHsJRuob9OeslLdJSH9y1+bk9iZl
 EhtQ==
X-Gm-Message-State: AOAM533hl8ZxdizOxB2EbbimxM/eFBSeaziOG/YWpNgpVX907ipdk73X
 HgHhDmufwa3w3SyWIa4cVeI=
X-Google-Smtp-Source: ABdhPJwQnprzp4GnEWbf56/MkuGm1MYO8ARdDmyNLi9xM7IhE1p4i4FhVyEGFiyYa3ZyQym1gi5oeg==
X-Received: by 2002:adf:d1e2:: with SMTP id g2mr7044819wrd.105.1637673082021; 
 Tue, 23 Nov 2021 05:11:22 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id u23sm1118492wmc.7.2021.11.23.05.11.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Nov 2021 05:11:21 -0800 (PST)
Subject: Re: [PATCH 07/12] nvme: Implement In-Band authentication
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Herbert Xu <herbert@gondor.apana.org.au>,
 David Miller <davem@davemloft.org>, linux-crypto@vger.kernel.org
References: <20211123123801.73197-1-hare@suse.de>
 <20211123123801.73197-8-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ffd1519b-1f39-898a-be7f-5d9db7377ad1@grimberg.me>
Date: Tue, 23 Nov 2021 15:11:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211123123801.73197-8-hare@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211123_051123_793118_E34CEF47 
X-CRM114-Status: GOOD (  20.69  )
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


> +int nvme_auth_generate_key(struct nvme_ctrl *ctrl, u8 *secret, bool set_ctrl)

Didn't we agree to pass the key pointer? i.e.
int nvme_auth_generate_key(struct nvme_dhchap_key **key, u8 *secret)

> +{
> +	struct nvme_dhchap_key *key;
> +	u8 key_hash;
> +
> +	if (!secret)
> +		return 0;
> +
> +	if (sscanf(secret, "DHHC-1:%hhd:%*s:", &key_hash) != 1)
> +		return -EINVAL;
> +
> +	/* Pass in the secret without the 'DHHC-1:XX:' prefix */
> +	key = nvme_auth_extract_key(secret + 10, key_hash);
> +	if (IS_ERR(key)) {
> +		dev_dbg(ctrl->device, "failed to extract key, error %ld\n",
> +			PTR_ERR(key));

The print here is slightly redundant - you already have prints inside
nvme_auth_extract_key already.

> +		return PTR_ERR(key);
> +	}
> +

Then we instead just do:
	*key = key;

> +	if (set_ctrl)
> +		ctrl->ctrl_key = key;
> +	else
> +		ctrl->host_key = key;
> +
> +	return 0;
> +}

...

> +EXPORT_SYMBOL_GPL(nvme_auth_generate_key);
> diff --git a/drivers/nvme/host/auth.h b/drivers/nvme/host/auth.h
> new file mode 100644
> index 000000000000..16e3d893d54a
> --- /dev/null
> +++ b/drivers/nvme/host/auth.h
> @@ -0,0 +1,33 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2021 Hannes Reinecke, SUSE Software Solutions
> + */
> +
> +#ifndef _NVME_AUTH_H
> +#define _NVME_AUTH_H
> +
> +#include <crypto/kpp.h>
> +
> +struct nvme_dhchap_key {
> +	u8 *key;
> +	size_t key_len;
> +	u8 key_hash;

Why not just name it len and hash? don't think the key_
prefix is useful...

