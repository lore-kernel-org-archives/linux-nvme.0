Return-Path: <SRS0=LdLJ=NC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D43DC4338F
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Aug 2021 01:03:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCA9160EE7
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Aug 2021 01:03:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DCA9160EE7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CjXtaFYNxj+tF2MjFXaciqDC00lBJumPGSqe0tlIPK0=; b=pXN5HpwnTe+CmhFVjQCc8svcxu
	iQoZ2yBA9IKmj62ZnNtAq4qc+2gFqXmnEv+hahWKtSB4IC70sbQn4Gh9P0xERkYypIpjYAoUHhzGx
	vfFvEyb0m+Vfzn8/ucj4roUNYXzwz9xBHabzf3SDZV7UdjYgkcWnIiuqOdEzuS3k+3lFjQjxphd+G
	VvTX26WU73djKv9pMh6jh03/n6T7uB9/KK9Dp8K1qcdo6aL22hgIIRD7/d5rTsaGX8SKzw7dW7mG0
	HRnAIqX0cy09II3+C48q6xW0032OA6oRkKVKpAoZTdeXrd6G7hGhob3ryHtPVhbSNGtMBvJb0LwRg
	z36+rn5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mDcdl-0057vZ-Eq; Wed, 11 Aug 2021 01:02:41 +0000
Received: from mail-pj1-f46.google.com ([209.85.216.46])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mDcdj-0057ur-1L
 for linux-nvme@lists.infradead.org; Wed, 11 Aug 2021 01:02:40 +0000
Received: by mail-pj1-f46.google.com with SMTP id
 fa24-20020a17090af0d8b0290178bfa69d97so2033850pjb.0
 for <linux-nvme@lists.infradead.org>; Tue, 10 Aug 2021 18:02:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7NTG/vEAVW33QwSz6IbOwW37gh6DXGDFaf8xH4NDYdc=;
 b=pKacbEkXCPkacfWHzoyX4yguUBQIDrfgiZSPXv+BRKHlUuZxY0KQW4RYEhFtjG8zQf
 mlOS7n/dOHWB0gSuwga2rZlGL/wBeFudZaBSWExMd8jyNkkQ+F9iu5C/ppiL+Qznrrv3
 I5185mbUpLV7vi0g26etxvmAAsVKIkauETlUet5f1jGbmveamAy3NdCIevboY9YUeijz
 8I6AUkfN1mWUnvtCqBoukMiLaB2dHhR61nkDo43GU21WxerJpOd4khkA42+bIsWg2afr
 /lRwHoPYn/69e8x+Oq7ZT4U+/lSyG14AWjxo+2dHSwkyClccLfZlvbpr+aSkeKjXy3jJ
 gEjA==
X-Gm-Message-State: AOAM5306bnyl4TIQNQHeaQa+17mxAWZM8wyoCKRXScu1gWcpj6vR98ax
 Hmu2OaQLZ3kUeCSf6ZnSiTc=
X-Google-Smtp-Source: ABdhPJy2Q/BoFQTa/ia3PdlVLFKaI4IXuMZ9P7J56R+D6rerGlNeIsQ+ZX02SDqDxFOQGEVaj2KxaA==
X-Received: by 2002:a63:83c7:: with SMTP id h190mr111482pge.51.1628643758343; 
 Tue, 10 Aug 2021 18:02:38 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:61e5:4b9f:b48a:e987?
 ([2601:647:4802:9070:61e5:4b9f:b48a:e987])
 by smtp.gmail.com with ESMTPSA id y6sm23014351pjr.48.2021.08.10.18.02.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Aug 2021 18:02:37 -0700 (PDT)
Subject: Re: [PATCH] nvme-tcp: Do not reset transport on data digest errors
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Hannes Reinecke <hare@suse.de>, yi.he@emc.com
References: <20210805121541.77613-1-dwagner@suse.de>
 <47ef76c6-4430-ca24-405e-a226d4303a39@grimberg.me>
 <20210809090947.luoqaooi7gc6u6yu@carbon>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <2e91c065-d3c6-1bef-5906-1a4648368894@grimberg.me>
Date: Tue, 10 Aug 2021 18:02:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210809090947.luoqaooi7gc6u6yu@carbon>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210810_180239_130293_FB05140A 
X-CRM114-Status: GOOD (  17.90  )
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


> Hi Sagi,
> 
> On Fri, Aug 06, 2021 at 12:42:00PM -0700, Sagi Grimberg wrote:
>>> @@ -89,6 +89,7 @@ struct nvme_tcp_queue {
>>>    	size_t			data_remaining;
>>>    	size_t			ddgst_remaining;
>>>    	unsigned int		nr_cqe;
>>> +	u16			status;
>>
>> Why is this a queue member and not a request member?
> 
> I was not sure if the TCP transport specific error handling should
> impact all other transport (size of struct request). Also I tried to
> avoid accessing cachelines which are not already in use. Except this I
> don't see there should be no problem to put this to struct request.

It is the correct place, lets see that it doesn't increase the struct.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
