Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A92DC4345F
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Apr 2024 09:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ONDxjlVCA+uto1n5Wf2qHkprP1PO56Yw5NIZ6Z7yRLw=; b=BPdqzQaXFZIfmO+h6rWu0gwO21
	XzgKABkdJqRrjYSZSouv+n2fTClMUzUJ/XGDkiivVdteCtLaTKbJOPmsfAkwaDa/H4BYleotXY1s2
	NRFUHYrOsjvb+oSkN9rAxY638CUN29mqDHY1rQM/Sm4/z3Q21aFxuIQ+BVBb1kyWsiI/SNpfgydou
	6MYRYUmxSPHkmMnzh0+Ind7/Jtv7ygGlyBO3z/3VJ7ogsPdOYeCZgdNa/HO/nvxBA/DqkbuFw4JMk
	ul9PKjsl8PE+Agjlw69u+pYoUeRO6kf2Q3QJEn6T2uU4e9cweohUS3QnuyPtpmE+Oo1/v6Kt5P+VR
	cu/4Z6xQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxO6F-00000001cfw-3Ade;
	Thu, 18 Apr 2024 09:30:35 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxO6C-00000001cdz-3LYb
	for linux-nvme@lists.infradead.org;
	Thu, 18 Apr 2024 09:30:34 +0000
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-349bd110614so110893f8f.3
        for <linux-nvme@lists.infradead.org>; Thu, 18 Apr 2024 02:30:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713432630; x=1714037430;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ONDxjlVCA+uto1n5Wf2qHkprP1PO56Yw5NIZ6Z7yRLw=;
        b=KNdf/puYnAylMXIfkbVfYV3sFluUirb2cv/S8VhTyF4L77C6G6z8FGFHlSxZhA+iR8
         LoLFefvWgZiPqwvv6AfrqsOdsvE40/3DUz9Jhz7Dh3OaF24kDHEDBjEztDxvwsX7MzAx
         hE+Rk4OswiYPUUxcjotM975+urfOqE3HruLp51boXXmI0rWBFjBDwWrtbgK3h4HkM2xA
         12I2OYQFHV5v+iMz9K7TCyXV69YQqAruwE0MNbGfjQH/GLyjh33oBTlDBi3bzUS0CWxS
         0ev3CU2GulQL1sZ6EBabA0VHJaIrD2TefyhYmkBlCxslqMz7RdiQsSsShrA8OWZZ0QOd
         rjxw==
X-Forwarded-Encrypted: i=1; AJvYcCXYnpV/d2KoyR/f5IrX8e2pccewkmM7lrU5pEWfaYHKopcTF+9UJn6olwaabzoREgPDoAdIzL/t5o0R5dL5afS0ksAX4Iu5JsbpGW+UYnk=
X-Gm-Message-State: AOJu0YwrdLFFIkBvSiam/gZ6P1034YB13XpU7Xjv7qTuJngy+gKjr6OL
	2Ci8x8WhDc5BoC6jMJpZSr4IqCzmPttZCvw/d1cd84ESTWrWZ3NH
X-Google-Smtp-Source: AGHT+IF7WrJSYKHhpcac39Dy8vRXma427d/VCWkQ48oc9GfdOAFCfwNEklux+J4fOYv1nTo5i0kkVw==
X-Received: by 2002:adf:f9d1:0:b0:349:ec31:8cd3 with SMTP id w17-20020adff9d1000000b00349ec318cd3mr1103765wrr.7.1713432629996;
        Thu, 18 Apr 2024 02:30:29 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id e5-20020adfe385000000b003455e5d2569sm1400699wrm.0.2024.04.18.02.30.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 02:30:29 -0700 (PDT)
Message-ID: <aa43242d-a460-4fc2-9802-bc68f050dd01@grimberg.me>
Date: Thu, 18 Apr 2024 12:30:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] nvme-fabrics: factor out auth code into helper
To: Chaitanya Kulkarni <kch@nvidia.com>, hare@suse.de
Cc: kbusch@kernel.org, hch@lst.de, linux-nvme@lists.infradead.org
References: <20240208062427.31255-1-kch@nvidia.com>
 <20240208062427.31255-2-kch@nvidia.com>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240208062427.31255-2-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240418_023032_880823_2AF62D6B 
X-CRM114-Status: GOOD (  21.54  )
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



On 08/02/2024 8:24, Chaitanya Kulkarni wrote:
> Post connect command authentication handling code is repeated into in
> nvmf_connect_admin_queue() and nvmf_connect_io_queue().
>
> Add a helper to handle post connect command authentication helper. Use
> the same helper in nvmf_connect_admin_queue(). This also removes
> authentication specific code from a build where authentication feature
> is not configured.
>
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>   drivers/nvme/host/auth.c    | 32 ++++++++++++++++++++++++++++++++
>   drivers/nvme/host/fabrics.c | 25 +------------------------
>   drivers/nvme/host/nvme.h    |  8 ++++++++
>   3 files changed, 41 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
> index 3dce480d932e..159071462738 100644
> --- a/drivers/nvme/host/auth.c
> +++ b/drivers/nvme/host/auth.c
> @@ -988,6 +988,38 @@ void nvme_auth_stop(struct nvme_ctrl *ctrl)
>   }
>   EXPORT_SYMBOL_GPL(nvme_auth_stop);
>   
> +u16 nvme_auth_post_connect(struct nvme_ctrl *ctrl, u16 qid, u32 result)
> +{
> +	int ret;
> +
> +	if (!(result & (NVME_CONNECT_AUTHREQ_ATR | NVME_CONNECT_AUTHREQ_ASCR)))
> +		return NVME_SC_SUCCESS;

I really dislike functions that may or may not do anything. I vote that 
we avoid
as much as possible.

How about calling the function nvme_authenticate_queue() and more the above
condition to the call-site?

> +
> +	/* Secure concatenation is not implemented */
> +	if (result & NVME_CONNECT_AUTHREQ_ASCR) {
> +		dev_warn(ctrl->device,
> +			  "qid %u: secure concatenation is not supported\n",
> +			  qid);
> +		return NVME_SC_AUTH_REQUIRED;
> +	}
> +	/* Authentication required */
> +	ret = nvme_auth_negotiate(ctrl, qid);
> +	if (ret) {
> +		dev_warn(ctrl->device,
> +			 "qid %u: authentication setup failed\n", qid);
> +		return NVME_SC_AUTH_REQUIRED;
> +	}
> +	ret = nvme_auth_wait(ctrl, qid);
> +	if (ret) {
> +		dev_warn(ctrl->device, "qid %u: authentication failed\n", qid);
> +		return ret;
> +	}
> +	if (!qid)
> +		dev_info(ctrl->device, "qid 0: authenticated\n");
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(nvme_auth_post_connect);
> +
>   void nvme_auth_free(struct nvme_ctrl *ctrl)
>   {
>   	int i;
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 373ed08e6b92..24f0d298825b 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -460,30 +460,7 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
>   
>   	result = le32_to_cpu(res.u32);
>   	ctrl->cntlid = result & 0xFFFF;
> -	if (result & (NVME_CONNECT_AUTHREQ_ATR | NVME_CONNECT_AUTHREQ_ASCR)) {
> -		/* Secure concatenation is not implemented */
> -		if (result & NVME_CONNECT_AUTHREQ_ASCR) {
> -			dev_warn(ctrl->device,
> -				 "qid 0: secure concatenation is not supported\n");
> -			ret = NVME_SC_AUTH_REQUIRED;
> -			goto out_free_data;
> -		}
> -		/* Authentication required */
> -		ret = nvme_auth_negotiate(ctrl, 0);
> -		if (ret) {
> -			dev_warn(ctrl->device,
> -				 "qid 0: authentication setup failed\n");
> -			ret = NVME_SC_AUTH_REQUIRED;
> -			goto out_free_data;
> -		}
> -		ret = nvme_auth_wait(ctrl, 0);
> -		if (ret)
> -			dev_warn(ctrl->device,
> -				 "qid 0: authentication failed\n");
> -		else
> -			dev_info(ctrl->device,
> -				 "qid 0: authenticated\n");
> -	}
> +	ret = nvme_auth_post_connect(ctrl, 0, result);
>   out_free_data:
>   	kfree(data);
>   	return ret;
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 1700063bc24d..bb1c9b74aa55 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -1085,6 +1085,7 @@ void nvme_auth_stop(struct nvme_ctrl *ctrl);
>   int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid);
>   int nvme_auth_wait(struct nvme_ctrl *ctrl, int qid);
>   void nvme_auth_free(struct nvme_ctrl *ctrl);
> +u16 nvme_auth_post_connect(struct nvme_ctrl *ctrl, u16 qid, u32 result);
>   #else
>   static inline int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
>   {
> @@ -1107,6 +1108,13 @@ static inline int nvme_auth_wait(struct nvme_ctrl *ctrl, int qid)
>   	return NVME_SC_AUTH_REQUIRED;
>   }
>   static inline void nvme_auth_free(struct nvme_ctrl *ctrl) {};
> +static inline u16 nvme_auth_post_connect(struct nvme_ctrl *ctrl, u16 qid,
> +		u32 result)
> +{
> +	if (result & (NVME_CONNECT_AUTHREQ_ATR | NVME_CONNECT_AUTHREQ_ASCR))
> +		return NVME_SC_AUTH_REQUIRED;
> +	return NVME_SC_SUCCESS;
> +}
>   #endif
>   
>   u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns,


