Return-Path: <SRS0=NjBy=W6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C6D8C3A5A2
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Sep 2019 20:23:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF5A520882
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Sep 2019 20:23:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Q4tP30e+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Lf6E4a1w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF5A520882
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=GQoObXYCOj8nR01Hh0SBQ0qHNh0W8ZqauWZzH9SZ6dg=; b=Q4tP30e+ooZyLgfwEcJ4Wm7iW
	92SGU5KPrvuw2q0FXX/KWE0MpJCgVLDA+JZ1PDtEMglZMwtUf9XtUHwCUZGI3FOWvJ9HtX9/MlEBg
	1NOQuoNlo5S00Vzv32k0KPxkp4oOUrhxx+Avz8Qws32KmqR/LSFRHrI5K6Cm5wwEtbkErcleyMJef
	Wk128vJUwY77RBFCjdqnd+KTff9US3df7PRoSfDEwKQb+f5oSPByeLzzwrkJA2rqam6FA0m9eKtnC
	6lG+oHKqUAf9Rz+TYDP8DpYyyKO7cHP5fRpWFbe8d13T9P2vsaxOmdPGYBvIZksr5pg860OSTfPkz
	xKTaZZNtA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i5FKS-0004OU-CR; Tue, 03 Sep 2019 20:23:04 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i5FKP-0004O8-0q
 for linux-nvme@lists.infradead.org; Tue, 03 Sep 2019 20:23:02 +0000
Received: by mail-pl1-x641.google.com with SMTP id y10so2523241pll.7
 for <linux-nvme@lists.infradead.org>; Tue, 03 Sep 2019 13:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=+DwN485uPBYWz/hY1YVGuuSWe1X4Mv4aWYKwvwENKPE=;
 b=Lf6E4a1wpIFHe0qb0eMnmWlxZbEuYOtphGlydHz7AWucDbojEB5UaV+wm01duYOEBt
 slKZmUaVtp9ZQgmoMvCKhEIwFB/8Jq0EM7ozNAv8XF3XcOqa02J6pFUikyUeHkg86Uqy
 3SDmjTLh51P3KME0mRfRo4+pjNGZVHUsdnLqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=+DwN485uPBYWz/hY1YVGuuSWe1X4Mv4aWYKwvwENKPE=;
 b=fIRlm+Rc7gNzvj76ZtZUY8n1uoa4SsWfViFdVtxGguWE+m5Rld0JNACPodUS044oxx
 5xa6lzDtysQB+CjyQqDjGLf6JXCNxMovQ6ICunc8LcVSR/hJKb41nhdcCHEvW23mb6Te
 1pKQSB0hskiT0WsCHy3/u8vEvyJx4sTJJbEGiz7ZniCxID1wwVoDGDkOFgRnRW37kl2m
 nGKADH09J5OvFaf5ljstTt1BXF72678pa0j1t2Qo5gV+SneUbQQSaVHE5MnUwDQaUuV4
 qP1kFTEKzEF6nQkXcJGYtzvLMh+Uoo2T2DS0aFtihmAbTK+1vievGCFjAJ2wo4CoYmZ/
 eo6Q==
X-Gm-Message-State: APjAAAUyp9cu8e61amYLJYO2PPwdkSX7G3/bv4svUBYcpWxq3SD6Dbl4
 B3QZEiABgNz6Dqs/d7rbLsymjw==
X-Google-Smtp-Source: APXvYqwM8od3rB6nGRm0FVII99vmMVyXWQa7rLV2FvWo7gHjBB1UVhdb73WZ6vGWj+qnlz3Js7AtGw==
X-Received: by 2002:a17:902:7613:: with SMTP id
 k19mr5619313pll.89.1567542179449; 
 Tue, 03 Sep 2019 13:22:59 -0700 (PDT)
Received: from [10.69.45.46] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id v66sm28091218pfv.79.2019.09.03.13.22.58
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 03 Sep 2019 13:22:58 -0700 (PDT)
Subject: Re: [PATCH] nvme: include admin_q sync with nvme_sync_queues
To: Edmund Nadolski <edmund.nadolski@intel.com>,
 linux-nvme@lists.infradead.org, keith.busch@intel.com
References: <20190903200847.3378-1-edmund.nadolski@intel.com>
From: James Smart <james.smart@broadcom.com>
Message-ID: <72e9ffb3-fdad-5624-12d5-b1fd38258413@broadcom.com>
Date: Tue, 3 Sep 2019 13:22:57 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190903200847.3378-1-edmund.nadolski@intel.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190903_132301_069656_894E7E0C 
X-CRM114-Status: GOOD (  14.23  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 9/3/2019 1:08 PM, Edmund Nadolski wrote:
> nvme_sync_queues currently syncs all namespace queues, but should
> also sync the admin queue, if present.
>
> Signed-off-by: Edmund Nadolski <edmund.nadolski@intel.com>
> ---
>   drivers/nvme/host/core.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 4660505eded9..43c12f8c030f 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3974,6 +3974,9 @@ void nvme_sync_queues(struct nvme_ctrl *ctrl)
>   	list_for_each_entry(ns, &ctrl->namespaces, list)
>   		blk_sync_queue(ns->queue);
>   	up_read(&ctrl->namespaces_rwsem);
> +
> +	if (ctrl->admin_q)
> +		blk_sync_queue(ctrl->admin_q);
>   }
>   EXPORT_SYMBOL_GPL(nvme_sync_queues);
>   
which probably mean the new request_q should be there too....



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
