Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E2A6C47422
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jan 2024 17:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HLcu/boAZYyJQLYT+m7wrWheub7FYhYbkhG1JYhS+fk=; b=xaFwwDfvCY93XxID7dQm2xYlJ2
	FG86YdYn9C+pmymy+AM5/VdfsCniHnZicDnPB3GZhGD+B7FzvlggMtEwEKmkqytZiplRdk7Z6rpWk
	6qnp3YZOy/+TG0PVfEVy7Q4LC6azeAXQxKz8XCaHfEeXKw9SxZwr3E9iR5X+ltMpfCW6EObhvC18n
	4LaUgUpMF4sA2212gQVjpE3E8vkdbkHS5Z3n53CRn9BUdtMTipx0zOO/SVqVl+KWhWbHSd9HqRfe/
	imH3w6PeDMzJl41IedciVgvILV9mQAXP1IK6Z/zXFxVpLI/fr1VbXFnVHHNvbONHmM5JLf76kEZ1B
	eAKzRzng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQ9qX-000FE1-2P;
	Wed, 17 Jan 2024 17:37:01 +0000
Received: from mail-pf1-f170.google.com ([209.85.210.170])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQ9qU-000FCX-3C
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jan 2024 17:37:00 +0000
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6dad22e13dcso7261031b3a.3
        for <linux-nvme@lists.infradead.org>; Wed, 17 Jan 2024 09:36:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705513016; x=1706117816;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HLcu/boAZYyJQLYT+m7wrWheub7FYhYbkhG1JYhS+fk=;
        b=mMKb0T8x0EznXWuXkmRgM7OvsVPK/64/DpaCo/tDqeS7tbQT86nJWAetQRUrl5fmNf
         LYTNTxpXHPywn1I5sZ4zVa7K9X1mzzSUZd6hm87hph94UJlN2+CdZTx2iwoPJkh6enzP
         J/B5R6hvPYdoZl1AEeJXf7p95ji8k3kuSswdWY8qD7PsGqguSaaEnAGP2f0da1WqdGkb
         LbcdHDF+HNEgyC3mfD5Ot0BGhaDi8j6V7vIsf/F7PJeJxt0YTnPpvGPidFkrKJ9FGu31
         3SpweAvmWgoHdHpBA2Gbrt1rNjFTblXX7wtij+aNAVryixfc9ldS6H2OFCDK77AoynNQ
         Cz0Q==
X-Gm-Message-State: AOJu0YwLqlai5uXp0dt6pPQX3XrC7gCOtfQAGsRBk86EMSIKSnuAlSIJ
	k6eZsGkBwsN2E5Efl69hDvc=
X-Google-Smtp-Source: AGHT+IHI9/Ofhg6vM6YAfEYG7xK18CTwCIfRXr/qD5ZaProbRjtw16y9FIupDIFf8JVEce1mLFyazg==
X-Received: by 2002:a05:6a20:439e:b0:19a:9655:49fa with SMTP id i30-20020a056a20439e00b0019a965549famr5691111pzl.84.1705513016241;
        Wed, 17 Jan 2024 09:36:56 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:5421:8f53:45a:4e37? ([2620:0:1000:8411:5421:8f53:45a:4e37])
        by smtp.gmail.com with ESMTPSA id fi21-20020a056a00399500b006d0d90edd2csm1698751pfb.42.2024.01.17.09.36.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 09:36:54 -0800 (PST)
Message-ID: <43cc2e4c-1dce-40ab-b4dc-1aadbeb65371@acm.org>
Date: Wed, 17 Jan 2024 09:36:52 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Improving Zoned Storage Support
Content-Language: en-US
To: Damien Le Moal <dlemoal@kernel.org>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>
References: <5b3e6a01-1039-4b68-8f02-386f3cc9ddd1@acm.org>
 <cc6999c2-2d53-4340-8e2b-c50cae1e5c3a@kernel.org>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <cc6999c2-2d53-4340-8e2b-c50cae1e5c3a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240117_093659_056435_C1BC945B 
X-CRM114-Status: GOOD (  12.78  )
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

On 1/16/24 15:34, Damien Le Moal wrote:
> FYI, I am about to post 20-something patches that completely remove zone write
> locking and replace it with "zone write plugging". That is done above the IO
> scheduler and also provides zone append emulation for drives that ask for it.
> 
> With this change:
>   - Zone append emulation is moved to the block layer, as a generic
> implementation. sd and dm zone append emulation code is removed.
>   - Any scheduler can be used, including "none". mq-deadline zone block device
> special support is removed.
>   - Overall, a lot less code (the series removes more code than it adds).
>   - Reordering problems such as due to IO priority is resolved as well.
> 
> This will need a lot of testing, which we are working on. But your help with
> testing on UFS devices will be appreciated as well.

When posting this patch series, please include performance results
(IOPS) for a zoned null_blk device instance. mq-deadline doesn't support
more than 200 K IOPS, which is less than what UFS devices support. I
hope that this performance bottleneck will be solved with the new
approach.

Thank you,

Bart.


