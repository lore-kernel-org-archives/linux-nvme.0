Return-Path: <SRS0=Ni0e=M5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122B8C4338F
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Aug 2021 19:36:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9E6861167
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Aug 2021 19:36:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A9E6861167
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+PIesPybz1ZcSQ97yfvllO9L+cGTqxoQlfZo3STuP/Y=; b=1Zr09lJRwf0NTMbJlh0VHJRoCA
	ZXDNGFLwfBSjoqVgp6SNTp7nI0lGkEk/F1qHeErgK0bm3o95Mb1+crQYFXAP04cVgxVNLq0zto9pX
	f0A42YTQfd/8Xmw5k0M6X6qnValOQWmHGiJqe+zn0AHQgMMf6wBNGlmAzoKSQljXvPYZH8NsPhZl6
	dIXAPW7ZRAQecOKkXJeNrqMx+X4fMj5LAOu9GVZR1/4m/f/t0snu1dy1IyfvBbfirspCPZYo15Ldl
	Muk1EqAmEe3Pg7UFPyKYDMs7nxtl5TKyFA2oZA0+U+zw+gLIcPtAZRU3nh6BntF8b4tAExbw1PXkj
	DTZjat3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mC5di-00DJnz-M1; Fri, 06 Aug 2021 19:36:18 +0000
Received: from mail-pj1-f54.google.com ([209.85.216.54])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mC5df-00DJn0-LK
 for linux-nvme@lists.infradead.org; Fri, 06 Aug 2021 19:36:16 +0000
Received: by mail-pj1-f54.google.com with SMTP id
 k11-20020a17090a62cbb02901786a5edc9aso318348pjs.5
 for <linux-nvme@lists.infradead.org>; Fri, 06 Aug 2021 12:36:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jPzjKHGEPie3WLUyUKb9yoM+uqF35K65h1aN+oXRelA=;
 b=pTuMjG4sAaMCRiZlnxzcA/XjLMAhneKIHPXUvaDux6BKrm2b19+1ztsICzpVVu9UkA
 dqAjXiH7fhyjNqX8nlZwCr6hpxuGQCutH5OMcMVAxAmgiLDHuktwT0FCSTHs/TWGHKD5
 DyDhO3C6zgLfoN+EoVVK+UCU6g8jEoeMxuq4VnA6npepAW4NHUPZl5FHdko6TPWu6eTC
 ARMqn12f+PE6o0FiNw81G6X/RyPjismyQQP1lwJKwkMKPbeHgC6VlaeP3vmYH9dkuoKN
 7Cvp1z0p1Kia7+mP58tdkL5RBgcIf74cjteL+tGKHysou8GwHUGIteL3NAfMwJI6beNK
 tFvQ==
X-Gm-Message-State: AOAM532t0t3SFO1hbQankPBF5rjrCZ7YmrOoADrgjP2jdtTmSQRG2Rsl
 t92dhEZ21NspLZVAMWgvwqQ=
X-Google-Smtp-Source: ABdhPJzBB/RZOat1t/oIyRWpzGllxDCcIVypIMvKCx9n1pVv5KZ/52FjbO2UwG3TOpyzG/KjV9iYsQ==
X-Received: by 2002:aa7:8704:0:b029:328:c7ca:fe33 with SMTP id
 b4-20020aa787040000b0290328c7cafe33mr6429872pfo.12.1628278574997; 
 Fri, 06 Aug 2021 12:36:14 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4a77:cdda:c1bf:a6b7?
 ([2601:647:4802:9070:4a77:cdda:c1bf:a6b7])
 by smtp.gmail.com with ESMTPSA id s31sm13533473pgm.27.2021.08.06.12.36.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Aug 2021 12:36:14 -0700 (PDT)
Subject: Re: [PATCH] nvmet: check that host sqsize does not exceed ctrl MQES
To: amit.engel@dell.com, linux-nvme@lists.infradead.org, kbusch@kernel.org
References: <20210805150251.30385-1-amit.engel@dell.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <8ef841fd-f6eb-7705-93fd-8848e83bfb6f@grimberg.me>
Date: Fri, 6 Aug 2021 12:36:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210805150251.30385-1-amit.engel@dell.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210806_123615_760909_2B38254C 
X-CRM114-Status: GOOD (  18.09  )
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


> From: Amit Engel <amit.engel@dell.com>
> 
> Check that host sqsize is not greater-than
> Maximum Queue Entries Supported (MQES) by the ctrl
> 
> Signed-off-by: Amit Engel <amit.engel@dell.com>
> ---
>   drivers/nvme/target/fabrics-cmd.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
> index 7d0f3523fdab..2b4a41b45c45 100644
> --- a/drivers/nvme/target/fabrics-cmd.c
> +++ b/drivers/nvme/target/fabrics-cmd.c
> @@ -109,6 +109,7 @@ static u16 nvmet_install_queue(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
>   	u16 qid = le16_to_cpu(c->qid);
>   	u16 sqsize = le16_to_cpu(c->sqsize);
>   	struct nvmet_ctrl *old;
> +	u16 mqes = NVME_CAP_MQES(ctrl->cap);
>   	u16 ret;
>   
>   	old = cmpxchg(&req->sq->ctrl, NULL, ctrl);
> @@ -123,6 +124,14 @@ static u16 nvmet_install_queue(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
>   		ret = NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR;
>   		goto err;
>   	}
> +	/* sqsize is not allowed to exceed Maximum Queue Entries Supported (MQES) */

Little redundant comment I think (it is also printed in the error).

> +	if (sqsize > mqes) {
> +		pr_warn("sqsize %u is larger than MQES supported %u cntlid %d\n",
> +				sqsize, mqes, ctrl->cntlid);
> +		req->error_loc = offsetof(struct nvmf_connect_command, sqsize);
> +		req->cqe->result.u32 = IPO_IATTR_CONNECT_SQE(sqsize);
> +		return NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR;
> +	}

Otherwise,
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
