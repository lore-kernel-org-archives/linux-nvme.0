Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0817C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Apr 2022 15:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S1FjCT12gWPDX7Sw/bh3UgnUWsvMlvjsGYIoMOy/yM8=; b=lgBh+C+7xhVtQa8XGNOO3Yhz3d
	IvSTSm9/N8tuB3b38Q+W0j9+gxQpbCeqR7iSttQuczQO4SC5g4R/Dv/H+kYbYRormZn6i1dVOAFfq
	IITCPxsIdnEJVwvPVwM6mHpay2iq7MGsXiI2qEegL3Oc4haEbB9lm+LSMFoEQ4zxHCezidoDwcMqS
	kB0cs2P/qSn96pRSQWnjd6/t4glIw4OpOh37qDjdJsURCDAU5ww17UaLmPtj3ucGXDt+ssdUjWafk
	euD6ND3A8/SOFIsVKI1A61Zbvf5Ahf/J7qctSz2RVyFU2vTWzblDj2b6CBmDOx9ifNv6NJCcHAsL5
	OszX+MxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ngpNm-004UhN-0V; Tue, 19 Apr 2022 15:03:10 +0000
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ngof7-004Brq-Fx
 for linux-nvme@lists.infradead.org; Tue, 19 Apr 2022 14:17:02 +0000
Received: by mail-lj1-x235.google.com with SMTP id bj36so14812289ljb.13
 for <linux-nvme@lists.infradead.org>; Tue, 19 Apr 2022 07:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=S1FjCT12gWPDX7Sw/bh3UgnUWsvMlvjsGYIoMOy/yM8=;
 b=PZOaTYQ+UMyU3lUm14a/aCBV02FMZPcsNmZAe2ftl9U+lGQ8jDEUjoMqxYdtSWWXVo
 xx3Yj+pkZkzIe39HENYGaAFamVI2T1dUSwveZIJznTmqex1yIqAIYwqMBXXlhqjQK80e
 C2w3CUihGSqvkXZcQwdq3cqffZ3SLhjNK90OLM+A6T2cwsoOIHEL3L9Z1pM1mNkaRL7E
 PZRoNr1Aw6bw6GVOwsSnxV5Zmb2rTuEA/q8APduLiifQiFjAReE9+rq8vncLbzG5lHFb
 jYt1+IebkFvq3eJlCD+1zglh+dNdLpZmqTC5cWmUYVga3ojnyP6wj0yF2k6ThqWsaF+q
 Yniw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=S1FjCT12gWPDX7Sw/bh3UgnUWsvMlvjsGYIoMOy/yM8=;
 b=SXYKiMQDSLNbv8J3qViIdmfNuIewv3mHz6bzbQacwq0RN8W2qYqGz8ojfCN1/x9vRE
 SFAQoFJBBHzMqup93i17Ryflfkf3fS7DOy3hA+qK9KfnHNu5CibqtHnM7tVyBDzbnDU+
 PVfkE5VX7G9rWdl99d3zAiZ27Ru7qp2E2ZD9DvJ4bjfB3cN4RQNNWdPrFY8bK7r6MFws
 4fI/Fg07DszMZvgCA5u8wVqeyPe2V5LobRzViTrfjnul/V3Dn3NLep2S5vYvYAjxemej
 AWMPmW6XdNwqTrc7c1rluEruFeU5To67dkyup6N8hMabxCRgUekugGhJM3gvv7MN6nCI
 ifFQ==
X-Gm-Message-State: AOAM531mvkCuRlutKM7FE8W4vURg+biOW4rcvwia3koPTyDYBxMOu63I
 NDpp2+VFHe/Ar1/3zXylNqKqfXozqDA=
X-Google-Smtp-Source: ABdhPJygx44PBZUYs5bklftTeHK7e8RMREal0EAnYTMqquGmZYxUZxpI/ET0uhQUiVG/rt8i9K8z4g==
X-Received: by 2002:a2e:8ed0:0:b0:24d:b5f4:ae33 with SMTP id
 e16-20020a2e8ed0000000b0024db5f4ae33mr8010756ljl.507.1650377817564; 
 Tue, 19 Apr 2022 07:16:57 -0700 (PDT)
Received: from localhost (87-49-147-96-mobile.dk.customer.tdc.net.
 [87.49.147.96]) by smtp.gmail.com with ESMTPSA id
 l28-20020a19495c000000b0044a8abcb589sm1523696lfj.186.2022.04.19.07.16.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Apr 2022 07:16:56 -0700 (PDT)
Date: Tue, 19 Apr 2022 16:16:55 +0200
From: Pankaj Raghav <pankydev8@gmail.com>
To: Vincent Fu <vincent.fu@samsung.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH] nvme: have nvme_setup_rw return BLK_STS_OK
Message-ID: <20220419141655.ijmik6r2ggli4zkp@quentin>
References: <CGME20220418194351uscas1p18e05fad61bc279e8ea18d1a1a8597dc3@uscas1p1.samsung.com>
 <20220418194324.589248-1-vincent.fu@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220418194324.589248-1-vincent.fu@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220419_071701_621279_1ACF796D 
X-CRM114-Status: GOOD (  17.49  )
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

On Mon, Apr 18, 2022 at 07:43:50PM +0000, Vincent Fu wrote:
> Return BLK_STS_OK instead of 0 on success. Since BLK_STS_OK is defined
> as 0 this patch results in no functional change but to avoid confusion
> and to be consistent with nvme_setup_write_zeroes as well as
> nvme_setup_discard we should have nvme_setup_rw also return BLK_STS_OK.
> 
> Signed-off-by: Vincent Fu <vincent.fu@samsung.com>
> ---
>  drivers/nvme/host/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index b9b0fbde9..f45665e36 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -895,7 +895,7 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
>  
>  	cmnd->rw.control = cpu_to_le16(control);
>  	cmnd->rw.dsmgmt = cpu_to_le32(dsmgmt);
> -	return 0;
> +	return BLK_STS_OK;
>  }
>  
>  void nvme_cleanup_cmd(struct request *req)
> -- 
> 2.25.1
> 
Small nit:
The commit line could be changed to:
nvme: return BLK_STS_OK on success in nvme_setup_rw

Otherwise, Looks good.
Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>

-- 
Pankaj Raghav

