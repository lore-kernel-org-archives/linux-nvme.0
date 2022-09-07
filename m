Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30AEFC38145
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Sep 2022 15:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wdxkeHabC29y5AfIfcjoOgzOsAWMffB0uGCrc134Hfc=; b=s3lXS9qHfy2oHYG9UKnBwrPu9N
	AHJOpxkCjbVp+Pc48WL6D0CWRUHQFTBaVX8cot0cKTzM0HUgqqSEKuCPET1b90DLnGPFnLKqXVe/D
	NQcIybAK7Fxzgoo+oPp8ManIekn53XZmzzb+h0/bPnPxLQ0DoQPhLXPK3xdsCDuDt19umnTKvJTeH
	61Gowae93kz6DHit6ljZZbY/v09BLkKyPW+r9TwHbPDdncdGBO3jBUq+BEd8msOdFIqhcHB0Iyq++
	O3Q8bknXxliU68oHwGMRw0tPLeNQP1tO1+9DhWZ3X+pJJZWPiTZMd7Acpxul3/95IkgQZ0Qa3hh9b
	lAnR/QzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVwmk-007Gw6-Q1; Wed, 07 Sep 2022 15:16:14 +0000
Received: from mail-wr1-f52.google.com ([209.85.221.52])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVwmg-007GuS-RW
	for linux-nvme@lists.infradead.org; Wed, 07 Sep 2022 15:16:12 +0000
Received: by mail-wr1-f52.google.com with SMTP id e16so1637375wrx.7
        for <linux-nvme@lists.infradead.org>; Wed, 07 Sep 2022 08:16:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=wdxkeHabC29y5AfIfcjoOgzOsAWMffB0uGCrc134Hfc=;
        b=GnX79WzJRmAo8YQKsePAcmxRs2z5JEacXa7Cw3vCa73cqZx4uVwP8+2jOkJtZUr1DA
         JGOK0nk6eWOdbfH1Y+1qNcsRv8K/hq9HshSLEERN8f8QPb8ZOLu7fNPTMrXjjHl7O5ep
         GqmoQ4if9J43gtkPm1iao7wepKCrCDptBohm6cVSO+7mnxxS9xUbLBJ4Yz+9Gdr1MPQj
         z+Von8um8bk6Q3VGKd+kmQDES5v3T1fJfNBk3JGmScmqW7eZDA2zX6D7kWkP8CsDxHZr
         37LEmqpFyi612ZJrznxE5FZNfO/XaKtVVVC9ct22gapnzxp0V8fXIC7s7ZCTGQBmoESn
         uKiQ==
X-Gm-Message-State: ACgBeo1lhUiTa8UoWL8OfimWlxexsdo72QQPpcjKNswbMi131VpaIbUG
	2zNkjLqQJAi36P6CJegXswU=
X-Google-Smtp-Source: AA6agR7di1Q19WYP57o0sDLPEfWUEB8+RzbUcBjs2uJRQTZXVH5M8Hy0Y9DjfCZN74IqRAE8kFU1Xw==
X-Received: by 2002:a05:6000:696:b0:226:f89d:55b2 with SMTP id bo22-20020a056000069600b00226f89d55b2mr2443264wrb.133.1662563769184;
        Wed, 07 Sep 2022 08:16:09 -0700 (PDT)
Received: from [192.168.64.104] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id i4-20020a05600c354400b003a2f6367049sm21582801wmq.48.2022.09.07.08.16.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 08:16:08 -0700 (PDT)
Message-ID: <ac268c86-c013-5cc5-5e1c-71ee90111d8f@grimberg.me>
Date: Wed, 7 Sep 2022 18:16:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH rdma-next 4/4] nvme-rdma: add more error details when a QP
 moves to an error state
Content-Language: en-US
To: Leon Romanovsky <leon@kernel.org>
Cc: Patrisious Haddad <phaddad@nvidia.com>, Christoph Hellwig <hch@lst.de>,
 Israel Rukshin <israelr@nvidia.com>,
 Linux-nvme <linux-nvme@lists.infradead.org>, linux-rdma@vger.kernel.org,
 Michael Guralnik <michaelgur@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
 Max Gurtovoy <mgurtovoy@nvidia.com>
References: <20220907113800.22182-1-phaddad@nvidia.com>
 <20220907113800.22182-5-phaddad@nvidia.com>
 <facc31c4-955e-c82e-191b-150313e73f6a@grimberg.me> <YxiTxJvDWPaB9iMf@unreal>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <YxiTxJvDWPaB9iMf@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220907_081610_919426_DE05D636 
X-CRM114-Status: GOOD (  11.24  )
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


>>> From: Israel Rukshin <israelr@nvidia.com>
>>>
>>> Add debug prints for fatal QP events that are helpful for finding the
>>> root cause of the errors. The ib_get_qp_err_syndrome is called at
>>> a work queue since the QP event callback is running on an
>>> interrupt context that can't sleep.
>>>
>>> Signed-off-by: Israel Rukshin <israelr@nvidia.com>
>>> Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>>> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
>>
>> What makes nvme-rdma special here? Why do you get this in
>> nvme-rdma and not srp/iser/nfs-rdma/rds/smc/ipoib etc?
>>
>> This entire code needs to move to the rdma core instead
>> of being leaked to ulps.
> 
> We can move, but you will lose connection between queue number,
> caller and error itself.

That still doesn't explain why nvme-rdma is special.

In any event, the ulp can log the qpn so the context can be interrogated
if that is important.

