Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88F74C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Nov 2021 10:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xMadJWddLw4QazmgJG8F+mTdfQ+pPIiZ9Wp7fL5FrDg=; b=az7kZMJNn+PNuhzadct6YaJ5LA
	+OMmODI/A/bYYt0LCzR1KRqRQYtzt4kN+L45AQi088g9pLdFRF9eRjGkZYiKUkMuIyqDPoXJCfu8I
	mxcwQoQHTY2g+ZSaulFn1LKlRd+jEPEVE2xNYbkKF1FbcPQV85RVx5U5u1V5snnoLy7Yi9rKFCLg5
	Cv8PZx06GZzJIuw3aoSTnOd8WbGe6et7/Tr3MnK2YhJNbwXJJitZDanuy3ZAiGkzf8gEw6KvcFtis
	4ln6PHScVLg3Z9V6BRQLb648EoCv7YoYhB/lxYsn3Nu3K1jP9a00U1YveFlfjjlB7wpsPMMLN9lOP
	Tkd4sD6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mp6CK-00Fl6P-3C; Mon, 22 Nov 2021 10:05:16 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mp5sA-00Ff9l-MI
 for linux-nvme@lists.infradead.org; Mon, 22 Nov 2021 09:44:28 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 ay10-20020a05600c1e0a00b0033aa12cdd33so2905529wmb.1
 for <linux-nvme@lists.infradead.org>; Mon, 22 Nov 2021 01:44:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xMadJWddLw4QazmgJG8F+mTdfQ+pPIiZ9Wp7fL5FrDg=;
 b=TDigrFg9jtm/nlL75aI5iPNN7leZOusw4XFhwu5xjkxVWphKwhEK2/7lr4Ev8NUL+u
 HPMrAql1cr965BJBB0CkWI5TIybx3Xpav4tjuGT9yNeEAKGDBkfDeZY5d/Lf0O1R2JLW
 hhQIdLVRzdel7isZy/bhsDI3LrLwV/gIetTHf3hlgtEOEeHLYIdrMbPpqbglt4sEna3q
 PAwHvulKllXBjKExuXqpdlT1k265wFWaMcR2yDSh97QPb/snwu9DTYDGwB+DRZEsoBf/
 Tg89RU6PIiGu+Z/fXCTTew+mxMgkBQU9hvw3xT8y5SuWXWkIVW0YQbDIJ/5ohCYDnVjw
 vTTA==
X-Gm-Message-State: AOAM532A1l8SrB7PieKRu3ZG1M2optUXHMs4cMtc2qDGvNQFR59jQyLp
 g10304+uG3myQ2xQ6B5Tc/8WA40GDWY=
X-Google-Smtp-Source: ABdhPJyoM5bDznjUu2NetuUHT9SNZAWtfkQwvYImlhqeYG3Uh/cyVR8rGEhV82UcbZrJoxvwJcG4iQ==
X-Received: by 2002:a05:600c:35d4:: with SMTP id
 r20mr28079914wmq.76.1637574265116; 
 Mon, 22 Nov 2021 01:44:25 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id q24sm11012489wmj.21.2021.11.22.01.44.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Nov 2021 01:44:24 -0800 (PST)
Subject: Re: [PATCH 5/9] nvme/040: create an authenticated nvmeof-tcp
 connection
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 Omar Sandoval <osandov@fb.com>, linux-nvme@lists.infradead.org
References: <20211122075524.26207-1-hare@suse.de>
 <20211122075524.26207-6-hare@suse.de>
 <6f85d8e0-a930-9ddc-e810-f56bf483a22c@grimberg.me>
 <48b581fe-8995-8ae7-44a0-03917cb10b52@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e37ea493-8c61-95df-4323-abd85b377a3a@grimberg.me>
Date: Mon, 22 Nov 2021 11:44:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <48b581fe-8995-8ae7-44a0-03917cb10b52@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211122_014426_809042_25861B28 
X-CRM114-Status: GOOD (  25.77  )
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



On 11/22/21 11:22 AM, Hannes Reinecke wrote:
> On 11/22/21 9:57 AM, Sagi Grimberg wrote:
>>
>>
>> On 11/22/21 9:55 AM, Hannes Reinecke wrote:
>>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>>> ---
>>>    tests/nvme/040     | 64 ++++++++++++++++++++++++++++++++++++++++++++++
>>>    tests/nvme/040.out |  6 +++++
>>>    2 files changed, 70 insertions(+)
>>>    create mode 100644 tests/nvme/040
>>>    create mode 100644 tests/nvme/040.out
>>>
>>> diff --git a/tests/nvme/040 b/tests/nvme/040
>>> new file mode 100644
>>> index 0000000..9c2eb07
>>> --- /dev/null
>>> +++ b/tests/nvme/040
>>> @@ -0,0 +1,64 @@
>>> +#!/bin/bash
>>> +# SPDX-License-Identifier: GPL-3.0+
>>> +# Copyright (C) 2021 Hannes Reinecke, SUSE Labs
>>> +#
>>> +# Test nvme over tcp authentication
>>> +
>>> +. tests/nvme/rc
>>> +
>>> +DESCRIPTION="Create authenticated TCP connection via localhost"
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
>>> +    local genctr
>>> +    local subsys="blktests-subsystem-"
>>> +    local hostid="$(uuidgen)"
>>> +    local hostnqn="nqn.2014-08.org.nvmexpress:uuid:${hostid}"
>>> +    local scratch="/tmp/blktest-ns1.img"
>>> +    local nvme_trtype="tcp"
>>
>> Why is this tcp specific? what prevents this from passing with
>> loop/rdma?
>>
> 
> Nothing in principle.
> 
>> AFAICT the rest of the tests are not tcp specific either, nor
>> is inband auth in general...
>>
>> I think we should have the tests run with a user-defind nvme_trtype.
>>
> 
> If you can tell me how to do that I'll happily make the change.

Remove the above setting for nvme_trtype=tcp and verify the test
is fine using:

$ nvme_trtype=[tcp|loop|rdma] ./check tests/nvme/040

> 
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
>> I think that this belongs in nvme/rc
>>
>>> +
>>> +    _setup_nvmet
>>> +
>>> +    truncate -s 512M "${scratch}"
>>> +
>>> +    port="$(_create_nvmet_port "${nvme_trtype}")"
>>> +
>>> +    _create_nvmet_subsystem "${subsys}1" "${scratch}"
>>> +    _add_nvmet_subsys_to_port "${port}" "${subsys}1"
>>> +    _create_nvmet_host "${subsys}1" "${hostnqn}"
>>> +    _set_nvmet_hostkey "${hostnqn}" "${hostkey}"
>>
>> Can you comment that hash/dhgrp are used with their default values.
>>
> Sure.
> 
>>> +
>>> +    nvme connect -t "${nvme_trtype}" -n "${subsys}1" \
>>> +         -a "${def_traddr}" -s "${def_trsvcid}" -S "${hostkey}" \
>>> +         --hostnqn="${hostnqn}" --hostid="${hostid}"
>>> +
>>> +    nvme list-subsys
>>
>> Why not just look in the connect retcode? why do you need the
>> list-subsys output?
>>
> Hmm. Possibly I could; just found it more obvious the check if the
> namespace shows up in the system as expected.
> Reasoning being that it doesn't help if nvme returns no error, but
> the namespace doesn't show up.
> But I'm open to suggestions.

What does the namespace has to do with inband auth?
But if you really want to, you can still try to access
the subsystem and retrieve the hostkey and/or validate
the ns device node exist or something like that...

