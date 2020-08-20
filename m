Return-Path: <SRS0=ANWg=B6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C38C433E1
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 21:38:13 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33A9C21734
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 21:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sr7YFMfk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XjRCPZno"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33A9C21734
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=njA5Iwj1P/itR3FRLS8n4nzs+1nG3glmDQ2sFr/MofM=; b=sr7YFMfk3sgO3drB5E4x3RbAs
	BFpOVxI4fNBgRCJB4dwae6Ah4/8ER2Ad52PT9Zvd3TjSIjnv/xC8vmV4qvbO/oVWKrgex5GYNU7UE
	XtoMraLGyZMRnzprSCIJV16C7fKdk2CHVUhqGiJK2nrGJZYjNQQwnKnswPMmdbkPsc8SWEXd+cvk8
	OcbUURQVcCxjUeq7LB9FWY+Y6WIE5YUyht0PGDQUfrUjMukOeMeWLhfnIcIUFtiG04ncknhoxFb78
	gopIW3ZDwpCVVX6QwfOA8F3Wt370zftjtVXLpfbqSYP/DaMpC4H2xVctFp56b+EptOdxlw62SV3Gw
	FMev5Fb/A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8sG5-0007Kn-4t; Thu, 20 Aug 2020 21:38:05 +0000
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8sG0-0007KL-Lb
 for linux-nvme@lists.infradead.org; Thu, 20 Aug 2020 21:38:02 +0000
Received: by mail-ed1-x542.google.com with SMTP id v22so2843301edy.0
 for <linux-nvme@lists.infradead.org>; Thu, 20 Aug 2020 14:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=rfWMA1LjEck/jAG3OUGYY+oM8wVhKA5f4Wrm7wNGG4o=;
 b=XjRCPZno/Qtt5/de4vkrq4EdoOJi+1rvx+4wfaCfwtpzs0nS0cxrOXdC9QlNW4SsRc
 grkLky55uPZToEQtCMjP2KNus2ge/CmEM4A0j5Q+VBcIcoQc3D1LD5jYh6ppc7i7LTxt
 v5y2NvfI3l38RGAvppsbBZSp8Qp1pFGuXrAMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=rfWMA1LjEck/jAG3OUGYY+oM8wVhKA5f4Wrm7wNGG4o=;
 b=gxyqIDBBnbUAhLQyVn70YRvhThHuiKEbJw+CUeNykVSFDsM9sKlmP83EFcn+M0AdOE
 YYwmD3FTkoRYcN6UbTTxVZpsTZ7PUhWkWn8hx9DMSNHWL74LUVpn7vxI/Svh2xZl1TUw
 suX2Vp6OIpNxBtZ1W2eNcB4IQdOtswELDotgc8ECgzi7j1fe0dyP24fwQJNrxE7tpHUL
 LO6rjjBMN/JuxKcaVf6kJ7uiIwmcBJagslMFk5v3f72ikeXmmdeq8ownHf9QWn7B5ZDt
 zCgzZXZqfHhdUeCNqms1+5E+2dPlEn7Lwjp+XgXt++3c4j2z6Vf1tdpIHU7bugTW9jV0
 xrfQ==
X-Gm-Message-State: AOAM5304jOylIOvywGKRMJdGcbYc78v4Zkxpv5BFDobXV2Q4Q1aHmVed
 Td5VqOJWfg42+BT8PfYoXXtfEw==
X-Google-Smtp-Source: ABdhPJxbiCyVu416slEVsQw2bGFPQeXzRTtz9Aen8Zx2woPzUZYzHjLC1yxefb+K5rC/I4jRQD0RUg==
X-Received: by 2002:aa7:c0d3:: with SMTP id j19mr544230edp.157.1597959478230; 
 Thu, 20 Aug 2020 14:37:58 -0700 (PDT)
Received: from [10.69.69.102] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id u13sm2119930eje.9.2020.08.20.14.37.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2020 14:37:57 -0700 (PDT)
Subject: Re: [PATCH v3 8/9] nvme-rdma: fix timeout handler
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
References: <20200820053651.197057-1-sagi@grimberg.me>
 <20200820053651.197057-9-sagi@grimberg.me>
From: James Smart <james.smart@broadcom.com>
Message-ID: <0de22585-22b1-ae49-f7a7-7b99115d5b1c@broadcom.com>
Date: Thu, 20 Aug 2020 14:37:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <20200820053651.197057-9-sagi@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200820_173800_943843_12DF0B55 
X-CRM114-Status: GOOD (  17.84  )
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



On 8/19/2020 10:36 PM, Sagi Grimberg wrote:
> When a request times out in a LIVE state, we simply trigger error
> recovery and let the error recovery handle the request cancellation,
> however when a request times out in a non LIVE state, we make sure to
> complete it immediately as it might block controller setup or teardown
> and prevent forward progress.
>
> However tearing down the entire set of I/O and admin queues causes
> freeze/unfreeze imbalance (q->mq_freeze_depth) because and is really
> an overkill to what we actually need, which is to just fence controller
> teardown that may be running, stop the queue, and cancel the request if
> it is not already completed.
>
> Now that we have the controller teardown_lock, we can safely serialize
> request cancellation. This addresses a hang caused by calling extra
> queue freeze on controller namespaces, causing unfreeze to not complete
> correctly.
>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>

Reviewed-by: James Smart <james.smart@broadcom.com>

Looks good

-- james

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
