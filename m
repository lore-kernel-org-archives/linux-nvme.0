Return-Path: <SRS0=kiw1=GR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51143C433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 03:13:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D54D23619
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 03:13:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D54D23619
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=4SQM17+x7hLVgMhmS8rLsUVmBFJsAvTA12H5kbCH/NI=; b=3hFz3rOz8/3iKD5rgCKM9VC78
	AA80zPkKlaaug4CJR+Tq3qhVZ8rbZUp4XUD2pbC95C5iZLJ7o+bwkJh+osTTstXzP+WJdbJC8vBnd
	4b8TqcI0TFz3RXIiMNPOnChN3HfUFmDbdqcoxOkGoR4T064f94ehhuthsM3J+wJyHS2kEnWIxiwwx
	ESyBvjiAmUGKJBHkcA0BN8Dyz7IHBTUaDvnaOdBR5br//CABbIrTi3g2Hh7rDwOLntjauOudRL4zP
	XNJk1DSfjS3/HzKndlpENZ6ia3vWEPvoK8ndl94SThgGgOKAMnWzN11n1kSjx8q1T/PKq217lUn23
	h3bz8z6mg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzt4W-0002Px-Pk; Thu, 14 Jan 2021 03:13:16 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzt4V-0002PX-4g
 for linux-nvme@lists.infradead.org; Thu, 14 Jan 2021 03:13:15 +0000
Received: by mail-wr1-f44.google.com with SMTP id a9so797261wrt.5
 for <linux-nvme@lists.infradead.org>; Wed, 13 Jan 2021 19:13:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=C0ul08ZwssAyJkNm3gLb4aqG1XLmghUqYXuBN0KVAXY=;
 b=q1q3ua50r3oST6ilam5E/WSNOPr9eIjfJpe80dfEwKzQPVdjP3dbu8lce0DwaPKtLu
 tIdQrM6ClRmfmDxFLO0g5V7n56czsId9iLFMveCL+tYMqk3flCRY3FPUbLsmgeapZ5Tu
 uAE/EmXmNzsr6emmJRmvTj4MxX4GPSFEkHJXlyhux0fCS2peHrcwBAz4sj+miLZeQhRy
 bZ+wKoGmPqh/FFoTlUyxbhwYv030MzowH8jdgByItWg/ltJjFZhZDKzGlWGcGxpGgJii
 F+R6KY3/NgoY2ZElTAZgK5QFUM56SmZQr/styLS9AnTqepD2SOQ+PCKeXnipmTBRs9y0
 S3Ng==
X-Gm-Message-State: AOAM53071ijTb8NwzBljaa+NP+RgHFpEdsT0gWeyEeLub5sFlEbVK9eh
 LMkyPO7nM/dHdi6Q5CfVlobAPOfYTDg=
X-Google-Smtp-Source: ABdhPJzzmEI1MX2lTS+zZyuawBwM4dEx/8qzOQn6i0UX2/20oGl8x+HEfglCeM0GArKfkY/SLS/jgA==
X-Received: by 2002:a5d:6902:: with SMTP id t2mr5456697wru.214.1610593993992; 
 Wed, 13 Jan 2021 19:13:13 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:e70c:620a:4d8a:b988?
 ([2601:647:4802:9070:e70c:620a:4d8a:b988])
 by smtp.gmail.com with ESMTPSA id f14sm5877288wme.14.2021.01.13.19.13.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Jan 2021 19:13:13 -0800 (PST)
Subject: Re: [PATCH] nvme: retrigger ANA log update if group descriptor isn't
 found
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
References: <20201205152901.56665-1-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <cbfc78e1-87be-cc09-9b8d-44bf0659eb26@grimberg.me>
Date: Wed, 13 Jan 2021 19:13:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201205152901.56665-1-hare@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210113_221315_233094_236B5C83 
X-CRM114-Status: GOOD (  20.90  )
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
Cc: linux-nvme@lists.infradead.org, Keith Busch <keith.busch@wdc.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> If ANA is enabled but no ANA group descriptor is found when creating
> a new namespace the ANA log is most likely out of date, so trigger
> a re-read. The namespace will be tagged with the NS_ANA_PENDING flag
> to exclude it from path selection until the ANA log has been re-read.
> 
> Reported-by: Martin George <marting@netapp.com>
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/host/multipath.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 74896be40c17..ee4a42dc99a0 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -667,6 +667,10 @@ void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id)
>   		if (desc.state) {
>   			/* found the group desc: update */
>   			nvme_update_ns_ana_state(&desc, ns);
> +		} else {
> +			/* group desc not found: trigger a re-read */
> +			set_bit(NVME_NS_ANA_PENDING, &ns->flags);
> +			queue_work(nvme_wq, &ns->ctrl->ana_work);

btw, I just commented on the original thread, but I do like this
one better.

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
