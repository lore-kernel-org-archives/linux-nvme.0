Return-Path: <SRS0=DxE/=PW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C00B9C433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Nov 2021 00:05:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F11860F02
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Nov 2021 00:05:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7F11860F02
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FKBstp6kXk0leka3MHP1S+ZlJ4CqG4tPxPQFtkAjb5g=; b=xMoLmuoQZWSRDrgVym+p9QfBNw
	Q0C4Bh+KLMSd57eohfUcyAJ6M8PLD+zeSj5f5lqJk1UNdlk2X+Nrjv5V4bCR5fWzV5/qrx/mrqC2x
	wx9BYVOUOPaLJF4Qgb+Km+8nmr/jxjsuut6uNhFufYFXjQkToHYCZ1sJValy2l5bnfseDiO3uuhv9
	l1yPnHjQatrn7fPTTVUMnhiE1TLCxzMOUIx/vZhoNsmYL8iN1+SAfsrx+5DmID8gnIGk0FaOHd4WB
	hYyzVJiF4icqxqobqsEHvs421mc7Em3I5n4fkf41UGZ+phjwSxOZDWjz6mshGDQ9EVxaFcVPRTETI
	oLpmqvZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mi3mF-003Yvm-CV; Wed, 03 Nov 2021 00:05:15 +0000
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mi3lz-003Yre-Io
 for linux-nvme@lists.infradead.org; Wed, 03 Nov 2021 00:05:01 +0000
Received: by mail-pg1-x52e.google.com with SMTP id e65so794747pgc.5
 for <linux-nvme@lists.infradead.org>; Tue, 02 Nov 2021 17:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=FKBstp6kXk0leka3MHP1S+ZlJ4CqG4tPxPQFtkAjb5g=;
 b=GeTd/aO4lwx3sHfxlFu88jsPX880uKGFfbyiitkI1SXRWmBYuIK+aoOivOlkNq9fwl
 wKzS8L6gr1vdNPXACPsKduIGpFTqu8t30Hs/dNbVEF8ul1zzYYlcHNTwvNAWs3YTEly2
 gkZq5O/um8iPjFcN0BJELCCROTFdI4a8tN5mv7f3K4oWR+1OytfABVIYFVLURKL5rYul
 IwUo6VinrCsA1Q4LS3FhEFnlq8lXHsUdT9ErEbo+XtN+aU8Y5S2G0clBZzIZHp3mO0aV
 RLBaKlcfzsc7MLeucryxpmhrygBa9eFt3F+i5O4mH0XWk+GjvMFQst1Z2odzS/iZL77v
 QPVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=FKBstp6kXk0leka3MHP1S+ZlJ4CqG4tPxPQFtkAjb5g=;
 b=z3EGX4BybJ6hLJUNtMB0yLlfSB9wN4XrWrWgHSA118P9NsMLzFY+5r95/pbW2Y/5lF
 3RgEWRbM+cCF55rIckYd4n3VJcpfM2kGEg6HAv4fIWNpw3L7dayqZ2yzg9/UrmctknAz
 G9W8BmQCMVuQrB1YKOFP7D65rCTfPQlaWNJ8oU73tb4tvmxLdZRKlyAAaQfII/SMAY45
 5H2KND8J6fcm1V2DEH8a8E0YalfWsSKQj4B1T+TFmHlMHCoegLCEqFVv9y6WebMjCrSX
 99Sd6JKsMg9+SIGkJD7UL5RfXcCUGajHIBBIYQbHsat13kGOA7U3No10ZLgywrGky2gl
 zkMg==
X-Gm-Message-State: AOAM532ANVHW+YhmHB1E4LhhyVijqSeDanZGHO27W342MKuUwhhXTc9O
 Edr7GTmlouXTLGF8D9UTbCA=
X-Google-Smtp-Source: ABdhPJyEsRvG35sUL+FiKVglCpmWHoVt9wV4oVF2JSefhlozZCQ4R+h6TzFFuyo8IaegEJg+Qrv80w==
X-Received: by 2002:aa7:8b49:0:b0:44d:65a9:fb9d with SMTP id
 i9-20020aa78b49000000b0044d65a9fb9dmr40468047pfd.24.1635897898485; 
 Tue, 02 Nov 2021 17:04:58 -0700 (PDT)
Received: from [10.69.44.239] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id g16sm282589pfj.5.2021.11.02.17.04.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Nov 2021 17:04:58 -0700 (PDT)
Message-ID: <306630c6-3c90-1abb-1757-b98d134933ce@gmail.com>
Date: Tue, 2 Nov 2021 17:04:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH 05/10] nvme/nvme-fabrics: introduce
 nvmf_error_recovery_work API
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, linux-nvme@lists.infradead.org,
 hch@lst.de, kbusch@kernel.org, sagi@grimberg.me
Cc: chaitanyak@nvidia.com, israelr@nvidia.com, oren@nvidia.com, hare@suse.de
References: <20211020103844.7533-1-mgurtovoy@nvidia.com>
 <20211020103844.7533-6-mgurtovoy@nvidia.com>
From: James Smart <jsmart2021@gmail.com>
In-Reply-To: <20211020103844.7533-6-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211102_170459_691921_3A5E950F 
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

On 10/20/2021 3:38 AM, Max Gurtovoy wrote:
> Error recovery work is duplicated in RDMA and TCP transports. Move this
> logic to common code. For that, introduce 2 new ctrl ops to teardown IO
> and admin queue.
> 
> Also update the RDMA/TCP transport drivers to use this API and remove
> the duplicated code.
> 
> Reviewed-by: Israel Rukshin <israelr@nvidia.com>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>   drivers/nvme/host/fabrics.c | 23 +++++++++++
>   drivers/nvme/host/fabrics.h |  1 +
>   drivers/nvme/host/nvme.h    |  4 ++
>   drivers/nvme/host/rdma.c    | 78 +++++++++++++++----------------------
>   drivers/nvme/host/tcp.c     | 46 +++++++---------------
>   5 files changed, 73 insertions(+), 79 deletions(-)
> 
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 2edd086fa922..5a770196eb60 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -493,6 +493,29 @@ void nvmf_reconnect_or_remove(struct nvme_ctrl *ctrl)
>   }
>   EXPORT_SYMBOL_GPL(nvmf_reconnect_or_remove);
>   
> +void nvmf_error_recovery_work(struct work_struct *work)
> +{
> +	struct nvme_ctrl *ctrl = container_of(work,
> +				struct nvme_ctrl, err_work);
> +
> +	nvme_stop_keep_alive(ctrl);
> +	ctrl->ops->teardown_ctrl_io_queues(ctrl, false);
> +	/* unquiesce to fail fast pending requests */
> +	nvme_start_queues(ctrl);
> +	ctrl->ops->teardown_ctrl_admin_queue(ctrl, false);
> +	blk_mq_unquiesce_queue(ctrl->admin_q);
> +
> +	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING)) {
> +		/* state change failure is ok if we started ctrl delete */
> +		WARN_ON_ONCE(ctrl->state != NVME_CTRL_DELETING &&
> +			     ctrl->state != NVME_CTRL_DELETING_NOIO);
> +		return;
> +	}
> +
> +	nvmf_reconnect_or_remove(ctrl);
> +}
> +EXPORT_SYMBOL_GPL(nvmf_error_recovery_work);
> +

Same comments on just use nvme_reset_ctrl().

-- james


