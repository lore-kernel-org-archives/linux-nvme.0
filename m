Return-Path: <SRS0=DxE/=PW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28923C433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Nov 2021 00:27:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD44E60F02
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Nov 2021 00:27:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AD44E60F02
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uPDmEKKeD9BI9rlTPpNFj9QwzGLec+rHGkukpWpLiiU=; b=WbQi4DgcCZC/xmDVLNJGW4L9nw
	2qpNBVQnHJiUY1c5OE/NtFoG88Ya7F7gp8USuKg+q8r6tNNAWo5OHwSrAv8f0KxQg/x+UHD/QqFXd
	/q0+WmWdWDU7PL9Qt9mN2lvGHcmj3Lp6mT8yStLsUOe0SnMPrLSRiadJh/hsfp9jckpJnP3iBe5dF
	qtSHKZ4EVsWdIsZs0sipAwQvBWhv6B1XrTDzR4ctckFDZz5+6JgtOr9gN4dmM47u+CiTaPD9IdIj0
	F9mThMhkemUztz3pjc3nmiO5NVLh1O2ne62EGK6rUG8UsCIkO9Xtw020EBehw4WsCbffhxGAWax/k
	0kn00HKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mi47i-003dQN-Pq; Wed, 03 Nov 2021 00:27:26 +0000
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mi47f-003dQ3-EY
 for linux-nvme@lists.infradead.org; Wed, 03 Nov 2021 00:27:24 +0000
Received: by mail-pf1-x436.google.com with SMTP id k2so578371pff.11
 for <linux-nvme@lists.infradead.org>; Tue, 02 Nov 2021 17:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=uPDmEKKeD9BI9rlTPpNFj9QwzGLec+rHGkukpWpLiiU=;
 b=VwqfqGajjHZGAcvXtXhnMGgDnm1YrgWBlef7jrn6hjWW+B5Lh7r53kDvhN7jvSsanX
 IoOsHgHv6cGshT7D/URXQyCPBebouMMnBhMIGE31HeqFPgq5UyeSz/liTDht+D6kvSQk
 lii+dGaABZwTCZWzt2qqk8VqrwRcFitYuTK/v8SJVP48ff0eHna0g6OnEPzw8CQtCuy1
 TrrAvmZwunoUCv5txe0xnZyjyTF22gkl+8KzgOun8D5Ui3HOl8NqQoU5OzpNLeLgLXxg
 NVqdT+K2+w+NKxxZ3Aw2m4mTMBbDI5TDie4bO5FgmRoln1/UQDXctUXduSlsOIRturJH
 bnag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=uPDmEKKeD9BI9rlTPpNFj9QwzGLec+rHGkukpWpLiiU=;
 b=m/1ENxFGVGjYRwiDJrOKQ/CqaDjLQVME9M995/gMJA9rVLql/s0jnVPhkvketUkJ5N
 na46jmhzaEQ0fzbQ9cjiy6t0V0fukg5NYPsCXV3pw9pdi8thMdHCG8NOw4/4TUHJEL4M
 yFGz5IxLix+RypxyA8e+FmeqcDvm2scwRnIQtqLynCN4+yEqHY8Cq0IdpJyHWXdBX2Fs
 cp6n6++rOrgo7dT6r8CrxCXMYysoBj2rX0tfqrwPpWLjPuke01e1X0q/tcrvpXuWtAU8
 6DJQ9fE2Lu6JhQd0n18SOaVXK1Rfzl5blV3QLdXRP9qfGvLZ6xCTHyHs+H3uZ0hgqI0A
 Vr6g==
X-Gm-Message-State: AOAM530qdYtfjUMpyWMOK7y5idc0GQjx5S5uuGugjJFzBMcWYmS94smY
 sZgc5AKusYWm0nWSS8zGvjs=
X-Google-Smtp-Source: ABdhPJyOI4IsYWf4rkgyTXW3osPR+ztXCIx02ahNYCfyL9PImhYjDBFKHq2XyrL+RHKLF24Zke+I0A==
X-Received: by 2002:a65:6643:: with SMTP id z3mr30815608pgv.16.1635899242757; 
 Tue, 02 Nov 2021 17:27:22 -0700 (PDT)
Received: from [10.69.44.239] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id on13sm212417pjb.23.2021.11.02.17.27.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Nov 2021 17:27:22 -0700 (PDT)
Message-ID: <0263ff02-fa13-645b-1c57-1e81bf9f6f69@gmail.com>
Date: Tue, 2 Nov 2021 17:27:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH 09/10] nvme/nvme-fabrics: move reset ctrl flow to common
 code
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, linux-nvme@lists.infradead.org,
 hch@lst.de, kbusch@kernel.org, sagi@grimberg.me
Cc: chaitanyak@nvidia.com, israelr@nvidia.com, oren@nvidia.com, hare@suse.de
References: <20211020103844.7533-1-mgurtovoy@nvidia.com>
 <20211020103844.7533-10-mgurtovoy@nvidia.com>
From: James Smart <jsmart2021@gmail.com>
In-Reply-To: <20211020103844.7533-10-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211102_172723_546639_EE7730BB 
X-CRM114-Status: GOOD (  22.42  )
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
> Reset work is duplicated in RDMA and TCP transports. Move this logic
> to common code. For that, introduce a new ctrl op to teardown a ctrl.
> 
> Also update the RDMA/TCP transport drivers to use this API and
> remove the duplicated code.
> 
> Make nvmf_reconnect_or_remove function static since it's only used
> inside the fabrics driver now.
> 
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>   drivers/nvme/host/fabrics.c | 29 +++++++++++++++++++++++--
>   drivers/nvme/host/fabrics.h |  1 -
>   drivers/nvme/host/nvme.h    |  1 +
>   drivers/nvme/host/rdma.c    | 43 ++++++++-----------------------------
>   drivers/nvme/host/tcp.c     | 27 +----------------------
>   5 files changed, 38 insertions(+), 63 deletions(-)
> 
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index e50f6b32a286..e13891619de0 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -472,7 +472,7 @@ bool nvmf_should_reconnect(struct nvme_ctrl *ctrl)
>   }
>   EXPORT_SYMBOL_GPL(nvmf_should_reconnect);
>   
> -void nvmf_reconnect_or_remove(struct nvme_ctrl *ctrl)
> +static void nvmf_reconnect_or_remove(struct nvme_ctrl *ctrl)
>   {
>   	/* If we are resetting/deleting then do nothing */
>   	if (ctrl->state != NVME_CTRL_CONNECTING) {
> @@ -491,7 +491,6 @@ void nvmf_reconnect_or_remove(struct nvme_ctrl *ctrl)
>   		nvme_delete_ctrl(ctrl);
>   	}
>   }
> -EXPORT_SYMBOL_GPL(nvmf_reconnect_or_remove);
>   
>   static void nvmf_error_recovery_work(struct work_struct *work)
>   {
> @@ -548,10 +547,36 @@ static void nvmf_reconnect_ctrl_work(struct work_struct *work)
>   	nvmf_reconnect_or_remove(ctrl);
>   }
>   
> +void nvmf_reset_ctrl_work(struct work_struct *work)
> +{
> +	struct nvme_ctrl *ctrl =
> +		container_of(work, struct nvme_ctrl, reset_work);
> +
> +	nvme_stop_ctrl(ctrl);
> +	ctrl->ops->teardown_ctrl(ctrl, false);
> +
> +	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING)) {
> +		/* state change failure is ok if we started ctrl delete */
> +		WARN_ON_ONCE(ctrl->state != NVME_CTRL_DELETING &&
> +			     ctrl->state != NVME_CTRL_DELETING_NOIO);
> +		return;
> +	}
> +
> +	if (ctrl->ops->setup_ctrl(ctrl, false))
> +		goto out_fail;
> +
> +	return;
> +
> +out_fail:
> +	++ctrl->nr_reconnects;
> +	nvmf_reconnect_or_remove(ctrl);
> +}
> +

This is close to what FC could use - just need a callout to check for 
connectivity and schedule a connect rather than attempt to connect to 
something not there.

Rest is fine for rdma/tcp. We would need something different to 
commonize this path for all 3 transports. Something to do later.

-- james





