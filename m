Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B316C433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Dec 2021 13:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HNUhPRn/ZPuPfoffB9A5rv9TN1OT/debqEkzcu6buok=; b=DpzYYrGnncrzjaq0nPcEZX7dzT
	kZFfd7UEqq+YCF6xfRK5FuRTvU9Cdp5dqcO3PbWxVxyoxOr0uqxDDb1HJIU04oxScZmf5vE62IYlK
	zuCBFRowoEk6zVwojjqu+AdpyXb5qoV2IGJvzD752JlN2gQRWqrTreYLrddHALieEe6XMO1wyL+wr
	vJGu/4RRpG7VmCati8YxmHurmxg/6JXrrogqAmqo8VHf4DTgP618/BLmlVsXAsrTwfA/a/FUv0+lU
	CpQg96dJbIVOl4O7cBGfe2igUr4b8gUMe/dLYqLUS81FHD5HcgCIJLA0zfdK45EC1NghE4Sm3oDjI
	Hnl7SiTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1muwho-00CgK7-0T; Wed, 08 Dec 2021 13:09:56 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1muwhc-00CgHM-6A
 for linux-nvme@lists.infradead.org; Wed, 08 Dec 2021 13:09:49 +0000
Received: by mail-wr1-f46.google.com with SMTP id u17so4033197wrt.3
 for <linux-nvme@lists.infradead.org>; Wed, 08 Dec 2021 05:09:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HNUhPRn/ZPuPfoffB9A5rv9TN1OT/debqEkzcu6buok=;
 b=xThDznmulaEgknPb/LeAyMrls0kdeUB+BMZALnLZvs8xj6W7SygDm8SiRTDcebtXgl
 t4rATHBodMFHDCRLGV0h7DSvgkO61UK9o9G681Y6g8lyluoTBoWdzGNFrJ0D30duNWhT
 gFgRB0xjQ2cp1odr4vHre8efm1rezUxzzalAeglOtNVE6AZaaSGb0NH8uhtXF4R9Kzhh
 uevQJ8pmtL7/kR+C6dxGk8MG+8tmTda94rkSF3TfzE4OYzJqMW2WoBBfUEV6qkKjMkub
 DYcG4lzC3L8AzUdHB8mMDU3qMoJWw7iu+iJzsINQfr3LWNBH+ja+/KybbmRK0gKnsgBZ
 whsQ==
X-Gm-Message-State: AOAM530+V63hm+V/rKa3JlTOVjb7lafYYxPpo68EnsK4XZxQo6qiwMpe
 2QKTZemmTLyc7v1VBw5eMPRIBLKN1LM=
X-Google-Smtp-Source: ABdhPJy9+opls628m+P5gjUtu0TgEAAUa8KjcNIQTDF+uSQOf4V1mfT96l1I/R9ThIF/b01t+VAcrA==
X-Received: by 2002:adf:e84d:: with SMTP id d13mr59074021wrn.72.1638968982042; 
 Wed, 08 Dec 2021 05:09:42 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id f13sm3358077wmq.29.2021.12.08.05.09.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Dec 2021 05:09:41 -0800 (PST)
Subject: Re: [PATCH 09/10] nvme/042: test bi-directional authentication
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 Omar Sandoval <osandov@fb.com>, linux-nvme@lists.infradead.org
References: <20211123074940.113390-1-hare@suse.de>
 <20211123074940.113390-10-hare@suse.de>
 <ffe973a1-1856-e2e7-9695-cb2ce532de3b@grimberg.me>
 <ebae81ae-94d8-6044-1492-cc856a476290@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <17b0e7fa-317a-fbd5-6a04-2a76e3c7f88c@grimberg.me>
Date: Wed, 8 Dec 2021 15:09:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <ebae81ae-94d8-6044-1492-cc856a476290@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211208_050944_263558_AA6B0D92 
X-CRM114-Status: GOOD (  18.67  )
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



On 11/28/21 7:34 PM, Hannes Reinecke wrote:
> On 11/28/21 2:36 PM, Sagi Grimberg wrote:
>>
>>
>> On 11/23/21 9:49 AM, Hannes Reinecke wrote:
>>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>>> ---
>>>   tests/nvme/042     | 107 +++++++++++++++++++++++++++++++++++++++++++++
>>>   tests/nvme/042.out |   8 ++++
>>>   2 files changed, 115 insertions(+)
>>>   create mode 100644 tests/nvme/042
>>>   create mode 100644 tests/nvme/042.out
>>>
>>> diff --git a/tests/nvme/042 b/tests/nvme/042
>>> new file mode 100644
>>> index 0000000..f3954b4
>>> --- /dev/null
>>> +++ b/tests/nvme/042
>>> @@ -0,0 +1,107 @@
>>> +#!/bin/bash
>>> +# SPDX-License-Identifier: GPL-3.0+
>>> +# Copyright (C) 2021 Hannes Reinecke, SUSE Labs
>>> +#
>>> +# Test bi-directional authentication
>>> +
>>> +. tests/nvme/rc
>>> +
>>> +DESCRIPTION="Test bi-directional authentication"
>>> +QUICK=1
>>> +
>>> +requires() {
>>> +    _nvme_requires
>>> +    _have_modules loop
>>> +    _require_nvme_trtype_is_fabrics
>>> +}
>>> +
>>> +
>>> +test() {
>>> +    local port
>>> +    local subsys="blktests-subsystem-1"
>>> +    local hostid="$(uuidgen)"
>>> +    local hostnqn="nqn.2014-08.org.nvmexpress:uuid:${hostid}"
>>> +    local scratch="/tmp/blktest-ns1.img"
>>> +    local hostkey
>>> +    local ctrlkey
>>> +    local ctrldev
>>> +
>>> +    echo "Running ${TEST_NAME}"
>>> +
>>> +    hostkey="$(nvme gen-dhchap-key -n ${subsys} 2> /dev/null)"
>>> +    if [ $? -ne 0 ] ; then
>>> +        echo "nvme gen-dhchap-key command missing"
>>> +        return 1
>>> +    fi
>>> +
>>> +    ctrlkey="$(nvme gen-dhchap-key -n ${subsys} 2> /dev/null)"
>>> +    if [ $? -ne 0 ] ; then
>>> +        echo "nvme gen-dhchap-key command missing"
>>> +        return 1
>>> +    fi
>>> +
>>> +    _setup_nvmet
>>> +
>>> +    truncate -s 512M "${scratch}"
>>> +
>>> +    port="$(_create_nvmet_port "${nvme_trtype}")"
>>> +
>>> +    _create_nvmet_subsystem "${subsys}" "${scratch}"
>>> +    _add_nvmet_subsys_to_port "${port}" "${subsys}"
>>> +    _create_nvmet_host "${subsys}" "${hostnqn}" "${hostkey}" 
>>> "${ctrlkey}"
>>> +
>>> +    _set_nvmet_dhgroup "${hostnqn}" "ffdhe2048"
>>> +
>>> +    # Step 1: Connect with host authentication only
>>> +    echo "Test host authentication"
>>> +    _nvme_connect_subsys "${nvme_trtype}" "${subsys}" \
>>> +                 "${def_traddr}" "${def_trsvcid}" \
>>> +                 "${hostnqn}" "${hostid}" \
>>> +                 "${hostkey}"
>>> +
>>> +    ctrldev=$(_find_nvme_dev "${subsys}")
>>> +    if [ -z "$ctrldev" ] ; then
>>> +        echo "nvme controller not found"
>>> +    fi
>>> +
>>> +    _nvme_disconnect_subsys "${subsys}"
>>> +
>>> +    # Step 2: Connect with host authentication
>>> +    # and invalid ctrl authentication
>>> +    echo "Test host authentication and invalid ctrl authentication"
>>> +    _nvme_connect_subsys "${nvme_trtype}" "${subsys}" \
>>> +                 "${def_traddr}" "${def_trsvcid}" \
>>> +                 "${hostnqn}" "${hostid}" \
>>> +                 "${hostkey}" "${hostkey}"
>>> +    ctrldev=$(_find_nvme_dev "${subsys}1")
>>> +    if [ -n "${ctrldev}" ] ; then
>>> +        echo "nvme controller found!"
>>> +        _nvme_disconnect_subsys "${ctrldev}"
>>> +    fi
>>
>> This test case has a weird behavior. Why isn't _nvme_connect_subsys
>> failing?
> 
> Oh, but it is.
> The line 'nvme controller found' is not part of the .out file, hence the 
> test will fail.
> 
> Call it an obscure feature of blktests :-)
> 
> But yeah, I can make it more obvious that this is the failure case.

Hannes, my question is why isn't nvme connect not failing (i.e.
returning a non-zero status code)?

