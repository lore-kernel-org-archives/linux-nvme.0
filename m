Return-Path: <SRS0=viL0=52=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 849E6C2BA2B
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Apr 2020 07:35:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E60420757
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Apr 2020 07:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oAEidbwq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E60420757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=PMDXwEO4n5N7GtgN1i9Cg5myltaC4Q2rtROxCrjmaqQ=; b=oAEidbwqw4E7Uu7hjWMRDnhHv
	7O8T6yzq9zKI3ijEz6VOySiNMx4Sh03JfIszSwUsI8VWDR7U9zUC9qBUYE3INDGzz84c3hX1ifxk0
	ZzsJvDrHnycKpgzh1uqxzg08vAzDz9jBRnMukMVlumBqTNRV4ejsay5vuFmN0M7XjeopBnWoSRiUw
	ucmEBsl3IWx+hP6xtTnah2WARj/sZM/26eRweKp7yxN9Mu+PF8eqD/YpZNrZqZmPmYw+byMSpE0Ae
	Gmd9Rdg71Y21oV5LyXTR2j6xqwf9AOj1sbLFEnDVPhCxgvzcemp+u7KdgolLdtXEfPTgdlHSrbuRP
	KcB8mPXtg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jMoCZ-0008Kv-Cq; Fri, 10 Apr 2020 07:35:47 +0000
Received: from mail-wm1-f68.google.com ([209.85.128.68])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jMoCW-0008KM-Tn
 for linux-nvme@lists.infradead.org; Fri, 10 Apr 2020 07:35:46 +0000
Received: by mail-wm1-f68.google.com with SMTP id a201so1452293wme.1
 for <linux-nvme@lists.infradead.org>; Fri, 10 Apr 2020 00:35:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YAhvJFrDSEuryJIcdC5iRKWzmEnwMce33rgd6QVeAfk=;
 b=b+ojMm38bWq4kCRkGXeKlBh8sWGByrJLwiKMUZWDnw6Pg6cyyXKk4Ydd6OTvMPuTSU
 yuhz5jqNCNevIMMgZmgwb9hWvJmDCC9peQJD1V+EFs4S2LWgDv8yPS3l/2Kvnp8RWjIe
 yhs6rtKy14Mzqs5TYyFYmPowtJ7e760ncZFUQZbf8ixuX0bkqA+fbyv/31q+jx6rr8Tn
 e7koxNI+F/pXrbOR6X79jF1lFEUjaHCZcCWiun5zB3hK1LadvzL5Nv7n93ZmXux/t2Zo
 LUWa3RCRDUXddYbBwtG9pQ5IgKZECksEs3NVivzXQ0l40TmsyM+pYbeUePpba+kbc8vj
 JBfQ==
X-Gm-Message-State: AGi0PuY6man4rsImzjnD521+arbYA+QQZf3/afU2iW1iF0XFPBvmuJEO
 vgt/+cUlqZEbwVnNojI3qiI=
X-Google-Smtp-Source: APiQypLVbSj+x1Ebhq1zVpO7VUbRnJcZLBFkXoceo69fJZWj60TwS/Wj6vMIg/EQwElKwbP8y4y5HQ==
X-Received: by 2002:a1c:4d07:: with SMTP id o7mr4030945wmh.59.1586504143674;
 Fri, 10 Apr 2020 00:35:43 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:9052:1641:fbba:d9ee?
 ([2601:647:4802:9070:9052:1641:fbba:d9ee])
 by smtp.gmail.com with ESMTPSA id y22sm6343917wma.0.2020.04.10.00.35.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Apr 2020 00:35:43 -0700 (PDT)
Subject: Re: [PATCH 04/10] nvme: check namespace head shared property
To: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, hch@lst.de
References: <20200409160908.1889471-1-kbusch@kernel.org>
 <20200409160908.1889471-5-kbusch@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f3d2255e-8351-222c-76fa-b9ca1612b7cf@grimberg.me>
Date: Fri, 10 Apr 2020 00:35:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200409160908.1889471-5-kbusch@kernel.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200410_003544_959602_99ADD818 
X-CRM114-Status: GOOD (  14.30  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
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
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Reject a new shared namespace if a duplicate unshared namespace exists.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>   drivers/nvme/host/core.c | 3 ++-
>   drivers/nvme/host/nvme.h | 1 +
>   2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index be2d856923e8..09ffb2d85854 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3496,8 +3496,9 @@ static int nvme_init_ns_head(struct nvme_ns *ns, unsigned nsid,
>   			ret = PTR_ERR(head);
>   			goto out_unlock;
>   		}
> +		head->shared = is_shared;

IIRC max added features bitmask on a namespace for pi? Maybe use that
and Max can rebase?

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
