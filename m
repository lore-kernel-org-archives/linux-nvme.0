Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5C8CC27C53
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Jun 2024 09:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0//pStmFFHWSOtCfn6ToCqy8bpe4PxQfeFWHsR89dJY=; b=PDJXc+dIRxHy8mKBcK8P6mDZM8
	tQJji20FvnHBK8iidiKsFq6EE5ru2Bsd7S+dk2bpr7sA8wF8qssW+ihuW6to9WPHR/hIO4dTvdtW3
	yqh9ssnbhcudcE1/2KEO8RYEZOQsTXJh3E86HjQO2ASSbF231+nIAe78ugxihkQ/TQgbftK/cWdhH
	vn9XpcmFEwC/Iuic/LL11mAN4ytdJWHQ+DWTvJxXxPWaNkqXH/yYT+2O/kPTQTVGocnPkLo93AIC9
	gEgKmTC9EaH40tEUk+87CirYyx8sXsVF5T+/H8EsWIQw8u1QsL3vQ5s9ReRbf+ldRskI0yM5H2LqN
	kWC0dHLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJrQp-00000000XKo-1fCc;
	Wed, 19 Jun 2024 09:16:43 +0000
Received: from mail-wr1-f53.google.com ([209.85.221.53])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJrQm-00000000XJr-3VaI
	for linux-nvme@lists.infradead.org;
	Wed, 19 Jun 2024 09:16:42 +0000
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-363db2f9fc5so27676f8f.1
        for <linux-nvme@lists.infradead.org>; Wed, 19 Jun 2024 02:16:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718788599; x=1719393399;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0//pStmFFHWSOtCfn6ToCqy8bpe4PxQfeFWHsR89dJY=;
        b=nA+GomAKkBiCm0Jhh6vW8JVWIojjSfY4tacfGOkYlrF4nKnV/QxwiU5xSHsXp8clhr
         e3ToFBHpv9JrKa+aerRlEMucdsnkOGPlAJmIJvD2KANGqniPTrfSUuT04jPEbIPEMIRE
         AGvCkGbObd1Up/xxcwWTgeN/eZpJGmxOMt80EKksn9MLgBt1wBE9T4KmyccQIAK60vjx
         vFFLemto6SbNnipHYlMpUsOsooOPePvgspd3HeNmEMGwRDhWqmmaKNgtbu3fN6SLg/w4
         Gk7Nt9uFOUGjf71fwUyzyrIsR/hDmWV39jjRcEg8CT1Ki7oyTwlCjxNc4kL8LV91X7z9
         5qhg==
X-Forwarded-Encrypted: i=1; AJvYcCWp5+lQH2/49uFnXz+Kv+4AH1dQArMG5TltLVdmW93nUadE0itBrtfMEkXNZ39+VEbw7SRtiRVCVa1xl3A9n5HWZ68po/OK6+gNsA4Qjzw=
X-Gm-Message-State: AOJu0YyS5F9VVF97JENB39qHq0+sxyhpWru8SQaqAwQPHPqlrbkxmqMu
	FACxHdLz5fGg6nXhO8yQnmrNDsHzPOEyzWtuiaTUR7TyW7k53suo
X-Google-Smtp-Source: AGHT+IEswHHQeRdbk/+Kn9td75vu7SYTc1eJTpQjs6DfmKMqwqQQbE3ZDyG7JU/dOZVdF0AQYBuMKw==
X-Received: by 2002:a5d:47cc:0:b0:360:874b:af9a with SMTP id ffacd0b85a97d-363195b2c64mr1430622f8f.3.1718788598839;
        Wed, 19 Jun 2024 02:16:38 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750f2295sm16637925f8f.82.2024.06.19.02.16.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 02:16:38 -0700 (PDT)
Message-ID: <f12e1a75-2fd1-46ef-aee9-520cced08f11@grimberg.me>
Date: Wed, 19 Jun 2024 12:16:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] IB/isert: remove the handling of last WQE reached
 event
To: Max Gurtovoy <mgurtovoy@nvidia.com>, leonro@nvidia.com, jgg@nvidia.com,
 linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
 chuck.lever@oracle.com
Cc: oren@nvidia.com, israelr@nvidia.com, maorg@nvidia.com,
 yishaih@nvidia.com, hch@lst.de, bvanassche@acm.org, shiraz.saleem@intel.com,
 edumazet@google.com
References: <20240618001034.22681-1-mgurtovoy@nvidia.com>
 <20240618001034.22681-3-mgurtovoy@nvidia.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240618001034.22681-3-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240619_021640_970063_9B481CED 
X-CRM114-Status: GOOD (  13.19  )
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



On 18/06/2024 3:10, Max Gurtovoy wrote:
> This event is handled by the RDMA core layer.
>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>   drivers/infiniband/ulp/isert/ib_isert.c | 3 ---
>   1 file changed, 3 deletions(-)
>
> diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
> index 00a7303c8cc6..42977a5326ee 100644
> --- a/drivers/infiniband/ulp/isert/ib_isert.c
> +++ b/drivers/infiniband/ulp/isert/ib_isert.c
> @@ -91,9 +91,6 @@ isert_qp_event_callback(struct ib_event *e, void *context)
>   	case IB_EVENT_COMM_EST:
>   		rdma_notify(isert_conn->cm_id, IB_EVENT_COMM_EST);
>   		break;
> -	case IB_EVENT_QP_LAST_WQE_REACHED:
> -		isert_warn("Reached TX IB_EVENT_QP_LAST_WQE_REACHED\n");
> -		break;

Don't think you need to touch the ulps, they want to log these events, 
so be it.
Although, a warn is not appropriate at all here.

