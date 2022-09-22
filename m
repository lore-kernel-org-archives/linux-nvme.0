Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E146C54EE9
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Sep 2022 15:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PNVneBBqEW38yX5fcY6SLx7yePp2eIuxdPyzjx6R/N4=; b=KhE0/+DL4aOOrxv0swfqI/PXvX
	dlqL/WktD4Nzq/+LJY38kyP9jIM2R/k8q6e8QX/m23li+UCGRLgOf+VIstgBUrdFtK2j81HmRfJqS
	aLFz53KqUbzsswAP3vqBjU/lQPcW1LVUDKVqyfg2Nxg5WBantz2xpwH0875BopGpPo/x65mLj7Row
	7V1u/bS0C/SfsFl3lsqXKRppQKs020MJ4ulJ87vFEcVpTgfXVizUAe6wBYZ8cmNqjy71oN20O/HJR
	kFhpNBfwbqnLg+XmTOR3IO89mx1MKARcqZElxyZtmGD3k+oA+YwYCmVSVEw0gOwqS4C/hSVMPJMDo
	pP+GPEDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obNtK-00GLFs-9E; Thu, 22 Sep 2022 15:13:30 +0000
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obNlV-00GH9D-SN
	for linux-nvme@lists.infradead.org; Thu, 22 Sep 2022 15:05:27 +0000
Received: by mail-pg1-x52a.google.com with SMTP id 78so9376898pgb.13
        for <linux-nvme@lists.infradead.org>; Thu, 22 Sep 2022 08:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=PNVneBBqEW38yX5fcY6SLx7yePp2eIuxdPyzjx6R/N4=;
        b=ZCPklyMg7mzEAENCa1rIDHzphe6dj33KHEdatchLw/7sUQkCf8HdAYxHya3IuYZ5Wp
         jqWX/6i/xM6hJgljEYTiRzjVUZ913D+8/cME4XjMUAFUfHLb01havjDphw1kTqPWY2V+
         /bsr2KOqYmlXOkEAhwRrWwVntwdTIIPsdbPzmyCC24T2qOuPYzZD8h2Ou/rWPTBZ5RCT
         qP1jm3854G+SKE/V8DidsYUtxjMmWEeHenc6E0gQVOmG/qywLDQGBrd40/McCyF/l5a+
         aXzyZ5gheIb7iA9w2id8U5VNEMZcg9RZrqPQT8iCitLG5RgAsPdefDFoFVmxyw/HOY6F
         9tDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=PNVneBBqEW38yX5fcY6SLx7yePp2eIuxdPyzjx6R/N4=;
        b=bh65bLhEZaMq/H5RprbfvDUzeg1VV4eEIZYKztMXZPqLA+WuL67F/VkdJwSpikB6F4
         FthZmG/tfKKC44wRh+sctbRFN8LJOb10+lcoJ2yRAJzN1rFAFlzQK+Ob1ZvcQB6A74kg
         0fA4flgIvAQ4fjvnaZU5rugMXuY6YxT6UIjmchVPMHOiatybKl6lUzVQBtsJOq81fs8/
         WGcZZeYB18iWORlxsiE2E1I7OEdehWkG7mIf+/X9ln/YZvBsOMWaugbDH2UqS7sSnqXV
         8MuK66JcvHSrhnV5GXzbuKNb/pkmcxLDMhHJVOMIKyU04Loe2p7Gefhj8fXJsgzaMuXj
         5HtA==
X-Gm-Message-State: ACrzQf3k7Ej0HpGCpYiqLizUrEvC0OuneUGWlYpS3+YntCTCY4Y8YMmQ
	DVLP0/wi89czKyviryEhBps=
X-Google-Smtp-Source: AMsMyM6fiEVNTQK1PlpHl+2Gq8QM6Bc+pI67grmQl5BHCT+I8G746BXQMHD4Mu8HrjTtv83QHPAL6A==
X-Received: by 2002:a63:6a48:0:b0:43a:18ce:4e08 with SMTP id f69-20020a636a48000000b0043a18ce4e08mr3498838pgc.432.1663859122691;
        Thu, 22 Sep 2022 08:05:22 -0700 (PDT)
Received: from [192.168.50.208] (ip98-164-255-77.oc.oc.cox.net. [98.164.255.77])
        by smtp.gmail.com with ESMTPSA id w19-20020aa79553000000b00540fee4a680sm4494312pfq.41.2022.09.22.08.05.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 08:05:22 -0700 (PDT)
Message-ID: <19349afa-c8fb-1765-364c-3928b7ff2c4a@gmail.com>
Date: Thu, 22 Sep 2022 08:05:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2 1/2] nvme: enumerate controller flags
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>,
 James Smart <james.smart@broadcom.com>
References: <20220922081538.13364-1-sagi@grimberg.me>
 <20220922081538.13364-2-sagi@grimberg.me>
Content-Language: en-US
From: James Smart <jsmart2021@gmail.com>
In-Reply-To: <20220922081538.13364-2-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220922_080526_025407_CDF27924 
X-CRM114-Status: GOOD (  11.22  )
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

On 9/22/2022 1:15 AM, Sagi Grimberg wrote:
> We expect to grow a few of these flags for various purposes
> so make them a proper enumeration.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/host/nvme.h | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 

Reviewed-by: James Smart <jsmart2021@gmail.com>

-- james


