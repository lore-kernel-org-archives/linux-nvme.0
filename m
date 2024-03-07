Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A824C54E49
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 11:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qqmsxarXm57ttEsoEJWCCNAOAHrk1ivj9RXVuFDVSCo=; b=rRV0u2AAmBa8B/09z3H9sLwRqz
	9k1v9u+G6WkzybgzxWTqltvjBACjAuTns861CXj6GH0gXilK1C7wipCsfj11UpFxTX7yDccW7Jy+Z
	v8qj1QIiQPI+9+mtPISkncQlgJMRyEVLW7MK5KPPKEfupUNMdx6YUtO70HpuRTyHBnnRUutEUmJDA
	E8jDrKfQTVWUacGWoE+kzboWHGrZXuOxefBTx1miJXACPbZMB31zAqSj5lgR59ImUau00l+h+G9Hj
	YZbVYz7jQQtNFG/XhGKwCpheudpx5UIrUnU5XJjioeJh3cWUuXOjPozXOMOxGw3NFrOvIKS2kzVLE
	kqV7zs9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riBcN-00000004DZL-01Wv;
	Thu, 07 Mar 2024 11:08:55 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riBcI-00000004DYG-3rio
	for linux-nvme@lists.infradead.org;
	Thu, 07 Mar 2024 11:08:53 +0000
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-412e41cab5aso303675e9.1
        for <linux-nvme@lists.infradead.org>; Thu, 07 Mar 2024 03:08:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709809729; x=1710414529;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qqmsxarXm57ttEsoEJWCCNAOAHrk1ivj9RXVuFDVSCo=;
        b=DM9lAEH616C8+ZzoBtkXcFnm/tnJcmbHqGhhnbOU87XGDMGIW9QLU/8FxeyE+LCkpj
         GTK2j9m6zpl6bZOReAcHPjbsIh7xmtJRDEcCm3mnjvCJoKbfP1wjfRdrAZce8R7df0j0
         UOQYC194ucvcnEA9+Fhb1CQY0OVxWmGMN476pFnNCiPKpOF+fe1D9O8OR5wbJpZOEPUC
         Gx5ZWVKyF56kcW8GFBhsAyiV7/NrEcJX7gL8c7I0acLu5H+NriCrTROSQgDPIyEU5nnM
         tH9sylWp1qetQkGd0OKpoIblv+JmFUGOHeURcQwCFczr4heTlpcqa+DH3FIDzm5p4GaU
         d9IA==
X-Forwarded-Encrypted: i=1; AJvYcCVp6jVv7R241+8jht/qYzkBy3vcjCj69mepSD76pivYk+PAHCTBYp1HkBlhSD7RTghXD0MZWkeqe0daZBGVccH3rswRfZPKITfxcfhqOEU=
X-Gm-Message-State: AOJu0YwVXr9HpAzSpOxtqRcnxyXRjJTRftY2z5dRaAJIOeIAPe7X7BIK
	UzikMBX7+NuIUKAesPnhcs0pEQ7nWW521h2IwuEKORZGAPecQOtb1dDEX9dw
X-Google-Smtp-Source: AGHT+IF1vT9MSYb3etDha69Do/HLT+G2kJmSElfS6YHHWOxP1y3zJqBTFAT513d40zYgItpTccfa7w==
X-Received: by 2002:a05:600c:4711:b0:412:f3f0:d8af with SMTP id v17-20020a05600c471100b00412f3f0d8afmr1198648wmo.0.1709809728650;
        Thu, 07 Mar 2024 03:08:48 -0800 (PST)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id i9-20020a5d6309000000b0033e122a9a91sm19262150wru.105.2024.03.07.03.08.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 03:08:48 -0800 (PST)
Message-ID: <68875550-6bd6-42e6-81b3-a62cb6a920d9@grimberg.me>
Date: Thu, 7 Mar 2024 13:08:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/13] nvme-tcp: combine reset and recovery
Content-Language: en-US
To: hare@kernel.org, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
References: <20240127093058.15699-1-hare@kernel.org>
 <20240127093058.15699-12-hare@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240127093058.15699-12-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_030851_060518_18EACA21 
X-CRM114-Status: GOOD (  13.26  )
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



On 27/01/2024 11:30, hare@kernel.org wrote:
> From: Hannes Reinecke <hare@suse.de>
>
> Call 'connect_work' from reset to reduce duplicate code.
>
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/host/tcp.c | 9 +--------
>   1 file changed, 1 insertion(+), 8 deletions(-)
>
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 6c8ca08f2972..a46ab8370007 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -2329,14 +2329,7 @@ static void nvme_reset_ctrl_work(struct work_struct *work)
>   		return;
>   	}
>   
> -	if (nvme_tcp_setup_ctrl(ctrl, false))
> -		goto out_fail;
> -
> -	return;
> -
> -out_fail:
> -	++ctrl->nr_reconnects;
> -	nvme_tcp_reconnect_or_remove(ctrl);
> +	queue_delayed_work(nvme_wq, &to_tcp_ctrl(ctrl)->connect_work, 0);
>   }

This breaks nvme_reset_ctrl_sync

>   
>   static void nvme_tcp_stop_ctrl(struct nvme_ctrl *ctrl)


