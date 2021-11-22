Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D564BC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Nov 2021 08:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Vcf1hhZCWFgfHxi8kTviWKhZCncx+U6N2s3OPnkYNeg=; b=1FpBjYmNa+Ixu3wHXuXCuYlf/e
	4Qb+sX5gHB0NmfRB/gVAiGmu7IApHIlq8+rVfwntem+eXCymdTFBgg5aLPcojceqooyPyj38GoLuW
	TqUhDHlF3PYNmiL/11ZlFg8mvobWyKFhOayOVHJ2Y50wfpp+Fb7/4CwC9SUvY8dMWzGcezBkGfF6q
	qs4Smx0FE+JL0KmPoWYUSUs+bM1sa3xGxyUrgP8Rc/vGJQXdwjRqgykUqDI1G2uLPXs1h+2FBGlVZ
	ckx1RPpyXYZ09s1o+7MliYy8x6Tw6Bbw6ebs1BzefnqA3R3871oXZF2S3dTjtqIQWymCA6fpiKSa/
	lWCJRIiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mp57p-00FQa4-0B; Mon, 22 Nov 2021 08:56:33 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mp54J-00FOOX-DW
 for linux-nvme@lists.infradead.org; Mon, 22 Nov 2021 08:52:56 +0000
Received: by mail-wm1-f47.google.com with SMTP id 133so14565820wme.0
 for <linux-nvme@lists.infradead.org>; Mon, 22 Nov 2021 00:52:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Vcf1hhZCWFgfHxi8kTviWKhZCncx+U6N2s3OPnkYNeg=;
 b=F5SDTVJHKSuZcxI3OYdMBHzaW/t8lJsvP9lzvUxqnb1p2xOiXsXge5zsohwZzCcODA
 PPUXvRa3b0krKs9w0zY7P56A2HjHFBVoUr75wFLuvRodlQtLCWlfbQB4YQGeRlQdg2d3
 SW32vJR00y8ltXEquJAva81n8CbTAwwu2POYQ+Mz/RrcomUUmEBQZ2e2+L2CCJl5xxLA
 /GzOhUjRl8026uqZuqEqKn2Tm4Fg+jK+/JgS5MZTVJgwFneTWkPzx4Lp0mm46k3yqpaN
 bqPsEYO4e+hCoitJyGRoiiGB5+KX4pKy7gRtn5sLtsz3JGmQvY8o93xqyivg15qRXArb
 hDig==
X-Gm-Message-State: AOAM533QPccWXSXywVGE2FXuZbiFMI7dDOfnItTLjTj/1Bt73jH18enH
 VIyl76UYMTodwZ4FA0vKYv15CoDvDYY=
X-Google-Smtp-Source: ABdhPJwgTtodn1Adf/Ft52y8SrMQJtZHrUIFTx/rGxWz9v/aPa0IFa88Ky9I6qmtqbDyysqaAYr81w==
X-Received: by 2002:a1c:9814:: with SMTP id a20mr26828431wme.18.1637571173733; 
 Mon, 22 Nov 2021 00:52:53 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id 21sm7937946wmj.18.2021.11.22.00.52.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Nov 2021 00:52:53 -0800 (PST)
Subject: Re: [PATCH 4/9] nvme/039: simple test for nvmeof-tcp connection
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 Omar Sandoval <osandov@fb.com>, linux-nvme@lists.infradead.org
References: <20211122075524.26207-1-hare@suse.de>
 <20211122075524.26207-5-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <197826e6-273c-6f19-f5cf-44814433976c@grimberg.me>
Date: Mon, 22 Nov 2021 10:52:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211122075524.26207-5-hare@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211122_005255_510246_39D8A96E 
X-CRM114-Status: GOOD (  16.85  )
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



On 11/22/21 9:55 AM, Hannes Reinecke wrote:
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   tests/nvme/039     | 56 ++++++++++++++++++++++++++++++++++++++++++++++
>   tests/nvme/039.out |  6 +++++
>   2 files changed, 62 insertions(+)
>   create mode 100644 tests/nvme/039
>   create mode 100644 tests/nvme/039.out
> 
> diff --git a/tests/nvme/039 b/tests/nvme/039
> new file mode 100644
> index 0000000..eb015be
> --- /dev/null
> +++ b/tests/nvme/039
> @@ -0,0 +1,56 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2021 Hannes Reinecke, SUSE Labs
> +#
> +# Test nvme over tcp connection
> +
> +. tests/nvme/rc
> +
> +DESCRIPTION="Create single TCP connection via localhost"

Why is this test needed?

