Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 942B9C7EE24
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jun 2023 23:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y8zPGauo5IGjlOWoNI867DR+5xDWdnkel73bVvbsYF4=; b=4ScWRqcKcVJUwlJM4fKXClBlgc
	AdJkFiY6w8gJkFTZNU2OEu21spUpQK1aTvqkpXkawnyw9QRfL1t5GnaKjFbTaNygZfc55W4WuCm1L
	TpQV2lwyK4GiCOEAOSX8/cNYxTaCmmp4XwkGjSFcxv29rnaax2VaZ+W2tQKUCM3pVLuuXj8N+YB2R
	vapZ602SpE0EfNRhcl41XfhLEplvBmjTtj2Sxk2nlZu3wsJhSY7GqicfJcwuBuFHBIarjHLHZPfuq
	JZni9OxpcNGYWldG1NW13C0hD2siEXeRS8YSJAGSgvyyev/IhSlbEJy4fvbRNS23Ji/Af1WkLaYzx
	lfm528kQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6JSn-00H7bi-20;
	Mon, 05 Jun 2023 23:18:13 +0000
Received: from mail-lf1-f41.google.com ([209.85.167.41])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6JSk-00H7ao-1k
	for linux-nvme@lists.infradead.org;
	Mon, 05 Jun 2023 23:18:11 +0000
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-4f13c41c957so482869e87.1
        for <linux-nvme@lists.infradead.org>; Mon, 05 Jun 2023 16:18:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686007089; x=1688599089;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y8zPGauo5IGjlOWoNI867DR+5xDWdnkel73bVvbsYF4=;
        b=gb5tyX/f2hUSkTaWKqV98NkxYnxjLSH7th/E3iqwN2ORlbk5wpwI9Ll0f6YlwwgY5+
         EAti0XmHok6PYJNx7bM8bLZMMscN6/L2oEjIgCxBPSfEC3NHEtp/Cx1imQRZ9xmvswIb
         HuEeusUV4mCTISuz5fBH7lPS3dHjU+LNRbVemUHfA9PSH8AFthSZby/EOoj5aWBcbLWI
         Po/UiysIVdic2Ge2k54tF6dEoLsaPUmYKi/RGWwV4EogMW20PHDINJLJ0nD7T+4ZeioN
         UOntQfByqUTXBlR9Sz8l5CMbSVy5LbLI13xI0xWBhJ2GSnv8EB+/c/diIis+3BFpE9pb
         UPKg==
X-Gm-Message-State: AC+VfDxAuH97Uxkcmy9k3uYiu2qnDCdY7118EniLenhBXEbQIEbq73xc
	n3+zcrdm6hbr0CjdEyUnNaI=
X-Google-Smtp-Source: ACHHUZ7tOjpGDR3uN2PYKuKb/jOyQ8HhYJZo5JSdlYn6jaDtFqS3lf+BuCv5YljQjhIP1bN6l2BhfQ==
X-Received: by 2002:a05:6512:4c1:b0:4f6:2246:aac4 with SMTP id w1-20020a05651204c100b004f62246aac4mr137014lfq.6.1686007088908;
        Mon, 05 Jun 2023 16:18:08 -0700 (PDT)
Received: from [10.100.102.14] (46-117-190-200.bb.netvision.net.il. [46.117.190.200])
        by smtp.gmail.com with ESMTPSA id a26-20020a056512021a00b004f60be0c685sm1264785lfo.123.2023.06.05.16.18.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 16:18:08 -0700 (PDT)
Message-ID: <446c46d8-fbc7-ecd2-8efa-1c9497e16851@grimberg.me>
Date: Tue, 6 Jun 2023 02:18:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH blktests] nvme/{016,017}: use _check_genctr instead of
 _filter_discovery
Content-Language: en-US
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Yang Xu <xuyang2018.jy@fujitsu.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <1685495221-4598-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <6fbgjc5ykve3jyko4vlzudrnwueou4ehgn6n2dtihjko3qv7ww@sqlyuxx4ijt5>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <6fbgjc5ykve3jyko4vlzudrnwueou4ehgn6n2dtihjko3qv7ww@sqlyuxx4ijt5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230605_161810_596637_FAFE77A3 
X-CRM114-Status: GOOD (  10.94  )
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


> On May 31, 2023 / 09:07, Yang Xu wrote:
>> Since commit 328943e3 ("Update tests for discovery log page changes"),
>> blktests also include the discovery subsystem itself. But it
>> will lead these cases fails on older nvme-cli system.
> 
> Thanks for this report. What is the nvme-cli version with the issue?
> 
>>
>> To avoid this, like nvme/002, use _check_genctr to check instead of
>> comparing many discovery Log Entry output.
>>
>> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> 
> The change looks fine to me, but I'd wait for comments by nvme developers.

I'm ok with this change, but IIRC Chaitanya wanted that we keep checking
the full log-page output...

