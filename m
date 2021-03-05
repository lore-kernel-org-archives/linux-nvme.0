Return-Path: <SRS0=roYe=ID=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 712DFC433E0
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Mar 2021 22:00:13 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19E2765092
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Mar 2021 22:00:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19E2765092
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=fkC/eYLoFNhIL0TmY2NQ7JsAOX0iJqV85gzJrlfqiIU=; b=f63OXhNfk4PgnvRvLrrah6fEf
	tKjO3/M1xxs4i9FLtfpTKVdjXudwkN6RmL1BJ9u22d0JezZ0FAiRQfl6ZwME6n9u4oXvvlyAD1c3h
	4q0DdxPpolilccbuH1uSVQlk65RykcfjS+3/FQ0SqJT1ODvZxlQcChf94jIYYjNsC4eNLU2kOE6Ht
	gp2UhRiZodSoDwTHe9iy0KM2/qtTqd054Ks6yVBRIPcoQfmzBbT40+Ko4XSn+2R6RaeHAQzMIFNPu
	TqBf62iRhFjhjPIeaRrT2RUct68kykapXKxT1j3dKhRcZi4de3QM0MptBHTxT1S9fDKnpucqjDbNK
	u+4xrD0Aw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lIITv-00GiCx-LP; Fri, 05 Mar 2021 21:59:35 +0000
Received: from mail-oo1-f41.google.com ([209.85.161.41])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lIITn-00GiA2-7Y
 for linux-nvme@lists.infradead.org; Fri, 05 Mar 2021 21:59:30 +0000
Received: by mail-oo1-f41.google.com with SMTP id h38so789074ooi.8
 for <linux-nvme@lists.infradead.org>; Fri, 05 Mar 2021 13:59:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=B2nZfWykRyP1guk/B8XyPAk79n0wAgVF81dpOqGu7hk=;
 b=XG7E8de+vEI6QLhWmDFltAt5CHIRlBYmo/pslqZTVXhyTqK5WJ8lOTEXIUv3b2jj5V
 e+0fYitfMvBUWksCrd2TuQMzALrbKky2EebB/mAwllHXfh4lEidRz5ATa+/FD6LV+5D/
 x+DTGLuWg///oxGeWpqgMKt28xAtAe1ZJNntnaPSQbrwLJBHC6MlsMwqg4uiQW6Zze1t
 uQ3PUac1EPUhJKN+cacGOWz4VxgrkDrQNz7hrXHRhaTayS5qpDM3CPeAkyEGP1MgvT1t
 fbxNt1I2r8SLqRKxu5R72vBXcOzAFcZHnBq9IzeqbFOynLaUAS0KlvCnLfhNmAKfWM7r
 odXg==
X-Gm-Message-State: AOAM533mWCtTkKXLBt0KpP2bNM7j28BghoBB7fKWS6FoYE+B0iUcgIlH
 CRWn77GMi5zLvxbpskVx69I=
X-Google-Smtp-Source: ABdhPJwgwH5k05n5UJzba7SsxyxcAFBgfOM9QHSSbIM1wqG94UcXJ8W0BbzCC2AC6eyAYl7eBwv3jQ==
X-Received: by 2002:a4a:b787:: with SMTP id a7mr9598936oop.18.1614981563688;
 Fri, 05 Mar 2021 13:59:23 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:e55e:67c6:e7ec:9?
 ([2600:1700:65a0:78e0:e55e:67c6:e7ec:9])
 by smtp.gmail.com with ESMTPSA id 8sm644942otx.1.2021.03.05.13.59.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Mar 2021 13:59:23 -0800 (PST)
Subject: Re: [PATCH 1/4] nvme: simplify error logic in nvme_validate_ns()
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>
References: <20210226071728.106923-1-hare@suse.de>
 <20210226071728.106923-2-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <06e33934-00c7-38ad-6a7e-86c14c1008fc@grimberg.me>
Date: Fri, 5 Mar 2021 13:59:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210226071728.106923-2-hare@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210305_215928_012614_CD9E1B4D 
X-CRM114-Status: GOOD (  25.53  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2/25/21 11:17 PM, Hannes Reinecke wrote:
> We only should remove namespaces when we get fatal error back from
> the device or when the namespace IDs have changed.
> So instead of painfully masking out error numbers which might indicate
> that the error should be ignored we could use an NVME status code
> to indicated when the namespace should be removed.
> That simplifies the final logic and makes it less error-prone.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Keith Busch <kbusch@kernel.org>
> ---
>   drivers/nvme/host/core.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index d77f3f26d8d3..bde1b22ca7f2 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1439,7 +1439,7 @@ static int nvme_identify_ns(struct nvme_ctrl *ctrl, unsigned nsid,
>   		goto out_free_id;
>   	}
>   
> -	error = -ENODEV;
> +	error = NVME_SC_INVALID_NS | NVME_SC_DNR;
>   	if ((*id)->ncap == 0) /* namespace not allocated or attached */
>   		goto out_free_id;
>   
> @@ -4036,7 +4036,7 @@ static void nvme_ns_remove_by_nsid(struct nvme_ctrl *ctrl, u32 nsid)
>   static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_ids *ids)
>   {
>   	struct nvme_id_ns *id;
> -	int ret = -ENODEV;
> +	int ret = NVME_SC_INVALID_NS | NVME_SC_DNR;
>   
>   	if (test_bit(NVME_NS_DEAD, &ns->flags))
>   		goto out;
> @@ -4045,7 +4045,7 @@ static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_ids *ids)
>   	if (ret)
>   		goto out;
>   
> -	ret = -ENODEV;
> +	ret = NVME_SC_INVALID_NS | NVME_SC_DNR;
>   	if (!nvme_ns_ids_equal(&ns->head->ids, ids)) {
>   		dev_err(ns->ctrl->device,
>   			"identifiers changed for nsid %d\n", ns->head->ns_id);
> @@ -4063,7 +4063,7 @@ static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_ids *ids)
>   	 *
>   	 * TODO: we should probably schedule a delayed retry here.
>   	 */
> -	if (ret && ret != -ENOMEM && !(ret > 0 && !(ret & NVME_SC_DNR)))
> +	if (ret > 0 && (ret & NVME_SC_DNR))
>   		nvme_ns_remove(ns);
>   }

This looks ok to me,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
