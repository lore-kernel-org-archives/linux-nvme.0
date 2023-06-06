Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91755C77B7A
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Jun 2023 06:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6ykdUDEsPsbdvXzXMVfKKjWXS0D8trIGOxCsakNyee0=; b=F2YdI9aDp6T2yDvMw9tpPkH4Oa
	Gds8nKLcB30Q1EvyvXajCeGbcDZL1Epvom7fLhKmRkbPPnI9677UpdcE3EFAolByeOKjUN3E6bwlZ
	XZwzOD9kEaZ/WthAcUTG2kJpGMvVraVM54ZuXa5UgJhWKHEEm4YgboX6NG8HIIb11WM32XkJ7fw8a
	8xJro81i0js3flGCHCH4tKyWq9246WJMcY/I7ASipWXipvlyLpl+COKv23qpZT4FVH2EFlUgD7CZB
	bSjWa087QBRSkrF8BLL77MSrzXcXp/bM98Bwvaz3n4dzqwjuXx7f1z1JrM95m5q7FOfc0ffJNMCOW
	JAzvtOiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6QRp-000Pvp-1D;
	Tue, 06 Jun 2023 06:45:41 +0000
Received: from mail-wm1-f45.google.com ([209.85.128.45])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6QRk-000PuR-23
	for linux-nvme@lists.infradead.org;
	Tue, 06 Jun 2023 06:45:37 +0000
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-3f7364c2ed8so5489485e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 05 Jun 2023 23:45:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686033934; x=1688625934;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6ykdUDEsPsbdvXzXMVfKKjWXS0D8trIGOxCsakNyee0=;
        b=goz64qBw95Sjgf+HmMEsDNkoI6sDt3Gi4ZKwjGhBbZAFriovnm1GDTVtWP41sKdMeX
         xxzlGiZl89Cp/vnfzHUXFLvKrDxlZnyTTizpmc2+T1rp9iMgX9qC7JUjIW8rPVsIzL0n
         Ju0anu0V3cNpE/iwuoOWxCwfDaDu62uJ+yb+Pqbx+FAWU3WRyClq+4VkjhvO+1TFuKe+
         tibTOlV5NMp5fi1GM9sZW1WWi+tCAQub5IAmGw6J+uzUTAVTVvzGVjjgHvjx9uHUVa0E
         3q3Elz59af/7bZpvjzaV1q8CWuQ5lH0FWA+eABKb0RA0WL8niPKY7qtiCS+Lb2A81+5E
         aneA==
X-Gm-Message-State: AC+VfDz5UAnkqpBsSLy8ZyL6eZNXbZQy5hbST7ceLq7ic5mEGGQLNNw/
	1Tf2LRh3/UnEESWjGbmtVIq+IcN5Kec=
X-Google-Smtp-Source: ACHHUZ4AIZ31+XwAvtHDKg/howeFqJ8dJ8R9XuUcJjYvbLutbnBHTWtN3eteTsrZ19vYo8IJPG/mcQ==
X-Received: by 2002:a05:600c:1c89:b0:3f6:335:d8e1 with SMTP id k9-20020a05600c1c8900b003f60335d8e1mr1296776wms.2.1686033934420;
        Mon, 05 Jun 2023 23:45:34 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id u12-20020a05600c00cc00b003f7678a07c4sm6195601wmm.29.2023.06.05.23.45.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 23:45:34 -0700 (PDT)
Message-ID: <18855542-e07b-70c0-ccd9-2fa0f0d2df86@grimberg.me>
Date: Tue, 6 Jun 2023 09:45:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH blktests] nvme/{016,017}: use _check_genctr instead of
 _filter_discovery
Content-Language: en-US
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Yang Xu <xuyang2018.jy@fujitsu.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <1685495221-4598-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <6fbgjc5ykve3jyko4vlzudrnwueou4ehgn6n2dtihjko3qv7ww@sqlyuxx4ijt5>
 <446c46d8-fbc7-ecd2-8efa-1c9497e16851@grimberg.me>
 <eadb2514-f06d-7cb2-2cdb-04a6226edac8@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <eadb2514-f06d-7cb2-2cdb-04a6226edac8@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230605_234536_680392_D0234B22 
X-CRM114-Status: GOOD (  13.53  )
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


>>> On May 31, 2023 / 09:07, Yang Xu wrote:
>>>> Since commit 328943e3 ("Update tests for discovery log page changes"),
>>>> blktests also include the discovery subsystem itself. But it
>>>> will lead these cases fails on older nvme-cli system.
>>>
>>> Thanks for this report. What is the nvme-cli version with the issue?
>>>
>>>>
>>>> To avoid this, like nvme/002, use _check_genctr to check instead of
>>>> comparing many discovery Log Entry output.
>>>>
>>>> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
>>>
>>> The change looks fine to me, but I'd wait for comments by nvme
>>> developers.
>>
>> I'm ok with this change, but IIRC Chaitanya wanted that we keep checking
>> the full log-page output...
> 
> the original testcase was designed to validate the log page internals
> and  that correctness cannot be established without looking into the log
> page.
> 
> but given that how much churn this is generating eveytime something
> changes in nvme-cli or in kernel implementation I'm really wondering is
> that worth everyone's time ?
> 
> Sagi/Shinichiro any thoughts ?

Also back then I thought it'd create churn because the log page output
is not an interface.

