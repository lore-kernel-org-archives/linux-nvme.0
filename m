Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FF40C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Nov 2021 10:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mlvFCudBDDu4YospvZDyBBFicK4mqn9GnSHtHY0Zzc8=; b=xc+OVV2jO4EkX7w401dtACFM11
	ye33fTJ1BG+fcLW000yuETGkCZ1bxXokcx+P0FmITmEODrEbDLj2LA2qRfRlqCfvyFlqSrPbOUzOc
	tip3CGgrwG905Mphy1yCPRFHhg/fHO0vXM9o2ooHUC5PNQaz432krZOO+NiyjFDaBDsHpUMd4I9yk
	lwDN7Z+kvMuHUfRIVWigrDzGoTjvIbQnnFNNeIQ2vg9I150usFdC+waekSZpIDlfAGzbJc37t4P6P
	PxFDmrkGas2nrKHSFnqARQIMP/Wj6mG1M1wSQAB1lZ5YlWpyKzYCdflaSL0Wsg8UueqeAcwY0n02T
	tC+gFV3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mp6Dc-00FlSD-Ls; Mon, 22 Nov 2021 10:06:36 +0000
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mp5ss-00FfIU-Ru
 for linux-nvme@lists.infradead.org; Mon, 22 Nov 2021 09:45:12 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 f7-20020a1c1f07000000b0032ee11917ceso13089663wmf.0
 for <linux-nvme@lists.infradead.org>; Mon, 22 Nov 2021 01:45:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mlvFCudBDDu4YospvZDyBBFicK4mqn9GnSHtHY0Zzc8=;
 b=1juzTI77ZvzuEKUQ524WCdZ+Ewpnh4MFbPSp4w8I25u1IkHM3bUr6hHd1mNWWhozVD
 7ZoZW2XT9zA/AdC3XZADMiWBBLQjMou/JBtSM3fNjd/GULf+1i+h7UnCA63ymtQF5pfl
 RBVZVWO2gankrosd81/BLmUPSPe9vojf9GUhO0YuejFayQQpUEduLjuRSQYws1SMHKdV
 chBUT2zHibbE5C84WGnl6EJT7MdQVyWhc4cJfpo5M/n3pTjZS8J/xFtGJv/Pg43sdm1h
 bLqq+yCAAm2cFTJTsVvK5vwS3JQC8tRlTAA/6nJD1EtBxraanXR9nXf2EiTOKyXvaC//
 d+8Q==
X-Gm-Message-State: AOAM532VbN8MPLLbh0qF1ahQmiKUqGPYs1qdczs3gCcDI2Ual6jFRZT+
 EGJ987Ke3WD5u4508dLfb9Lk8t6O7dk=
X-Google-Smtp-Source: ABdhPJy9385eh3LTpuw4Sqg+/WoGaZM9wDj6w6iTJlsstHWnY3GqCpKV8q1B/vncKEsN5yx+c5r/Lw==
X-Received: by 2002:a05:600c:4f87:: with SMTP id
 n7mr27154114wmq.168.1637574308656; 
 Mon, 22 Nov 2021 01:45:08 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id q26sm8545888wrc.39.2021.11.22.01.45.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Nov 2021 01:45:08 -0800 (PST)
Subject: Re: [PATCH 6/9] nvme/041: test different key types
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 Omar Sandoval <osandov@fb.com>, linux-nvme@lists.infradead.org
References: <20211122075524.26207-1-hare@suse.de>
 <20211122075524.26207-7-hare@suse.de>
 <96c61139-5206-dad1-6157-d8dab1f314c1@grimberg.me>
 <ff74b9cd-04a1-bc37-14f2-dd40823fa73c@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <b10edc32-6f2c-7683-8ad9-3bb48d6b3e20@grimberg.me>
Date: Mon, 22 Nov 2021 11:45:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <ff74b9cd-04a1-bc37-14f2-dd40823fa73c@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211122_014510_955285_DC2558BC 
X-CRM114-Status: GOOD (  12.44  )
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


>>> +test() {
>>> +    local port
>>> +    local genctr
>>> +    local subsys="blktests-subsystem-"
>>> +    local hostid="$(uuidgen)"
>>> +    local hostnqn="nqn.2014-08.org.nvmexpress:uuid:${hostid}"
>>> +    local scratch="/tmp/blktest-ns1.img"
>>> +    local nvme_trtype="tcp"
>>> +    local hostkey
>>> +
>>> +    echo "Running ${TEST_NAME}"
>>> +
>>> +    hostkey="$(nvme gen-dhchap-key -n ${subsys}1 2> /dev/null)"
>>> +    if [ $? -ne 0 ] ; then
>>> +        echo "nvme gen-dhchap-key command missing"
>>> +        return 1
>>> +    fi
>>
>> Don't we want to test different secret formats?
> 
> We do.
> But this is just a check if the nvme cli contains functionality for
> generating keys in the first place.
> 
> Maybe we should make this a requirement (like
> _requre_nvme_trtype_is_fabrics).

Absolutely.

