Return-Path: <SRS0=i2V4=PV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E80D4C433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Nov 2021 23:59:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B781860E73
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Nov 2021 23:59:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B781860E73
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=02aPD3oV3IYNB92kQEE00fse4w0fXi4eOsRfb08mAG0=; b=p2KOOvHjX5JzLnmr2oUS0RZ9bk
	GUDrWfHG2DEeLK4uF1CjK9BthHgZrWW+jswizxNPI7N3aOYaGsa6s7hExkyxnstliuCpRtEb5Hkcf
	I4RhOWU5S/aNWfVFJ3YKVZcEezYg5rfXjez+TpAblbWRhaIBDsMt8v7Q61UMfL9dTkRzk3tr2BWCz
	S1e7TwsKWv97N0J4tJqZsmWyyUNJ4ztxmQSQyz7IXwI1RD8uShbIwmzWs/wMSFocp2A1oj/0bAlBj
	va0byeX++ROg9/qWr2v/QBayeWIaB4DPNlrO03HmzlAqeXlTBcP7FY/UJDICyhFZECRHsdDNK+Xh+
	IEtpQbEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mi3gY-003X4z-BT; Tue, 02 Nov 2021 23:59:22 +0000
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mi3gV-003X3q-PW
 for linux-nvme@lists.infradead.org; Tue, 02 Nov 2021 23:59:21 +0000
Received: by mail-pf1-x42a.google.com with SMTP id k2so526512pff.11
 for <linux-nvme@lists.infradead.org>; Tue, 02 Nov 2021 16:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=02aPD3oV3IYNB92kQEE00fse4w0fXi4eOsRfb08mAG0=;
 b=csy3ncGltvgcdDd7qA/OTBenXXFqr30alSGUGjiQpJgs5HDceuhNqiEpjWYx8abgW1
 6fjNO324p7ucOBObG5dTABaRs/KZOweasmmgINXm+rZ81LJkdhSQv794nn+RsfxKpAqX
 n7BK5fHCSUR6xQqQucnzFifH1U7foKVuF+PoVZZY9HZB9waQOlw8lZfXjXFcURKHEdp/
 TABYjri8HR+xutySNa4A51Wams8zQTjAkU1HNlDn71ciM9mTiSull+KQV/Ui3gBcLZA/
 Iq24hY7pXVqlELTNcJl8uhBgP40lsaKvJBjN1C+3lU4no0eXrSVv28JtvMCp0kjacWYK
 XO0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=02aPD3oV3IYNB92kQEE00fse4w0fXi4eOsRfb08mAG0=;
 b=v0AA70U82abA6t0lGpoDWaTwFK4JejntdectIqQg3uaQ4hOPhTMDe6KSOuYzhEilm7
 RRoQS9s5a4fM8ah/vv7Zu1il98uIqgmc+NbP4UVwW37mUdrFSddvI1xPiR/1iMuNcW6+
 xObpvCAUsNgJKw2eKqykvON9eYRdabyCtVKRxWNfGHm1eCNMMV3FplkWIdmbp3/DZiRC
 nTJ3otmWjSEB8/YZLiCoz6qkB7Y+rf3z8dfE4zCtbDHR4ykzrsJNBLgPz6E0X2BX2IRu
 +a2imhSr+fdAHmhphC9vgXZnH5xPwlBydwcXF3B/Kj2xQN4KWOWQQYtMHvfeum0F5zbp
 MH4g==
X-Gm-Message-State: AOAM532HKo077BAjhF6HoBAEAYv6Ly9yMnwoS3fZYL6GRcA/2Yf2+mGz
 KPiRNKw4NirrMoSmRxfKGQQ=
X-Google-Smtp-Source: ABdhPJxInqYy0l7kOpZv/3bCV/ov3+eMcIyLnJwDOKgNb5wQ4V6FrmLcm+r39Qxa51NS7HZlbRdvAA==
X-Received: by 2002:a63:8b41:: with SMTP id j62mr15302507pge.420.1635897559088; 
 Tue, 02 Nov 2021 16:59:19 -0700 (PDT)
Received: from [10.69.44.239] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id y32sm276025pfa.145.2021.11.02.16.59.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Nov 2021 16:59:18 -0700 (PDT)
Message-ID: <9aba0761-353b-1d93-1dfd-ec8c3a6c51d5@gmail.com>
Date: Tue, 2 Nov 2021 16:59:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH 04/10] nvme-fabrics: introduce nvmf_error_recovery API
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, linux-nvme@lists.infradead.org,
 hch@lst.de, kbusch@kernel.org, sagi@grimberg.me
Cc: chaitanyak@nvidia.com, israelr@nvidia.com, oren@nvidia.com, hare@suse.de
References: <20211020103844.7533-1-mgurtovoy@nvidia.com>
 <20211020103844.7533-5-mgurtovoy@nvidia.com>
From: James Smart <jsmart2021@gmail.com>
In-Reply-To: <20211020103844.7533-5-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211102_165919_891939_FA279388 
X-CRM114-Status: GOOD (  16.91  )
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

On 10/20/2021 3:38 AM, Max Gurtovoy wrote:
> Error recovery mechanism is duplicated in RDMA and TCP transports. Move
> this logic to common code.
> 
> Also update the RDMA/TCP transport drivers to use this API and remove
> the duplicated code.
> 
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> Reviewed-by: Israel Rukshin <israelr@nvidia.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>   drivers/nvme/host/fabrics.c | 10 ++++++++++
>   drivers/nvme/host/fabrics.h |  1 +
>   drivers/nvme/host/rdma.c    | 25 ++++++++-----------------
>   drivers/nvme/host/tcp.c     | 19 +++++--------------
>   4 files changed, 24 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 4a1ef67c6fb3..2edd086fa922 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -493,6 +493,16 @@ void nvmf_reconnect_or_remove(struct nvme_ctrl *ctrl)
>   }
>   EXPORT_SYMBOL_GPL(nvmf_reconnect_or_remove);
>   
> +void nvmf_error_recovery(struct nvme_ctrl *ctrl)
> +{
> +	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
> +		return;
> +
> +	dev_warn(ctrl->device, "starting error recovery\n");
> +	queue_work(nvme_reset_wq, &ctrl->err_work);
> +}
> +EXPORT_SYMBOL_GPL(nvmf_error_recovery);
> +

don't disagree with this - but my comments on patch 3 relate to this. It 
should be making a call to nvme_reset_ctlr. no need to have another 
place where state is moved to RESETTING.

-- james


