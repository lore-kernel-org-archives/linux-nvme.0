Return-Path: <SRS0=ZbIm=I7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91860C433B4
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Apr 2021 01:37:26 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39A286108B
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Apr 2021 01:37:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39A286108B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=n3BQ8GBV5aRmY+b+SJt9MLQ5rbfqqIQ+VreaaGRNhqE=; b=ol86IkgdlReCwoGN0fPjrw4I/
	wCW8jI8athclLWjUyMrMQroO8m+1YTK3YjIuuUnTKPt3tjA8xuF9mI6y1uPe971TH6XBDcbVQLI9f
	cyfkKtGt4v9cXRY85F4G9qyEbmU0UMI5dhaLW4TXViJg0S5+wKPLe0RGYpC1bPpvRYbuCpnv1Jr0X
	CT8TGaH/hpQDG4qMI/KCPFsPVe5U4WtJZ9oEiSb04j80jNEXox5RTCDCzkr3vwisekP4zNqL0Rfgr
	0/F8uZ4blCzL7l1n1HpU+CpxKN25g2KiNwHFMVzyCxQp0FsAsW8TnUyS6ORzDmL5fPD1fndA2mZFA
	tsKfj6KHg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lS8kN-00Beco-G7; Fri, 02 Apr 2021 01:37:15 +0000
Received: from mail-pl1-f178.google.com ([209.85.214.178])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lS8kE-00Beb7-NQ
 for linux-nvme@lists.infradead.org; Fri, 02 Apr 2021 01:37:09 +0000
Received: by mail-pl1-f178.google.com with SMTP id w11so1868658ply.6
 for <linux-nvme@lists.infradead.org>; Thu, 01 Apr 2021 18:37:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FV+ec2NrYZ4oGjjagL3/N6YtgowQBxCLa+imGE5J3SI=;
 b=WYMwyT+nEKJR2FXq6/QGkdppCO4jjWHwFfEgMzeRMh/I5G3cB2bwJGhapCViLimDfV
 S7UtfwQuAfCSf7uARUnVtfzzzH7dczrejvOYXSTpyy0jVQYcd7Ee/rDh/xPSnAizZiNu
 GazoRJDEvNq//VzA1tqMRbgiLT997JsF/ZtOckYH6U2KfcAGMkGEFyQOGN7uzxuUYwTx
 qc9oTiJAYvA07PsbVEDArw7a75ZgW43No164UaZSrYE+OiZcFqefnAVxPDYCIhoAmF7U
 uo2zOpxMZykgi8UxFN5u4YPX3tLUIrRJQPejXKBF+WiKxptdvG2EPPvGQ4FQLVAG6xHO
 lFAQ==
X-Gm-Message-State: AOAM531wtUTPH0z0EWXsMqiosVeQ4i4VIoM7QqXlOQL0IWTWsugCIvMl
 7e3+onQTuraKgXFfm/oqFEFULcTxTtM=
X-Google-Smtp-Source: ABdhPJwv201/vylDuCkogO2YZY20m6i03OEelj2XakmkuFdg2utUFYvT7jikg89YFQ2HyHrge2FFzA==
X-Received: by 2002:a17:90a:7344:: with SMTP id
 j4mr11067240pjs.223.1617327424764; 
 Thu, 01 Apr 2021 18:37:04 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:2046:e611:bcdf:eb50?
 ([2601:647:4000:d7:2046:e611:bcdf:eb50])
 by smtp.gmail.com with ESMTPSA id bk8sm6414405pjb.13.2021.04.01.18.37.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Apr 2021 18:37:04 -0700 (PDT)
Subject: Re: [PATCH v2] nvme: Fix handling of large MDTS values
To: Keith Busch <kbusch@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org
References: <20210401035952.7249-1-bvanassche@acm.org>
 <20210401155456.GA31698@redsun51.ssa.fujisawa.hgst.com>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <dc9d48f1-3597-5f5a-185c-6196cb613957@acm.org>
Date: Thu, 1 Apr 2021 18:37:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210401155456.GA31698@redsun51.ssa.fujisawa.hgst.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210402_023707_259006_F047C3FE 
X-CRM114-Status: GOOD (  15.77  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 4/1/21 8:54 AM, Keith Busch wrote:
> On Wed, Mar 31, 2021 at 08:59:52PM -0700, Bart Van Assche wrote:
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 40215a0246e4..25bc28e8845f 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -3123,10 +3123,11 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
>>  
>>  	atomic_set(&ctrl->abort_limit, id->acl + 1);
>>  	ctrl->vwc = id->vwc;
>> -	if (id->mdts)
>> -		max_hw_sectors = 1 << (id->mdts + page_shift - 9);
>> -	else
>> +	max_hw_sectors = UINT_MAX;
>> +	if (id->mdts && check_shl_overflow(1U, id->mdts + page_shift - 9,
>> +					   &max_hw_sectors)) {
>>  		max_hw_sectors = UINT_MAX;
>> +	}
> 
> The condition can be rearranged so that max_hw_sectors is set to
> UINT_MAX just once:
> 
> 	if (!id->mdts || check_shl_overflow(1U, id->mdts + page_shift - 9,
> 					    &max_hw_sectors)) {
>   		max_hw_sectors = UINT_MAX;
> 	}

Hi Keith,

That's an interesting suggestion. I will integrate this change in my
patch and repost it.

Thanks,

Bart.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
