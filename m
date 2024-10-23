Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A24CFA478
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Oct 2024 21:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CT5XeBQQaf5gpeKwKyp9KwMrZzTbNucisPSnXJGSrP8=; b=KrvpydeYxK4orp1I1YucKaN1/o
	GD4WsZGXkSjUkMZTvbpYss1fc8RiFDIqRZIzEPSSjmS82oGpiEfEkuulM7aIbdBgwycihCwcbJtYO
	AC/w0PJsmTQUhTOJQ+WPAJZFuKCNcASoBi34bl027BPKhGfAE+6PwoewXbu6i73hhnyUcamvrf1mZ
	QiGFeSx/fITp9uW/YX93lZGn4mAOoq8YmIhbbE6GeRo1OfchqqTp0Ol74r5n3PtRG1Vuut2NjzAGa
	aILVp+wVv1wGD56t08FuVnmx+T7ckwRjr3zYLrv0Fwwm7969ywXo8GJAhbq166u7gOdk1umxr+g1K
	ZJeyJZSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3inq-0000000Fxlt-22uw;
	Wed, 23 Oct 2024 21:22:02 +0000
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3ine-0000000Fxkl-2S8w
	for linux-nvme@lists.infradead.org;
	Wed, 23 Oct 2024 21:21:52 +0000
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-208cf673b8dso1534415ad.3
        for <linux-nvme@lists.infradead.org>; Wed, 23 Oct 2024 14:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1729718508; x=1730323308; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CT5XeBQQaf5gpeKwKyp9KwMrZzTbNucisPSnXJGSrP8=;
        b=ROtHwNIODgEm1JVzTJ3P13eZigl3rQjiiVBU1SnWGtjDetb10IJUVgTbq/UOHmJ0XV
         9Z7DWpTkkpdd1qC+HS6D0+g7TVVkMpDv58bWCC+0zC8jxLZGxZ83RPyELBBJoC29qDSy
         7zAvS116IXQtxEsqNxuHeSr7CetrQBhhglZe6gHzj14cdlh+X0HE+9n8Imm4oBCT51g2
         HazsPlPj9/+HhYjYTh/4EXsdESJ1EjJ405wHAoGDTNwwOgnX9w/7X106oei7SNVJE4Dd
         0V88ljfnF0HHNItGdo4m18zPCNCOSZnTYzYs6J6OQh/AMcD289mYsqjewtwuMY0YGrm3
         uvgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729718508; x=1730323308;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CT5XeBQQaf5gpeKwKyp9KwMrZzTbNucisPSnXJGSrP8=;
        b=Q20eL9BQ7V2YrntacNMEHK/2ptdhE5S6o7bb6ZqNFGmbNM/nHsoK9whPdEHSrPkfOM
         nHRVzVYWxi03UZif7wJyodo3UvR+0QBjXBKP0y3yZ8wilFo2RkKAqhgumLdptbY9qU7W
         0vjMqniFfEYMMYSsAeiYUIBTeuU01blwYY2kMykA6xOKtSh3aQmfMCB1ombpkLMK1TrI
         d47Wm0CK3EKaNBr6SBlpjsnhnvuX6BieeZIn3Vtqtb6aqfeTyOCgsTkPhVDJhATPxw5t
         JaLCTVtjlqAGY7x1u8I99KKoeB3hjEM7oDLTyIRUEpT6TedTloTelVDS8gGy5d2wQAtA
         MoTA==
X-Forwarded-Encrypted: i=1; AJvYcCUxB9SmZZWkLi7C02/8B9gBdVpONYD+ziFyMqczQyhA0HQXDcwgBsugLjzdCdCwPHDsfvZDZmBeHjBR@lists.infradead.org
X-Gm-Message-State: AOJu0YwGL3FabmeJxjC6qkPFvVl40uWAywmQik6v7jXtGwynxTvo1bbX
	FsVC5LhbkY1ZFiOS0AzkQzKVhI+4/Id8Q3Hu6xtXbOOyJj3c6LXjzqa2IAfDscPWsuEkXPlxxGC
	ITZM=
X-Google-Smtp-Source: AGHT+IGU7eNiMeBQEUWbrmiNNf4xhQtd6CuqS4Xvqerw5enb1JdlQ55FfBx8KNH/EAZLarwIN69giw==
X-Received: by 2002:a17:903:1cf:b0:20c:9c09:8280 with SMTP id d9443c01a7336-20fab2db962mr59276545ad.54.1729718508649;
        Wed, 23 Oct 2024 14:21:48 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1256:1:80c:c984:f4f1:951f? ([2620:10d:c090:500::6:ae7e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0f65cbsm61724465ad.273.2024.10.23.14.21.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 14:21:48 -0700 (PDT)
Message-ID: <3e97f4e9-e657-42f4-aaa0-a7200bedfe03@davidwei.uk>
Date: Wed, 23 Oct 2024 14:21:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: module parameter to disable pi checks
Content-Language: en-GB
To: Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Keith Busch <kbusch@meta.com>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "joshi.k@samsung.com" <joshi.k@samsung.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>
References: <20241023155048.634988-1-kbusch@meta.com>
 <cb19f610-b6b3-4dde-9d1a-88446dc0615f@nvidia.com>
 <Zxla500xnmoKVrpB@kbusch-mbp>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <Zxla500xnmoKVrpB@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241023_142150_995133_F42CA504 
X-CRM114-Status: GOOD (  10.43  )
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

On 2024-10-23 13:21, Keith Busch wrote:
> On Wed, Oct 23, 2024 at 08:01:43PM +0000, Chaitanya Kulkarni wrote:
>> @@ -1774,9 +1773,9 @@ static bool nvme_init_integrity(struct 
>> nvme_ns_head *head,
>>                  return nvme_ns_has_pi(head);
>>
>>          if (disable_pi)
>> -               pi_type = 0;
>> +               goto out;
> 
> I'm not against 'goto' in principle, but I try to restrict it to
> unwinding an error, and this isn't an error. I know, personal preference
> and all...

Agreed. This is more unreadable and a modern compiler will most likely
do the right thing anyway.

